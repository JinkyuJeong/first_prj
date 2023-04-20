package controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import gdu.mskim.MskimRequestMapping;
import gdu.mskim.RequestMapping;
import model.Board;
import model.BoardDao;

@WebServlet(urlPatterns = {"/board/*"},
initParams = {@WebInitParam(name="view", value="/view/")}
		)
public class BoardController extends MskimRequestMapping{
	private BoardDao dao = new BoardDao();
	private static String boardName(String boardType) {
		String boardName = "";
		switch (boardType){
			case "1" : boardName = "자유게시판"; break;
			case "2" : boardName = "질문게시판"; break;
			case "3" : boardName = "후기게시판"; break;
			case "4" : boardName = "공지사항"; break;
		}
		return boardName;
	}
	
	@RequestMapping("writeForm")
	public String writeForm(HttpServletRequest request, HttpServletResponse response) {
		request.getSession().setAttribute("login", "admin");
		/*
		 * 1. list를 거쳐서 들어오는거 말고 그냥 들어왔을 때는 세션에 boardType이 저장되어 있지않음
		 * 2. 하지만 null일 때 1로 설정해서 자유게시판으로 글 쓰는건 가능함
		 * 3. 그러면 boardName으로 넘기는값이 항상 자유게시판임
		 * 4. 사용자는 boardType=2 로 들어가서 질문게시판으로 바로 갈 수도 있음
		 * 5. 그러면 자유게시판 글쓰기로 가니깐 파라미터로 초기화 하는거임
		 * 6. 공지사항 폼 체크도 했음 공지사항타입4로 들어왔을 때 운영자가 아니면 아웃!
		 * */
		String boardType = request.getParameter("boardType");
		String login = (String)request.getSession().getAttribute("login");
		if(boardType == null || boardType.equals("")) boardType = "1";
		request.getSession().setAttribute("boardType", boardType);
		
//		if(login == null) {	// 로그인 상태가 아닐 때
//			request.setAttribute("msg", "비회원은 게시글 작성이 불가능합니다.");
//			request.setAttribute("url", "list?boardType="+boardType);
//			return "alert";		
//		}else if(boardType.equals("4") && !login.equals("admin")){	// 공지사항 글쓰기로 들어왔는데 admin이 아닐 경우 
//			request.setAttribute("msg", "일반회원은 공지사항 게시글은 작성이 불가능합니다.");
//			request.setAttribute("url", "list?boardType="+boardType);
//			return "alert";
//		}
		String boardName = boardName(boardType);
		request.setAttribute("boardName", boardName);
		
		return "board/writeForm";
	}
	
	@RequestMapping("write")
	public String write(HttpServletRequest request, HttpServletResponse response) {
		String nickname = (String)request.getSession().getAttribute("nickname");
		if(nickname == null) nickname = "테스트계정";
		String boardType = (String)request.getSession().getAttribute("boardType");
		if(boardType == null) boardType = "1";
		
		String uploadPath = request.getServletContext().getRealPath("/") + "/upload/board"; // 절대경로
		File f = new File(uploadPath);
		if(!f.exists()) f.mkdirs();
		int size = 1024*1024*10;
		MultipartRequest multi = null;
		try {
			multi = new MultipartRequest(request, uploadPath, size, "UTF-8");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		Board b = new Board();
		b.setTitle(multi.getParameter("title"));
		b.setNickname(nickname);
		b.setContent(multi.getParameter("content"));
		b.setFile1(multi.getFilesystemName("file1"));
		b.setBoardType(boardType);
		if(b.getFile1() == null) b.setFile1("");

		if(dao.insert(b)){
			request.setAttribute("msg", "게시물 등록 성공");
			request.setAttribute("url", "list?boardType="+boardType);
			return "alert";
		}
		
		request.setAttribute("msg", "게시물 등록 실패");
		request.setAttribute("url", "writeForm");
		return "alert";
	}
	
	@RequestMapping("list")
	public String list(HttpServletRequest request, HttpServletResponse response) {
		request.getSession().setAttribute("login", "admin");
		/*
			1. 한 페이지당 10건의 게시물을 출력하기
					pageNum 파라미터값을 저장 => 없는 경우는 1로 설정하기
			2. 최근 등록된 게시물이 가장 위에 배치함
			3. db에서 해당 페이지에 출력될 내용을 조회하여 화면에 출력.
					게시물 출력부분
					페이지 구분 출력부분
			4. 페이지별 게시물번호 출력하기
			5. 파일유무
		*/
		if(request.getParameter("boardType") != null){
			// session에 게시판종류 정보등록
			request.getSession().setAttribute("boardType", request.getParameter("boardType"));
			request.getSession().setAttribute("pageNum", "1");	// 현재 페이지 정보
		}

		// 초기화작업
		String boardType = (String)request.getSession().getAttribute("boardType");
		if(boardType == null) {
			boardType = "1";
			request.getSession().setAttribute("boardType", boardType);
		}
		int pageNum = 1;
		try{
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}catch (NumberFormatException e) {}
		
		int limit = 10;	// 한 페이지에 보여질 게시물 건 수
		
		// 게시판 종류별 전체 게시물 등록 건 수
		int boardCnt = dao.boardCount(boardType);
		
		// 현재 페이지에 보여질 게시물 목록
		List<Board> list = dao.list(boardType, pageNum, limit);	// (문자열, 정수, 정수)
		List<Board> nList = dao.nList();
		/*
			maxPage : 필요한 페이지 갯수
			게시물 건 수		|		필요한 페이지
					3								1 // 3.0/10 => 0.3+0.95 => (int)1.25 => 1
					10							1 // 10.0/10 => 1+0.95 => (int)1.95 => 1
					11							2 // 11.0/10 => 1.1+0.95 => (int)2.05 => 2
					500							50 // 500.0/10 => 50.0+0.95 => (int)50.95 => 50
					501							51 // 501.0/10 => 50.1+0.95 => (int)51.05 => 51
		*/
		int maxPage = (int)((double)boardCnt/limit +0.95);
		int startPage = pageNum-(pageNum-1)%5;
		int endPage = startPage + 4;
		if(endPage > maxPage) endPage = maxPage;
		
		int boardNum = boardCnt-(pageNum-1) * limit;
		
		request.setAttribute("list", list);
		request.setAttribute("nList", nList);
		request.setAttribute("nCnt", nList.size());
		request.setAttribute("boardNum", boardNum);
		request.setAttribute("boardCnt", boardCnt);
		request.setAttribute("boardType", boardType);
		request.setAttribute("boardName", boardName(boardType));
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("maxPage", maxPage);
		request.setAttribute("today", new Date());
		
		return "board/list";
	}
}

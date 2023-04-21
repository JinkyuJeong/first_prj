package controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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
import model.BoardMybatisDao;

@WebServlet(urlPatterns = {"/board/*"},
initParams = {@WebInitParam(name="view", value="/view/")}
		)
public class BoardController extends MskimRequestMapping{
	private BoardMybatisDao dao = new BoardMybatisDao();
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
		String boardType = request.getParameter("boardType");
		String login = (String)request.getSession().getAttribute("login");
		if(boardType == null || boardType.equals("")) boardType = "1";
		request.getSession().setAttribute("boardType", boardType);
		
		if(login == null) {	// 로그인 상태가 아닐 때
			request.setAttribute("msg", "비회원은 게시글 작성이 불가능합니다.");
			request.setAttribute("url", "list?boardType="+boardType);
			return "alert";		
		}else if(boardType.equals("4") && !login.equals("admin")){	// 공지사항 글쓰기로 들어왔는데 admin이 아닐 경우 
			request.setAttribute("msg", "일반회원은 공지사항 게시글은 작성이 불가능합니다.");
			request.setAttribute("url", "list?boardType="+boardType);
			return "alert";
		}
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
		String pageNum_ = request.getParameter("pageNum");
		String field_ = request.getParameter("f");
		String query_ = request.getParameter("q");
		
		int pageNum = 1;
		String field = "title+content";
		String query = "";
		
		if(field_ != null && !field_.equals("")) field = field_;
		if(query_ != null && !query_.equals("")) query = query_;
		if(pageNum_ != null && !pageNum_.equals("")) {
			try{
				pageNum = Integer.parseInt("pageNum");
			}catch (Exception e) {e.printStackTrace();}
		}
		
		int limit = 10;	// 한 페이지에 보여질 게시물 건 수
		
		// 게시판 종류별 전체 게시물 등록 건 수
		int boardCnt = dao.boardCount(boardType, field, query);
		
		// 현재 페이지에 보여질 게시물 목록
		List<Board> list = dao.list(boardType, pageNum, limit, field, query);	// (문자열, 정수, 정수)
		
		// 맨 위 상단 공지글 2개
		List<Board> nList = dao.nList();
		if(nList != null) {
			int nCnt = nList.size();
			request.setAttribute("nList", nList);
			request.setAttribute("nCnt", nCnt);
		}
		
		List<String> userPicList = new ArrayList<>();
		
		int maxPage = (int)((double)boardCnt/limit +0.95);
		int startPage = pageNum-(pageNum-1)%5;
		int endPage = startPage + 4;
		if(endPage > maxPage) endPage = maxPage;
		
		int boardNum = boardCnt-(pageNum-1) * limit;
		
		request.setAttribute("list", list);
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

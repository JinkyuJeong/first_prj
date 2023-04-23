package controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
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
import model.BoardDetailView;
import model.BoardListView;
import model.BoardMybatisDao;
import model.Member;
import model.MemberDao;

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
		List<BoardListView> list = dao.list(boardType, pageNum, limit, field, query);	// (문자열, 정수, 정수)
		
		// 맨 위 상단 공지글 2개
		List<Board> nList = dao.nList();
		if(nList != null) {
			int nCnt = nList.size();
			request.setAttribute("nList", nList);
			request.setAttribute("nCnt", nCnt);
		}
		
		// 운영자 프사등록
		Member admin = new MemberDao().selectOneNick("운영자");
		request.setAttribute("adminPicture", admin.getPicture());
		
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
	
	// 공개여부
	@RequestMapping("public")
	public String pub(HttpServletRequest request, HttpServletResponse response) {
		String login = (String)request.getSession().getAttribute("login");
		
		if(login == null || !login.equals("admin")) {	// 로그인 상태가 아니거나 운영자가 아닐 때
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "list");
			return "alert";		
		}
		
		String[] openNos = request.getParameterValues("noChks");	// 해당 페이지 게시글 번호
		String nos_ = request.getParameter("nos");	// 해당 페이지 체크(공개)된 게시글 번호
		String[] nos = nos_.trim().split(" ");	// 공백단위로 잘라서 집어넣음
		
		List<String> oids = Arrays.asList(openNos);		// 공개된 게시글번호
		
		List<String> cids = new ArrayList(Arrays.asList(nos));		
		cids.removeAll(oids);		// cids : 비공개 게시글 번호
		
		if(dao.pubBoardAll(oids, cids)) {
			return "redirect:list";
		}
		
		request.setAttribute("msg", "공개여부 과정에서 문제가 생겼습니다.");
		request.setAttribute("url", "list");
		return "alert";	
	}
	
	//상세페이지
	@RequestMapping("detail")
	public String detail(HttpServletRequest request, HttpServletResponse response) {
		String nickname = (String)request.getSession().getAttribute("nickname");
		int no = Integer.parseInt(request.getParameter("no"));
		/*
		String readcnt = request.getParameter("readcnt");
		if(readcnt == null || !readcnt.equals("f")) {
		}
		이건 댓글처리 때 조회수 처리할려고함
		*/
		
		dao.HitAdd(no);
		BoardDetailView b = dao.selectOne(no);
		BoardDetailView bNext = dao.selectNext(b);
		BoardDetailView bPrevious = dao.selectPrevious(b);
		String boardName = boardName(b.getBoardType());
		
		request.setAttribute("boardName", boardName);
		request.setAttribute("b", b);
		request.setAttribute("bNext", bNext);
		request.setAttribute("bPrevious", bPrevious);
		request.setAttribute("nickname", nickname);	// 게시글 삭제와 수정은 본인만 가능하게 할려고 보내는거
//		request.setAttribute("no", no); 댓글 때 등록때 param.no으로 보낼려고함
		
		return "board/detail";
	}
	
	@RequestMapping("imgupload")
	public String imgupload(HttpServletRequest request, HttpServletResponse response) {
		String uploadPath = request.getServletContext().getRealPath("/") + "/upload/imgfile/"; // 절대경로
		File f = new File(uploadPath);
		if(!f.exists()) f.mkdirs();
		int size = 1024*1024*10;
		MultipartRequest multi = null;
		try {
			multi = new MultipartRequest(request, uploadPath, size, "UTF-8");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		String fileName = multi.getFilesystemName("upload");
		request.setAttribute("fileName", fileName);
		
		return "ckeditor";
	}
	
	@RequestMapping("updateForm")
	public String updateForm(HttpServletRequest request, HttpServletResponse response) {
		String nickname = (String)request.getSession().getAttribute("nickname");
		String login = (String)request.getSession().getAttribute("login");
		String boardType = (String)request.getSession().getAttribute("boardType");
		
		int no = Integer.parseInt(request.getParameter("no"));
		BoardDetailView b = dao.selectOne(no);
		
		if(login == null) {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("url", "list?boardType="+boardType);
			return "alert";		
		}else if(b.getBoardType().equals("4") && !login.equals("admin")) {
			request.setAttribute("msg", "공지사항은 운영자만 수정 가능합니다.");
			request.setAttribute("url", "detail?no="+b.getNo());
			return "alert";		
		}else if(!login.equals("admin") && !nickname.equals(b.getNickname())) {
			request.setAttribute("msg", "본인이 작성한 글만 수정이 가능합니다.");
			request.setAttribute("url", "detail?no="+b.getNo());
			return "alert";	
		}
		
		request.setAttribute("boardName", boardName(b.getBoardType()));
		request.setAttribute("b", b);
		
		return "board/updateForm";
	}
}

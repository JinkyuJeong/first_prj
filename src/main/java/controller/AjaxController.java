package controller;

import java.util.List;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gdu.mskim.MskimRequestMapping;
import gdu.mskim.RequestMapping;
import model.BoardDetailView;
import model.BoardMybatisDao;
import model.CommRecommendMybatisDao;
import model.Comment;
import model.CommentMybatisDao;
import model.MessengerMybatisDao;
import model.RecommendMybatisDao;

@WebServlet(urlPatterns = {"/ajax/*"},
initParams = {@WebInitParam(name="view", value="/view/")}
		)
public class AjaxController extends MskimRequestMapping{
	private RecommendMybatisDao rDao = new RecommendMybatisDao();
	private CommRecommendMybatisDao crDao = new CommRecommendMybatisDao ();
	private MessengerMybatisDao msgdao = new MessengerMybatisDao();
	private BoardMybatisDao bDao = new BoardMybatisDao();
	private CommentMybatisDao cDao = new CommentMybatisDao();
	
	
	@RequestMapping("unreadMsg")
	public String unreadMsg(HttpServletRequest request, HttpServletResponse response) {
		String nickname = (String)request.getSession().getAttribute("nickname");
		int notReadCnt = msgdao.notReadCnt(nickname);
		
		request.setAttribute("unreadMsg", notReadCnt);
		return "ajax/unreadMsg";
	}
	
	@RequestMapping("replyRecommForm")
	public String replyRecommForm(HttpServletRequest request, HttpServletResponse response) {
		String login = (String)request.getSession().getAttribute("login");
		int no = Integer.parseInt(request.getParameter("no"));
		int seq = Integer.parseInt(request.getParameter("seq"));
		
		Comment c = cDao.selectOne(no, seq);
		List<String> list = crDao.list(no, seq);
		int isDup = 0;
		for(String s : list) {
			if(s.equals(login))  isDup = 1;
		}
		
		request.setAttribute("c", c);
		request.setAttribute("isDup", isDup);
		
		return "ajax/replyRecommForm";
	}
	
	@RequestMapping("replyRecomm")
	public String replyRecomm(HttpServletRequest request, HttpServletResponse response) {
		int no = Integer.parseInt(request.getParameter("no"));
		String login = (String)request.getSession().getAttribute("login");
		int seq = Integer.parseInt(request.getParameter("seq"));
		
		String url = "/first_prj/board/detail?no="+no;
		if(!crDao.insert(no, seq, login)) {
			request.setAttribute("msg", "이미 추천 하셨습니다.");
			request.setAttribute("url", url);
			return "alert";
		}
		if(!cDao.plusRecomm(no, seq)) {
			request.setAttribute("msg", "오류");
			request.setAttribute("url", url);
			return "alert";
		}
		return "redirect:" + url;
	}
	
	@RequestMapping("recommForm")
	public String recommForm(HttpServletRequest request, HttpServletResponse response) {
		String login = (String)request.getSession().getAttribute("login");
		int no = Integer.parseInt(request.getParameter("no"));
		BoardDetailView b = bDao.selectOne(no);
		List<String> list = rDao.list(no);
		int isDup = 0;
		for(String s : list) {
			if(s.equals(login))  isDup = 1;
		}
		
		request.setAttribute("b", b);
		request.setAttribute("isDup", isDup);
		
		return "ajax/recommForm";
	}
	
	@RequestMapping("recomm")
	public String recomm(HttpServletRequest request, HttpServletResponse response) {
		
		int no = Integer.parseInt(request.getParameter("no"));
		String login = (String)request.getSession().getAttribute("login");
		
		String url = "/first_prj/board/detail?no="+no;
		if(!rDao.insert(no, login)) {
			request.setAttribute("msg", "이미 추천 하셨습니다.");
			request.setAttribute("url", url);
			return "alert";
		}
		if(!bDao.plusRecomm(no)) {
			request.setAttribute("msg", "오류");
			request.setAttribute("url", url);
			return "alert";
		}
		return "redirect:" + url;
	}
}
package controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gdu.mskim.MskimRequestMapping;
import gdu.mskim.RequestMapping;
import model.Member;
import model.MemberMybatisDao;
import model.Messenger;
import model.MessengerMybatisDao;

@WebServlet(urlPatterns = {"/messenger/*"},
initParams = {@WebInitParam(name="view", value="/view/")})
public class MessengerController extends MskimRequestMapping {
	private MessengerMybatisDao dao = new MessengerMybatisDao();
	private MemberMybatisDao mdao = new MemberMybatisDao();
	
	@RequestMapping("msgForm")
	public String msgForm(HttpServletRequest request, HttpServletResponse response) {
		String nickname = (String)request.getSession().getAttribute("nickname");
		String receiver = request.getParameter("receiver");
		Messenger msg = new Messenger();		
		List<Messenger> msgs = dao.selectMsgs(receiver,nickname); //서로 주고 받은 레코드 시간 순 정렬(regdate asc)
		List<String> senders = dao.selectSenders(nickname); //receiver가 나이고 sender가 나인 모든 레코드(regdate desc)
		int notReadCnt = 0;		
			
		if(receiver==null) { //맨 처음 페이지. 왼쪽 쪽지함만 보임
			senders = dao.selectSenders(nickname);
			notReadCnt = dao.notReadCnt(nickname);
			
			Map<String, Map<String, Object>> senderInfoMap = new HashMap<>(); //쪽지함 정보
			for(String sender : senders) {
				senderInfoMap.put(sender, new HashMap<>()); //보낸사람 닉네임(key)
				Map<String, Object> senderInfo = senderInfoMap.get(sender); 
				senderInfo.put("cnt", dao.notReadCntSep(nickname,sender)); //읽지 않은 메세지
				senderInfo.put("pic", mdao.selectOneNick(sender).getPicture()); //사진
			}
			
			request.setAttribute("senders", senders);
			request.setAttribute("notReadCnt", notReadCnt);
			request.setAttribute("senderInfoMap",senderInfoMap);
			return "messenger/noMsgForm";
		} else {
			dao.read(nickname,receiver); //isRead update
			
			msgs = dao.selectMsgs(receiver,nickname); //주고받은 메세지 정보
			senders = dao.selectSenders(nickname); //쪽지함
			
			Map<String, Map<String, Object>> senderInfoMap = new HashMap<>(); //쪽지함 정보
			for(String sender : senders) {
				senderInfoMap.put(sender, new HashMap<>()); //보낸사람 닉네임(key)
				Map<String, Object> senderInfo = senderInfoMap.get(sender); 
				senderInfo.put("cnt", dao.notReadCntSep(nickname,sender)); //읽지 않은 메세지
				senderInfo.put("pic", mdao.selectOneNick(sender).getPicture()); //사진
			}
			
			String myPic = mdao.selectOneNick(nickname).getPicture(); //채팅방 내 내 사진
			String yourPic = mdao.selectOneNick(receiver).getPicture(); //채팅방 내에서 상대방 사진
			
			request.setAttribute("receiver",receiver);
			request.setAttribute("senders", senders);		
			request.setAttribute("msgs",msgs);
			request.setAttribute("notReadCnt", notReadCnt);	
			request.setAttribute("senderInfoMap",senderInfoMap);
			request.setAttribute("myPic", myPic);
			request.setAttribute("yourPic", yourPic);
			return "messenger/msgForm";
		}
	}

	@RequestMapping("msg")
	public String msg(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//메세지 보내는 부분
		String nickname = (String)request.getSession().getAttribute("nickname");
		String sender1 = nickname;
		String receiver = request.getParameter("receiver");
		String content = request.getParameter("content");
		Messenger messenger = new Messenger();
		messenger.setSender(sender1);
		messenger.setReceiver(receiver);
		messenger.setContent(content);		
		dao.insert(messenger);	
		
		List<Messenger> msgs = dao.selectMsgs(receiver,nickname);
		List<String> senders = dao.selectSenders(nickname);
		int notReadCnt = dao.notReadCnt(nickname);
		
		String myPic = mdao.selectOneNick(nickname).getPicture();
		String yourPic = mdao.selectOneNick(receiver).getPicture();
		
		Map<String, Map<String, Object>> senderInfoMap = new HashMap<>();
		for(String sender : senders) {
			senderInfoMap.put(sender, new HashMap<>());
			Map<String, Object> senderInfo = senderInfoMap.get(sender);
			senderInfo.put("cnt", dao.notReadCntSep(nickname,sender));
			senderInfo.put("pic", mdao.selectOneNick(sender).getPicture());
		}
		
		request.setAttribute("receiver",receiver);
		request.setAttribute("senders", senders);
		request.setAttribute("msgs",msgs);
		request.setAttribute("notReadCnt", notReadCnt);		
		request.setAttribute("myPic", myPic);
		request.setAttribute("yourPic", yourPic);
		request.setAttribute("senderInfoMap",senderInfoMap);
		return "messenger/msgForm";
	}
}

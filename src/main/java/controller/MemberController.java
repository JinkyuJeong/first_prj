package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import gdu.mskim.MskimRequestMapping;
import gdu.mskim.RequestMapping;
import model.Member;
import model.MemberMybatisDao;

// /member/ 이후의 어떤 요청이 들어와도 MemberController가 요청됨
@WebServlet(urlPatterns = {"/member/*"},
						initParams = {@WebInitParam(name="view", value="/view/")}
		)
public class MemberController extends MskimRequestMapping{
	private MemberMybatisDao dao = new MemberMybatisDao();
	
	@RequestMapping("joinForm")
	public String joinForm(HttpServletRequest request, HttpServletResponse response) {
		boolean able=true;
		request.setAttribute("able", able);
		return "member/joinForm";
	}
	
	@RequestMapping("join")
	public String join(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		Member mem = new Member();
//		mem.setEmail1(request.getParameter("email1"));
//		mem.setEmail2(request.getParameter("email2"));
		String emailaddress = request.getParameter("email1")+"@"+request.getParameter("email2");
		mem.setEmailaddress(emailaddress);
		mem.setPassword(request.getParameter("pass"));
		mem.setPicture(request.getParameter("picture"));
		mem.setNickname(request.getParameter("nickname"));
		if(dao.insert(mem)) {
			request.setAttribute("msg", "회원가입 성공");
			request.setAttribute("url", "loginForm");
			return "alert";
		} else {
			request.setAttribute("msg", "회원가입 실패");
			request.setAttribute("url", "joinForm");
			return "alert";
		}				
	}
	@RequestMapping("emailForm2")
	public String emailForm2(HttpServletRequest request, HttpServletResponse response) {
		request.getSession().setAttribute("fromEmail2", "fromEmail2");
		return "member/emailForm2";
	}
	@RequestMapping("emailForm") //이메일 인증
	public String emailForm(HttpServletRequest request, HttpServletResponse respnose) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		//비밀번호 찾기 할 때, 가입되어있는지 확인
		String from = (String)request.getSession().getAttribute("fromEmail2");
		System.out.println(from);
		String email = request.getParameter("email");
		boolean able = false;
		if(from == null) from = "";
		if(from.equals("fromEmail2")) {			
			if(dao.selectOneEmail(email)==null) {
				request.setAttribute("msg", "가입되지 않은 이메일입니다.");
				request.getSession().removeAttribute("fromEmail2");
				return "self_close";
			} else {
				//비밀번호 찾을 때
				String inputedEmail = request.getParameter("email");
				//인증번호 랜덤 생성
			    String randomkey = authCodeMaker();
				// 발신자 정보
				String sender = "zxc2289@naver.com";
				String password = "slfflflakaqh";
				
				// 메일 받을 주소
				String recipient = inputedEmail;
				System.out.println("inputedEmail : " + inputedEmail);
				Properties prop = new Properties();
				   try {
					   FileInputStream fis = new FileInputStream("D:\\jsp\\workspace\\first_prj\\mail.properties"); //파일의 내용(mail.properties)을 읽기 위한 스트림
					   prop.load(fis);
					   prop.put("mail.smtp.user", sender);
					   System.out.println(prop);
				   } catch(IOException e) {
					   e.printStackTrace();
				   }
				Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(sender, password);
					}
				});
				MimeMessage msg = new MimeMessage(session);
					
					// email 전송
				try {
					try {
							msg.setFrom(new InternetAddress(sender,"SHOERACE 인증센터","UTF-8"));
						} catch (UnsupportedEncodingException e) {
							e.printStackTrace();
						}
						msg.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));

						// 메일 제목
						msg.setSubject("이메일 인증");
						// 메일 내용
						msg.setText(randomkey);
						Transport.send(msg);
						System.out.println("이메일 전송 : " + randomkey);

					} catch (AddressException e) { 
						e.printStackTrace(); 
					} catch (MessagingException e) { 
						e.printStackTrace(); 
					}
				request.getSession().setAttribute("randomkey", randomkey);
				return "member/emailForm";
			}
		} else {
		
		//회원가입 할 때
		String inputedEmail = request.getParameter("email");
		//인증번호 랜덤 생성
	    String randomkey = authCodeMaker();
		// 발신자 정보
		String sender = "zxc2289@naver.com";
		String password = "slfflflakaqh";
		
		// 메일 받을 주소
		String recipient = inputedEmail;
		System.out.println("inputedEmail : " + inputedEmail);
		Properties prop = new Properties();
		   try {
			   FileInputStream fis = new FileInputStream("D:\\jsp\\workspace\\first_prj\\mail.properties"); //파일의 내용(mail.properties)을 읽기 위한 스트림
			   prop.load(fis);
			   prop.put("mail.smtp.user", sender);
			   System.out.println(prop);
		   } catch(IOException e) {
			   e.printStackTrace();
		   }
		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(sender, password);
			}
		});
		MimeMessage msg = new MimeMessage(session);
			
			// email 전송
		try {
			try {
					msg.setFrom(new InternetAddress(sender,"SHOERACE 인증센터","UTF-8"));
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
				msg.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));

				// 메일 제목
				msg.setSubject("이메일 인증");
				// 메일 내용
				msg.setText(randomkey);
				Transport.send(msg);
				System.out.println("이메일 전송 : " + randomkey);

			} catch (AddressException e) { 
				e.printStackTrace(); 
			} catch (MessagingException e) { 
				e.printStackTrace(); 
			}
		request.getSession().setAttribute("randomkey", randomkey);
		return "member/emailForm";
		}
	}
	
	 //인증번호 생성 함수
	   public String authCodeMaker() {
			String authCode = null;
			
			StringBuffer temp = new StringBuffer();
			Random random = new Random();
			for (int i = 0; i < 10; i++) {
				int rIndex = random.nextInt(3);
				switch (rIndex) {
				case 0:
					// a-z
					temp.append((char) ((int) (random.nextInt(26)) + 97));
					break;
				case 1:
					// A-Z
					temp.append((char) ((int) (random.nextInt(26)) + 65));
					break;
				case 2:
					// 0-9
					temp.append((random.nextInt(10)));
					break;
				}
			}
			
			authCode = temp.toString();
			System.out.println(authCode);
			
			return authCode;
		}
	   
	   @RequestMapping("emailchk") //인증번호 확인
		public String emailchk(HttpServletRequest request, HttpServletResponse respnose) {
		   String autoNum = request.getParameter("autoNum");
		   String randomkey = (String)request.getSession().getAttribute("randomkey");
		   String pwchg = request.getParameter("pwchg");
		   boolean able = true;
		   if(!autoNum.equals(randomkey)) {
			   request.setAttribute("msg", "인증번호가 틀립니다.");
			   request.setAttribute("url", "emailForm");
			   return "alert";
		   } else {
			   able=true;
			   if(pwchg==null || pwchg.equals("")) {
				   request.setAttribute("able", able);
				   return "member/emailForm";
			   } else {
				   request.setAttribute("able", able);
				   request.setAttribute("pwchg", pwchg);
				   return "member/emailForm";
			   }			   
		   }
	   }
	   
	   @RequestMapping("nickChk")
	   public String nickChk(HttpServletRequest request, HttpServletResponse response) {
		   try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		   String nickname = request.getParameter("nickname");
		   Member mem = dao.selectOneNick(nickname);
		   request.setAttribute("mem" , mem);
		   return "member/nickChk";	 
	   }
	   
	   @RequestMapping("picture")
	   public String picture(HttpServletRequest request, HttpServletResponse response) {
		   try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		   String path = request.getServletContext().getRealPath("/") + "/upload/member"; 
		   String fname = null;
		   File f = new File(path);
		   if(!f.exists()) f.mkdirs(); 
		   MultipartRequest multi=null;
		   try {
			   multi = new MultipartRequest(request, path, 10*1024*1024, "UTF-8");
		   } catch (IOException e) {
			   e.printStackTrace();
		   } //업로드(최대 10 MB)
		   fname = multi.getFilesystemName("picture"); 
		   request.setAttribute("fname", fname);
		   return "member/picture";
	   }
	   
	   @RequestMapping("login")
	   public String login(HttpServletRequest request, HttpServletResponse response) {
		   String email = request.getParameter("id");
		   String pass = request.getParameter("pass");
		   Member mem = dao.selectOneEmail(email);
		   String msg = null;
		   String url = null;
		   if(mem == null) {
			   msg="아이디를 확인하세요";
			   url="loginForm";
		   } else if(!pass.equals(mem.getPassword())) {
			   msg="비밀번호가 틀립니다.";
			   url="loginForm";
		   } else {
			   request.getSession().setAttribute("login", email);
			   request.getSession().setAttribute("nickname", mem.getNickname());
			   msg="반갑습니다. " + mem.getNickname() + "님";
			   url="/first_prj/index";
		   }
		   request.setAttribute("msg", msg);
		   request.setAttribute("url", url);
		   return "alert";
	   }
	   
	   @RequestMapping("myPage")
	   public String myPage(HttpServletRequest request, HttpServletResponse response) {
		   String email = request.getParameter("email");
		   Member mem = dao.selectOneEmail(email);
		   request.setAttribute("mem", mem);
		   return "member/myPage";
	   }
	   
	   @RequestMapping("logout")
	   public String logout(HttpServletRequest request, HttpServletResponse response) {
		   request.getSession().invalidate();
		   return "redirect:/first_prj/index";
	   }
	   
	   @RequestMapping("updateForm")
	   public String updateForm(HttpServletRequest request, HttpServletResponse response) {
		   try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		   String email = request.getParameter("email");
		   Member mem = dao.selectOneEmail(email);
		   request.setAttribute("mem", mem);
		   return "member/updateForm";
	   }
	   
	   @RequestMapping("update")
	   public String update(HttpServletRequest request, HttpServletResponse response) {
		   try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		   String login = (String)request.getSession().getAttribute("login");
		   Member mem = new Member();
		   Member dbMem = dao.selectOneEmail(login);
		   String email1 = request.getParameter("email1");
		   String email2 = request.getParameter("email2");
		   mem.setEmailaddress(email1 + "@" + email2);
		   mem.setNickname(request.getParameter("nickname"));
		   mem.setPicture(request.getParameter("picture"));
		   mem.setPassword(request.getParameter("pass"));
		   if(!mem.getPassword().equals(dbMem.getPassword())) {
			   request.setAttribute("msg", "비밀번호가 틀립니다.");
			   request.setAttribute("url", "updateForm?email="+mem.getEmailaddress());
			   return "alert";
		   } else {
			   if(dao.update(mem)) {
				   request.setAttribute("msg", "회원정보 수정 완료");
				   request.setAttribute("url", "myPage?email="+mem.getEmailaddress());
				   return "alert";
			   } else {
				   request.setAttribute("msg", "회원정보 수정 실패");
				   request.setAttribute("url", "updateForm?email="+mem.getEmailaddress());
				   return "alert";
			   }
		   }
	   }
	   
	   @RequestMapping("delete")
	   public String delete(HttpServletRequest request, HttpServletResponse response) {
		   String pass = request.getParameter("pass");
		   String email = request.getParameter("email");
		   System.out.println(email);
		   Member dbMem = dao.selectOneEmail(email);
		   if(!dbMem.getPassword().equals(pass)) {
			   request.setAttribute("msg", "비밀번호가 다릅니다.");
			   request.setAttribute("url", "deleteForm?email="+email);
			   return "alert";
		   } else {
			   if(dao.delete(email)) {
				   request.setAttribute("msg", "회원탈퇴 완료");
				   request.setAttribute("url", "/first_prj/index");
				   return "alert";
			   } else {
				   request.setAttribute("msg", "회원탈퇴 실패");
				   request.setAttribute("url", "/first_prj/index");
				   return "alert";
			   }
		   }
	   }
	   
	   //비밀번호 찾기(loginForm) 
	   @RequestMapping("password1")
	   public String password1(HttpServletRequest request, HttpServletResponse response) {
		   String pass = request.getParameter("pass");	
		   String email = request.getParameter("email");
		   if(dao.updatePass(email,pass)) {
			   request.setAttribute("msg", "비밀번호가 수정되었습니다.");
			   return "self_close";
		   } else {
			   request.setAttribute("msg", "비밀번호 수정 실패.");
			   request.setAttribute("url", "pwChgForm");
			   return "alert";
		   }
	   }
	   
	   //비밀번호 수정 updateForm
	   @RequestMapping("password2")
	   public String password2(HttpServletRequest request, HttpServletResponse response) {
		   String pass = request.getParameter("pass");
		   String currentPass = request.getParameter("currentPass");
		   String email = (String)request.getSession().getAttribute("login");
		   Member dbMem = dao.selectOneEmail(email);
		   if(!dbMem.getPassword().equals(currentPass)) {
			   request.setAttribute("msg", "비밀번호가 틀립니다.");
			   request.setAttribute("url", "pwChgUpdateForm?email="+email);
			   return "alert";
		   } else {
			   if(dao.updatePass(email, pass)) {
				   request.setAttribute("msg", "비밀번호가 수정되었습니다.");
				   return "self_close";
			   } else {
				   request.setAttribute("msg", "비밀번호 수정 실패.");
				   request.setAttribute("url", "pwChgUpdateForm");
				   return "alert";
			   }
		   }
	   }
}

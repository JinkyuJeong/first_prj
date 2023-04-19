package controller;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;

import gdu.mskim.MskimRequestMapping;

// /member/ 이후의 어떤 요청이 들어와도 MemberController가 요청됨
@WebServlet(urlPatterns = {"/member/*"},
						initParams = {@WebInitParam(name="view", value="/view/")}
		)
public class MemberController extends MskimRequestMapping{}

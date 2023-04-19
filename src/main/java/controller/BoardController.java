package controller;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;

import gdu.mskim.MskimRequestMapping;

@WebServlet(urlPatterns = {"/board/*"},
initParams = {@WebInitParam(name="view", value="/view")}
		)
public class BoardController extends MskimRequestMapping{}

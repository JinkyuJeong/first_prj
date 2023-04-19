package model;
/*
CREATE TABLE board1 (
	  no INT AUTO_INCREMENT PRIMARY KEY,
	  title VARCHAR(255),
	  nickname VARCHAR(255),
	  content TEXT,
	  file1 VARCHAR(255),
	  boardType INT,
	  regdate DATETIME DEFAULT NOW(),
	  hit INT DEFAULT 0,
	  recommend INT DEFAULT 0,
	  pub INT DEFAULT 1
	);
	
	boardType : 1은 자유게시판글 2는 질문게시판글 3은 후기게시판글 4는 공지사항
	*/
import java.util.Date;

import lombok.Data;

@Data
public class Board {
	private int no;
	private String nickname;
	private String title;
	private String content;
	private String file1;
	private Date regdate;
	private String boardType;
	private int hit;
	private int recommend;
	private int pub;
}

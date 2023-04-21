package model;
/*
CREATE TABLE comment (
	  no INT NOT NULL,
	  seq INT NOT NULL,
	  nickname VARCHAR(50) NOT NULL,
	  content TEXT,
	  regdate DATETIME DEFAULT NOW(),
	  recommend INT DEFAULT 0,
	  PRIMARY KEY (no,seq),
	  grp INT,
	  grpLevel INT,
	  grpStep INT,
	  FOREIGN KEY (NO) REFERENCES board(no) ON DELETE CASCADE,
	  FOREIGN KEY (nickname) REFERENCES member(nickname) ON DELETE CASCADE
);
*/

import java.util.Date;

import lombok.Data;
@Data
public class Comment {
	private int no;
	private int seq;
	private String nickname;
	private String content;
	private Date regdate;
	private int recommend;
	private int grp;
	private int grpLevel;
	private int grpStep;
}

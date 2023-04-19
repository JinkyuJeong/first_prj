package model;

import java.util.Date;

import lombok.Data;
import lombok.Getter;
import lombok.ToString;

@Data
public class Board {
	private int num;
	private String writer;
	private String pass;
	private String title;
	private String content;
	private String file1;
	private String boardId;
	private Date regDate;
	private int readcnt;
	private int grp;
	private int grpLevel;
	private int grpStep;
}

package model;

import java.util.Date;

import lombok.Data;
import lombok.Getter;
import lombok.ToString;

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

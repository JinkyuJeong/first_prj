package model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import model.Board;

public interface BoardMapper {
	
	@Insert("insert into board (title, nickname, content, file1, boardType) values (#{title}, #{nickname}, #{content}, #{file1}, #{boardType})")
	int insert(Board b);

	String sqlField = " and ( ${field1} like '%${query}%' " + " <if test='field2 != null'> or ${field2} like '%${query}%' </if> ";
	@Select("<script>"
			+ " SELECT * FROM (SELECT b.*, m.picture from board b, member m WHERE b.nickname = m.nickname) b "
			+ " WHERE BOARDTYPE=#{boardType} "
			+ sqlField
			+ " ) ORDER BY NO DESC LIMIT #{start}, #{limit} "
			+ " </script>")
	List<Board> list(Map<String, Object> map);

	@Select("<script>"
			+ " SELECT COUNT(*) FROM (SELECT b.*, m.picture from board b, member m WHERE b.nickname = m.nickname) b "
			+ " WHERE BOARDTYPE=#{boardType} "
			+ sqlField
			+ " ) </script>")
	int boardCount(Map<String, Object> map);

	@Select("SELECT * FROM board WHERE BOARDTYPE=4 and PUB=1 ORDER BY regdate DESC LIMIT 1")
	Board getRecentBoard();

	@Select("SELECT * FROM board WHERE boardType=4 and PUB=1 ORDER BY regdate ASC LIMIT 1")
	Board getOldestBoard();
}

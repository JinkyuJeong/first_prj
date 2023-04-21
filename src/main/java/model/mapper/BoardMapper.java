package model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Board;

public interface BoardMapper {
	@Select("SELECT ifnull(MAX(Num),0) FROM board")
	int maxnum();

	@Insert("INSERT INTO board (num, writer, pass, title, content, file1, regdate, readcnt, grp, grplevel, grpstep, boardid) "
			+ " values (#{num}, #{writer}, #{pass}, #{title}, #{content}, #{file1}, now(), 0, #{grp}, #{grpLevel}, #{grpStep}, #{boardId})")
	int insert(Board b);

	String sqlcol =  " <if test='column != null'> and ( ${col1} like '%${find}%' "
			+ " <if test='col2 == null'> ) </if> "
			+ " <if test='col2 != null'> or ${col2} like '%${find}%' </if> "
			+ " <if test='col3 == null and col2 != null'> ) </if> "
			+ " <if test='col3 != null'> or ${col3} like '%${find}%' )</if></if> ";
	
	@Select("<script> "
			+ " SELECT COUNT(*) FROM BOARD WHERE BOARDID=#{boardid} "
			+ sqlcol
			+ " </script>")
	int boardCount(Map<String, Object> map);

	@Select("<script> SELECT *, (SELECT COUNT(*) FROM comment c WHERE c.num = b.num) commcnt "
			+ " FROM BOARD b "
			+ " WHERE BOARDID=#{boardid} "
			+ sqlcol
			+ " ORDER BY GRP DESC, GRPSTEP LIMIT #{start},#{limit} </script>")
	List<Board> selectList(Map<String, Object> map);

	@Select("select * from board where num=#{value}")
	Board selectOne(int num);

	@Update("update board set readcnt = readcnt+1 where num=#{value}")
	void readcntAdd(int num);

	@Update("update board set grpstep = grpstep+1 where grp=#{grp} and grpstep>#{grpstep}")
	void grpStepAdd(@Param("grp")int grp,@Param("grpstep")int grpstep);

	@Update("update board set writer=#{writer}, title=#{title}, content=#{content}, file1=#{file1} where num=#{num}")
	int update(Board b);

	@Delete("delete from board where num=#{value}")
	int delete(int num);

}

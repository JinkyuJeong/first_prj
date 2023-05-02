package model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Messenger;

public interface MessengerMapper {

	@Insert("insert into msg (sender, receiver, content) values (#{sender}, #{receiver}, #{content})")
	void insert(Messenger messenger);

	@Select("SELECT * FROM msg where receiver=#{value} ORDER BY no DESC LIMIT 1;")
	Messenger selectLatest(String nickname);

	@Select("SELECT * FROM msg"
			+ " WHERE (receiver = #{receiver} AND sender = #{nickname})"
			+ " OR (receiver = #{nickname} AND sender = #{receiver})"
			+ " ORDER BY regdate ASC")
	List<Messenger> selectMsgs(@Param("receiver")String receiver, @Param("nickname")String nickname);

	@Select("SELECT DISTINCT"
			+ " CASE WHEN sender=#{value} THEN receiver"
			+ " ELSE sender"
			+ " END AS correspondent"
			+ " FROM msg"
			+ " WHERE receiver=#{value} OR sender=#{value}"
			+ " ORDER BY regdate desc")
	List<String> selectSenders(String nickname);

	@Update("update msg set isRead='1' where receiver=#{nickname} and sender=#{receiver}")
	void read(@Param("nickname")String nickname, @Param("receiver")String receiver);

	@Select("select count(*) from msg where receiver=#{value} and isRead='0'")
	int notReadCnt(String nickname);

	@Select("select count(*) from msg where (receiver=#{nickname} and sender=#{receiver}) and isRead='0'")
	int notRadCntSep(@Param("nickname")String nickname, @Param("receiver")String receiver);
}

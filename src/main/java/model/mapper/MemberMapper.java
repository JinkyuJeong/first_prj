package model.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Member;

public interface MemberMapper {
	@Insert("insert into member (emailaddress, password, nickname, picture, regdate) "
			+ "values (#{emailaddress}, #{password}, #{nickname}, #{picture}, now())")
	int insert(Member mem);

	@Select("select * from member where nickname=#{value}")
	Member selectOneNick(String nickname);

	@Select("select * from member where emailaddress=#{value}")
	Member selectOneEmail(String email);

	@Update("update member set nickname=#{nickname}, picture=#{picture} where emailaddress=#{emailaddress}")
	int update(Member mem);

	@Delete("delete from member where emailaddress=#{value}")
	int delete(String email);

	@Update("update member set password=#{param2} where emailaddress=#{param1}")
	int updatePass(String email, String pass);

}

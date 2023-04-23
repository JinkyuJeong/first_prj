package model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import model.Comment;
import model.CommentListView;

public interface CommentMapper {

	@Select("SELECT ifnull(MAX(seq),0) cnt FROM comment where no=#{value}")
	int maxSeq(int no);

	@Insert("insert into comment "
			+ " (no, seq, nickname, content, grp, grpLevel, grpStep) values "
			+ " (#{no}, #{seq}, #{nickname}, #{content}, #{grp}, #{grpLevel}, #{grpStep})")
	int insert(Comment comm);

	@Select("select * from commentListView where no=#{value} ORDER BY GRP DESC, GRPSTEP LIMIT 0, 10")
	List<CommentListView> list(int no);

	@Select("select count(*) from comment where no=#{value}")
	int commCnt(int no);
	
	
}

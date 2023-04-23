package model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import model.mapper.CommentMapper;

public class CommentMybatisDao {
	private static Class<CommentMapper> cls = CommentMapper.class;
	
	public int maxSeq(int no) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).maxSeq(no);
			return cnt;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		
		return 0;
	}

	public boolean insert(Comment comm) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).insert(comm);
			return cnt>0;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		
		return false;
	}

	public List<CommentListView> list(int no) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			return session.getMapper(cls).list(no);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		
		return null;
	}

	public int commCnt(int no) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			return session.getMapper(cls).commCnt(no);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return 0;
	}

}

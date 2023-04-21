package model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import model.mapper.BoardMapper;

public class BoardMybatisDao {
	private static Class<BoardMapper> cls = BoardMapper.class;
	private static Map<String, Object> map = new HashMap<>();
	
	//게시물 등록
	public boolean insert(Board b) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).insert(b);
			return cnt>0;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		
		return false;
	}

	// 검색기능에 따른 게시물 카운트 수정해야함
	public int boardCount(String boardType, String field, String query) {
		SqlSession session = MybatisConnection.getConnection();
		
		try {
			map.clear();
			map.put("boardType", boardType);
			String[] fields = field.split("\\+");
			if(fields.length == 2) {
				map.put("field1", fields[0]);
				map.put("field2", fields[1]);
			}else {
				map.put("field1", field);
				map.put("field2", null);
			}
			map.put("query",query);
			
			return session.getMapper(cls).boardCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		
		return 0;
	}

	public List<Board> list(String boardType, int pageNum, int limit, String field, String query) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			map.clear();
			map.put("boardType", boardType);
			String[] fields = field.split("\\+");
			if(fields.length > 1) {
				map.put("field1", fields[0]);
				map.put("field2", fields[1]);
			}else {
				map.put("field1", field);
				map.put("field2", null);
			}
			map.put("query", query);
			map.put("start", (pageNum -1) * limit);
			map.put("limit", limit);
			
			return session.getMapper(cls).list(map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			MybatisConnection.close(session);
		}
	
		return null;
	}
	
	public List<Board> nList() {
		SqlSession session = MybatisConnection.getConnection();
		try {
			List<Board> list = new ArrayList<>();
			list.add(session.getMapper(cls).getOldestBoard());
			list.add(session.getMapper(cls).getRecentBoard());
			
			// 공지사항이 1개일 경우
			if(list.size() == 2 && list.get(0).getNo() == list.get(1).getNo()) list.remove(1);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			MybatisConnection.close(session);
		}
	
		return null;
	}
}		
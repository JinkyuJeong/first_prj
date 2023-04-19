package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BoardDao {
	//게시물 등록
	public boolean insert(Board b) {
		Connection con = DBConnection.getConnection();
		
		String sql = "INSERT INTO board "
				+ "(title, nickname, content, file1, boardType) "
				+ "values (?,?,?,?,?)";
		
		PreparedStatement pstmt = null;
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, b.getTitle());
			pstmt.setString(2, b.getNickname());
			pstmt.setString(3, b.getContent());
			pstmt.setString(4, b.getFile1());
			pstmt.setString(5, b.getBoardType());
			
			if(pstmt.executeUpdate() > 0) return true;
			else return false;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(con, pstmt, null);
		}
		
		return false;
	}

	public int boardCount(String boardType) {
		Connection con = DBConnection.getConnection();
		
		String sql = "SELECT COUNT(*) FROM BOARD WHERE BOARDTYPE=?";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardType);
			rs = pstmt.executeQuery();
			
			if(rs.next()) return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(con, pstmt, null);
		}
		
		return 0;
	}

	public List<Board> list(String boardType, int pageNum, int limit) {
		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM BOARD  WHERE BOARDTYPE=? and PUB=1 ORDER BY NO DESC LIMIT ?,?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Board> list = new ArrayList<>();
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardType);
			pstmt.setInt(2, (pageNum -1) * limit);
			pstmt.setInt(3, limit);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Board b = new Board();
				b.setTitle(rs.getString("title"));
				b.setContent(rs.getString("content"));
				b.setFile1(rs.getString("file1"));
				b.setNickname(rs.getString("nickname"));
				b.setRegdate(rs.getTimestamp("regdate"));
				b.setHit(rs.getInt("hit"));
				b.setRecommend(rs.getInt("recommend"));
				
				list.add(b);
			}
			
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(con, pstmt, rs);
		}
	
		return null;
	}
}		
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
		
		String sql = "INSERT INTO board1 "
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

	// 검색기능에 따른 게시물 카운트 수정해야함
	public int boardCount(String boardType) {
		Connection con = DBConnection.getConnection();
		
		String sql = "SELECT COUNT(*) FROM BOARD1 WHERE BOARDTYPE=?";
		
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

	public List<Board> list(String boardType, int pageNum, int limit, String filed, String query) {
		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM BOARD1  WHERE BOARDTYPE=? and " + filed +" like ? ORDER BY NO DESC LIMIT ?,?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Board> list = new ArrayList<>();
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardType);
			pstmt.setString(2, "%"+ query +"%");
			pstmt.setInt(3, (pageNum -1) * limit);
			pstmt.setInt(4, limit);
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
				b.setPub(rs.getInt("pub"));
				
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
	
	public List<Board> nList() {
		Connection con = DBConnection.getConnection();
		String sql1 = "SELECT * FROM BOARD1 WHERE BOARDTYPE=4 and PUB=1 ORDER BY regdate DESC LIMIT 1";
		String sql2 = "SELECT * FROM board1 WHERE boardType=4 and PUB=1 ORDER BY regdate ASC LIMIT 1;";
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		List<Board> list = new ArrayList<>();
		
		try {
			pstmt2 = con.prepareStatement(sql2);
			rs2 = pstmt2.executeQuery();
			
			if(rs2.next()) {
				Board b = new Board();
				b.setTitle(rs2.getString("title"));
				b.setFile1(rs2.getString("file1"));
				b.setRegdate(rs2.getTimestamp("regdate"));
				b.setHit(rs2.getInt("hit"));
				
				list.add(b);
			}
			
			pstmt1 = con.prepareStatement(sql1);
			rs1 = pstmt1.executeQuery();
			
			if(rs1.next()) {
				Board b = new Board();
				b.setTitle(rs1.getString("title"));
				b.setFile1(rs1.getString("file1"));
				b.setRegdate(rs1.getTimestamp("regdate"));
				b.setHit(rs1.getInt("hit"));
				
				list.add(b);
			}
			
			// 공지사항이 1개일 경우
			if(list.size() == 1 && list.get(0).getNo() == list.get(1).getNo()) list.remove(1);
			
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(con, pstmt1, rs1);
			DBConnection.close(con, pstmt2, rs2);
		}
	
		return null;
	}
}		
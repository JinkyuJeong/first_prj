package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDao {

	public boolean insert(Member mem) {
		Connection con = DBConnection.getConnection();
		PreparedStatement pstmt = null;
		String sql = "insert into member (emailaddress, password, nickname, picture, regdate) values (?,?,?,?,now())";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mem.getEmailaddress());
			pstmt.setString(2, mem.getPassword());
			pstmt.setString(3, mem.getNickname());
			pstmt.setString(4, mem.getPicture());
			if(pstmt.executeUpdate()>0) return true;
			else return false;
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(con, pstmt, null);
		}
		return false;
	}

	public Member selectOneNick(String nickname) {
		Connection con = DBConnection.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from member where nickname=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nickname);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Member mem = new Member();
				mem.setEmailaddress(rs.getString("emailaddress"));
				mem.setNickname(rs.getString("nickname"));
				mem.setPassword(rs.getString("password"));
				mem.setPicture(rs.getString("picture"));
				mem.setRegdate(rs.getDate("regdate"));
				return mem;
			}			
		} catch(SQLException e) {
			e.printStackTrace(); 
		} finally {
			DBConnection.close(con, pstmt, rs);
		}
		return null;
	}
	
	//로그인
	public Member selectOneEmail(String email) {
		Connection con = DBConnection.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from member where emailaddress=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Member mem = new Member();
				mem.setEmailaddress(rs.getString("emailaddress"));
				mem.setNickname(rs.getString("nickname"));
				mem.setPassword(rs.getString("password"));
				mem.setPicture(rs.getString("picture"));
				mem.setRegdate(rs.getDate("regdate"));
				return mem;
			}			
		} catch(SQLException e) {
			e.printStackTrace(); 
		} finally {
			DBConnection.close(con, pstmt, rs);
		}
		return null;
	}

	public boolean update(Member mem) {
		Connection con = DBConnection.getConnection();
		PreparedStatement pstmt = null;
		String sql = "update member set nickname=?, picture=? where emailaddress=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mem.getNickname());
			pstmt.setString(2, mem.getPicture());
			pstmt.setString(3, mem.getEmailaddress());
			if(pstmt.executeUpdate()>0) return true;
			else return false;
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(con, pstmt, null);
		}
		return false;
	}
	
}

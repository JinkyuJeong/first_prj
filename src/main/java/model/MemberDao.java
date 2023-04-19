package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

// db관련 함수들의 모음
public class MemberDao {
	// 비밀번호 변경
	public boolean updatePass(String id, String chgpass) {
		Connection con = DBConnection.getConnection();
		
		String sql = "update member set pass=? where id=?";
		
		PreparedStatement pstmt = null;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, chgpass);
			pstmt.setString(2, id);
			if(pstmt.executeUpdate() > 0) return true;
			else return false;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(con, pstmt, null);
		}
		
		return false;
	}
	// 비밀번호 찾기
	public String pwSearch(String id, String tel, String email) {
		Connection con = DBConnection.getConnection();
		
		String sql = "select pass from member where id=? and tel=? and email=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, tel);
			pstmt.setString(3, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString("pass");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(con, pstmt, rs);
		}
		return null;
	}
	// 아이디 찾기
	public String idSearch(String tel, String email) {
		Connection con = DBConnection.getConnection();
		
		String sql = "select id from member where tel=? and email=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, tel);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString("id");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(con, pstmt, rs);
		}
		return null;
	}
	// 등록
	public boolean insert(Member mem) {
		Connection con = DBConnection.getConnection();
		
		String sql = "INSERT INTO member (id, pass, NAME, gender, tel, email, picture) VALUES (?, ?, ?, ?, ?, ?, ?)";
		
		PreparedStatement pstmt = null;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mem.getId());
			pstmt.setString(2, mem.getPass());
			pstmt.setString(3, mem.getName());
			pstmt.setInt(4, mem.getGender());
			pstmt.setString(5, mem.getTel());
			pstmt.setString(6, mem.getEmail());
			pstmt.setString(7, mem.getPicture());
			if(pstmt.executeUpdate() > 0) return true;
			else return false;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(con, pstmt, null);
		}
		
		return false;
	}
	
	// 변경
	public boolean update(Member mem) {
		Connection con = DBConnection.getConnection();
		
		String sql = "Update member set name=?, gender=?, tel=?, email=?, picture=? where id=?";
		
		PreparedStatement pstmt = null;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mem.getName());
			pstmt.setInt(2, mem.getGender());
			pstmt.setString(3, mem.getTel());
			pstmt.setString(4, mem.getEmail());
			pstmt.setString(5, mem.getPicture());
			pstmt.setString(6, mem.getId());
			if(pstmt.executeUpdate() > 0) return true;
			else return false;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(con, pstmt, null);
		}
		
		return false;
	}
	
	// 삭제
	public boolean delete(String id) {
		Connection con = DBConnection.getConnection();
		
		String sql = "delete from member where id = ?";
		
		PreparedStatement pstmt = null;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			if(pstmt.executeUpdate() > 0) return true;
			else return false;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(con, pstmt, null);
		}
		
		return false;
	}
	
	// 1개의 데이터 조회
	public Member selectOne(String id) {
		Connection con = DBConnection.getConnection();
		String sql = "select * from member where id=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				Member mem = new Member();
				mem.setId(rs.getString("id"));
				mem.setPass(rs.getString("pass"));
				mem.setName(rs.getString("name"));
				mem.setGender(rs.getInt("gender"));
				mem.setTel(rs.getString("tel"));
				mem.setEmail(rs.getString("email"));
				mem.setPicture(rs.getString("picture"));
				
				return mem;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(con, pstmt, rs);
		}
	
		return null;
	}
	
	// 여러개 데이터 조회
	public List<Member> list() {
		Connection con = DBConnection.getConnection();
		String sql = "select * from member";
		Statement stmt = null;
		ResultSet rs = null;
		List<Member> list = new ArrayList<>();
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			Member mem=null;
			while(rs.next()) {
				mem = new Member();
				mem.setId(rs.getString("id"));
				mem.setPass(rs.getString("pass"));
				mem.setName(rs.getString("name"));
				mem.setGender(rs.getInt("gender"));
				mem.setTel(rs.getString("tel"));
				mem.setEmail(rs.getString("email"));
				mem.setPicture(rs.getString("picture"));
				
				list.add(mem);
			}
			
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(con, stmt, rs);
		}
	
		return null;
	}
	// 메일보내기, 체크된 사람 리스트
	public List<Member> selectEmail(String[] ids){
		List<Member> list = new ArrayList<>();
		StringBuilder sb = new StringBuilder();
		for(int i=0; i<ids.length; i++) {
			sb.append("'" + ids[i] + ((i<ids.length-1)?"',":"'"));
		}
		
		Connection con = DBConnection.getConnection();
		String sql = "select * from member where id in(" + sb.toString() + ")";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Member mem = new Member();
				mem.setId(rs.getString("id"));
				mem.setPass(rs.getString("pass"));
				mem.setName(rs.getString("name"));
				mem.setGender(rs.getInt("gender"));
				mem.setTel(rs.getString("tel"));
				mem.setEmail(rs.getString("email"));
				mem.setPicture(rs.getString("picture"));
				
				list.add(mem);
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

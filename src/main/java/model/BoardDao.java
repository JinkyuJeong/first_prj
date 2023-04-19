package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BoardDao {
	// 게시글 삭제
	public boolean delete(int num) {
		Connection con = DBConnection.getConnection();
		
		String sql = "delete from board where num=?";
		
		PreparedStatement pstmt = null;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			if(pstmt.executeUpdate() > 0) return true;
			else return false;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(con, pstmt, null);
		}
		
		return false;
	}
	// 게시글 수정
	public boolean update(Board b) {
		Connection con = DBConnection.getConnection();
		
		String sql = "update board set writer=?, title=?, content=?, file1=? where num=?";
		
		PreparedStatement pstmt = null;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, b.getWriter());
			pstmt.setString(2, b.getTitle());
			pstmt.setString(3, b.getContent());
			pstmt.setString(4, b.getFile1());
			pstmt.setInt(5, b.getNum());
			if(pstmt.executeUpdate() > 0) return true;
			else return false;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(con, pstmt, null);
		}
		
		return false;
	}
	// 답글추가
	public void grpStepAdd(int grp, int grpstep) {
		Connection con = DBConnection.getConnection();
		
		String sql = "update board set grpstep = grpstep+1 where grp=? and grpstep>?";
		
		PreparedStatement pstmt = null;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, grp);
			pstmt.setInt(2, grpstep);
			pstmt.executeQuery();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(con, pstmt, null);
		}
	}
	// 조회수 증가
	public void readcntAdd(int num) {
		Connection con = DBConnection.getConnection();
		
		String sql = "update board set readcnt = readcnt+1 where num=?";
		
		PreparedStatement pstmt = null;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeQuery();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(con, pstmt, null);
		}
	}
	//1개의 데이터 조회
	public Board selectOne(int num) {
		Connection con = DBConnection.getConnection();
		String sql = "select * from board where num=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				Board b = new Board();
				b.setNum(rs.getInt("num"));
				b.setWriter(rs.getString("writer"));
				b.setPass(rs.getString("pass"));
				b.setTitle(rs.getString("title"));
				b.setContent(rs.getString("content"));
				b.setFile1(rs.getString("file1"));
				b.setBoardId(rs.getString("boardid"));
				b.setRegDate(rs.getTimestamp("regdate"));
				b.setReadcnt(rs.getInt("readcnt"));
				b.setGrp(rs.getInt("grp"));
				b.setGrpLevel(rs.getInt("grplevel"));
				b.setGrpStep(rs.getInt("grpstep"));
				
				return b;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.close(con, pstmt, rs);
		}
	
		return null;
	}
	// 게시물 종류별 리스트
	public List<Board> list(String boardid, int pageNum, int limit){
		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM BOARD WHERE BOARDID=? ORDER BY GRP DESC, GRPSTEP LIMIT ?,?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Board> list = new ArrayList<>();
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardid);
			pstmt.setInt(2, (pageNum -1) * limit);
			pstmt.setInt(3, limit);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Board b = new Board();
				b.setNum(rs.getInt("num"));
				b.setWriter(rs.getString("writer"));
				b.setPass(rs.getString("pass"));
				b.setTitle(rs.getString("title"));
				b.setContent(rs.getString("content"));
				b.setFile1(rs.getString("file1"));
				b.setBoardId(rs.getString("boardid"));
				b.setRegDate(rs.getTimestamp("regdate"));
				b.setReadcnt(rs.getInt("readcnt"));
				b.setGrp(rs.getInt("grp"));
				b.setGrpLevel(rs.getInt("grplevel"));
				b.setGrpStep(rs.getInt("grpstep"));
				
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
	// 게시물 갯수 구하기
	public int boardCount(String boardid) {
		Connection con = DBConnection.getConnection();
		
		String sql = "SELECT COUNT(*) FROM BOARD WHERE BOARDID=?";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(con, pstmt, null);
		}
		
		return 0;
	}
	// 테이블 최신번호 구하기
	public int maxNum() {
		Connection con = DBConnection.getConnection();
		
		String sql = "SELECT ifnull(MAX(Num),0) cnt FROM board";
		int result = 0;
		
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) return result = rs.getInt("cnt");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(con, stmt, null);
		}
		return result;
	}
	// 게시물 등록
	public boolean insert(Board b) {
		Connection con = DBConnection.getConnection();
		
		String sql = "INSERT INTO board values (?,?,?,?,?,?,?,?,?,?,?,?)";
		
		PreparedStatement pstmt = null;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, b.getNum());
			pstmt.setString(2, b.getWriter());
			pstmt.setString(3, b.getPass());
			pstmt.setString(4, b.getTitle());
			pstmt.setString(5, b.getContent());
			pstmt.setString(6, b.getFile1());
			pstmt.setString(7, b.getBoardId());
			b.setRegDate(new Date(System.currentTimeMillis()));
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			pstmt.setString(8, sf.format(b.getRegDate()));
			pstmt.setInt(9, b.getReadcnt());
			pstmt.setInt(10, b.getGrp());
			pstmt.setInt(11, b.getGrpLevel());
			pstmt.setInt(12, b.getGrpStep());
			if(pstmt.executeUpdate() > 0) return true;
			else return false;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(con, pstmt, null);
		}
		
		return false;
	}
}

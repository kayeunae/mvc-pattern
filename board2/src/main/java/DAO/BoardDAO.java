package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import DTO.Board;

//리소스 방식
public class BoardDAO {
	//상수로 드라이버 연결
	final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
    final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:xe";
	
    //데이터베이스와의 연결을 수행하는 메소드
    public Connection open() {
    	Connection conn = null;
    	try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(JDBC_URL, "test", "test1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return conn;  //데이터베이스의 연결 객체를 리턴
    }
    
    //게시판 리스트 가져오는 메소드
    //exception이 발생하면 getList 메소드를 실행시키는 곳으로 에러를 던진다.
    public ArrayList<Board> getList() throws Exception {
    	Connection conn = open();
    	ArrayList<Board> boardList = new ArrayList<>();	//데이터(Board 객체) 저장할 arraylist
    	
    	String sql = "select board_no, title, user_id, to_char(reg_date, 'yyyy.mm.dd') reg_date, views from board order by board_no desc";
    	PreparedStatement pstmt = conn.prepareStatement(sql);	//쿼리문 등록 -> 컴파일
    	ResultSet rs = pstmt.executeQuery();	//쿼리문 실행 -> 데이터베이스 결과 저장
    	
    	//리소스 자동 닫기(try-with-resource 구문)
    	//try(~~) 괄호 안에 있는 친구들은 try문이 끝나면 자동으로 닫힌다.
    	try(conn; pstmt; rs) {
    		while(rs.next()) {
    			Board b = new Board();
    			b.setBoard_no(rs.getInt(1));
    			b.setTitle(rs.getString(2));
    			b.setUser_id(rs.getString(3));
    			b.setReg_date(rs.getString(4));
    			b.setView(rs.getInt(5));
    		
    			boardList.add(b);
    		}
    	} 
    	return boardList;
    } 
    
    //게시글 조회
    public Board getView(int board_no) throws Exception {
    	Connection conn = open();
    	ArrayList<Board> boardList = new ArrayList<>();	//데이터(Board 객체) 저장할 arraylist
    	Board b = new Board();
    	
    	String sql = "select board_no, title, user_id, to_char(reg_date, 'yyyy.mm.dd') reg_date, views, content from board where board_no = ?";
    	PreparedStatement pstmt = conn.prepareStatement(sql);	//쿼리문 등록 -> 컴파일
    	pstmt.setInt(1, board_no);    	
    	ResultSet rs = pstmt.executeQuery();	//쿼리문 실행 -> 데이터베이스 결과 저장
    	
    	try(conn; pstmt; rs) {
    		while(rs.next()) {
    			b.setBoard_no(rs.getInt(1));
    			b.setTitle(rs.getString(2));
    			b.setUser_id(rs.getString(3));
    			b.setReg_date(rs.getString(4));
    			b.setView(rs.getInt(5));
    			b.setContent(rs.getString(6));
    		}
    		return b;
    	} 
    }
    
    //조회수 증가
    public void updateView(int board_no) throws Exception {
    	Connection conn = open();
    	
    	String sql = "update board set views = (views + 1) where board_no = ?";
    	PreparedStatement pstmt = conn.prepareStatement(sql);	//쿼리문 등록 -> 컴파일
    
    	try(conn; pstmt) {
    		pstmt.setInt(1, board_no);
    		pstmt.executeUpdate();
    	}
    
    }
    
    //게시판 글 등록
    public void insertBoard(Board b) throws Exception {
    	Connection conn = open();
    	String sql = "insert into board (board_no, user_id, title, content, reg_date, views) values(board_seq.nextval, ?, ?, ?, sysdate, 0)";
    	
    	PreparedStatement pstmt = conn.prepareStatement(sql);
    	
    	try(conn; pstmt) {
    		pstmt.setString(1, b.getUser_id());
    		pstmt.setString(2, b.getTitle());
    		pstmt.setString(3, b.getContent());
    		pstmt.executeUpdate();
    	}
    }
}
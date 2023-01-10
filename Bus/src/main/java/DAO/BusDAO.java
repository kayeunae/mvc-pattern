package DAO;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import DTO.Bus;
import DTO.Inquiry;
import DTO.Modify;
import DTO.Passenger;
import DTO.Reservation;

public class BusDAO {
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
	    
	    
	    //버스 시간표 가져오기
	    public ArrayList<Bus> getView() throws Exception{
	    	Connection conn = open();
	    	ArrayList<Bus> busTime = new ArrayList<>();
	    	
	    	String sql = "SELECT BUS_NO, DEPART, ARRIVAL, D_TIME, DURATION, CHARGE FROM BUS ORDER BY DEPART ASC";
			PreparedStatement pstmt;
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
	    	
	    	try(conn; pstmt; rs) {
	    		while(rs.next()) {
	    			Bus bus = new Bus();
	    			bus.setBus_no(rs.getString(1));
	    			bus.setDepart(rs.getString(2));
	    			bus.setArrival(rs.getString(3));
	    			bus.setD_time(rs.getString(4));
	    			bus.setDuration(rs.getString(5));
	    			bus.setCharge(rs.getInt(6));
	    			
	    			busTime.add(bus);
	    		}
	    	}
	    	return busTime;
	    }
	    
	    public Bus getBus(String bus_no) throws Exception {
	    	Connection conn = open();
	    	Bus bus = new Bus();
	    	
	    	String sql = "SELECT BUS_NO, DEPART, ARRIVAL, D_TIME, A_TIME, DURATION, CHARGE FROM BUS WHERE BUS_NO = '" + bus_no + "'";
	    	PreparedStatement pstmt = conn.prepareStatement(sql);
	    	ResultSet rs = pstmt.executeQuery();
	    	
	    	try(conn; pstmt; rs) {
	    		
	    		while(rs.next()) {
	    		bus.setBus_no(rs.getString(1));
	    		bus.setDepart(rs.getString(2));
	    		bus.setArrival(rs.getString(3));
	    		bus.setD_time(rs.getString(4));
	    		bus.setA_time(rs.getString(5));
	    		bus.setDuration(rs.getString(6));
	    		bus.setCharge(rs.getInt(7));
	    		}
	    	}
	    	return bus;
	    }
	    
	    public String check(Passenger passenger) throws Exception {
	    	Connection conn = open();
	    	
	    	String sql = "SELECT ID FROM PASSENGER WHERE ID = ?";
	    	PreparedStatement pstmt = conn.prepareStatement(sql);
	    	pstmt.setString(1, passenger.getId());
	    	ResultSet rs = pstmt.executeQuery();
	    	
	    	try (conn; pstmt; rs) {
	    		
	    		if (rs.next()) {
	    			return "1";  
	    		}
	    		else {
	    			return "0";  
	    		}
	    	}

	    }
	    
	    public void signUp(Passenger passenger) throws Exception {
	    	Connection conn = open();
	    	
	    	String sql = "INSERT INTO PASSENGER VALUES(?, ?, ?, ?, ?)";
	    	PreparedStatement pstmt = conn.prepareStatement(sql);
	    	
	    	try(conn; pstmt) {
	    		pstmt.setString(1, passenger.getId());
	    		pstmt.setString(2, passenger.getPw());
	    		pstmt.setString(3, passenger.getName());
	    		pstmt.setString(4, passenger.getBirth());
	    		pstmt.setString(5, passenger.getPhone());
	    		pstmt.executeUpdate();
	    	}
	    }
	    
	    public String reserve(Reservation rev) throws Exception {
	    	Connection conn = open();
	    	
	    	String sql = "SELECT ID FROM PASSENGER WHERE ID = ?";
	    	PreparedStatement pstmt = conn.prepareStatement(sql);
	    	pstmt.setString(1, rev.getId());
	    	ResultSet rs = pstmt.executeQuery();
	    	
	    	try(conn; pstmt; rs) {
	    		if(rs.next()) {
	    	    	return "1";
	    		} else {
	    			return "0";
	    		}
	    	}
	    }
	    public int CountResv() throws Exception {
			Connection conn = open();
			String sql = "select count(*) from bus";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();		
			try (conn; pstmt; rs) {
				if(rs.next()) {
					return rs.getInt(1);
				}
				else {return rs.getInt(1);}
			}
		}
	    
	    
	    public void insertRev(Reservation rev) throws Exception {
	    	Connection conn = open();
	    	
	    	String sql = "INSERT INTO RESERVATION VALUES(R_SEQ.NEXTVAL, ?, ?, ?, ?)";
	    	PreparedStatement pstmt = conn.prepareStatement(sql);
	    	
	    	try(conn; pstmt) {
	    		pstmt.setString(1, rev.getBus_no());
	    		pstmt.setString(2, rev.getId());
	    		pstmt.setInt(3, rev.getTicket());
	    		pstmt.setInt(4, rev.getPrice());
	    		pstmt.executeUpdate();
	    	}
	    }
	    
	    //예약조회 페이지 - 아이디 검색
	    public String inquirCheck(Reservation rev) throws Exception {
	    	Connection conn = open();
	    	
	    	String sql = "SELECT ID FROM PASSENGER WHERE ID = ?";
	    	PreparedStatement pstmt = conn.prepareStatement(sql);
	    	pstmt.setString(1, rev.getId());
	    	ResultSet rs = pstmt.executeQuery();
	    	
	    	try(conn; pstmt; rs) {
	    		if(rs.next()) {
	    
	    	    	return "1";
	    		} else {
	    			return "0";
	    		}
	    	}
	    }
	    
	    public ArrayList<Inquiry> inquirDetail(String id) throws Exception {
	    	Connection conn = open();
	    	ArrayList<Inquiry> inqList = new ArrayList<>();
	    	
	    	String sql = "SELECT A.R_NO, B.DEPART, B.ARRIVAL, B.D_TIME, B.DURATION, A.TICKET FROM RESERVATION A INNER JOIN BUS B ON A.BUS_NO = B.BUS_NO INNER JOIN PASSENGER C ON A.ID = C.ID WHERE A.ID = ?";
	    	PreparedStatement pstmt = conn.prepareStatement(sql);
	    	pstmt.setString(1, id);
	    	ResultSet rs = pstmt.executeQuery();
	    	
	    	try(conn; pstmt; rs) {
	    		while(rs.next()) {
	    			Inquiry inq = new Inquiry();
	    			inq.setR_no(rs.getString(1));
	    			inq.setDepart(rs.getString(2));
	    			inq.setArrival(rs.getString(3));
	    			inq.setD_time(rs.getString(4));
	    			inq.setDuration(rs.getString(5));
	    			inq.setTicket(rs.getInt(6));
	    			
	    			inqList.add(inq);
	    		}
	    		return inqList;
	    	}
	    }
	    
	    public Modify modify(String reserveNo) throws Exception{
	    	Connection conn = open();
	    	
	    	String sql = "SELECT A.R_NO, A.BUS_NO, B.DEPART, B.ARRIVAL, B.D_TIME, B.A_TIME, B.DURATION, A.TICKET, A.PRICE, B.CHARGE, A.ID "
	    			+ "FROM RESERVATION A INNER JOIN BUS B ON A.BUS_NO = B.BUS_NO "
	    			+ "INNER JOIN PASSENGER C ON A.ID = C.ID WHERE R_NO = ?";
	    	
	    	PreparedStatement pstmt = conn.prepareStatement(sql);
	    	pstmt.setString(1, reserveNo);
	    	ResultSet rs = pstmt.executeQuery();
	    	
	    	Modify modi = new Modify();
	    	
	    	try(conn; pstmt) {
	    		while(rs.next()) {
	    			modi.setR_no(rs.getInt(1));
	    			modi.setBus_no(rs.getString(2));
	    			modi.setDepart(rs.getString(3));
	    			modi.setArrival(rs.getString(4));
	    			modi.setD_time(rs.getString(5));
	    			modi.setA_time(rs.getString(6));
	    			modi.setDuration(rs.getString(7));
	    			modi.setTicket(rs.getInt(8));
	    			modi.setPrice(rs.getInt(9));
	    			modi.setCharge(rs.getInt(10));
	    			modi.setId(rs.getString(11));
	    		}
	    	}
	    	return modi;
	    }
	    
	    public void subModify(Reservation reserv) throws Exception{
	    	Connection conn = open();
	    	
	    	String sql ="UPDATE RESERVATION SET BUS_NO = ?, TICKET = ?, PRICE = ? WHERE R_NO = ?";
	    	PreparedStatement pstmt = conn.prepareStatement(sql);
	    	
	    	try(conn; pstmt){
	    		pstmt.setString(1, reserv.getBus_no());
	    		pstmt.setInt(2, reserv.getTicket());
	    		pstmt.setInt(3, reserv.getPrice());
	    		pstmt.setInt(4, reserv.getR_no());
	    		pstmt.executeUpdate();
	    	}
	    }
	    
	    public void subDelete(Reservation reserv) throws Exception {
	    	Connection conn = open();
	    	String sql = "DELETE FROM RESERVATION WHERE R_NO = ?";
	    	PreparedStatement pstmt = conn.prepareStatement(sql);
	    	
	    	try(conn; pstmt){
	    		pstmt.setInt(1, reserv.getR_no());
	    		pstmt.executeUpdate();
	    	}
	    }
}

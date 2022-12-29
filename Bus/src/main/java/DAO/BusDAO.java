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
import DTO.Passenger;

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

}

package DAO;

import java.sql.Connection;
import java.sql.DriverManager;

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
	    
	    
}

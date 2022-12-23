<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
request.setCharacterEncoding("UTf-8"); /* 데이터를 받아올 때는 인코딩 써줘야 함 ! */
int custno = Integer.parseInt(request.getParameter("custno"));
String custname = request.getParameter("custname");
String phone = request.getParameter("phone");
String address = request.getParameter("address");
String joindate = request.getParameter("joindate");
String grade = request.getParameter("grade");
String city = request.getParameter("city");

String gubun = request.getParameter("gubun"); /* getParameter는 name으로 구분함. add, modify에 input name으로 설정했는지 확인 필수 */

//insert 할 때 멘트
String ment = "회원등록이 완료 되었습니다!";
String error = "회원등록실패!";

int result = 0;

try {
	Class.forName("oracle.jdbc.OracleDriver");
	Connection con = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "system", "sys1234");

	PreparedStatement ps = null;
	ResultSet rs = null;

	/* add할 때는 insert 쿼리문을, modify할 때는 select 쿼리문을 ! */
	/* 이때 input hidden이 필요함 */

	if (gubun.equals("add")) {
		// prepareStatement는 순서에 따라 값이 등록된다.
		String sql = "INSERT INTO member_tbl_02 VALUES(?,?,?,?,TO_DATE(?,'YYYY-MM-DD'),?,?)";
		ps = con.prepareStatement(sql);
		ps.setInt(1, custno);
		ps.setString(2, custname);
		ps.setString(3, phone);
		ps.setString(4, address);
		ps.setString(5, joindate);
		ps.setString(6, grade);
		ps.setString(7, city);
	} else {
		ment = "회원정보 수정이 완료되었습니다.";
		error = "회원정보 수정 실패!";
		
		String sql = "UPDATE member_tbl_02 SET";
		sql += " custname = ? , ";
		sql += " phone = ? , ";
		sql += " address = ? , ";
		sql += " joindate = TO_DATE(?,'YYYY-MM-DD'), ";
		sql += " grade = ? , ";
		sql += " city = ? ";
		sql += " WHERE custno = ? ";
		
		ps = con.prepareStatement(sql);
		ps.setString(1, custname);
		ps.setString(2, phone);
		ps.setString(3, address);
		ps.setString(4, joindate);
		ps.setString(5, grade);
		ps.setString(6, city);
		ps.setInt(7, custno);
	}
	
	result = ps.executeUpdate();
	
	con.close();
	ps.close();

} catch (Exception e) {
	e.printStackTrace();
}

if(result == 1) {%>
<script>
	alert("<%=ment %>");
	location = "index.jsp";
</script>
<%} else { %>
	alert("<%=error %>");
	location = "index.jsp";
<%} %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
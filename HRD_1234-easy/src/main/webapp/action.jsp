<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
request.setCharacterEncoding("UTF-8");
int custno = Integer.parseInt(request.getParameter("custno"));
String custname = request.getParameter("custname");
String phone = request.getParameter("phone");
String address = request.getParameter("address");
String joindate = request.getParameter("joindate");
String grade = request.getParameter("grade");
String city = request.getParameter("city");
String gubun = request.getParameter("gubun");
String ment = "회원등록이 완료 되었습니다!";
String error = "회원등록실패!";
int result = 0;

try {
	Class.forName("oracle.jdbc.OracleDriver");
	Connection con = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1524/xe", "system", "sys1234");

	PreparedStatement ps = null;
	ResultSet rs = null;

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
		ment= "회원정보수정이 완료되었습니다.";
		error = "회원정보수정 실패!";
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

if (result == 1) {
%>
<script>
	alert("<%=ment%>");
	location = "index.jsp";
</script>
<%
} else {
%>
<script>
     alert("<%=error%>");
	location = "index.jsp";
</script>
<%
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
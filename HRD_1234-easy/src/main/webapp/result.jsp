<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<%@ include file="topmenu.jsp"%>
	<section>
		<div class="title">회원매출조회</div>
		<div class="wrapper">
			<table>
				<tr>
					<th>회원번호</th>
					<th>회원성명</th>
					<th>고객등급</th>
					<th>매출</th>
				</tr>
				<%
				try {
					Class.forName("oracle.jdbc.OracleDriver");
					Connection con = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1524/xe", "system", "sys1234");

					Statement stmt = con.createStatement();

					request.setCharacterEncoding("UTF-8");
					String sql = "SELECT m1.custno, m1.custname, DECODE(m1.grade,'A','VIP','B','일반','직원')grade, SUM(m2.price)price ";
				       sql+= "FROM member_tbl_02 m1, money_tbl_02 m2 ";
				       sql+= "WHERE m1.custno = m2.custno ";
				       sql+= "GROUP BY (m1.custno, m1.custname, grade) ";
				       sql+= "ORDER BY price DESC";

					ResultSet rs = stmt.executeQuery(sql);
					while (rs.next()) {
				%>
				<tr>
					<td><%=rs.getInt(1)%></td>
					<td><%=rs.getString(2)%></td>
					<td><%=rs.getString(3)%></td>
					<td><%=rs.getString(4)%></td>
				</tr>
				<%
					}
					con.close();
					stmt.close();

					} catch (Exception e) {
					e.printStackTrace();
					}
				%>
			</table>
		</div>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
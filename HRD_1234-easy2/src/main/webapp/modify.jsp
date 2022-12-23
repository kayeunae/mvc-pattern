<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<%@ include file="topmenu.jsp"%>
	<section>
		<div class="title">홈쇼핑 회원 등록</div>
		<form name="frm" action="action.jsp">
			<input type="hidden" name="gubun" value="modify">
			<div class="wrapper">
				<table>
					<%
					try {
						Class.forName("oracle.jdbc.OracleDriver");
						Connection con = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "system", "sys1234");
						Statement stmt = con.createStatement(); //DB 커넥셕 끝

						String custno = request.getParameter("custno"); //modify.jsp?custno=100002 / custno파라미터 값을 얻어옴

						String sql = "SELECT custname, phone, address, TO_CHAR(joindate,'YYYY-MM-DD') joindate, grade, city ";
						sql += "FROM member_tbl_02 WHERE custno =" + custno;
						
						ResultSet rs = stmt.executeQuery(sql);
						
						while (rs.next()) {
					%>
					<tr>
						<th>회원번호(자동발생)</th>
						<td><input name="custno" value="<%=custno%>" readonly>
						</td>
					</tr>
					<tr>
						<th>회원성명</th>
						<td><input type="text" name="custname"
							value="<%=rs.getString(2)%>"></td>
					</tr>
					<tr>
						<th>회원전화</th>
						<td><input type="text" name="phone"
							value="<%=rs.getString(3)%>"></td>
					</tr>
					<tr>
						<th>회원주소</th>
						<td><input type="text" name="address"
							value="<%=rs.getString(4)%>"></td>
					</tr>
					<tr>
						<th>가입일자</th>
						<td><input type="text" name="joindate"
							value="<%=rs.getString(5)%>"></td>
					</tr>
					<tr>
						<th>고객등급[A:VIP, B:일반, C:직원]</th>
						<td><input type="text" name="grade"
							value="<%=rs.getString(6)%>"></td>
					</tr>
					<tr>
						<th>도시코드</th>
						<td><input type="text" name="city"
							value="<%=rs.getString(7)%>"></td>
					</tr>
					<tr>
						<td colspan="2">
							<button class="btn" type="submit"
								onclick="fn_submit(); return false;">수정</button>
							<button class="btn" type="button" onclick="location='list.jsp'">조회</button>
						</td>
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
		</form>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
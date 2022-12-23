<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<script src="script.js"></script>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<%@ include file="topmenu.jsp"%>
	<section>
		<div class="title">홈쇼핑 회원 등록</div>
		<form name="frm" action="action.jsp">
		<input type="hidden" name="gubun" value="add">
			<div class="wrapper">
				<table>
					<tr>
						<th>회원번호(자동발생)</th>
						<td>
							<%
							try {

								Class.forName("oracle.jdbc.OracleDriver");
								Connection con = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1524/xe", "system", "sys1234");
								Statement stmt = con.createStatement();
								// 회원번호+1 가져오기
								String sql = "SELECT max(custno)+1 custno FROM member_tbl_02";
								ResultSet rs = stmt.executeQuery(sql);
								int custno = 0;
								if (rs.next()) {
							%> <input name="custno" value="<%=rs.getInt(1)%>" readonly>
							<%
							}
							con.close();
							stmt.close();

							} catch (Exception e) {
							e.printStackTrace();
							}
							%>
						</td>
					</tr>
					<tr>
						<th>회원성명</th>
						<td><input type="text" name="custname"></td>
					</tr>
					<tr>
						<th>회원전화</th>
						<td><input type="text" name="phone"></td>
					</tr>
					<tr>
						<th>회원주소</th>
						<td><input type="text" name="address"></td>
					</tr>
					<tr>
						<th>가입일자</th>
						<td><input type="text" name="joindate"></td>
					</tr>
					<tr>
						<th>고객등급[A:VIP,B:일반,C:직원]</th>
						<td><input type="text" name="grade"></td>
					</tr>
					<tr>
						<th>도시코드</th>
						<td><input type="text" name="city"></td>
					</tr>
					<tr>
						<td colspan="2">
							<button class="btn" type="submit"
								onclick="fn_submit(); return false;">등 록</button>
							<button class="btn" type="button" onclick="location='list'">조
								회</button>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "DTO.Rating" %>
<%
request.setCharacterEncoding("UTF-8");
ArrayList<Rating> rating = new ArrayList<Rating>();
rating = (ArrayList<Rating>)request.getAttribute("rating");
 %>
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
		<div class="title">후보자등수</div>
			<div class="wrapper">
				<table class="rate">
					<tr>
						<th>후보번호</th>
						<th>성명</th>
						<th>총투표건수</th>
					</tr>
					<%for(Rating rate : rating) {%>
					<tr>
						<td><%=rate.getNumber() %></td>
						<td><%=rate.getName() %></td>
						<td><%=rate.getCount() %></td>
					</tr>
					<%} %>
				</table>
			</div>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
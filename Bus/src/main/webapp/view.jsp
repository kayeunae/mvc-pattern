<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<%@include file="header.jsp"%>
	<%@include file="topmenu.jsp" %>
		<section>
			<div class="title">시간표 조회</div>
			<div class="wrapper">
				<table class="color">
					<tr>
						<th>차량코드</th>
						<th>출발지</th>
						<th>도착지</th>
						<th>출발시각</th>
						<th>소요시간</th>
						<th>요금</th>
						<th>예약하기</th>
					</tr>
					<c:forEach var="bus" items="${busTime}" varStatus="status">
					<tr>
						<td>${bus.bus_no}</td>
						<td>${bus.depart}</td>
						<td>${bus.arrival}</td>
						<td>${bus.d_time}</td>
						<td>${bus.duration}</td>
						<td>${bus.charge}</td>
						<td>
							<button class="view_btn table_btn" onclick="location.href='./reservation?bus_no=${bus.bus_no}';">예약</button>
						</td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</section>
	<%@include file="footer.jsp"%>
</body>
</html>
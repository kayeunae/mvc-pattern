<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- MVC패턴으로 작업하는 환경 : JSP(java server page). 표기법: "< %@ %>" -->
<!-- jstl : jsp의 라이브러리 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고속버스 통합 서비스</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<!-- jstl 표기법 -->
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
						<td id="money"><fmt:formatNumber value="${bus.charge}" pattern="#,###" /></td>
						<td>
							<button class="table_btn" onclick="location.href='./reservation?bus_no=${bus.bus_no}';">예약</button>
						</td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</section>
	<%@include file="footer.jsp"%>
	<script>
		$(document).ready(function(){
			Object.values(${bus});
			var money = $('#money').val();
			
			var add = money.toString()
				.replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
		})
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="style.css">
<script type="text/javascript" src="./script.js"></script>
</head>
<body>
	<%@include file="header.jsp"%>
	<%@include file="topmenu.jsp" %>
		<section>
			<div class="title">예약 조회</div>
			<div class="subtitle">${id}님의 예약 건</div>
			<div class="inq_wrapper">
				<table class="color">
					<tr>
						<th>예약코드</th>
						<th>출발지</th>
						<th>도착지</th>
						<th>출발시각</th>
						<th>소요시간</th>
						<th>티켓수량</th>
						<th>예약 수정</th>
						<th>예약 취소</th>
					</tr>
					<c:forEach var="inq" items="${inqList}" varStatus="status">
					<tr>
						<td>${inq.r_no}</td>
						<td>${inq.depart}</td>
						<td>${inq.arrival}</td>
						<td>${inq.d_time}</td>
						<td>${inq.duration}</td>
						<td>${inq.ticket}</td>
						<td>
							<button class="table_btn"><a href="./modify?r_no=${inq.r_no}">예약 변경</a></button>
						</td>
						<td>
							<button class="table_btn" type="button" onclick="inq_delete(${inq.r_no});">예약 취소</button>
						</td>
					</tr>
					</c:forEach>
					<form name="frm_inq" method="post" action="delete">
					<input id="delete_no" type="hidden" name="r_no" value="0" />
					<input type="hidden" name="id" value="${id}" />
					</form>
				</table>
				<div class="back">
				<button class="bigbtn" type="button" onclick="location.href='inquiry';">돌아가기</button>
				</div>
			</div>
		</section>
	<%@include file="footer.jsp"%>
</body>
</html>
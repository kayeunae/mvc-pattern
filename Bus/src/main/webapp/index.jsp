<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<%@include file="header.jsp"%>
	<section>
		<div class="wrapper">
			<div class="big" onclick="location.href='view';"><a class="menu">시간표 조회</a></div>
			<div class="big" onclick="location.href='inquiry';"><a class="menu">예약 조회</a></div>
			<div class="big" onclick="location.href='sign';"><a class="menu">회원가입</a></div>
		</div>
	</section>
	<%@include file="footer.jsp"%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고속버스 통합 예매 시스템 - 예약조회</title>
<link rel="stylesheet" href="style.css">
<script type="text/javascript" src="./script.js"></script>
</head>
<body>
	<%@include file="header.jsp"%>
	<%@include file="topmenu.jsp" %>
		<section>
			<div class="title">예약조회</div>
			<div class="wrapper">
				<div class="inq_container">
					<span class="inq_id">ID</span>
					<form class="inq_frm" name="frm_inquiry" method="post" action="inquirSelect">
						<input class="inq_input" type="text" name="id" maxlength="10" />
					</form>
					<button class="inq_btn" type="button" onclick="frm_inquiry_submit();">조회</button>					
				</div>
			</div>
		</section>
	<%@include file="footer.jsp"%>
</body>
</html>
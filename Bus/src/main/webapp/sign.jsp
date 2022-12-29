<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
			<form name="signForm" method="post" action="signUp">
				<div>
					<div class="back">
						<table class="sign">
							<tr>
								<th>아이디</th>
								<td><input type="text" name="id" maxlength="10"></td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td><input type="text" name="pw" maxlength="15"></td>
							</tr>
							<tr>
								<th>이름</th>
								<td><input type="text" name="name" maxlength="6"></td>
							</tr>
							<tr>
								<th>생년월일</th>
								<td><input type="text" name="birth" maxlength="6"></td>
							</tr>
							<tr>
								<th>연락처</th>
								<td><input type="text" name="phone" maxlength="13"></td>
							</tr>
						</table>
					</div> <!-- end of back -->
				</div>
			</form>
				<div>
					<button type="button" onclick="signUP();">회원가입</button>
				</div>
		</section>
	<%@include file="footer.jsp"%>
	<script type="text/javascript" src="./script.js"></script>
</body>
</html>
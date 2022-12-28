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
	<%@include file="topmenu.jsp" %>
		<section>
			<form name="signForm" method="post" action="signUp">
				<div>
					<div class="back">
						<table class="sign">
							<tr>
								<th>ID</th>
								<td><input type="text" name="user_id" maxlength="10"></td>
							</tr>
							<tr>
								<th>이름</th>
								<td><input type="text" name="user_name" maxlength="6"></td>
							</tr>
							<tr>
								<th>생년월일</th>
								<td><input type="text" name="user_birth" maxlength="6"></td>
							</tr>
							<tr>
								<th>연락처</th>
								<td><input type="text" name="user_phone" maxlength="13"></td>
							</tr>
						</table>
					</div> <!-- end fo back -->
				</div>
			</form>
				<div>
					<button type="button" onclick="signUp();">회원가입</button>
				</div>
		</section>
	<%@include file="footer.jsp"%>
</body>
</html>
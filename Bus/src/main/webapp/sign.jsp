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
			<form style="text-align:center;" name="signForm" method="post" action="signUp">
				<div class="title">회원가입</div>
				<div class="wrapper">
					<div class="signback">
						<table class="sign">
							<colgroup>
								<col width="40%">
								<col width="60%">
							</colgroup>
							<tr>
								<th>아이디</th>
								<td><input type="text" id="id" name="id" maxlength="10"
								placeholder="최대 10글자 입력 가능" size="300"></td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td><input type="password" name="pw" maxlength="15"></td>
							</tr>
							<tr>
								<th>이름</th>
								<td><input type="text" id="name" name="name" maxlength="6"></td>
							</tr>
							<tr>
								<th>생년월일</th>
								<td><input type="text" id="birth" name="birth" maxlength="6" placeholder="예) 230101"></td>
							</tr>
							<tr>
								<th>연락처</th>
								<td><input type="text" id="phone" name="phone" maxlength="13" placeholder="숫자만 입력해주세요."></td>
							</tr>
						</table>
					</div> <!-- end of back -->
				</div>
				<button class="sign_btn" type="button" onclick="signUP();">회원가입</button>
			</form>
				
		</section>
	<%@include file="footer.jsp"%>
	<script type="text/javascript" src="./script.js"></script>
	<script>
	window.onload = function(){
		  engAndNumberFunc(document.getElementById("id"));
		  onlyKorFunc(document.getElementById("name"));
		  onlyNumberFunc(document.getElementById("birth"));
		  onlyNumberFunc(document.getElementById("phone"));
		}
	
	function engAndNumberFunc(t){
		  var regexp = /[^a-z0-9]/gi;
		  t.onkeyup = function(e){
		    var v = this.value;
		    this.value = v.replace(regexp,'');
		  }
		}
	
	function onlyKorFunc(t){
		  var regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
		  t.onkeyup = function(e){
		    var v = this.value;
		    this.value = v.replace(regexp,'');
		  }
		}
	
	function onlyNumberFunc(t){
		  var regexp = /[^0-9]/gi;
		  t.onkeyup = function(e){
		    var v = this.value;
		    this.value = v.replace(regexp,'');
		  }
		}
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="script.js"></script>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<%@ include file="topmenu.jsp"%>
	<section>
		<div class="title">투표하기</div>
		<form name="frm" action="voting">
			<div class="wrapper">
				<table class="doVote">
					<tr>
						<th>주민번호</th>
						<td><input type="text" name="v_jumin">예: 8906153154726</td>
					</tr>
					<tr>
						<th>성명</th>
						<td><input type="text" name="v_name"></td>
					</tr>
					<tr>
						<th>후보번호</th>
						<td><select name="m_no">
						<option selected></option>
						<option value="1">[1] 김후보</option>
						<option value="2">[2] 이후보</option>
						<option value="3">[3] 박후보</option>
						<option value="4">[4] 조후보</option>
						<option value="5">[5] 최후보</option>
						</select></td>
					</tr>
					<tr>
						<th>투표시간</th>
						<td><input type="text" name="v_time"></td>
					</tr>
					<tr>
						<th>투표장소</th>
						<td><input type="text" name="v_area"></td>
					</tr>
					<tr>
						<th>유권자확인</th>
						<td>
						<input class="rbtn" type="radio" name="v_confirm" value="Y">확인
						<input class="rbtn" type="radio" name="v_confirm" value="N">미확인
						</td>
					</tr>
					<tr>
						<td class="button" colspan="2">
						<button class="btn" type="submit" onclick="fn_submit(); return false;">투표하기</button>
						<button class="btn" type="reset" onclick="fn_reset();">다시하기</button>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
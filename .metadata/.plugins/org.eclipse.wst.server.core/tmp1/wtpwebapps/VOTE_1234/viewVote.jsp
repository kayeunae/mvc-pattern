<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="DTO.Vote" %>
<%
request.setCharacterEncoding("UTF-8");
ArrayList<Vote> voteList = new ArrayList<Vote>();
voteList = (ArrayList<Vote>)request.getAttribute("voter");
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
		<div class="title">투표검수조회</div>
			<div class="wrapper">
				<table>
					<tr>
						<th>성명</th>
						<th>생년월일</th>
						<th>나이</th>
						<th>성별</th>
						<th>후보번호</th>
						<th>투표시간</th>
						<th>유권자확인</th>
					</tr>
					<%for(Vote vote : voteList) {%>
					<tr>
						<td><%=vote.getName() %></td>
						<td><%=vote.getBirth() %></td>
						<td><%=vote.getAge() %></td>
						<td><%=vote.getGender() %></td>
						<td><%=vote.getNo() %></td>
						<td><%=vote.getTime() %></td>
						<td><%=vote.getConf() %></td>
					</tr>
					<%} %>
				</table>
			</div>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Insert title here</title>
<link rel="stylesheet" href="./css/style.css" />
</head>
<body>
	<div class="wrap">
		<table class="board_list">
			<caption>
				<h1>자유게시판</h1>
			</caption>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>글쓴이</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<!--for(Board board : boardList)  -->
				<!-- var: 배열에서 받아올 객체 변수명, items: ArrayList varStatus: var상태(돌아가는 횟수 ex.count!)  -->
				<c:forEach var="board" items="${boardList}" varStatus="status">
					<tr>
						<td>${board.board_no}</td>
						<td class="title"><a href="./view?board_no=${board.board_no}">${board.title}</a></td>
						<td>${board.user_id}</td>
						<td>${board.reg_date}</td>
						<td>${board.view}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="bt_wrap bt_list">
			<a href="write">글쓰기</a>
		</div>
		<div class="board_page">
			<a class="bt first">&lt;&lt;</a> 
			<a class="bt prev">&lt;</a>
			<a class="num on">1</a> 
			<a class="num">2</a> 
			<a class="num">3</a> 
			<a class="num">4</a> 
			<a class="num">5</a> 
			<a class="bt next">&gt;</a>
			<a href="" class="bt last">&gt;&gt;</a>
		</div>
	</div>
	<script>
		//에러메세지 전달
		
		//쿼리스트링으로 오류가 전달될 때 (param. 을 붙여야 한글로 뜸)
		<c:if test="${param.error != null}">
			alert("${error}");
		</c:if>
		//setAttribute로 오류가 전달될 때
		<c:if test="${error != null}">
		alert("${error}");	//error 메세지가 뜰 것(BoardController에 있는 value값이 뜬다.)
		</c:if>
	</script>
</body>
</html>
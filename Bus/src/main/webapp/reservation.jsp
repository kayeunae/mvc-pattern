<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<%@include file="topmenu.jsp"%>
	<section>
		<div class="wrapper">
			<form name="frm" method="post" action="reserve">
				<div class="title">예약하기</div>
				<div><!-- table -->
					<table>
						<tr>
							<th>차량코드</th>
							<th>출발지</th>
							<th>도착지</th>
							<th>출발시각</th>
							<th>도착시각</th>
							<th>소요시간</th>
							<th>요금</th>
						</tr>
						<tr>
							<td name="bus_no">${bus.bus_no}</td>
							<td>${bus.depart}</td>
							<td>${bus.arrival}</td>
							<td>${bus.d_time}</td>
							<td>${bus.a_time}</td>
							<td>${bus.duration}</td>
							<td>${bus.charge}원</td>
						</tr>
					</table>
				</div><!-- end of table -->

				<div><!-- pay -->
					<div class="semi">결제 정보</div>
					<div><!-- pay2 -->
						<dl>
							<dt>버스요금</dt>
							<dd id="chr">${bus.charge}원</dd>
						</dl>
						<dl>
							<dt>예약 매수</dt>
							<dd>
								<select id="tck" name="ticket" onchange="selectBoxValue(this.value)">
									<option value="no">매수 선택</option>
									<option value=1>1매</option>
									<option value=2>2매</option>
									<option value=3>3매</option>
									<option value=4>4매</option>
									<option value=5>5매</option>
									<option value=7>7매</option>
									<option value=8>8매</option>
									<option value=9>9매</option>
									<option value=10>10매</option>
								</select>
							</dd>
						</dl>
						<dl>
							<dt>결제 금액</dt>
							<dd id="testfee" name="price">원</dd>
						</dl>
					</div><!-- end of pay2 -->
				</div><!-- end of pay -->
				
				<div> <!-- user -->
					<div class="semi">회원 정보</div>
					<div> <!-- user2 -->
						<dl>
							<dt>아이디</dt>
							<dd>
								<input type="text" name="id" maxlength="10" />
							</dd>
						</dl>
					</div> <!-- end of user2 -->
				</div> <!-- end of user -->
			</form>
			<div><!-- btn -->
				<button type="button" onclick="frm_submit();">예약하기</button>
				<button type="reset" href="view">돌아가기
					<!-- <a href="view">돌아가기</a> -->
				</button>
			</div><!-- end of btn -->
		</div><!-- end of wrapper -->
	</section>
	<%@include file="footer.jsp"%>
	<script>
		function selectBoxValue(value) {
			var selval = document.getElementById('tck').value;
			var chrval = ${bus.charge};
			var fee = chrval * selval;
			document.getElementById('testfee').innerText = fee + "원";
			/*
			var selval = document.getElementById('tck').value;
			if (selval == "no") {
				alert('숫자를 선택해주십시오');
			}
			else {
				var chrval = ${bus.charge};
				var fee = chrval * selval;
				document.getElementById('testfee').innerText = fee + "원";
			}
			 */
		}
	</script>
</body>
</html>
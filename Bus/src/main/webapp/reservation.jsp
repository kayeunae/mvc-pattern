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
		<div class="title">예약하기</div>
		<div class="wrapper noflex">
			<form name="frm" method="post" action="reserve">
				<input type="hidden" name="bus_no" value="${bus.bus_no}" /> <input
					type="hidden" id="fee" name="price" />
				<div>
					<!-- table -->
					<table class="color">
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
							<td>${bus.bus_no}</td>
							<td>${bus.depart}</td>
							<td>${bus.arrival}</td>
							<td>${bus.d_time}</td>
							<td>${bus.a_time}</td>
							<td>${bus.duration}</td>
							<td>${bus.charge}원</td>
						</tr>
					</table>
				</div>
				<!-- end of table -->

				<div class="semi">
					<!-- pay -->
					<table class="bottom_table">
						<colgroup>
							<col width="40%">
							<col width="60%">
						</colgroup>
						<tr>
							<th colspan="2" class="semititle st1">결제 정보</th>
						</tr>
						<tr>
							<th>버스요금</th>
							<td id="chr">${bus.charge}원</td>
						</tr>
						<tr>
							<th>예약 매수</th>
							<td>
								<select id="tck" name="ticket" onchange="selectBoxValue(this.value)">
									<option value=0>매수 선택</option>
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
							</td>
						</tr>
						<tr>
							<th>결제 금액</th>
							<td id="testfee">원</td>
						</tr>
					</table>
					<!-- end of pay2 -->
				</div>
				<!-- end of pay -->

				<div class="semi">
					<!-- user -->
					<table class="bottom_table">
						<colgroup>
							<col width="40%">
							<col width="60%">
						</colgroup>
						<tr>
							<th colspan="2" class="semititle st2">회원 정보</th>
						</tr>
						<tr style="height: 91px;">
							<th>아이디</th>
							<td>
								<input type="text" class="id_input" id="id" name="id" maxlength="10"
									placeholder="회원님의 아이디를 입력해 주세요." />
							</td>
						</tr>
						
					</table>
				</div>
				<!-- end of user -->
			</form>
			<div class="div_btn">
				<!-- btn -->
				<button class="bigbtn" type="button" onclick="frm_submit();">예약하기</button>
				<button class="bigbtn" type="reset" href="view">
					돌아가기
					<!-- <a href="view">돌아가기</a> -->
				</button>
			</div>
			<!-- end of btn -->
		</div>
		<!-- end of wrapper -->
	</section>
	<%@include file="footer.jsp"%>
	<script>
		function selectBoxValue(value) {
			var selval = document.getElementById('tck').value;
			var chrval = ${bus.charge};
			var fee = chrval * selval;
			$('#testfee').text(fee + "원");
			$('#fee').val(fee);
			if (isNaN(fee)) {
				fee = 0;
			}

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
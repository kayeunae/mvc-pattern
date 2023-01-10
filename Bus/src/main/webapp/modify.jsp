<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		<div class="title">${modi.id} 님의 예약 건 수정</div>
		<div class="wrapper noflex">
			<div><!-- table -->
				<table class="color">
					<tr>
						<th>예약코드</th>
						<th>출발지</th>
						<th>도착지</th>
						<th>출발시각</th>
						<th>도착시각</th>
						<th>소요시간</th>
						<th>예약 매수</th>
						<th>결제액</th>
					</tr>
					<tr>
						<td>${modi.r_no}</td>
						<td>${modi.depart}</td>
						<td>${modi.arrival}</td>
						<td>${modi.d_time}</td>
						<td>${modi.a_time}</td>
						<td>${modi.duration}</td>
						<td>${modi.ticket}</td>
						<td>${modi.price}원</td>
					</tr>
				</table>
			</div><!-- end of table -->
			<form name="frm_modify" method="post" action="sbmModify">
				<input type="hidden" name="id" value="${modi.id}"/>
				<input type="hidden" name="r_no" value="${modi.r_no}"/>
				<input type="hidden" id="in_bus" name="bus_no" value="0" />
				<input type="hidden" id="in_tck" name="ticket" value="0" />
				<input type="hidden" id="in_price" name="price" value="0" />
				<div><!-- pay -->
					<table class="bottom_table">
						<colgroup>
							<col width="10%" />
							<col width="40%" />
							<col width="40%" />
							<col width="10%" />
						</colgroup>
						<tbody>
							<tr>
								<th colspan="4" class="semititle">예약 수정</th>
							</tr>
							<tr>
								<td></td>
								<th>출발지-도착지 선택</th>
								<td>
									<select id="test" onchange="mdf_bus()">
										<c:forEach var="b" items="${blist}">
											<option value="${b.bus_no}" <c:if test="${b.bus_no eq modi.bus_no}">selected</c:if>>
												${b.depart} - ${b.arrival}
											</option>
										</c:forEach>
									</select>
								</td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<th>예약 매수</th>
								<td>
								<select id="tck" name="ticket" onchange="selectBoxValue()">
									<option value=1 <c:if test="${modi.ticket eq 1}">selected</c:if>>1매</option>
									<option value=2 <c:if test="${modi.ticket eq 2}">selected</c:if>>2매</option>
									<option value=3 <c:if test="${modi.ticket eq 3}">selected</c:if>>3매</option>
									<option value=4 <c:if test="${modi.ticket eq 4}">selected</c:if>>4매</option>
									<option value=5 <c:if test="${modi.ticket eq 5}">selected</c:if>>5매</option>
									<option value=6 <c:if test="${modi.ticket eq 6}">selected</c:if>>6매</option>
									<option value=7 <c:if test="${modi.ticket eq 7}">selected</c:if>>7매</option>
									<option value=8 <c:if test="${modi.ticket eq 8}">selected</c:if>>8매</option>
									<option value=9 <c:if test="${modi.ticket eq 9}">selected</c:if>>9매</option>
									<option value=10 <c:if test="${modi.ticket eq 10}">selected</c:if>>10매</option>
								</select>
								</td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<th>결제 금액</th>
								<td id="testfee" value="">원</td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div><!-- end of pay -->
			</form>
			<div><!-- btn -->
				<button class="bigbtn" type="button" onclick="mdf_submit();">예약 변경</button>
				<button class="bigbtn" type="button" onclick="mdf_delete();">예약 취소</button>
				<button class="bigbtn" type="button" onclick="location.href='inquirDetail?id=${modi.id}'">돌아가기
					<!-- <a href="view">돌아가기</a> -->
				</button>
			</div><!-- end of btn -->
		</div><!-- end of wrapper -->
	</section>
	<form name="frm_modify_delete" method="post" action="delete">
		<input type="hidden" name="r_no" value="${modi.r_no}"/>
		<input type="hidden" name="id" value="${modi.id}"/>
	</form>
	<%@include file="footer.jsp"%>
	<script>
		$(document).ready(function (){
			var selval = $('#tck').val();
			var chrval = ${modi.charge};
			var fee = chrval * selval;
			var sel_bus = $('#test option:selected').val(); //버스 선택된 값
			$('#testfee').text(fee + "원");
			$('#fee').val(fee);
			$('#in_tck').val(selval);
			$('#in_price').val(fee);
			$('#in_bus').val(sel_bus);
		})
		
		function selectBoxValue() {
			const selval = $('#tck').val();
			var chrval = ${modi.charge};
			var fee = chrval * selval;
			$('#testfee').text(fee + "원");
			$('#fee').val(fee);
			$('#in_tck').val(selval);
			$('#in_price').val(fee);
		}
	</script>
</body>
</html>
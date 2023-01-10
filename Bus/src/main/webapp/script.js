//reservation.jsp
function frm_submit() {
	var f = document.frm;

	if (f.ticket.value == 'no') {
		alert("티켓 매수를 선택해주십시오");
		f.ticket.focus();
		return false;
	}
	if (f.id.value == '') {
		alert("아이디를 입력해주십시오");
		f.id.focus();
		return false;
	}
	f.submit();
}

//sign.jsp
function signUP() {
	var s = document.signForm;

	if (s.id.value == '') {
		alert("아이디를 입력해주십시오");
		s.id.focus();
		return false;
	}
	if (s.pw.value == '') {
		alert("비밀번호를 입력해주십시오");
		s.pw.focus();
		return false;
	}
	if (s.name.value == '') {
		alert("이름을 입력해주십시오");
		s.name.focus();
		return false;
	}
	if (s.birth.value == '') {
		alert("생년월일을 입력해주십시오");
		s.birth.focus();
		return false;
	}
	if (s.phone.value == '') {
		alert("연락처를 입력해주십시오");
		s.phone.focus();
		return false;
	}
	s.submit();
}


//inquiry.jsp
function frm_inquiry_submit() {
	var f = document.frm_inquiry;

	if (f.id.value == '') {
		alert("아이디를 입력해주십시오");
		f.id.focus();
		return false;
	}
	f.submit();
}

//inquiryDetail.jsp
function inq_delete(value){
	var f = document.frm_inq;
	console.log(value);
	if(confirm('예약을 취소하시겠습니까?')){
		$('#delete_no').val(value);
		f.submit();
	} else return false;
}

//modify.jsp
function mdf_submit() {
	var f = document.frm_modify;

	if (f.ticket.value == 'no') {
		alert("티켓 매수를 선택해주십시오");
		f.ticket.focus();
		return false;
	}
	f.submit();
}

function mdf_delete(){
	var f = document.frm_modify_delete;
	
	if(confirm('예약을 취소하시겠습니까?')){
		f.submit();
	} else return false;
}

function mdf_bus(){
	var sel_bus = $('#test option:selected').val();
	$('#in_bus').val(sel_bus);
}
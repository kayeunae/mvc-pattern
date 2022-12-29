//reservation.jsp
function frm_submit() {
	var f = document.frm;
	
	if (f.count.value == 'no') {
		alert("티켓 매수를 선택해주십시오");
		f.count.focus();
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
//유효성 체크
function frm_submit() {
	var f = document.frm;

	if (f.pass_id.value == '') {
		alert("아이디를 입력해주십시오");
		f.pass_id.focus();
		return false;
	}
	if (f.pass_name.value == '') {
		alert("이름을 입력해주십시오");
		f.pass_name.focus();
		return false;
	}
	if (f.pass_birth.value == '') {
		alert("생년월일을 입력해주십시오");
		f.pass_birth.focus();
		return false;
	}
	if (f.pass_phone.value == '') {
		alert("연락처를 입력해주십시오");
		f.pass_phone.focus();
		return false;
	}
	if (f.count.value == 'no') {
		alert("티켓 매수를 선택해주십시오");
		f.count.focus();
		return false;
	}
	f.submit();
}

//
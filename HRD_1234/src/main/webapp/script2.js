function fn_submit(){
	var fn = document.frm;
	
	//유효성 체크
	//.value : input창에 입력된 값을 가져올 수 있다.
	if(fn.custname.value == "") {		//input에 값이 빈값인지 체크
		alert("회원성명이 입력되지 않았습니다.");
		fn.custname.focus();	//입력창에 포커싱 주기
		return false;	//함수 끝내기
	}
	
		if(fn.phone.value == "") {
		alert("회원전화가 입력되지 않았습니다.");
		fn.phone.focus();
		return false;
	}	
	
			if(fn.address.value == "") {
		alert("회원주소가 입력되지 않았습니다.");
		fn.address.focus();
		return false;
	}	
	
			if(fn.joindate.value == "") {
		alert("가입일자가 입력되지 않았습니다.");
		fn.custname.focus();
		return false;
	}	
	
			if(fn.grade.value == "") {
		alert("고객등급이 입력되지 않았습니다.");
		fn.grade.focus();
		return false;
	}	
	
			if(fn.city.value == "") {
		alert("도시코드가 입력되지 않았습니다.");
		fn.city.focus();
		return false;
	}	
	
	fn.submit();	//컨트롤러(서버)에 전송
}




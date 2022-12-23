function fn_submit(){
	var fn = document.frm; //add.jsp 이름이 frm
	
	if (fn.custname.value == "") { //input창에 입력된 값을 가져오는 방법 ~.name.value    식 : 빈값인지 확인함.
		alert("회원성명이 입력되지 않았습니다.");
		fn.custname.focus(); //custname에 가서 focus 포커싱을 줌.
		return false; //함수 종료
	}
	if (fn.phone.value == "") { //input창에 입력된 값을 가져오는 방법 ~.name.value    식 : 빈값인지 확인함.
		alert("회원전화가 입력되지 않았습니다.");
		fn.phone.focus(); //focus 포커싱을 줌.
		return false; //함수 종료
	}
	if (fn.address.value == "") { //input창에 입력된 값을 가져오는 방법 ~.name.value    식 : 빈값인지 확인함.
		alert("회원주소가 입력되지 않았습니다.");
		fn.address.focus(); //focus 포커싱을 줌.
		return false; //함수 종료
	}
	if (fn.joindate.value == "") { //input창에 입력된 값을 가져오는 방법 ~.name.value    식 : 빈값인지 확인함.
		alert("회원가입일자가 입력되지 않았습니다.");
		fn.joindate.focus(); //focus 포커싱을 줌.
		return false; //함수 종료
	}
	if (fn.grade.value == "") { //input창에 입력된 값을 가져오는 방법 ~.name.value    식 : 빈값인지 확인함.
		alert("고객등급이 입력되지 않았습니다.");
		fn.grade.focus(); //focus 포커싱을 줌.
		return false; //함수 종료
	}
	if (fn.city.value == "") { //input창에 입력된 값을 가져오는 방법 ~.name.value    식 : 빈값인지 확인함.
		alert("도시코드가 입력되지 않았습니다.");
		fn.city.focus(); //focus 포커싱을 줌.
		return false; //함수 종료
	}
	fn.submit(); //컨트롤러(서버)에 전송합니다.
	
}
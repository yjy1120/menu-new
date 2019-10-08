<%@ page language="java" contentType="text/html; charset=UTF-8"		
pageEncoding="UTF-8"%>		
<!DOCTYPE html>		
<html>		
<head>		
<title>맛집 리스트</title>		
<meta charset="utf-8">		
<meta name="viewport" content="width=device-width, initial-scale=1">		
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">		
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>		
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>		
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>		
		
<script>		
function inputPhoneNumber(obj) {		
var number = obj.value.replace(/[^0-9]/g, "");		
var phone = "";		
if(number.length < 4) {		
return number;		
} else if(number.length < 7) {		
phone += number.substr(0, 3);		
phone += "-";		
phone += number.substr(3);		
} else if(number.length < 11) {		
phone += number.substr(0, 3);		
phone += "-";		
phone += number.substr(3, 3);		
phone += "-";		
phone += number.substr(6);		
} else {		
phone += number.substr(0, 3);		
phone += "-";		
phone += number.substr(3, 4);		
phone += "-";		
phone += number.substr(7);		
}		
obj.value = phone;		
}		
function inpuTime(obj) {		
	var number = obj.value.replace(/[^0-9]/g, "");		
	var time = "";		

	if(number.length < 9) {		
	time += number.substr(0, 2);		
	time += ":";		
	time += number.substr(2, 2);	
	time += "~";	
	time += number.substr(4, 2);		
	time += ":";		
	time += number.substr(6, 2);
	} 
	obj.value = time;		
	}		
</script>		
		
</head>		
<body>		
		
<jsp:include page="top.jsp" flush="false"/>		
<div class="container">		
<h2>맛집추가</h2>		
<form action="data2.jsp">		
<div class="form-group">		
<label for="name">가게이름</label>		
<input type="text" class="form-control" id="name" placeholder="가게이름 입력" name="name">		
</div>		
<div class="form-group">		
<label for="loc">위치</label>		
<input type="text" class="form-control" id="loc" placeholder="위치 입력" name="loc">		
</div>		
<div class="form-group">		
<label for="tel">전화번호</label>		
<input type="text" onKeyup="inputPhoneNumber(this);" maxlength="13" class="form-control" id="tel" placeholder="전화번호 입력" name="tel">		
</div>		
<div class="form-group">		
<label for="tel">영업시간</label>		
<input type="text" onKeyup="inpuTime(this);" maxlength="11" class="form-control" id="time" placeholder="시간" name="time">		
</div>
<button type="submit" class="btn btn-primary">맛집 등록</button>		
</form>		
</div>		
		
</body>		
</html>		
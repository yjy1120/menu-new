<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맛집 리스트</title>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="top.jsp" flush="false"/>

<div class="container">



<form action="data.jsp">
    <div class="form-group">
      <label for="name">가게:</label>
      <input type="text" class="form-control" id="name" placeholder="가게 이름 입력" name="name">
    </div>
    <div class="form-group">
      <label for="menu">메뉴:</label>
      <input type="text" class="form-control" id="menu" placeholder="메뉴 이름 입력" name="menu">
    </div>
    <div class="form-group">
      <label for="home">원산지:</label>
      <input type="text" class="form-control" id="home" placeholder="원산지 입력" name="home">
    </div>
    <div class="form-group">
      <label for="price">가격:</label>
      <input type="number" class="form-control" id="price" placeholder="가격 입력" name="price">
    </div>
    <div class="form-group">
      <label for="loc">위치:</label>
      <input type="text" class="form-control" id="loc" placeholder="가게 위치 입력" name="loc">
    </div>
    <div class="form-group">
      <label for="star">별점:</label>
      <input type="number" class="form-control" id="star" placeholder="별점 입력" name="star">
    </div>
    <div class="form-group">
      <label for="tel">전화번호:</label>
      <input type="text" class="form-control" id="tel" placeholder="전화번호 입력" name="tel">
    </div>
    <div class="form-group">
      <label for="time">영업시간:</label>
      <input type="text" class="form-control" id="time" placeholder="영업시간 입력" name="time">
    </div>
    <button type="submit" class="btn btn-primary">전송</button>
    <button type="button" class="btn btn-success" onclick = "location.href = 'index.jsp'">Main</button>
  </form>
 </div>
  
</body>
</html>
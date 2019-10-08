<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="menu.UserVO"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    UserVO vo= (UserVO)session.getAttribute("users");
   
    System.out.println(vo);

    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <!-- Brand/logo -->
  <a class="navbar-brand" href="index.jsp">맛집 정보</a>
  
  <!-- Links -->
  <ul class="navbar-nav">
    <li class="nav-item">
      <a class="nav-link" href="print2.jsp">전체 맛집</a>
    </li>
    <%if(vo !=null && vo.getGrade()>9){ %>
    <li class="nav-item">
      <a class="nav-link" href="store.jsp">맛집 입력</a>
    </li>
    <%}else{%>
 
    <%}%>
    <li class="nav-item">
    <%if(vo != null){ %>
      <a class="nav-link" href="rec.jsp">맛집 추천</a>
     <%}else{%>
     <a class="nav-link" href="login.jsp">맛집 추천</a>
     <%}%>
    </li>
     <li class="nav-item">
     <%if(vo == null){ %>
      <a class="nav-link" href="login.jsp">로그인</a>
      <%}else{%>
      <a class="nav-link" href="logout.jsp">로그아웃</a>
       
      <%}%>
    </li>
    <% /* <li class="nav-item">
      <a class="nav-link" href="star.jsp">평가 하기</a>
    </li>*/%>
  </ul>
   <form class="form-inline ml-auto" action="search.jsp">
    <input class="form-control mr-sm-2" type="text" name ="search" placeholder="Search">
    <button class="btn btn-success" type="submit">Search</button>
  </form>
</nav>
</body>
</html>
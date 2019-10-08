<%@page import="menu.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    UserVO vo = (UserVO)session.getAttribute("users");
    session.invalidate();
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
	alert("<%=vo.getName()%>님 로그아웃 되었습니다");
	<%out.println("location.href = 'index.jsp'");%>
</script>
<%--  <% --%>
//  session.invalidate();
// 	response.sendRedirect("index.jsp");
<%--  %> --%>
</body>
</html>
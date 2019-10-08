<%@page import="menu.UserVO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <% 

request.setCharacterEncoding("utf-8");
 String name = request.getParameter("name");
 String loc = request.getParameter("loc");
 String tel = request.getParameter("tel");
 String time = request.getParameter("time");
 UserVO	vo =  (UserVO)session.getAttribute("users");
 
 int u_id = vo.getId();
 
 
 Connection conn=null;
 
 Boolean connect = false;

 try{
 	Context init = new InitialContext();
 	DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
 	conn = ds.getConnection();
    
   
 	String sql = "INSERT INTO store (name, loc, tel, time, u_id) VALUES (?, ?, ?, ?, ?)";
     PreparedStatement pstmt = conn.prepareStatement(sql);
     pstmt.setString(1, name);
     pstmt.setString(2, loc);
     pstmt.setString(3, tel);
     pstmt.setString(4, time);
     pstmt.setInt(5, u_id);
     pstmt.executeUpdate();
     connect = true;
     
     conn.close();
 }catch(Exception e){
     connect = false;
     e.printStackTrace();
 }

 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
가게이름 :  <%=name %><br>
위치 :  <%=loc %><br>
전화번호 :  <%=tel %><br>
영업시간 :  <%=time %><br>
<script>alert("입력 완료");</script>
<script>location.href="print2.jsp"</script>
</body>
</html>
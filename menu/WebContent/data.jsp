<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <% 
 // index.jsp 에서 넘어오는 데이터 처리
 
 String name = request.getParameter("name");
 String menu = request.getParameter("menu");
 String home = request.getParameter("home");
 String price = request.getParameter("price");
 String loc = request.getParameter("loc");
 String star = request.getParameter("star");
 String tel = request.getParameter("tel");
 String time = request.getParameter("time");
 
 Connection conn=null;
 
 Boolean connect = false;

 try{
 	Context init = new InitialContext();
 	DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
 	conn = ds.getConnection();
    
   
 	String sql = "INSERT INTO food (name, menu, home, price, loc, star, tel, time) VALUES (?, ?, ?,?,?,?,?,?)";
     PreparedStatement pstmt = conn.prepareStatement(sql);
     pstmt.setString(1, name);
     pstmt.setString(2, menu);
     pstmt.setString(3, home);
     pstmt.setString(4, price);
     pstmt.setString(5, loc);
     pstmt.setString(6, star);
     pstmt.setString(7, tel);
     pstmt.setString(8, time);
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
메뉴 :  <%=menu %><br>
원산지 :  <%=home %><br>
가격 :  <%=price%><br>
위치 :  <%=loc %><br>
별점 :  <%=star %><br>
전화번호 :  <%=tel %><br>
영업시간 :  <%=time %><br>
<script>alert("입력 완료");</script>
<script>location.href="print.jsp"</script>
</body>
</html>
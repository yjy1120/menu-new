<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8"); //
String email = request.getParameter("email");
String pw = request.getParameter("password");
String name = request.getParameter("name");
String phone = request.getParameter("phone");
String radio = request.getParameter("radio");


System.out.println(email);
System.out.println(pw);
System.out.println(name);
System.out.println(phone);
System.out.println(radio);
//	out.println(menu + " 에 " + "별점 " + star + " 점을 줬다.");

// 점수를 DB에 저장
Connection conn = null;			
Boolean connect = false;
	
try {	
	Context init = new InitialContext();
	DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
	conn = ds.getConnection();
	
	String sql = "INSERT INTO users (email, pw, name, phone, grade) VALUES (?, ?, ?, ?, ?);";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, email);
	pstmt.setString(2, pw);
	pstmt.setString(3, name);
	pstmt.setString(4, phone);
	pstmt.setString(5, radio);
	int ret = pstmt.executeUpdate();
	
			out.println("<script>");
			if(ret == 1){
				out.println("alert('"+name+"님 가입 되었습니다.')");
				out.println("location.href = 'login.jsp'");
			}else{
				out.println("alert('가입 실패!!')");
				
			}
			out.println("</script>");
	
	
		connect = true;
		conn.close();
	} catch (Exception e) {	
		connect = false;
		e.printStackTrace();
	}	
		
	if (connect == true) {	
		System.out.println("연결되었습니다.");
		out.println(1);
	} else {	
		System.out.println("연결실패.");
		out.println(0);
	}	

    
%>

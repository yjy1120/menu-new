<%@page import="menu.InsertVO"%>
<%@page import="menu.UserVO"%>
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
// 	out.println(menu + " 에 " + "별점 " + star + " 점을 줬다.");
	
	// 점수를 DB에 저장
	Connection conn = null;			
	Boolean connect = false;
	
	try {	
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
		conn = ds.getConnection();
		
		String sql = "SELECT * FROM users WHERE email = ? AND pw= ? AND state =1";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		pstmt.setString(2, pw);
		ResultSet rs = pstmt.executeQuery();
		
		UserVO vo = new UserVO();
		InsertVO vo2 = new InsertVO();
		out.println("<script>");
		if(rs.next()){
		 	vo.setEmail(rs.getString("email"));
		 	vo.setPw(rs.getString("pw"));
		 	vo.setName(rs.getString("name"));
		 	vo.setPhone(rs.getString("phone"));
		 	vo.setGrade(rs.getInt("grade"));
		 	vo.setId(rs.getInt("id"));
		 	session.setAttribute("users", vo);
			out.println("alert('"+vo.getName()+" 연결되었습니다.')");
			out.println("location.href = 'index.jsp'");
		}else{
			out.println("alert('로그인 실패!!')");
			out.println("location.href = 'index.jsp'");
		}
		out.println("</script>");
		connect = true;
		conn.close();
	} catch (Exception e) {	
		connect = false;
		e.printStackTrace();
	}	
	
	
	
    
%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.dd.FoodVO2"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="util.dbhelper.DBconn"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
   
  
    //out.println("code=>"+code);
ArrayList<FoodVO2> list = new ArrayList<>();
try{
    Connection conn = DBconn.getConnection(); //Connection 객체 얻기.
    String sql = "Select * from food";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery(); //실행 -> 조회
  
  
    while(rs.next()){ //검색된 결과가 존재하면 true
    	FoodVO2 vo = new FoodVO2();
    	vo.setName(rs.getString("name"));
    	vo.setPrice(rs.getString("price"));
    	vo.setTel(rs.getString("tel"));
    	list.add(vo);
    
    	
    }
    rs.close();
    pstmt.close();
    DBconn.close();
}catch(Exception e){
	
    e.printStackTrace();
}
	 
      %> 
      <h1>조회결과</h1>
      <table border="1">
  <%for(FoodVO2 vo : list){ %>
        
            <tr>
            <td>가게 이름</td><td><%=vo.getName() %></td>	
            </tr>
            <tr>
            <td>가격</td><td><%=vo.getPrice() %></td>
            </tr>
            <tr>
            <td>연락처</td><td><%=vo.getTel() %></td>
            </tr>
                
      
       
   
<%} %>
    </table>
     
   
</body>
</html>

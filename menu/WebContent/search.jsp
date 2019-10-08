<%@page import="java.util.ArrayList"%>
<%@page import="menu.FoodVO"%>
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
String search = request.getParameter("search");
System.out.println(search);
Connection conn=null;

Boolean connect = false;
ArrayList<FoodVO> list = new ArrayList<>();
try{
	Context init = new InitialContext();
	DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
	conn = ds.getConnection();
   

	String sql = "SELECT * FROM store WHERE name  LIKE concat ('%', ?, '%')";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, search);
    ResultSet rs = pstmt.executeQuery();
    while(rs.next()){
    FoodVO vo = new FoodVO();	
    vo.setName(rs.getString("name"));
    vo.setLoc(rs.getString("loc"));
    vo.setTel(rs.getString("tel"));
    vo.setTime(rs.getString("time"));
    list.add(vo);
    
    }
    connect = true;
    conn.close();
}catch(Exception e){
    connect = false;
    e.printStackTrace();
}

%>

<!DOCTYPE html>
<head>
  <title>맛집 정보</title>
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
  <table class="table">
    <thead>
      <tr>
        <th>가게이름</th>
        <th>메뉴</th>
        <th>원산지</th>
        <th>가격</th>
        <th>위치</th>
        <th>별점</th>
        <th>전화번호</th>
        <th>영업시간</th>
      </tr>
    </thead>
    <tbody>   
    <%for(FoodVO vo : list) {%>  
      <tr class="table-primary">
        <td><%=vo.getName() %></td>
        <td><%=vo.getMenu() %></td>
        <td><%=vo.getHome() %></td>
        <td><%=vo.getPrice() %></td>
        <td><%=vo.getLoc() %></td>
        <td><%=vo.getStar() %></td>
        <td><%=vo.getTel() %></td>
        <td><%=vo.getTime() %></td>
       
      </tr>
      <%} %>
    </tbody>
  </table>
  <button type="button" class="btn btn-success" onclick = "location.href = 'index.jsp'">Main</button>
</div>

</body>
</html>


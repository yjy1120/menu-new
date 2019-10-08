<%@page import="java.util.ArrayList"%>
<%@page import="menu.StoreVO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String ob = request.getParameter("orderby");
Connection conn=null;

Boolean connect = false;
ArrayList<StoreVO> list = new ArrayList<>();
try{
	Context init = new InitialContext();
	DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
	conn = ds.getConnection();
    String sql = null;
  
  if(ob == null)
  {
		sql = "SELECT * FROM store ORDER BY name desc";
  }else{
		sql = "SELECT * FROM store ORDER BY name asc";
  }
  
    PreparedStatement pstmt = conn.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();
    while(rs.next()){
   	StoreVO vo = new StoreVO();
   	vo.setId(rs.getString("id"));
    vo.setName(rs.getString("name"));
    vo.setLoc(rs.getString("loc"));
    vo.setTel(rs.getString("tel"));
    vo.setTime(rs.getString("time"));
    vo.setU_id(rs.getInt("u_id"));
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
<html>
<head>
  <title>맛집 정보</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  <style>	
	.starR {
	background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
	background-size: auto 100%;
	width: 30px;
	height: 30px;
	display: inline-block;
	text-indent: -9999px;
	cursor: pointer;
	}
	.starR.on{background-position:0 0;}
</style>
<script>	
var score = 5;
$(document).ready(function(){	
	$('.starRev span').click(function(){					
		$(this).parent().children('span').removeClass('on');		
		$(this).addClass('on').prevAll('span').addClass('on');		
		
		
		score = $(this).addClass('on').text();
		return false;
		}),
		$("#starsub").click(function(){
		    $.post("star_proc.jsp",
		    {
		      menu: $('#m_menuname').text(),
		      star: score
		    },
	    function(data,status){
	      alert("Data: " + data + "\nStatus: " + status);
	    });
	});
});			
function getMenuName(name) {
	//alert(name);
	$('#m_menuname').text(name);
	$('#myModal').show();
}
function modalClose() {	
	location.reload();
	//$('#myModal').hide();
}	

</script>

</head>
<body>
<jsp:include page="top.jsp" flush="false"/>


<div class="container">
 <h2>전체 맛집</h2>	
  <table class="table">
    <thead>
      <tr>     
        <%  if(ob == null){ %>
        <th>가게이름<a href="print2.jsp?orderby=1">⏬</a></th>
        <%}else {%>
        <th>가게이름<a href="print2.jsp">⏫</a></th>
        <%} %>
        <th>위치</th>
        <th>전화번호</th>
        <th>영업시간</th>
      </tr>
    </thead>
    <tbody>   
    <%for(StoreVO vo : list) {%>  
      <tr class="table-primary">
        <td><a  href="menu.jsp?s_id=<%= vo.getId() %>&s_name=<%=vo.getName()%>&u_id=<%=vo.getU_id()%>"><%=vo.getName()%></a></td>				
        <td><%=vo.getLoc() %></td>
        <td><%=vo.getTel() %></td>
        <td><%=vo.getTime() %></td>
      </tr>
      <%} %>
    </tbody>
  </table>
</div>
<div class="modal" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">평가 하기</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<p id="m_menuname"></p>
      		<div class="starRev">
				<span class="starR on">1</span>
				<span class="starR on">2</span>
				<span class="starR on">3</span>
				<span class="starR on">4</span>
				<span class="starR on">5</span>
			</div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-primary" id = "starsub"onclick = "location.href = 'print.jsp'"  >전송</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="modalClose()">취소</button>		
        </div>
        
      </div>
    </div>
  </div>
</body>
</html>


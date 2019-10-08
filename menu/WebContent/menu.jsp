<%@page import="menu.UserVO"%>
<%@page import="menu.MenuVO"%>
<%@page import="menu.StoreVO"%>
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
request.setCharacterEncoding("utf-8");  // 한글처리
String s_id = request.getParameter("s_id");   // DB에서 메뉴를 불러 오기 위한 가게 ID
String s_name = request.getParameter("s_name");  // 가게이름
int u_id = Integer.parseInt(request.getParameter("u_id"));
// String ob = request.getParameter("orderby");  // 오름 차순
// System.out.println(ob);
//위 데이터를 데이터 베이스에 넣기
UserVO u_vo = (UserVO)session.getAttribute("users");
Connection conn = null;			
Boolean connect = false;
ArrayList<MenuVO> list = new ArrayList<>();
	
try {	
	Context init = new InitialContext();
	DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
	conn = ds.getConnection();
	String sql = "SELECT * FROM menu WHERE s_id = ?";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, s_id);
	ResultSet rs = pstmt.executeQuery();
	
	while (rs.next()) {
		MenuVO vo = new MenuVO();
		vo.setId(rs.getInt("id"));
		vo.setName(rs.getString("name"));
		vo.setPrice(rs.getString("price"));
		vo.setStar_avg(rs.getString("star_avg"));
		list.add(vo);
	}
	
	
	connect = true;
	conn.close();
} catch (Exception e) {	
	connect = false;
	e.printStackTrace();
}	
	
if (connect == true) {	
	System.out.println("연결되었습니다.");
} else {	
	System.out.println("연결실패.");
}	

%>    

<!DOCTYPE html>
<html>
<head>
  <title>맛집 리스트</title>
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
	span.star-prototype, span.star-prototype > * {
    height: 17px; 
    background: url(http://i.imgur.com/YsyS5y8.png) 0 -16px repeat-x;
    width: 80px;
    display: inline-block;
}
 
span.star-prototype > * {
    background-position: 0 0;
    max-width:80px; 
}
</style>

<script>
$(document).ready(function(){
// 	$('#star').hide();    // 별점 확인 버튼 숨기기
	var score = 5;	 // 별점 초기값
	// 별 클릭 할 때 마다 별점이 바뀜
	$('.starRev span').click(function(){
		  $(this).parent().children('span').removeClass('on');
		  $(this).addClass('on').prevAll('span').addClass('on');
		  
		  console.log($(this).addClass('on').text());
		  score = $(this).addClass('on').text();
		  
		  return false;
	});
 	
	// 별점 주기 확인 버튼
	$(".star").click(function(){
		    $.post("star_proc.jsp",
		    {
		      menu: $('#m_menuname').text(),
		      star: score
		    },
		    function(data,status){
		      alert("Data: " + data + "\nStatus: " + status);
		      
		      modalClose();	
		    });
	 });
	
	// 메뉴 추가 버튼
	 $("#submit").click(function(){
		    $.post("m_data.jsp",
		    {
		      name: $('#menu').val(),
		      price: $('#price').val(),
		      img: $('#img').val(),
		      s_id: $('#s_id').val() 
		    },
		    function(data,status){
//		      alert("Data: " + data + "\nStatus: " + status);
				if (data == 1) {
					alert("메뉴 추가 성공!!");
				} else {
					alert("오류 났어요. 관리자에게 문의!")
				}
		      modalClose();	
		    });
	  });
	 $.fn.generateStars = function() {
		    return this.each(function(i,e){$(e).html($('<span/>').width($(e).text()*16));});
		};

		// 숫자 평점을 별로 변환하도록 호출하는 함수
		$('.star-prototype').generateStars();
	
});
function getMenuName(name) {
	//alert(name);
	$('#m_menuname').text(name);
	$('#myModal').show();
}
function modalClose() {
	location.reload();
// 	$('#myModal').hide();
}
</script>

</head>
<body>
<jsp:include page="top.jsp" flush="false"/>
<div class="container">
  <h2><%=s_name %></h2>
  <table class="table">
    <thead>
      <tr>
		<th>메뉴이름</th>
        <th>가격</th> 
        <th>평점</th>
      </tr>
    </thead>
    <tbody>
    <%for (MenuVO vo : list) { %>
      <tr class="table-dark text-dark">
        <td id="m_menuname"><a href="menu2.jsp?m_name=<%=vo.getName() %>"><%=vo.getName() %></a></td>
        <td><%=vo.getPrice() %></td>
        <td>
        <span class="star-prototype">
	        <% 
		        String star_avg = vo.getStar_avg();
		        if (star_avg.length() > 3) {
		        	star_avg = star_avg.substring(0, 3);
		        }
	        %>
	        <%=star_avg %>
	        </span> 
	        (<%=star_avg %>)
        </td>
      </tr>      
  	<% } %>
    </tbody>
  </table>
  <%if(u_vo !=null && u_vo.getId() == u_id) {%>
  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">메뉴 추가하기</button>
  <%}%>
  
</div>
																	
										
	<!-- 모달 시작 -->									
	<!-- The Modal -->																	
	<div class="modal" id="myModal">									
		<div class="modal-dialog">								
			<div class="modal-content">							
										
				<!-- Modal Header -->						
				<div class="modal-header">						
					<h4 class="modal-title"><%=s_name %> 메뉴 추가</h4>					
				</div>						
										
				<!-- Modal body -->						
				<div class="modal-body">						
			<label for="menu">메뉴:</label>							
			<input type="text" class="form-control" id="menu" placeholder="메뉴 이름 입력" name="menu">								
			<label for="price">가격:</label>							
			<input type="number" class="form-control" id="price" placeholder="가격 입력" name="price">
			<label for="img">이미지 주소:</label>							
			<input type="text" class="form-control" id="img" placeholder="메뉴 이미지 주소 넣기" name="img">
			
			<input type="hidden" id="s_id" name="s_id" value="<%=s_id%>">								
				</div>						
										
				<!-- Modal footer -->						
				<div class="modal-footer">						
					<button type="submit" class="btn btn-primary" id="submit">메뉴 추가</button>					
					<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="modalClose()">취소</button>					
				</div>						
										
			</div>							
		</div>								
	</div>																	
<!-- 모달 끝-->										
</body>
</html>
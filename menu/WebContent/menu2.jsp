<%@page import="menu.InsertVO"%>
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
String m_name = request.getParameter("m_name");  // 메뉴이름
UserVO u_vo= (UserVO)session.getAttribute("users");
String u_id = request.getParameter("u_id");
// System.out.println(ob);
//위 데이터를 데이터 베이스에 넣기
Connection conn = null;			
Boolean connect = false;
MenuVO vo = new MenuVO();

ArrayList<InsertVO> list = new ArrayList<>();
ArrayList<InsertVO> list2 = new ArrayList<>();
InsertVO r_vo2 = new InsertVO();
try {	
	Context init = new InitialContext();
	DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
	conn = ds.getConnection();
	String sql = "SELECT * FROM menu WHERE name = ? ";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, m_name);
	ResultSet rs = pstmt.executeQuery();
	if (rs.next()) {
		vo.setId(rs.getInt("id"));
		vo.setName(rs.getString("name"));
		vo.setPrice(rs.getString("price"));
		vo.setImg(rs.getString("img"));
	}
	sql= "SELECT * FROM review WHERE m_id=? ";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, vo.getId());

	rs = pstmt.executeQuery();
	while(rs.next()){
		InsertVO r_vo = new InsertVO();
		r_vo.setReview(rs.getString("review"));
		r_vo.setU_id(rs.getString("u_id"));
		list.add(r_vo);
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
	#counter {
  background:rgba(0,0,0,0);
  border-radius: 0.5em;
  padding: 0 .5em 0 .5em;
  font-size: 0.75em;
}
.wrap {
    width: 467px;
    height: auto;
    position: relative;
    display: inline-block;
}
.wrap textarea {
    width: 100%;
    resize: none;
    min-height: 4.5em;
    line-height:1.6em;
    max-height: 9em;
}
.wrap span {
    position: absolute;
    bottom: 5px;
    right: 5px;
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
	$("#star").click(function(){
		    $.post("star_proc.jsp",
		    {
		      star: score,
		      m_id : $('#m_id').val(),
		      u_id : $('#u_id').val()
		      
		    },
		    function(data,status){
		      //alert("Data: " + data + "\nStatus: " + status);
		      if(data ==1){
		    	  alert("감사합니다." );
		      }else{
		    	  alert("에러"); 
		      }
		      modalClose();
		    });
	 });
	$("#submit").click(function(){
	    $.post("review_proc.jsp",
	    {
	      review : $('#comment').val(),
	      m_id : $('#m_id').val(),
	      u_id : $('#u_id').val()
	    },
	    function(data,status){
	    	if (data == 1) {
				alert("작성 완료");
			} else {
				alert("오류 났어요. 관리자에게 문의!")
			}
	      
	      modalClose();	
	    });
	});	
});
	
	

function modalClose() {
	location.reload();
	//history.back();
// 	$('#myModal').hide();
};

$(function() {
    $('#comment').keyup(function (e){
        var comment = $(this).val();
        $(this).height(((comment.split('\n').length + 1) * 1.5) + 'em');
        $('#counter').html(comment.length + '/300');
    });
    $('#comment').keyup();
});

function send_login() {
	alert("로그인 하세요.");
	location.href="login.jsp";
	//history.back();
// 	$('#myModal').hide();
};
</script>

</head>
<body>
<jsp:include page="top.jsp" flush="false"/>
<div class="container">
  <h2><%=m_name %></h2>
  <table class="table">
    <thead>
      <tr>
		<th>메뉴이름</th>
        <th>가격</th> 
        <th>평가하기</th> 
        <th></th> 
      </tr>
    </thead>
    <tbody>
      <tr class="table-dark text-dark">
        <td id="m_menuname"><%=vo.getName() %></td>
        <td><%=vo.getPrice() %></td>
        <td>
        	<div class="starRev">
			  <span class="starR on">1</span>
			  <span class="starR on">2</span>
			  <span class="starR on">3</span>
			  <span class="starR on">4</span>
			  <span class="starR on">5</span>
			  <%if(u_vo == null){ %>
			  <button type="button" class="btn btn-danger" id="star" onclick = "send_login()">확인</button>
			   <%}else{%>
			   <button type="button" class="btn btn-danger" id="star" >확인</button>
			    <%} %>
			</div> 
        </td>
        
        <td>
        <%if(u_vo == null){ %>
        <button type = "button" class="btn btn-primary" onclick="send_login()">리뷰 작성</button>
        <%}else{%>
        <button class="btn btn-primary" data-toggle="modal" data-target="#myModal">리뷰 작성</button>
        <%} %>
        </td>
        
      </tr>      
    </tbody>
  </table>
  
  <% if (vo.getImg() == null) { %>
  	<p> 이미지가 없습니다. </p>
  <% }else{%>
  	<img src="<%=vo.getImg() %>" width="320" height="240" style = "float: left"  class="rounded mx-auto d-block">
  <%}%>
  
	</div> 
	<div class ="container">
    
   <table class="table">
   <thead>
      <tr>
		<th><h4>Review</h4></th>
      </tr>
    </thead>
   <tbody >
  <%for(InsertVO r_vo : list) {%>  
  <tr class="table-primary">
        <td><%=r_vo.getReview()%></td>	
  </tr>			
      <%} %>
      
      </tbody>
      </table>
    </div>
<div class="container">


  <!-- The Modal -->
  <div class="modal" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">리뷰 작성</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
      		<div class="wrap">
      			<label for="comment"></label>
      			<textarea class="form-control" rows="5" id="comment" name="text"></textarea>
      			<%if(u_vo != null){%>
      			<input type= "hidden" id ="m_id" value = "<%=vo.getId()%>">
      			<input type= "hidden" id ="u_id" value = "<%=u_vo.getId()%>">
      			<%}%>
      			<span id="counter" class="text-">###</span>
   			 </div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-primary" id = "submit"  >전송</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
        </div>
        
      </div>
    </div>
  </div>
  
</div>
																									
</body>
</html>

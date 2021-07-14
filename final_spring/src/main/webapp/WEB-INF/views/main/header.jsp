<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Website menu 03</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>	
<link rel="stylesheet" href="resources/css/style.css">
<script type="text/javascript" src="resources/js/jquery.min.js"></script>
<script type="text/javascript" src="resources/js/popper.js"></script>
<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/js/main.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script type="text/javascript">
    
    var socket = null;
    var sock = new SockJS("<c:url value="/message_ws"/>");
    socket = sock;
    $(document).ready(function(){
		connectWS();

    });

        function connectWS(){
            sock.onopen = function() {
                   console.log('info: connection opened.');
            };
            sock.onmessage = function(e){
                var splitdata =e.data.split(":");
                if(splitdata[0].indexOf("msgNum") > -1)
                	if(splitdata[1] != '0') {
                		$("#msgNum").empty();
                		$("#msgNum").append(" ["+splitdata[1]+"통의 쪽지가 왔습니다.]");
                	} 
            }
            sock.onclose = function(){

            }
            sock.onerror = function (err) {console.log('Errors : ' , err);};
     
        }
           
</script>
<style type="text/css">

li { list-style: none; float: left; padding: 6px; }

</style>
</head>
<body>
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
					<h2 class="heading-section">save earth save us</h2>
				</div>
			</div>
		</div>

		<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
	    <div class="container">
	    	<a class="navbar-brand" href="main.do">마크넣기</a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="fa fa-bars"></span> Menu
	      </button>
	      <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav m-auto">
	        	<!-- <li class="nav-item active"><a href="#" class="nav-link">정보안내</a></li> -->
	        	<li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">정보안내</a>
              <div class="dropdown-menu" aria-labelledby="dropdown04">
              	<a class="dropdown-item" href="calendar.do">Calendar</a>
                <a class="dropdown-item" href="teacherble.do">Teacherble</a>
                <a class="dropdown-item" href="board.do">정보 게시판</a>
                <a class="dropdown-item" href="#">나중에 창민님 지도 api</a>
              </div>
            </li>
	        	<li class="nav-item"><a href="funding_list.do" class="nav-link">펀딩</a></li>
	        	<li class="nav-item"><a href="group_list.do" class="nav-link">소모임</a></li>
	        	<li class="nav-item"><a href="dealList.do" class="nav-link">회원거래</a></li>
	         <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="dropdown02" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">공지 및 이벤트</a>
              <div class="dropdown-menu" aria-labelledby="dropdown04">
              	<a class="dropdown-item" href="#">공지</a>
                <a class="dropdown-item" href="event_list.do">이벤트</a>
                <a class="dropdown-item" href="qna_list.do">QnA</a>
              </div>
            </li> 
	        </ul>
	      </div>
	      <div>
	           <ul class="header_login">
		        <% if(session.getAttribute("dto") == null) { %>
				<li class="nav-item"><a href="login_loginform.do" class="nav-link">로그인</a></li>
	        	<li class="nav-item"><a href="login_memberjoin.do" class="nav-link">회원가입</a></li>
		
		        <% } else { %>
		        <li class="nav-item" style="vertical-align:middle;"><a href="message_recvList.do" class="nav-link" style="font-size:22px; height:35px; vertical-align:middle; padding-top:3px;"><i class="far fa-envelope"></i><span id="msgNum" style="font-size: 13px;"></span></a></li>
		        <li class="nav-item"><a href="#" class="nav-link">마이페이지 로고</a></li>
	        	<li class="nav-item"><a href="member_logout.do" class="nav-link">로그아웃</a></li>
		        <% } %>
    		  </ul>
	      </div>
	    </div>
	  </nav>
    <!-- END nav -->
	</section>

	</body>
</html>
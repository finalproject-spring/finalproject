<%@page import="com.spring.recycle.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>Save earth Save us</title>
<meta content="" name="description">
<meta content="" name="keywords">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
<!-- Favicons -->
<link href="resources/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Roboto:100,300,400,500,700|Philosopher:400,400i,700,700i" rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="resources/vendor/aos/aos.css" rel="stylesheet">

<!-- Template Main CSS File -->
<link href="resources/css/style.css" rel="stylesheet">

<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
<link href="resources/css/chatbot.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="resources/js/popper.js"></script>
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

</style>
<body>

 	<!-- ======= Header ======= -->
  <header id="header" class="header">
    <div class="container">

      <div id="logo" class="pull-left">
         <a class="navbar-brand" href="main.do"><img src="resources/images/earth-globe.png" alt="https://www.freepik.com" style="width: 40px; vertical-align: middle;"/></a>
         <!-- Uncomment below if you prefer to use an image logo -->
        <!-- <a href="index.html"><img src="resources/img/logo.png" alt="" title="" /></a>-->
      </div>

      <nav id="nav-menu-container">
        <ul class="nav-menu" style="display: inline-block; margin-left: 50px;">
			<li class="menu-has-children"><a>정보안내</a>
         	   <ul>
	          	   <li><a href="teacherble.do">분리수거 안내</a></li>
	          	   <li><a href="board.do">환경보호 정보</a></li>
	          	   <li><a href="map.do">안심식당 찾기</a></li>
	          	   <li><a href="calendar.do">캘린더</a></li>
          	   </ul>
          	</li>
          <li><a href="funding_list.do">펀딩</a></li>
          <li><a href="group_list.do">소모임</a></li>
          <li><a href="dealList.do">회원거래</a></li>
          <li class="menu-has-children"><a>이벤트 / QnA</a>
            <ul>
              <li><a href="event_list.do">이벤트</a></li>
              <li><a href="qna_list.do">QnA</a></li>
            </ul>
          </li>
        </ul>
        <ul class="nav-menu" style="display: inline-block; float: right;" id="login_menu">
<% 
		  if(session.getAttribute("dto") == null) { 
%>
          <li class="menu-active" style="padding-left: 20px;"><a href="login_loginform.do" style="font-weight: 700;">로그인</a></li>
	      <li class="menu-active"><a href="login_memberjoin.do" style="font-weight: 700;">회원가입</a></li>
<% 		  } else { 
		      	 MemberDto dto = (MemberDto) session.getAttribute("dto");
		      	 String member_pic = dto.getMember_pic();
%>
		  <li class="menu-active" style="vertical-align:middle; padding-left: 20px;"><a href="message_recvList.do" class="menu-active" style="font-size:22px; height:35px; vertical-align:middle;"><i class="far fa-envelope"></i><span id="msgNum" style="font-size: 13px;"></span></a></li>
		  <li class="menu-active">
<%
		  if(dto.getMember_role() == 0) {
%>
					<a href="admin_main.do" class="menu-active"><img alt="프로필 사진" src="<%=member_pic%>" style="width: 30px; height: 30px; border-radius: 25px;"></a>
<%
		  } else {
%>
		        	<a href="mypage.do" class="menu-active"><img alt="프로필 사진" src="<%=member_pic%>" style="width: 30px; height: 30px; border-radius: 25px;"></a>
<%
		 }
%>
	        	</li>
	        	<li class="menu-active"><a href="member_logout.do" style="font-weight: 700;">로그아웃</a></li>
<% } %>     
        </ul>
      </nav><!-- #nav-menu-container -->
    </div>
  </header><!-- End Header -->
  <a class="chatbot" onclick="chatbotStart();" style="cursor: pointer;"><i class="fas fa-robot" style="color: white;"></i></a>
  <div id="chatbot">
	<div class="chat_wrap">
	<div class="header"><i class="fas fa-robot"></i> ChatBot<i class="fas fa-times" onclick="chatbotEnd();" style="float: right; padding-right: 12px; cursor: pointer;"></i></div>
	<div class="chat">
		<ul>
			<li class="left">
				<div class="message">안녕하세요! save earth save us 챗봇입니다. 사이트 내 게시판 이용 안내와 환경 보호 및 분리수거 정보를 제공하고 있어요 :)</div>
			</li>
		</ul>
	</div>
	<div class="input">
        <textarea placeholder="메세지를 입력해 주세요." style="resize: none; float: left;"></textarea>
        <i class="fas fa-paper-plane" id="sendMsg"></i>
    </div>
	<div class="chat format">
		<ul>
			<li>
				<div class="message">
					<span></span>
				</div>
			</li>
		</ul>
	</div>
</div>
  </div>
  <script type="text/javascript">
  
  	function chatbotStart(){
  		$(".chatbot").hide();
  		$("#chatbot").show();
  		
  		$.ajax({
  			url: "chatbot.do",
  			type: "POST",
  			success:function(){
  			}
  		});
  	}
  	
  	var Chat = (function(){
  	    function init() {

  	        $(document).on('keydown', 'div.input textarea', function(e){
  	            if(e.keyCode == 13 && !e.shiftKey) {
  	                e.preventDefault();
  	                var message = $(this).val();
  	 
  	                sendMessage(message);

  	                clearTextarea();
  	            }
  	        });
  	        
  	        $(document).on('click', '#sendMsg', function(){
  	                var message = $('div.input textarea').val();
  	 
  	                sendMessage(message);

  	                clearTextarea();
  	        });
  	        
  	        
  	    }
  	 
  	    function createMessageTag(LR_className, message) {

  	        var chatLi = $('div.chat.format ul li').clone();
  	 
  	        chatLi.addClass(LR_className);
  	        chatLi.find('.message span').text(message);
  	 
  	        return chatLi;
  	    }
  	 
  	    function sendMessage(message) {
  			var data = {
  					"message" : message
  				};
  			
  				request(data);
  				
  				$.ajax({
  					type:"POST",
  					url:"chatbot_message.do",
  					data : data,
  					dataType : "json",
  					success : function(responseChat) {
  						response(responseChat);
  					}
  				});
  	    }
  	    
  	    function request(data) {
  	        appendMessageTag("right", data.message);
  	        $('div.chat').scrollTop($('div.chat')[0].scrollHeight);
  	    }
  		
  		function response(data) {
  			appendMessageTag("left", data.message);
  			$('div.chat').scrollTop($('div.chat')[0].scrollHeight);
  		}
  		
  	    function appendMessageTag(LR_className, message) {
  	        var chatLi = createMessageTag(LR_className, message);
  	        $('div.chat:not(.format) ul').append(chatLi);
  	    }
  	 
  	 
  	    function clearTextarea() {
  	        $('div.input textarea').val('');
  	    }
  	 
  	    return {
  	        'init': init
  	    };
  	})();
  	 
  	$(function(){
  	    Chat.init();
  	});

  	
  	function chatbotEnd(){
  		$("#chatbot").hide();
  		$(".chatbot").show();
  	}
  		
  </script>	
  
  
  <!-- Vendor JS Files -->
  <script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="resources/vendor/jquery.easing/jquery.easing.min.js"></script>
  <script src="resources/vendor/superfish/superfish.min.js"></script>
  <script src="resources/vendor/hoverIntent/hoverIntent.js"></script>
  <script src="resources/vendor/aos/aos.js"></script>
  
	</body>
	
</html>
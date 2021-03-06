<%@page import="java.util.List"%>
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
<link href="resources/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Fonts -->
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Roboto:100,300,400,500,700|Philosopher:400,400i,700,700i" rel="stylesheet">
<link rel="stylesheet" href="//fonts.googleapis.com/earlyaccess/nanumpenscript.css">
<link rel="stylesheet" href="//fonts.googleapis.com/earlyaccess/nanumgothic.css">
<!-- Vendor CSS Files -->
<link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="resources/vendor/modal-video/css/modal-video.min.css" rel="stylesheet">
<link href="resources/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet">
<link href="resources/vendor/aos/aos.css" rel="stylesheet">

<!-- Template Main CSS File -->
<link href="resources/css/style.css" rel="stylesheet">
<link href="resources/css/chatbot.css" rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
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
	            		$("#msgNum").append(" ["+splitdata[1]+"?????? ????????? ????????????.]");
	            	} 
	        }
	        sock.onclose = function(){
	        }
	        sock.onerror = function (err) {console.log('Errors : ' , err);};
	 
	    }
	    	       
</script>
</head>
<body>

<!-- ======= Header ======= -->
<header id="header" class="header">
    <div class="container">

      <div id="logo" class="pull-left">
        <a class="navbar-brand" href="main.do"><img src="resources/images/earth-globe.png" alt="https://www.freepik.com" style="width: 40px; vertical-align: middle;"/></a>
      </div>

      <nav id="nav-menu-container">
        <ul class="nav-menu" style="display: inline-block; margin-left: 50px;">
			<li class="menu-has-children"><a>????????????</a>
         	   <ul>
	          	   <li><a href="teacherble.do">???????????? ??????</a></li>
	          	   <li><a href="board.do">???????????? ??????</a></li>
	          	   <li><a href="map.do">???????????? ??????</a></li>
	          	   <li><a href="calendar.do">?????????</a></li>
          	   </ul>
          	</li>
          <li><a href="funding_list.do">??????</a></li>
          <li><a href="group_list.do">?????????</a></li>
          <li><a href="dealList.do">????????????</a></li>
          <li class="menu-has-children"><a>????????? / QnA</a>
            <ul>
              <li><a href="event_list.do">?????????</a></li>
              <li><a href="qna_list.do">QnA</a></li>
            </ul>
          </li>
        </ul>
        <ul class="nav-menu" style="display: inline-block; float: right;" id="login_menu">
<%
if(session.getAttribute("dto") == null) {
%>
          <li class="menu-active" style="padding-left: 20px;"><a href="login_loginform.do" style="font-weight: 700;">?????????</a></li>
	      <li class="menu-active"><a href="login_memberjoin.do" style="font-weight: 700;">????????????</a></li>
<%
} else { 
		      	 MemberDto dto = (MemberDto) session.getAttribute("dto");
		      	 String member_pic = dto.getMember_pic();
%>
		  <li class="menu-active" style="vertical-align:middle;"><a href="message_recvList.do" class="menu-active" style="font-size:22px; height:35px; vertical-align:middle;"><i class="far fa-envelope"></i><span id="msgNum" style="font-size: 13px;"></span></a></li>
		  <li class="menu-active">
<%
if(dto.getMember_role() == 0) {
%>
					<a href="admin_main.do" class="menu-active"><img alt="????????? ??????" src="<%=member_pic%>" style="width: 30px; height: 30px; border-radius: 25px;"></a>
<%
} else {
%>
		        	<a href="mypage.do" class="menu-active"><img alt="????????? ??????" src="<%=member_pic%>" style="width: 30px; height: 30px; border-radius: 25px;"></a>
<%
}
%>
	        	</li>
	        	<li class="menu-active"><a href="member_logout.do" style="font-weight: 700;">????????????</a></li>
<%
}
%>     
        </ul>
      </nav><!-- #nav-menu-container -->
    </div>
  </header><!-- End Header -->
  <!-- ======= Hero Section ======= -->
  <section id="hero">
    <div class="hero-container" data-aos="fade-in">
      <h1>Save earth Save us</h1>
      <h2 style="font-size: 18px;">?????? ????????? ????????? ????????? ????????? ??? ???!
	  <br/>?????????????????? ????????? ?????????, ????????? ????????? ????????? ?????? ??????????????????.</h2>
      <img src="resources/img/main_img.png" width="720px;" height="440px;" alt="Hero Imgs" data-aos="zoom-out" data-aos-delay="100">
      <a href="#get-started" class="btn-get-started scrollto">????????????</a>
      </div>
  </section><!-- End Hero Section -->

  <main id="main">
    <!-- ======= Get Started Section ======= -->
    <section id="get-started" class="padd-section text-center">

      <div class="container" data-aos="fade-up">
        <div class="section-title text-center">

          <h2 style="font-family: 'Nanum Pen Script'; font-size: 60px; color: #71c55d;">?????? ????????? ??????!</h2>
          <p class="separator">Save earth Save us??? ?????? ????????? ???????????????.</p>

        </div>
      </div>

      <div class="container">
        <div class="row">

          <div class="col-md-6 col-lg-4" data-aos="zoom-in" data-aos-delay="100">
            <div class="feature-block">

              <img src="resources/images/recycle.png" alt="" class="img-fluid">
              <h4>???????????? ??????</h4>
              <p>????????? ????????? ai??? ????????? ??????! <br/>???????????? ????????? ?????????.</p>
              <a href="teacherble.do">????????????</a>

            </div>
          </div>

          <div class="col-md-6 col-lg-4" data-aos="zoom-in" data-aos-delay="200">
            <div class="feature-block">

              <img src="resources/images/invest.png" alt="img" class="img-fluid">
              <h4>??????</h4>
              <p>?????? ????????? ????????? ?????? ????????? ?????? ?????? ????????? ???????????? ?????????.</p>
              <a href="funding_list.do">?????? ????????????</a>

            </div>
          </div>

          <div class="col-md-6 col-lg-4" data-aos="zoom-in" data-aos-delay="300">
            <div class="feature-block">

              <img src="resources/images/discussion.png" alt="img" class="img-fluid">
              <h4>?????????</h4>
              <p>??????????????? ?????? ?????? ????????? ?????? ????????? ?????????. ?????? ???????????? ????????? ?????? ??? ????????????! </p>
              <a href="group_list.do">????????????</a>

            </div>
          </div>

        </div>
      </div>

    </section><!-- End Get Started Section -->
	    <!-- ======= ???????????? ======= -->
<script type="text/javascript">

 $.ajax({
	 url : "main_crawling.do",
	 type: "POST",
	 success: function(list){
		for(i = 0; i < list.length; i++) {
			switch(true) {
				case (list[i] < 31):
					list[i] = 'resources/images/dust1.png,'+list[i]+'???/??? ??????'
					break;
				case (30 < list[i] < 81):
					list[i] = 'resources/images/dust2.png,'+list[i]+'???/??? ??????'
					break;
				case (80 < list[i] < 151):
					list[i] = 'resources/images/dust3.png'+list[i]+'???/??? ??????'
					break;
				case (list[i] > 150):
					list[i] = 'resources/images/dust4.png'+list[i]+'???/??? ????????????'
					break;
			}
		}

		$('#dust1').attr('src', list[0].split(",")[0]);
		$('#dust_desc1').text(list[0].split(",")[1]);
		$('#dust2').attr('src', list[1].split(",")[0]);
		$('#dust_desc2').text(list[1].split(",")[1]);
		$('#dust3').attr('src', list[2].split(",")[0]);
		$('#dust_desc3').text(list[2].split(",")[1]);
		$('#dust4').attr('src', list[3].split(",")[0]);
		$('#dust_desc4').text(list[3].split(",")[1]);
		$('#dust5').attr('src', list[4].split(",")[0]);
		$('#dust_desc5').text(list[4].split(",")[1]);
		$('#dust6').attr('src', list[5].split(",")[0]);
		$('#dust_desc6').text(list[5].split(",")[1]);
		$('#dust7').attr('src', list[6].split(",")[0]);
		$('#dust_desc7').text(list[6].split(",")[1]);
		$('#dust8').attr('src', list[7].split(",")[0]);
		$('#dust_desc8').text(list[7].split(",")[1]);
	 }
	 
	 
 });

</script>

    <section id="features" class="padd-section text-center">

      <div class="container" data-aos="fade-up">
        <div class="section-title text-center">
          <h2 style="font-family: 'Nanum Pen Script'; font-size: 60px; color: #5d5de7;">?????? ????????????????</h2>
        </div>

        <div class="row" data-aos="fade-up" data-aos-delay="100">

          <div class="col-md-6 col-lg-3">
            <div class="feature-block">
              <img src="" alt="img" id="dust1" class="img-fluid">
              <h4>??????</h4>
              <p id="dust_desc1"></p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-block">
              <img src="" alt="img" id="dust2" class="img-fluid">
              <h4>??????</h4>
              <p id="dust_desc2"></p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-block">
              <img src="" alt="img"  id="dust3" class="img-fluid">
              <h4>??????</h4>
              <p id="dust_desc3"></p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-block">
              <img src="" alt="img" id="dust4" class="img-fluid">
              <h4>??????</h4>
              <p id="dust_desc4"></p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-block">
              <img src="" alt="img" id="dust5" class="img-fluid">
              <h4>??????</h4>
              <p id="dust_desc5"></p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-block">
              <img src="" alt="img" id="dust6" class="img-fluid">
              <h4>??????</h4>
              <p id="dust_desc6"></p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-block">
              <img src="" alt="img" id="dust7" class="img-fluid">
              <h4>??????</h4>
              <p id="dust_desc7"></p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-block">
              <img src="" alt="img" id="dust8" class="img-fluid">
              <h4>??????</h4>
              <p id="dust_desc8"></p>
            </div>
          </div>

        </div>
      </div>
    </section><!-- End Features Section -->
    
    <!-- ======= About Us Section ======= -->
    <section id="about-us" class="about-us padd-section">
      <div class="container" data-aos="fade-up">
        <div>
            <div class="about-content" data-aos="fade-left" data-aos-delay="100">  
	          <div style="text-align: center;">
	            <img src="resources/images/maincovid.jpg" alt="?????? : https://kids.hyundai.com/kidshyundai/safetyEnvironment/learnenvDet.kids?cotnSn=3742" data-aos="zoom-in" data-aos-delay="100">
	          </div>
              <div id="text1">????????? ????????? ????????? ??????????</div>
              <p>?????? ???????????? ????????? <span>?????? 1??????</span>????????????.<br/>
              ????????? 19??? ???????????? ???????????? ????????? ??? ?????? ??????????????????.<br/>
              ?????? ?????? ????????? ??????????????? ????????? ???????????? ????????????.</p>
            </div>
            
            <div id="text2" data-aos="fade-left" data-aos-delay="100">
	            ??????????????? '????????? ??????'??? ???????????? ????????? ????????? ????????? ????????? ??????,<br/>
	            ?????? ?????? ????????? ????????? ????????? ????????????.<br/>
	            <span>Save earth Save us</span>??? ????????? ???????????????<br/>
	           	?????? ????????? ?????? ?????? ?????? ????????? ???????????????.<br/>
            </div>

        </div>
      </div>
    </section><!-- End About Us Section -->
    
        <section id="infoimg" class="padd-section text-center">

      <div class="container" data-aos="fade-up">
        <div class="section-title text-center">
        	<div style="text-align: center;">
	            <img src="resources/images/main_img2.png" data-aos="zoom-in" data-aos-delay="100" style="width: 900px; height: 900px;">
	        </div>
        </div>
      </div>
    </section><!-- End Features Section -->

    <!-- ======= Testimonials Section ======= -->
    <section id="testimonials" class="padd-section text-center">
      <div class="container" data-aos="fade-up">
        <div class="row justify-content-center">

          <div class="col-md-8">

            <div class="testimonials-content">
              <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">

                <div class="carousel-inner" role="listbox">

                  <div class="carousel-item  active">
                    <div class="top-top">

                      <h2 style="font-size:35px;">????????????, ?????? ????????? ????????????</h2>
                      <p style="font-size:14px;">?????????????????? ?????? ????????? ????????? ???????????? ????????? ??????, ???????????? ??????, ????????? ?????????????????? ?????? ????????? ??????. ?????? 30????????? ????????? ?????? ???????????? ???????????? ??????????????? ????????????.
						????????? ?????? ??? ???????????? ?????? ????????? ????????? ???????????? ??????, ????????? ???????????????, ??????????????? ?????? ????????? ??? ?????????/????????? ????????????.</p>
                      <h4>James Gustave Speth<span>???????????????</span></h4>

                    </div>
                  </div>

                  <div class="carousel-item ">
                    <div class="top-top">

                      <h2 style="font-size:35px;">?????? ?????? ?????????</h2>
                      <p style="font-size:14px;">
                      	??????, ?????? ????????????????????? ????????? ????????? ???????????? ?????? ???????????? ?????? ?????? ????????????. ????????? ???????????????, ?????? ????????? ?????? ?????? ?????????. ????????? ??? ?????? ?????? ????????????, ????????? ????????? ?????? ?????? ??? ?????? ?????? ??? ??? ??????.<br/>
                      ???????????? ????????????, ????????? ????????? ????????? ?????? ???????????? ??????. ????????? ??? ??? ?????? ?????? ?????????????
                      </p>
                      <h4>Jacques Cousteau<span>???????????????</span></h4>

                    </div>
                  </div>

                  <div class="carousel-item ">
                    <div class="top-top">

                      <h2 style="font-size:35px;">????????? ???????????? ??????????????????</h2>
                      <p style="font-size:14px;">
						You'll Die of Old Age, We'll Die of Climate Change. ???????????? ?????? ?????? ???????????????. ????????? ???????????? ????????? ?????????.
						??????????????? ????????? ??? ??? ?????? ???????????? ????????? ????????? ?????? ??? ????????? ????????? ????????????. 10?????? ?????? ?????? ??? ????????? ??? ????????????. ?????????????????? ??? ??????
						??? ??? ?????? ?????? ?????? ??? ????????? ???????????? ?????????.
                      </p>
                      <h4>?????????<span>brunch ??????</span></h4>

                    </div>
                  </div>

                </div>

                <div class="btm-btm">

                  <ul class="list-unstyled carousel-indicators">
                    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                  </ul>

                </div>

              </div>
            </div>
          </div>

        </div>
      </div>
    </section><!-- End Testimonials Section -->

    <!-- ======= Blog Section ======= -->
    <section id="event" class="padd-sectio">

      <div class="container" data-aos="fade-up">
        <div align="center">
          <h2>EVENT</h2>
          <p class="separator">???????????? ???????????? ????????? ????????? ???????????????!</p>
        </div>

        <div id="event_row" class="row" data-aos="fade-up" data-aos-delay="100">

          <div class="col-md-6 col-lg-4">
            <div class="block-blog text-left">
              <a href="#"><img src="resources/images/main_event1.png" alt="img"></a>
            </div>
          </div>

          <div class="col-md-6 col-lg-4">
            <div class="block-blog text-left">
              <a href="#"><img src="resources/images/main_event2.png" class="img-responsive" alt="img"></a>
            </div>
          </div>

          <div class="col-md-6 col-lg-4">
            <div class="block-blog text-left">
              <a href="#"><img src="resources/images/main_event3.png" class="img-responsive" alt="img"></a>
            </div>
          </div>

        </div>
      </div>
    </section><!-- End Blog Section -->
	
	    <!-- ======= Team Section ======= -->
    <section id="team" class="padd-section text-center">

      <div class="container" data-aos="fade-up" align="center">
        <div class="section-title text-center">

          <h2 style="font-size: 30px; font-weight: 700;">Save earth Save us</h2>
          <p class="separator">????????? ????????? ?????????!</p>
        </div>

        <div class="row">

          <div data-aos="zoom-in" data-aos-delay="100">
            <div class="team-block bottom">
              <img src="resources/images/team_info1.png" class="img-responsive" alt="img">
              <div class="team-content">
                <ul class="list-unstyled">
                  <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                  <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                  <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                </ul>
                <h4>?????????</h4>
              </div>
            </div>
          </div>

          <div data-aos="zoom-in" data-aos-delay="200">
            <div class="team-block bottom">
              <img src="resources/images/team_info2.png" class="img-responsive" alt="img">
              <div class="team-content">
                <ul class="list-unstyled">
                  <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                  <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                  <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                </ul>
                <h4>?????????</h4>
              </div>
            </div>
          </div>

          <div data-aos="zoom-in" data-aos-delay="300">
            <div class="team-block bottom">
              <img src="resources/images/team_info4.png" class="img-responsive" alt="img">
              <div class="team-content">
                <ul class="list-unstyled">
                  <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                  <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                  <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                </ul>
                <h4>?????????</h4>
              </div>
            </div>
          </div>

          <div data-aos="zoom-in" data-aos-delay="400">
            <div class="team-block bottom">
              <img src="resources/images/team_info3.png" class="img-responsive" alt="img">
              <div class="team-content">
                <ul class="list-unstyled">
                  <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                  <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                  <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                </ul>
                <h4>?????????</h4>
              </div>
            </div>
          </div>

        </div>
      </div>
    </section><!-- End Team Section -->
    
  </main><!-- End #main -->

  <!-- ======= Footer ======= -->
  <footer class="footer">
    <div class="container">
      <div align="center">
        <div>
          <div class="footer-logo">

            <a class="navbar-brand" href="#">Save earth Save us</a>
            <p>TEAM ????????? ?????? ????????? <i class="fas fa-seedling"></i><br/>
            ??????????????? ????????? ???????????? 14??? 6 ????????????<br/>
            https://github.com/finalproject-spring/finalproject
            </p>

          </div>
        </div>

        <div>
          <div class="list-menu">
          </div>
        </div>  
	  </div>
	</div>
  </footer><!-- End  Footer -->
	
    <div class="copyrights" style="width: 100%;">
      <div>
        <p>&copy; Copyrights Save earth Save us. All rights reserved.</p>
        <div class="credits">
          <!--
          All the links in the footer should remain intact.
          You can delete the links only if you purchased the pro version.
          Licensing information: https://bootstrapmade.com/license/
          Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/buy/?theme=eStartup
        -->
 		Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>, Icons made by <a href="https://www.freepik.com" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a>
              , Image made by <a href="https://kids.hyundai.com/kidshyundai/safetyEnvironment/learnenvDet.kids?cotnSn=3742">kids_hyundai</a>
     	</div>
    </div>
    </div>
  <a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>
      <a class="chatbot" onclick="chatbotStart();" style="cursor: pointer;"><i class="fas fa-robot" style="color: white;"></i></a>
  <div id="chatbot">
	<div class="chat_wrap">
	<div class="header"><i class="fas fa-robot"></i> ChatBot<i class="fas fa-times" onclick="chatbotEnd();" style="float: right; padding-right: 12px; cursor: pointer;"></i></div>
	<div class="chat">
		<ul>
			<li class="left">
				<div class="message">???????????????! save earth save us ???????????????. ????????? ??? ????????? ?????? ????????? ?????? ?????? ??? ???????????? ????????? ???????????? ????????? :)</div>
			</li>
		</ul>
	</div>
	<div class="input">
        <textarea placeholder="???????????? ????????? ?????????." style="resize: none; float: left;"></textarea>
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
  <script src="resources/vendor/modal-video/js/modal-video.min.js"></script>
  <script src="resources/vendor/owl.carousel/owl.carousel.min.js"></script>
  <script src="resources/vendor/superfish/superfish.min.js"></script>
  <script src="resources/vendor/hoverIntent/hoverIntent.js"></script>
  <script src="resources/vendor/aos/aos.js"></script>

  <!-- Template Main JS File -->
  <script src="resources/js/main.js"></script>

</body>
</html>
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
	            		$("#msgNum").append(" ["+splitdata[1]+"통의 쪽지가 왔습니다.]");
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
      <h2 style="font-size: 18px;">이제 우리의 손으로 지구를 지켜야 할 때!
	  <br/>쓰레기로부터 생명을 지키고, 깨끗한 지구를 만들기 위해 함께해주세요.</h2>
      <img src="resources/img/main_img.png" width="720px;" height="440px;" alt="Hero Imgs" data-aos="zoom-out" data-aos-delay="100">
      <a href="#get-started" class="btn-get-started scrollto">시작하기</a>
      </div>
  </section><!-- End Hero Section -->

  <main id="main">
    <!-- ======= Get Started Section ======= -->
    <section id="get-started" class="padd-section text-center">

      <div class="container" data-aos="fade-up">
        <div class="section-title text-center">

          <h2 style="font-family: 'Nanum Pen Script'; font-size: 60px; color: #71c55d;">이런 활동을 해요!</h2>
          <p class="separator">Save earth Save us의 주요 기능을 소개합니다.</p>

        </div>
      </div>

      <div class="container">
        <div class="row">

          <div class="col-md-6 col-lg-4" data-aos="zoom-in" data-aos-delay="100">
            <div class="feature-block">

              <img src="resources/images/recycle.png" alt="" class="img-fluid">
              <h4>분리수거 안내</h4>
              <p>재활용 분류를 ai가 알아서 척척! <br/>분리수거 어렵지 않아요.</p>
              <a href="teacherble.do">알아보기</a>

            </div>
          </div>

          <div class="col-md-6 col-lg-4" data-aos="zoom-in" data-aos-delay="200">
            <div class="feature-block">

              <img src="resources/images/invest.png" alt="img" class="img-fluid">
              <h4>펀딩</h4>
              <p>우리 주변의 다양한 환경 문제를 돕기 위한 펀딩을 진행하고 있어요.</p>
              <a href="funding_list.do">펀딩 참여하기</a>

            </div>
          </div>

          <div class="col-md-6 col-lg-4" data-aos="zoom-in" data-aos-delay="300">
            <div class="feature-block">

              <img src="resources/images/discussion.png" alt="img" class="img-fluid">
              <h4>소모임</h4>
              <p>사용자들과 만나 환경 문제에 대해 의논해 보세요. 작은 일이지만 지구를 지킬 수 있습니다! </p>
              <a href="group_list.do">참여하기</a>

            </div>
          </div>

        </div>
      </div>

    </section><!-- End Get Started Section -->
	    <!-- ======= 미세먼지 ======= -->
<script type="text/javascript">

 $.ajax({
	 url : "main_crawling.do",
	 type: "POST",
	 success: function(list){
		for(i = 0; i < list.length; i++) {
			switch(true) {
				case (list[i] < 31):
					list[i] = 'resources/images/dust1.png,'+list[i]+'㎍/㎥ 좋음'
					break;
				case (30 < list[i] < 81):
					list[i] = 'resources/images/dust2.png,'+list[i]+'㎍/㎥ 보통'
					break;
				case (80 < list[i] < 151):
					list[i] = 'resources/images/dust3.png'+list[i]+'㎍/㎥ 나쁨'
					break;
				case (list[i] > 150):
					list[i] = 'resources/images/dust4.png'+list[i]+'㎍/㎥ 매우나쁨'
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
          <h2 style="font-family: 'Nanum Pen Script'; font-size: 60px; color: #5d5de7;">현재 미세먼지는?</h2>
        </div>

        <div class="row" data-aos="fade-up" data-aos-delay="100">

          <div class="col-md-6 col-lg-3">
            <div class="feature-block">
              <img src="" alt="img" id="dust1" class="img-fluid">
              <h4>서울</h4>
              <p id="dust_desc1"></p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-block">
              <img src="" alt="img" id="dust2" class="img-fluid">
              <h4>경기</h4>
              <p id="dust_desc2"></p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-block">
              <img src="" alt="img"  id="dust3" class="img-fluid">
              <h4>강원</h4>
              <p id="dust_desc3"></p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-block">
              <img src="" alt="img" id="dust4" class="img-fluid">
              <h4>대전</h4>
              <p id="dust_desc4"></p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-block">
              <img src="" alt="img" id="dust5" class="img-fluid">
              <h4>대구</h4>
              <p id="dust_desc5"></p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-block">
              <img src="" alt="img" id="dust6" class="img-fluid">
              <h4>부산</h4>
              <p id="dust_desc6"></p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-block">
              <img src="" alt="img" id="dust7" class="img-fluid">
              <h4>광주</h4>
              <p id="dust_desc7"></p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3">
            <div class="feature-block">
              <img src="" alt="img" id="dust8" class="img-fluid">
              <h4>제주</h4>
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
	            <img src="resources/images/maincovid.jpg" alt="출처 : https://kids.hyundai.com/kidshyundai/safetyEnvironment/learnenvDet.kids?cotnSn=3742" data-aos="zoom-in" data-aos-delay="100">
	          </div>
              <div id="text1">코로나 이후로 늘어난 쓰레기?</div>
              <p>연간 일회용품 소비량 <span>세계 1위인</span>우리나라.<br/>
              코로나 19의 영향으로 일회용품 소비는 더 크게 늘어났습니다.<br/>
              그로 인해 지구에 무분별하게 버려진 쓰레기도 증가했죠.</p>
            </div>
            
            <div id="text2" data-aos="fade-left" data-aos-delay="100">
	            기후위기로 '인류의 생존'이 위협받고 있다는 암울한 경고가 나오는 지금,<br/>
	            환경 문제 더이상 외면할 사항이 아닙니다.<br/>
	            <span>Save earth Save us</span>는 우리의 실생활에서<br/>
	           	환경 보호를 위한 여러 실천 방법을 제공합니다.<br/>
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

                      <h2 style="font-size:35px;">환경보호, 나를 살리는 정신혁명</h2>
                      <p style="font-size:14px;">환경문제에서 가장 중요한 주제는 생물종의 다양성 감소, 생태계의 붕괴, 그리고 기후변화라고 줄곧 생각해 왔다. 나는 30년이면 과학이 이런 문제들을 중대하게 다루리라고 예상했다.
						하지만 지금 와 생각건대 정말 중요한 주제는 이기심과 탐욕, 그리고 무관심이고, 환경문제를 위해 필요한 건 문화적/정신적 변화이다.</p>
                      <h4>James Gustave Speth<span>환경전문가</span></h4>

                    </div>
                  </div>

                  <div class="carousel-item ">
                    <div class="top-top">

                      <h2 style="font-size:35px;">아직 늦지 않았다</h2>
                      <p style="font-size:14px;">
                      	신문, 뉴스 프로그램에서는 우리의 환경이 직면하고 있는 문제들에 대해 매일 보도한다. 전망은 암울하지만, 아직 희망이 없는 것은 아니다. 우리가 더 많이 배워 나갈수록, 우리는 그것을 돕기 위해 더 많은 것을 할 수 있다.<br/>
                      느리지만 확실하게, 우리는 지구를 구하기 위해 노력하고 있다. 당신이 할 수 있는 일은 무엇인가?
                      </p>
                      <h4>Jacques Cousteau<span>환경운동가</span></h4>

                    </div>
                  </div>

                  <div class="carousel-item ">
                    <div class="top-top">

                      <h2 style="font-size:35px;">북극곰 이야기가 아니라니까요</h2>
                      <p style="font-size:14px;">
						You'll Die of Old Age, We'll Die of Climate Change. 어른들은 나이 들어 죽겠지만요. 저희는 기후위기 때문에 죽어요.
						뜨거워지는 지구와 갈 곳 잃은 북극곰에 연민의 감정을 갖는 건 배부른 어른의 시선이다. 10대는 당장 숨이 턱 끝까지 찬 당사자다. 지구온난화는 더 이상
						가 본 적도 없는 설원 위 북극곰 이야기가 아니다.
                      </p>
                      <h4>이소연<span>brunch 발췌</span></h4>

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
          <p class="separator">이벤트에 참여하고 다양한 혜택을 받아가세요!</p>
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
          <p class="separator">지구를 지키는 크루들!</p>
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
                <h4>한지현</h4>
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
                <h4>김인겸</h4>
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
                <h4>김태희</h4>
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
                <h4>이창민</h4>
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
            <p>TEAM 봄봄봄 봄이 왔네요 <i class="fas fa-seedling"></i><br/>
            서울특별시 강남구 테헤란로 14길 6 남도빌딩<br/>
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
  <script src="resources/vendor/modal-video/js/modal-video.min.js"></script>
  <script src="resources/vendor/owl.carousel/owl.carousel.min.js"></script>
  <script src="resources/vendor/superfish/superfish.min.js"></script>
  <script src="resources/vendor/hoverIntent/hoverIntent.js"></script>
  <script src="resources/vendor/aos/aos.js"></script>

  <!-- Template Main JS File -->
  <script src="resources/js/main.js"></script>

</body>
</html>
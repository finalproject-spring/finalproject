<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

	.main-body{
		width : 1800px;
		height: 500px;
		margin: 0 auto;
	}
	
	@import url(https://fonts.googleapis.com/css?family=Varela+Round);


	.slides {
	    padding: 0;
	    top: 35px;
	    width: 605px;
	    height: 420px;
	    display: block;
	    margin: 0 0 0 60px;
	    position: relative;
	    display: inline-block;
	    
	}
	
	.slides * {
	    user-select: none;
	    -ms-user-select: none;
	    -moz-user-select: none;
	    -khtml-user-select: none;
	    -webkit-user-select: none;
	    -webkit-touch-callout: none;
	}
	
	.slides input { display: none; }
	
	.slide-container { display: block; }
	
	.slide {
	    top: 0;
	    opacity: 0;
	    width: 600px;
	    height: 420px;
	    display: block;
	    position: absolute;
	    right: 10px;
	
	    transform: scale(0);
	
	    transition: all .7s ease-in-out;
	}
	
	.slide img {
	    width: 100%;
	    height: 100%;
	}
	
	.nav label {
	    width: 200px;
	    height: 100%;
	    display: none;
	    position: absolute;
	
		opacity: 0;
	    z-index: 9;
	    cursor: pointer;
	
	    transition: opacity .2s;
	
	    color: #FFF;
	    font-size: 156pt;
	    text-align: center;
	    line-height: 380px;
	    font-family: "Varela Round", sans-serif;
	    background-color: rgba(255, 255, 255, .3);
	    text-shadow: 0px 0px 15px rgb(119, 119, 119);
	}
	
	.slide:hover + .nav label { opacity: 0.5; }
	
	.nav label:hover { opacity: 1; }
	
	.nav .next { right: 0; }
	
	input:checked + .slide-container  .slide {
	    opacity: 1;
	
	    transform: scale(1);
	
	    transition: opacity 1s ease-in-out;
	}
	
	input:checked + .slide-container .nav label { display: block; }
	
	.nav-dots {
		width: 100%;
		bottom: 9px;
		height: 11px;
		display: block;
		position: absolute;
		text-align: center;
	}
	
	.nav-dots .nav-dot {
		top: -5px;
		width: 11px;
		height: 11px;
		margin: 0 4px;
		position: relative;
		border-radius: 100%;
		display: inline-block;
		background-color: rgba(0, 0, 0, 0.6);
	}
	
	.nav-dots .nav-dot:hover {
		cursor: pointer;
		background-color: rgba(0, 0, 0, 0.8);
	}
	
	input#img-1:checked ~ .nav-dots label#img-dot-1,
	input#img-2:checked ~ .nav-dots label#img-dot-2,
	input#img-3:checked ~ .nav-dots label#img-dot-3,
	input#img-4:checked ~ .nav-dots label#img-dot-4,
	input#img-5:checked ~ .nav-dots label#img-dot-5,
	input#img-6:checked ~ .nav-dots label#img-dot-6 {
		background: rgba(0, 0, 0, 0.8);
	}
	
	.text-box{
		display: inline-block;
	    width: 600px;
	    position: absolute;
	    margin: 25px;
	}
	

</style>

</head>
<body>
<jsp:include page="../main/header.jsp"></jsp:include>
	
	<div class="main-body">
	
		<ul class="slides">
		    <input type="radio" name="radio-btn" id="img-1" checked />
		    <li class="slide-container">
				<div class="slide">
					<img src="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=http%3A%2F%2Fcfile21.uf.tistory.com%2Fimage%2F267B9D375832947019E276" />
		        </div>
				<div class="nav">
					<label for="img-6" class="prev">&#x2039;</label>
					<label for="img-2" class="next">&#x203a;</label>
				</div>
		    </li>
		
		    <input type="radio" name="radio-btn" id="img-2" />
		    <li class="slide-container">
		        <div class="slide">
		          <img src="https://dimg.donga.com/wps/NEWS/IMAGE/2020/07/15/101972884.2.jpg" />
		        </div>
				<div class="nav">
					<label for="img-1" class="prev">&#x2039;</label>
					<label for="img-3" class="next">&#x203a;</label>
				</div>
		    </li>
		
		    <input type="radio" name="radio-btn" id="img-3" />
		    <li class="slide-container">
		        <div class="slide">
		          <img src="https://pimg.daara.co.kr/kidd/photo/2020/04/24/thumbs/thumb_520390_1587716456_38.jpg" />
		        </div>
				<div class="nav">
					<label for="img-2" class="prev">&#x2039;</label>
					<label for="img-4" class="next">&#x203a;</label>
				</div>
		    </li>
		
		    <input type="radio" name="radio-btn" id="img-4" />
		    <li class="slide-container">
		        <div class="slide">
		          <img src="http://talk.hyundai-steel.com/wp-content/uploads/2019/07/5532_%ED%99%98%EA%B2%BD%EB%B3%B4%ED%98%B8%EC%8D%B8.jpg" />
		        </div>
				<div class="nav">
					<label for="img-3" class="prev">&#x2039;</label>
					<label for="img-5" class="next">&#x203a;</label>
				</div>
		    </li>
		
		    <input type="radio" name="radio-btn" id="img-5" />
		    <li class="slide-container">
		        <div class="slide">
		          <img src="https://www.trusens.com/contentassets/0aa9b99c6570472ab072c0d4a724950f/imagekaodo.png?width=1254&height=836" />
		        </div>
				<div class="nav">
					<label for="img-4" class="prev">&#x2039;</label>
					<label for="img-6" class="next">&#x203a;</label>
				</div>
		    </li>
		
		    <input type="radio" name="radio-btn" id="img-6" />
		    <li class="slide-container">
		        <div class="slide">
		          <img src="https://cdn.pixabay.com/photo/2018/09/05/07/09/nature-3655651_960_720.jpg" />
		        </div>
				<div class="nav">
					<label for="img-5" class="prev">&#x2039;</label>
					<label for="img-1" class="next">&#x203a;</label>
				</div>
		    </li>
		
		    <li class="nav-dots">
		      <label for="img-1" class="nav-dot" id="img-dot-1"></label>
		      <label for="img-2" class="nav-dot" id="img-dot-2"></label>
		      <label for="img-3" class="nav-dot" id="img-dot-3"></label>
		      <label for="img-4" class="nav-dot" id="img-dot-4"></label>
		      <label for="img-5" class="nav-dot" id="img-dot-5"></label>
		      <label for="img-6" class="nav-dot" id="img-dot-6"></label>
		    </li>
		</ul>
	
		<div class="text-box">
			<div class="text-header">
			
				<h1>환경보호정보</h1>
			
			</div>
			
			<div class="text-body">
				<span>환경보호정보관련페이지입니다.</span>
			</div>
			
		</div>
	
	</div>
	

</body>
</html>
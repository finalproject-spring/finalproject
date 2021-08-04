<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">



<style type="text/css">

	.main-body{
		width : 1300px;
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
	
	 div.question-box {
        margin: 10px 0 20px 0;
        text-align: center;
      }
      div.newsbox {
        width: 300px;
        display: -webkit-inline-box;
      }

      div.newsbox > div {
        border: 1.5px solid #181818;
        padding: 10px;
        margin: 20px;
      }

      div.newsbox > div > a > img {
      	width: 300px;
    	height: 200px;
      }

      div.newsbox > div > div.title-box {
        margin: 30px 0 30px 0;
      }
      
      div.newsbox > div > div > a {
        color: #181818;
        font-size: 16px;
        font-weight: bold;
      }
      
      div.newsbox > div > div > h5 {
        color: #5d5d5d;
        margin: 4px 0 2px 0;
      }

	.text-box{
		display: inline-block;
	    width: 700px;
	    position: absolute;
	    margin: 25px;
	}
	
	.main-footer{
        width: 100%;
	    height: 600px;
	    overflow: scroll;
	    overflow-y: hidden;
	    margin: 0 auto;
	    background-color: #d3ffc5;
	    padding: 0px 25px 0px 25px;
	}
	
	.text-body{
		position:absolute;
	}
	
	.txt1{
		width: 630px;
	}
	
	.css-class-name{
        width: 1300px;
	    height: 400px;
	    margin: 10px auto;
	    border-bottom: 1px solid gainsboro;
	}
	
	.img-class-name{
		width: 500px;
	    height: 400px;
	    padding: 30px;
        border-radius: 40px;
	}
	
	.text-box-page{
		width: 700px;
		height: 400px;
		display: inline-block;
		position: absolute;
	}
	
	.page-title{
	    text-align: center;
	    width: 700px;
        margin-top: 120px;
        font-weight: 700;
	}
	
	.page-content{
		text-align: center;
	    width: 700px;
	}
	
	@import url(https://fonts.googleapis.com/css?family=Cabin:700);

	body {
	  padding-top: 2em;
	}
	
	.circle-container {
		position: relative;
		perspective: 1000;	
	    margin: 70px auto 30px auto;
	}
			
	.circle-container:hover .circle {
		transform: rotate3d(45, 45, 0, 180deg);
	}
			
	.circle-container:hover .outer-ring {
		transform: rotate3d(45, 0, 0, 180deg);
	}
	
	.circle-container:hover .outer-outer-ring {
		transform: rotate3d(0, 45, 0, 180deg);
	}
			
	.circle-container, .front, .back {
	    width: 500px;
    	height: 500px;
		background-color: rgba(0,0,0,0);
	}
			
	.circle, .outer-ring, .outer-outer-ring {
		transition: 0.5s;
		transform-style: preserve-3d;
		transition-timing-function: cubic-bezier(0.785, 0.135, 0.150, 0.860);
	}
			
	.circle {
		position: relative;
	    width: 500px;
    	height: 500px;
	}
			
	.front, .back {
		border-radius: 50%;
		box-shadow: 0px 0px 20px rgba(0,0,0,0.4);
		backface-visibility: hidden;
		position: absolute;
		top: 0;
		left: 0;
	  line-height: 140px;
	}
			
	
			
	.front p, .back p {
		margin-top: 300px;
	    font-family: cabin, sans-serif;
	    font-weight: 700;
	    font-size: 85px;
	    text-align: center;
	    color: #faffc7;
	    text-shadow: 0 0 20px #000;
	}
			
	.back {
		transform: rotate3d(45,45,0,180deg);
	  background-color: white;  
		background-image: url(https://www.urbanbrush.net/web/wp-content/uploads/edd/2021/05/urbanbrush-20210514105708156990-548x548.jpg);
	  background-size: auto 100%, cover;
	}
			
	.back-logo {
		width: 60%;
		display: block;
		margin: 2em auto;
	}
			
	.outer-ring {
		position: absolute;
		top: -10px;
		left: -10px;
		border-radius: 50%;
		border: 2px solid #fff;
	    width: 520px;
    	height: 520px;
		background-color: rgba(255,255,255,0);
		box-shadow: 0px 0px 20px rgba(0,0,0,0.4);
	}
	
	.outer-outer-ring {
		position: absolute;
		top: -20px;
		left: -20px;
		border-radius: 50%;
		border: 2px solid #fff;
		width: 211px;
		height: 211px;
		background-color: rgba(255,255,255,0);
		box-shadow: 0px 0px 20px rgba(0,0,0,0.4);
	}
	
	.front {
		background-color: #fff;
		z-index: 2;
	    background-image: url(https://cdn.pixabay.com/photo/2020/01/21/11/40/world-4782728_640.jpg);
	    background-size: auto 95%, cover;
	}
	
	.main-text{
	    width: 315px;
    	margin: 20px auto;
    	text-align: center;
	}
	
	.newsbox-container{
		width: 200px;
	}
	
	.main-text p, .main-text h2, .question-box h3{
		font-family: 'Do Hyeon', sans-serif;
		font-weight:500;
	}
	
	.main-text p{
		font-size: 19px;
	}
	
	.page-date{
	    width: 250px;
    	margin: 0px auto;
	}
	

</style>
 <script>
 
 	  window.onload = function(){
 		 let keyword = '친환경';

         $('#news').html('');

         let target_url = 'https://newsapi.org/v2/everything?q='+keyword+'&apiKey=5d6c1a1d4c0d4de1a60bc34087bb8655';

         $.ajax({
           type: "GET",
           url: target_url,
           data: {},
           success: function(response){
               let articles = response['articles'];
               if(articles == 0){
             	  alert('해당 검색어와 일치하는 뉴스가 없습니다.');
               }
               console.log(response['articles']);
               for (let i = 0 ; i < articles.length; i++){
                 let url = articles[i]['url'];
                 let title = articles[i]['title'];
                 let imgurl = articles[i]['urlToImage'];
                 let date = articles[i]['publishedAt'];
                 let author = articles[i]['author'];
                 let content = articles[i]['content'];

                 let temp_html = '<div>\
                 				  <a href="'+url+'" target="_blank">\
                                   <img src="'+imgurl+'" width="100%"></a>\
                                   <div class="title-box">\
                                   <a href="'+url+'" target="_blank">'+title+'</a>\
                                   <h5>'+date+' | '+author+'</h5>\
                                   </div>\
                                 </div>';
                 $('#news').append(temp_html);
               }
             }
         })
 	  }
 
      function q1() {
        let keyword = $('#input-keyword').val();
        if (keyword == '') {
          keyword = '친환경';
          return;
        }

        $('#news').html('');

        let target_url = 'https://newsapi.org/v2/everything?q='+keyword+'&apiKey=5d6c1a1d4c0d4de1a60bc34087bb8655';

        $.ajax({
          type: "GET",
          url: target_url,
          data: {},
          success: function(response){
              let articles = response['articles'];
              if(articles == 0){
            	  alert('해당 검색어와 일치하는 뉴스가 없습니다.');
              }
              console.log(response['articles']);
              for (let i = 0 ; i < articles.length; i++){
                let url = articles[i]['url'];
                let title = articles[i]['title'];
                let imgurl = articles[i]['urlToImage'];
                let date = articles[i]['publishedAt'];
                let author = articles[i]['author'];
                let content = articles[i]['content'];

                let temp_html = '<div>\
                				  <a href="'+url+'" target="_blank">\
                                  <img src="'+imgurl+'" width="100%"></a>\
                                  <div class="title-box">\
                                  <a href="'+url+'" target="_blank">'+title+'</a>\
                                  <h5>'+date+' | '+author+'</h5>\
                                  </div>\
                                </div>';
                $('#news').append(temp_html);
              }
            }
        })

      }
</script>





</head>
<body>
	<jsp:include page="../main/header.jsp"></jsp:include>
	<div class="main-circle">
		<div class="circle-container">
			<div class="outer-ring"></div>
		  
			<div class="circle">
				<div class="front">
					<p>save earth</p>
				</div>
				<div class="back">
					<p>save us</p>
				</div>
			</div>
		</div>
		
		<div class="main-text">
			<h2 >환경보호</h2>
			<p>
				지구를 지키는 것이 우리를 지키는 것입니다. <br/>
				지구를 지킬 수 있는 방법이 무엇이 있는지 검색 및 정보를 통해 얻을 수 있습니다.
			</p>
		</div>
	
		
	</div>
	
	<div class="main-footer">
		<div class="question-box">
		 	<h3>최신 뉴스 기사 검색</h3>
	      	<input type="text" id="input-keyword" placeholder="ex)친환경">
	     	<button onclick="q1()">검색</button>      
    	</div>
    	<hr/>
    	<div class="newsbox-container">
    		<div class="newsbox" id="news">
	    	</div>	
    	</div>
    </div>
	
	<script>
	
	var pages = [];
	
	<c:forEach items="${list }" var="info">
		pages.push({title:"${info.info_title}", content:"${info.info_content}", src:"${info.info_pic}", start:"${info.info_start}", end:"${info.info_end}"});
	</c:forEach>
	
	console.log(pages.length); 
	
	var page = pages.length;
	var i = 0;
	$(window).scroll(function(){
		if(i < page){
			if($(window).scrollTop() == $(document).height() - $(window).height()){
				var container = document.createElement("div");
				container.className = "css-class-name";
				
				var img = document.createElement("img");
				img.className = "img-class-name";
				img.src = pages[i].src;
				
				var tbox = document.createElement("div");
				tbox.className = "text-box-page";
				
				var title = document.createElement("h1");
				title.className = "page-title"
				title.innerHTML = pages[i].title;
				
				var content = document.createElement("p");
				content.className = "page-content"
				content.innerHTML = pages[i].content + "<br/>"
				
				var date = document.createElement("p");
				date.className = "page-date";
				date.innerHTML = pages[i].start + "부터 ~ " + pages[i].end + "까지";
				
				$("body").append(container);
				container.appendChild(img);
				container.appendChild(tbox);
				tbox.appendChild(title);
				tbox.appendChild(content);
				tbox.appendChild(date);
				i++;
			} 
		}
	});
		
	
	</script>
	

	

</body>
</html>
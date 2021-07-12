<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://www.google.com/recaptcha/api.js"></script>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<style type="text/css">
.box {
    width: 500px;
    margin: 200px 0;
}

.shape1{
    position: relative;
    height: 150px;
    width: 150px;
    background-color: #18a605;
    border-radius: 80px;
    float: left;
    margin-right: -50px;
}
.shape2 {
    position: relative;
    height: 150px;
    width: 150px;
    background-color: #18a605;
    border-radius: 80px;
    margin-top: -30px;
    float: left;
}
.shape3 {
    position: relative;
    height: 150px;
    width: 150px;
    background-color: #18a605;
    border-radius: 80px;
    margin-top: -30px;
    float: left;
    margin-left: -31px;
}
.shape4 {
    position: relative;
    height: 150px;
    width: 150px;
    background-color: #18a605;
    border-radius: 80px;
    margin-top: -25px;
    float: left;
    margin-left: -32px;
}
.shape5 {
    position: relative;
    height: 150px;
    width: 150px;
    background-color: #18a605;
    border-radius: 80px;
    float: left;
    margin-right: -48px;
    margin-left: -32px;
    margin-top: -30px;
}
.shape6 {
    position: relative;
    height: 150px;
    width: 150px;
    background-color: #18a605;
    border-radius: 80px;
    float: left;
    margin-right: -20px;
    margin-top: -35px;
}
.shape7 {
    position: relative;
    height: 150px;
    width: 150px;
    background-color:#18a605;
    border-radius: 80px;
    float: left;
    margin-right: -20px;
    margin-top: -57px;
}
.float {
    position: absolute;
    z-index: 2;
}

.form {
    margin-left: 145px;
}
</style>
</head>
<body>
<div class="container">
        <div id="login-row" class="row justify-content-center align-items-center">
            <div id="login-column" class="col-md-6">
                <div class="box">
                    <div class="shape1"></div>
                    <div class="shape2"></div>
                    <div class="shape3"></div>
                    <div class="shape4"></div>
                    <div class="shape5"></div>
                    <div class="shape6"></div>
                    <div class="shape7"></div>
                    <div class="float">
                        <form class="form" method="post" id="login_form">
                            <div class="form-group">
                                <label for="username" class="text-white">User name:</label><br>
                                <input type="text" name="member_id" id="member_id" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="password" class="text-white">Password:</label><br>
                                <input type="text" name="member_pw" id="member_pw" class="form-control">
                            </div>
                            <div class="form-group">
                                <input id = "login_button" type="submit" name="submit" class="btn btn-info btn-md" value="submit">
                                <input id = "" type="submit" name="submit" class="btn btn-info btn-md" value="register" >
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="" class="g-recaptcha" data-sitekey=6LdFpmQbAAAAAJvXJ0dYqFRw0d4yCy0uTBotBxjn></div>
<script>

	/* 로그인 버튼 클릭 메서드 */
	$("#login_button").eq(0).click(function(){
		
		//alert("로그인 버튼 작동!!!!!!!!!!!!!!");
		
		/* 로그인 메서드 서버 요청 */
		$("#login_form").attr("action", "login.do");
		$("#login_form").submit();
		
	});
	
	
	// 캡차 api
	$(function() {
	$('#add_member_form').submit(function() {
			var captcha = 1;
			$.ajax({
	            url: '/pro/VerifyRecaptcha',
	            type: 'post',
	            data: {
	                recaptcha: $("#g-recaptcha-response").val()
	            },
	            success: function(data) {
	                switch (data) {
	                    case 0:
	                        console.log("자동 가입 방지 봇 통과");
	                        captcha = 0;
	                		break;
	                    case 1:
	                        alert("자동 가입 방지 봇을 확인 한뒤 진행 해 주세요.");
	                        break;
	                    default:
	                        alert("자동 가입 방지 봇을 실행 하던 중 오류가 발생 했습니다. [Error bot Code : " + Number(data) + "]");
	                   		break;
	                }
	            }
	        });
			if(captcha != 0) {
				return false;
			} 
	});
	});
</script>

<!-- 소셜로그인 -->
	<div>간편로그인</div>
	<div><a href=${naver_url }><img alt="네이버 로그인 로고" src="resources/images/naverlogo.png"></a></div>
	<div><a><img alt="카카오 로그인 로고" src="resources/images/kakaologo.png"></a></div>
</body>
</html>
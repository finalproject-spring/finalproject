<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
function execution_daum_address(){

    new daum.Postcode({
        oncomplete: function(data) {

            var addr = '';
            var extraAddr = ''; 

            if (data.userSelectedType === 'R') {
                addr = data.roadAddress;
            } else {
                addr = data.jibunAddress;
            }

            if(data.userSelectedType === 'R'){

                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }

                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }

                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }

               addr += extraAddr;
            
            } else {
                addr += ' ';
            }

            $(".address_input_1").val(data.zonecode);
            $(".address_input_2").val(addr);
            $(".address_input_3").attr("readonly",false);
            $(".address_input_3").focus();
            
        }
    }).open();   
    
}
$(document).ready(function(){
	$('.id_input').on("propertychange change keyup paste input", function(){
		   
		   var memberId = $('.id_input').val();   
		   var data = {memberId : memberId} 
		   
		   
		   
		   $.ajax({
		      type : "post",
		      url : "login_memberIdChk.do",
		      data : data,
		      success : function(res){
		         if(res != 'fail'){
		            $('.id_input_re_1').css("display","inline-block");
		            $('.id_input_re_2').css("display", "none");   
		            idckCheck = true;
		         } else {
		            $('.id_input_re_2').css("display","inline-block");
		            $('.id_input_re_1').css("display", "none");
		            idckCheck = false;
		         }   
		      }
		   });   
	
		});
});
</script>
<style type="text/css">

	#naver{ background-color:#2DB400; color:white; font-weight: 700px; padding:3px; }
	#kakao{ background-color:#F7E600; color:black; font-weight: 700px; padding:3px; }
	
	.address_wrap { width: 500px;}
</style>
</head>
<body>
<jsp:include page="../main/header.jsp"></jsp:include>
	<div class="container">
	<c:choose>
		<c:when test="${fn:contains(dto.member_socialid,'@naver@')}">
			<div><span id="naver">네이버</span> 처음 로그인 시 회원가입이 필요합니다.</div>
			<div>추가정보를 입력해 주세요.</div>
			<form action="login_naverJoin.do" method="post">
				<input type="hidden" value="${dto.member_socialid }" name="member_socialid"/>
				<input type="hidden" value="${dto.member_name }" name="member_name"/>
				<input type="hidden" value="${dto.member_email }" name="member_email"/>
				<input type="hidden" value="${dto.member_phone }" name="member_phone"/>
				<input type="hidden" value="${dto.member_pw }" name="member_pw"/>
				<div>아이디</div>
				<div>사이트 내에서 보여지는 아이디로 소셜 로그인 시 아이디 입력 없이 로그인 가능합니다.</div>
				<div>
					 <input class="id_input" type="text" name="member_id"/>
				</div>
				<span class="id_input_re_1" style="display: none;">사용가능한 아이디 입니다.</span> 
				<span class="id_input_re_2" style="display: none;">아이디가 이미 존재합니다.</span>
				<div class="address_wrap">
	               <div class="address_name">주소를 입력해주세요.</div>
	               <div class="address_input_1_wrap">
	                  <div class="address_input_1_box" style="float: left;">
	                     <input class="address_input_1" name="member_addr" readonly="readonly">
	                  </div>
	                  <div>
	                  	<input type="button" class="address_button" onclick="execution_daum_address();" value="주소찾기">
	                  </div>
	                  <div class="clearfix"></div>
	               </div>
	               <div class="address_input_2_wrap">
	                  <div class="address_input_2_box">
	                     <input class="address_input_2" name="member_addr" readonly="readonly">
	                  </div>
	               </div>
	               <div class="address_input_3_wrap">
	                  <div class="address_input_3_box">
	                     <input class="address_input_3" name="member_addr" readonly="readonly" required="required">
	                  </div>
	               </div>
	            </div>
	            <div align="center">
					<button type="submit" class="list_btn btn btn-primary">가입하기</button>	
				</div>
			</form>
		</c:when>
		<c:otherwise>
			<div><span id="kakao">카카오</span> 처음 로그인 시 회원가입이 필요합니다.</div>
			<div>추가정보를 입력해 주세요.</div>
		</c:otherwise>
	</c:choose>
	</div>

</body>
</html>
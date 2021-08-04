<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style type="text/css">

*{
   margin: 0;
   padding:0;
}
.wrapper{
   width: 100%;   
}
.wrap{
   width : 650px;
   margin: auto;
}
.subjecet span{
   margin-left: 31px;
    font-size: 56px;
    font-weight: 600;
    color: #71C55D;
    
}

/* 이름 영역 */
.user_wrap{
   width: 100%;
    margin-top: 20px;
}
.user_name{
   font-size: 25px;
    font-weight: ;
    margin-bottom : 20px;
}
.user_input_box{
   border-bottom: 1px solid black;
   height:31px;
   
   
}
.user_input{
   width:100%;
   height:100%;
   border:none;
   font-size:28px;
}

/* 아이디 영역 */
.id_wrap{
   width: 100%;
    margin-top: 20px;
}
.id_name{
   font-size: 25px;
    font-weight: ;
    margin-bottom : 20px;
    
}
.id_input_box{
   border-bottom: 1px solid black;
   height:31px;
     
   
}
.id_input{
   width:100%;
   height:100%;
   border:none;
   font-size:28px;
}

/* 비밀번호 영역 */
.pw_wrap{
   width: 100%;
    margin-top: 20px;
}
.pw_name{
   font-size: 25px;
    font-weight: ;
    margin-bottom : 20px;
}
.pw_input_box{
   border-bottom: 1px solid black;
   height:31px;
  
   
}
.pw_input{
   width:100%;
   height:100%;
   border:none;
   font-size:28px;
}
/* 메일 영역 */
.mail_wrap{
   width: 100%;
    margin-top: 20px;
}
.mail_name{
   font-size: 25px;
    font-weight: ;
    margin-bottom : 20px;
}
.mail_input_box{
   border-bottom: 1px solid black;
   height:31px;
  
   
}
.mail_input{
   width:100%;
   height:100%;
   border:none;
   font-size:28px;
}

/*전화번호 영역 */
.phone_wrap{
   width: 100%;
    margin-top: 20px;
}
.phone_name{
   font-size: 25px;
    font-weight: ;
    margin-bottom : 20px;
}
.phone_input_box{
   border-bottom: 1px solid black;
   height:31px;
     
   
}
.phone_input{
   width:100%;
   height:100%;
   border:none;
   font-size:28px;
}

/* 주소 영역 */
.address_wrap{
   width: 100%;
    margin-top: 20px;
}
.address_name{
   font-size: 25px;
    font-weight: ;
    margin-bottom : 20px;
}
.address_input_1_box{
      border-bottom: 1px solid black;
    height: 35px;
      
}
.address_input_1{
   width:100%;
   height:100%;
   border:none;
   font-size:28px;   
}

</style>
</head>
<body>
<jsp:include page="../main/header.jsp"></jsp:include>
<div id="wrapper">
    <div class="wrap">
     <div class="subjecet">
               <span>${dto.member_id }'s  mypage <i  style="-webkit-text-stroke: 3px  #0e3803;" class="fas fa-globe-asia"></i></span>
            </div> 
    
       <!-- 이름 -->
      <div class="user_wrap">
      <div class="user_name"><i style="color:#71C55D; " class="fas fa-check"></i> Name : </div>
         <div class="user_input_box">
                  <input  type="text" class="user_input" name="member_name" value="${dto.member_name }"  readonly="readonly">
               </div>
      </div>
      
      <!-- 아이디 -->
      <div class="id_wrap">
      <div class="id_name"><i style="color:#71C55D; " class="fas fa-check"></i> Id : </div>
         <div class="id_input_box">
                  <input id="member_id"  type="text" class="id_input" name="member_id" value="${dto.member_id }"  readonly="readonly">
               </div>
      </div>
      
      <!-- 비밀번호 -->
       <div class="pw_wrap">
               <div class="pw_name"><i style="color:#71C55D; " class="fas fa-check"></i>현재 비밀번호</div>
               <div class="pw_input_box">
                  <input class="pw_input" name="member_pw" type="text"  id="member_pw">
               </div>
               
               <div class="pw_name"><i style="color:#71C55D; " class="fas fa-check"></i>변경할 비밀번호</div>
               <div class="pw_input_box">
                  <input class="pw_input" name="member_pw" type="text"  id="changePW">
               </div>
               <div align="right" style="padding-top: 5px;"><input type="button" value="비밀번호 수정하기" onclick="update()" style="background-color: #1AAB8A; border: 1px solid #1AAB8A; color: white; width: 140px; height:30px; border-radius: 5px;"></div>
            </div>
         
         <!-- 이메일-->
          <div class="mail_wrap">
               <div class="mail_name"><i style="color:#71C55D; " class="fas fa-check"></i> Email</div>
               <div class="mail_input_box">
                  <input type="text" class="mail_input" name="member_email" value="${dto.member_email }" readonly="readonly">
               </div>
               
               <!-- 휴대폰 -->
                  <div class="phone_wrap">
               <div class="phone_name"> <i style="color:#71C55D; " class="fas fa-check"></i> Phone</div>
               <div class="phone_input_box">
                  <input type="text" class="phone_input" name="member_phone" value="${dto.member_phone }" readonly="readonly">
               </div>
            </div>
           
           
           <div class="address_wrap">
               <div class="address_name"><i style="color:#71C55D; " class="fas fa-check"></i> Addr</div>
               <div class="address_input_1_wrap">
                  <div class="address_input_1_box">
                     <input  type="text" class="address_input_1" name="member_addr"
                        value="${dto.member_addr }" readonly="readonly">
                  </div>
          
                  <div class="clearfix"></div>
               </div>
               </div>
      
   
   <br/><br/>
   <div id="delete">
      <input type="button" value="구매내역" onclick="location.href='paymentList.do'" style="background-color: #1AAB8A; border: 1px solid #1AAB8A; color: white; width: 80px; height:30px; border-radius: 5px;">
      <input type="button" value="돌아가기" onclick="location.href='main.do'" style="background-color: #1AAB8A; border: 1px solid #1AAB8A; color: white; width: 80px; height:30px; border-radius: 5px;">
      <p align="right"><input type="button" value="계정탈퇴" onclick="del()" style="width: 70px;"></p>
      <script type="text/javascript">
      let res = ${res};
      if(res == null){
         alert("로그인이 해제되어 메인페이지로 이동됩니다.")
         location.href="main.do"
      }
      
      function del(){
         if(confirm("계정을 탈퇴하시겠습니까?")){
            location.href="MyPageDelete.do?member_id=${dto.member_id }"
         }
      }
      function update(){
         let pass = $("#member_pw")
         let chpass = $("#changePW")
         if(pass == null || pass == "" || pass == " "){
            alert("현재 비밀번호를 입력해 주세요")
            return
         }
         if(chpass == null || chpass == "" || chpass == " "){
            alert("변경할 비밀번호를 입력해 주세요")
            return
         }
         let pw = {
               "member_id" : $("#member_id").val(),
               "member_pw" : pass.val(),
               "changePW" : chpass.val()
         }
         $.getJSON("updatePW.do", pw).done(function(data){
            pass.val("")
            chpass.val("")
            if(data.res == 1){
               alert("비밀번호 변경 성공")
            } else{
               alert("비밀번호 변경 실패")
            }
         })
      }
      </script>
   </div>
   </div>
   </div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

      <!-- 부가적인 테마 -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
       
       <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
.blinking{ -webkit-animation:blink 1s ease-in-out infinite alternate; -moz-animation:blink 1s ease-in-out infinite alternate; animation:blink 1s ease-in-out infinite alternate; } @-webkit-keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} } @-moz-keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} } @keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} }

button{
  background:#1AAB8A;
  color:#fff;
  border:none;
  position:relative;
  height:35px;
  font-size:1.6em;
  padding:0 2em;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
}
button:hover{
  background:#fff;
  color:#1AAB8A;
}
button:before,button:after{
  content:'';
  position:absolute;
  top:0;
  right:0;
  height:2px;
  width:0;
  background: #1AAB8A;
  transition:400ms ease all;
}
button:after{
  right:inherit;
  top:inherit;
  left:0;
  bottom:0;
}
button:hover:before,button:hover:after{
  width:100%;
  transition:800ms ease all;
}

input:focus {
   outline: none;
}


</style>
</head>
<body>

 <jsp:include page="../main/header.jsp"></jsp:include>
      <div class="container">
         <header>
         
            
         </header>
         
         <br/>
          
          
         <section id="container">
         <form name="readForm" role="form" method="post">
         <!-- <input type="hidden" id="bno" name="bno" value="${read.bno}" />
               <input type="hidden" id="page" name="page" value="${scri.page}"> 
               <input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
               <input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
               <input type="hidden" id="keyword" name="keyword" value="${scri.keyword}">  -->
               
            </form>
            
            <div class="form-group">
            
            <jsp:useBean id="today" class="java.util.Date" />
               <fmt:parseNumber value="${today.time / (1000*60*60*24)}" integerOnly="true" var="nowDate" scope="request" />
               <fmt:parseDate var="dateString" value="${dto.event_end}" pattern="yyyy-MM-dd" />
               <fmt:parseNumber value="${dateString.time / (1000*60*60*24)}" integerOnly="true" var="endDate" scope="request" />
                                    
                                 <c:choose>
                  <c:when test="${endDate-nowDate > 0 &&  endDate-nowDate <=6 }">
                     <div class="image blinking" style="font-weight: 660; font-size: 15px; color: #1AAB8A; ">D-${endDate-nowDate }</div></c:when>
                     
                     <c:when test="${endDate-nowDate < 0}">
                     <div style="font-weight: 660; font-size: 15px; color: #999; ">이미 종료된 이벤트 입니다.</div>
                     </c:when>
                     
                     <c:when test="${endDate-nowDate == 0}">
                     <div class="image blinking" style="font-weight: bold; color: #1AAB8A;" >D-DAY</div>
                     </c:when>
                     
                  <c:otherwise>
                     <div style="font-weight: 660; font-size: 15px; color: #999; ">D-${endDate-nowDate }</div>
                  </c:otherwise>
            </c:choose>
            
            </div>
            
            
            <div class="form-group">
               <label for="title" style="font-weight: bolder;"></label>
               <input style="width:600px; border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px; font-size: 26px; font-weight:550; color: #363636;" type="text" id="title" name="title"  value="${dto.event_title}" readonly="readonly" />
            </div>
            <div class="form-group" style="font-size: 16px; font-weight:600; color: #36363666;">
               <label for="regdate" ></label>
               <br/>
                <em style="font-style: normal;">admin</em><br/>   ${dto.event_start } ~  ${dto.event_end }   
            </div>
            
            <hr/>
            <div class="form-group">
            <label for="content" style="font-weight: bolder;" class="col-sm-2 control-label"></label>
               
               <div id="summer"  class="form-group">
               ${dto.event_content }
               </div>

            </div>
            
               
            
         
            
                  
            
            
         </section>
      
         <hr />
            <div style="padding-bottom: 30px;">
            <c:if test="${memberdto.member_role eq 0 }">
               <button type="button"  onclick="location.href='event_updateform.do?event_no=${dto.event_no}'">수정</button>
               <button type="button"  onclick="location.href='event_delete.do?event_no=${dto.event_no}'">삭제</button>
               </c:if>
               <button type="button"  onclick="location.href='event_list.do'">목록</button>   
            </div>
      </div>
   </body>
</html>
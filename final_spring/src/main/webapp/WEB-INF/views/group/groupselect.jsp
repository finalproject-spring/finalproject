<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
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

.replyList li {
    list-style: none;
 }
 #summer p{
  font-size: 23px;
 }
input:focus {
   outline: none;
}
</style>
</head>
<body>
   <div class="form-group">
               <jsp:include page="../main/header.jsp"></jsp:include>
            </div>


      <div class="container">
         <header>
                  <h1 style=" font-size: 19.8px; font-weight:600; color: #363636; ">Let's save earth together <i class="fas fa-leaf"></i></h1>
            </header>
         <hr/>
          
         <section id="container">
            
      
            
            <div class="form-group">
               <label for="title" style="font-weight: bolder;" class="col-sm-2 control-label"></label>
               <input  style=" float:left;  width:600px; border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px; font-size: 26px; font-weight:550; color: #363636;"    type="text"  name="board_title" value="${dto.board_title}" readonly="readonly" />
            </div>
            
            <div class="form-group" >
               <label for="title" style="font-weight: bolder;" class="col-sm-2 control-label"></label>
               <input type="text" style="width:600px; border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px; font-size: 16px; font-weight:550; color: #36363666;"  name="board_filter" value="${dto.board_filter }" readonly="readonly" />
            </div>
            
            <div class="form-group">
               <label for="title" style="font-weight: bolder;" class="col-sm-2 control-label"></label>
               <input type="text"  name="board_views"style=" float:left;width:600px; border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px; font-size: 16px; font-weight:550; color: #36363666;" value="조회수 : ${dto.board_views}" readonly="readonly" />
            </div>
            
            <div class="form-group">
               <label for="title" style="font-weight: bolder;" class="col-sm-2 control-label"></label>
               <input type="text"name="board_id "style=" float:left;width:600px; border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px; font-size: 16px; font-weight:550; color: #36363666;"  value="글쓴이 : ${dto.board_id}" readonly="readonly" />
            </div>
            <hr/>
            <div class="form-group">
               <label for="content" style="font-weight: bolder;" class="col-sm-2 control-label"></label>
               
               <div id="summer"  style=" padding:30px;  background-color: none; padding-bottom: 180px;">${dto.board_content }</div>
            </div>
            <br/>
            <hr/>
               <div>
            <button type="button"  onclick="location.href='group_list.do'">목록</button>   
            </div>
            <br/>
            <div id="update12" style="float: left;">
               <button type="button"  style="display: none;"onclick="location.href='group_updateform.do?board_no=${dto.board_no}'">수정</button>
                  <br/>
                  
               <button type="button"  style="display: none;"onclick="location.href='group_delete.do?board_no=${dto.board_no}'">삭제</button>
            </div>
            <br/>
         
         <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
   <script type="text/javascript">
         $(document).ready(function(){
      
      if("${dto.board_id}" != null) {
    	  if("${id}" === "${dto.board_id}"){
         
         $("#update12>button").css("display", "inline")
      	}	
      }

   })
</script>
         </section>
            <form name="replyForm" method="post" class="form-horizontal">
               <input type="hidden"  id="board_no" name="board_no" value="${dto.board_no }" />
               <input type="hidden" id="page" name="page" value="${scri.page}"> 
               <input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
               <input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
               <input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
                  <!--  댓글 -->
                  <br/>
            <div id="reply">
               <ol class="replyList">
                  <c:forEach items="${replylist}" var="groupReply">
                  <hr/>
                     <li style="border:1px solid #d4d9de; border-radius: 15px; padding: 10px 5px;">
                        <p style="font-weight: bold; font-size: 16px; color: #36363666;">
                        <i class="fas fa-user" style="color: #36363666;"></i>
                          ${groupReply.reply_id }<br />
                        <i class="fas fa-clock"></i>  <fmt:formatDate value="${groupReply.reply_date}" pattern="yyyy-MM-dd" />
                        </p>
                        <p   style="font-weight: bold; font-size: 16px;">${groupReply.reply_content }</p>
                     </li>
                  </c:forEach>   
               </ol>
            </div>
            <br/>
            <br/>
               
               <div class="form-group">
                  <label for="writer"></label>
                  
                  <div>
                  <i class="fas fa-user" style="font-size: 35px; padding: 10px 5px;" ></i>
                     <input type="text" id="reply_id" name="reply_id" style="  font-weight:589 ;  font-size:17px; background-color: #E9ECEF; border-radius: 15px; padding: 10px 5px;   border: 1px solid #d4d9de; width:750px;height:50px;" value="${memberdto.member_id}" readonly="readonly" />
                     
                  </div>
               </div>
               
               <div class="form-group">
                  <label for="content" class="col-sm-2 control-label"></label>
                  <div>
                  <i class="fas fa-pencil-alt" style="font-size:35px; padding: 10px 5px;"></i>
                     <input type="text" id="reply_content"name="reply_content" style=" border-radius: 15px; padding: 10px 5px;   border: 1px solid #d4d9de; width:750px;height:100px;"/>
                  </div>
               </div>
               
               <div class="form-group">
                  <div class="col-sm-offset-2 col-sm-10">
                     <button type="button" class="replyWriteBtn">댓글 작성</button>
                  </div>
               </div>
            </form>
         <hr/>
      </div>
   </body>
   <script type="text/javascript">
//댓글 작성 버튼
$(".replyWriteBtn").eq(0).on("click",function(){
   var formObj = $("form[name='replyForm']").eq(0);
   formObj.attr("action", "./group_replywrite.do");
   formObj.submit();
})


</script>
</html>
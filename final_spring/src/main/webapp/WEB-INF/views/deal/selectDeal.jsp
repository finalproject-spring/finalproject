<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	 	
	 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

.container h2 {margin: 50px 0px 10px 0px;}

#button1{
  border-radius:5px;
  background:#1AAB8A;
  color:#fff;
  border:none;
  position:relative;
  height:28px;
  font-size: 14px;
  padding:0 1em;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
  
}
#button1:hover{
  background:#fff;
  color:#1AAB8A;
}

#button2{
  border-radius:5px;
  background:#959A9D;
  color:#fff;
  border:none;
  position:relative;
  height:32px;
  font-size: 14px;
  padding:0 1em;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
  
}
#button2:hover{
  background:#fff;
  color:#959A9D;
}

#button3{
  border-radius:5px;
  background:#C7E5D4;
  color:#717171;
  border:none;
  position:relative;
  height:25px;
  font-size: 14px;
  padding:0 1em;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
  
}
#button3:hover{
  background:#fff;
  color:#717171;
}

#chatroom {margin-bottom: 10px;}

#price {margin-top: 20px;}
#price2 {width: 100%; border: 1px solid rgba(0, 0, 0, 0.1); height: 37px; vertical-align: middle; padding-top: 5px;}

textarea:focus {
	outline: none;
}
</style>
</head>
<body>
 <jsp:include page="../main/header.jsp"></jsp:include>
<div class="container">
	<h2>${dealDto.board_title }</h2>
	<hr/>
	
	<a id="update">
		<input type="button" id="button1" style="display: none;" value="글 수정" onclick="location.href='./updateDealForm.do?board_no=${dealDto.board_no}'">
		<input type="button" id="button1" style="display: none;" value="글 삭제" onclick="rem();">
	</a>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		if("${id}" === "${dealDto.board_id}"){
			$("#update>input").css("display", "inline")
			$("#createRoom>form").css("display", "inline")
			$("#deleteRoom>input").css("display", "inline")
		}
	})
	function rem(){
		if(confirm("글을 삭제하시겠습니까?")){
			location.href="./deleteDeal.do?board_no=${dealDto.board_no}"
		}
	}
	
	function kakaopay() {
		
		if("${memberdto}" != ""){
			$("#kakaopay").submit();
		} else {
			alert("로그인 후 펀딩할 수 있습니다.");
		}
		
	}
	</script>
	
	<div class="form-group">
		<label for="content" style="font-size: 19px;">가격 : </label>
		₩ ${dealDto.board_price }
	</div>
	<div class="form-group">
		<label for="content"></label>
		<textarea readonly="readonly" style=" border:none; resize: none; overflow: auto; height: 220px; width: 100%;  font-size: 14px"> ${dealDto.board_content }</textarea> 
	</div>
<hr/>
		<div id="payment">
		<input type="button" id="button1" value="돌아가기" onclick="location.href='./dealList.do'">
		<input type="button" id="button1" value="거래하기" onclick="kakaopay();">				
				<form id ="kakaopay" action="deal_kakaopay.do" method="post">
				<input type="hidden" id="pay_price" name="pay_price" value=" ${dealDto.board_price}"/>
				<input type="hidden" id="board_no" name="board_no" value="${dealDto.board_no}"/>
				</form>
			</div>
	
	<br>
	<br>
	<div>
		<c:choose>
			<c:when test="${empty roomChat }">
				<div>
					<div>-----방이 없습니다-----</div>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${roomChat }" var="dto">
					<fmt:formatDate var="formatCreateDate" value="${dto.create_date }" pattern="yyyy.MM.dd HH:MM"/>
					<div id="chatromm">
						<a>${dto.creator_name } : </a>
						<a href="./JoinRoom.do?room=${dto.room_name }">${dto.room_name }</a>
						<a>${formatCreateDate }</a>
						<a id="deleteRoom"><input type="button" id="button3" style="display: none;" onclick="location.href='./deleteRoom.do?room=${dto.room_name }&board_no=${dealDto.board_no }'" value="방 삭제"></a>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<div>
			<div align="right" id="createRoom">
				<form action="./createRoom.do" method="post" style="display: none;">
					<input type="hidden" name="board_no" value="${dealDto.board_no }">
					<input type="text" placeholder="방 이름을 입력해 주세요." name="room">&nbsp;<input id="button2" type="submit" value="방 생성">
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>
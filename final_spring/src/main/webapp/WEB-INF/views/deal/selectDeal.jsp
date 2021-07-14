<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>거랫글 상세보기</h1>
<div>
	<label for="title">제목 :</label>
	<a>${dealDto.board_title }</a>
	<br>
	<a id="update">
		<input type="button" style="display: none;" value="글 수정" onclick="location.href='./updateDealForm.do?board_no=${dealDto.board_no}'">
		<input type="button" style="display: none;" value="글 삭제" onclick="rem();">
		<input type="button" value="돌아가기" onclick="location.href='./dealList.do'">
	</a>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		if("${id}" === "${dealDto.board_id}"){
			$("#update>input").css("display", "inline")
		}
	})
	function rem(){
		if(confirm("글을 삭제하시겠습니까?")){
			location.href="./deleteDeal.do?board_no=${dealDto.board_no}"
		}
	}
	</script>
</div>
<div class="form-group">
	<label for="content">내용</label>
	<textarea readonly="readonly" style="resize: none; overflow: auto; height: 220px; width: 100%; border: 1px solid rgba(0, 0, 0, 0.1); font-size: 14px">${dealDto.board_content }</textarea> 
</div>
<div>
	<label for="content">가격 : </label>
	<a>${dealDto.board_price }</a>
</div>
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
				<fmt:formatDate var="formatCreateDate" value="${dto.create_date }" pattern="yyyy.MM.dd HH:MM:SS"/>
				<div>
					<a>${dto.room_no }</a>
					<a>${dto.creator_name }</a>
					<a href="./JoinRoom.do?room=${dto.room_name }">${dto.room_name }</a>
					<a>${formatCreateDate }</a>
					<a><input type="button" onclick="location.href='./deleteRoom.do?room=${dto.room_name }&board_no=${dealDto.board_no }'" value="방 삭제"></a>
				</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<div>
		<div align="right">
			<form action="./createRoom.do" method="post">
				<input type="hidden" name="board_no" value="${dealDto.board_no }">
				<input type="text" placeholder="방 이름을 입력해 주세요." name="room"><input type="submit" value="방 생성">
			</form>
		</div>
	</div>
</div>
</body>
</html>
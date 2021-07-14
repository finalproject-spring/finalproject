<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
</style>
</head>
<body>

<h1>채팅 방 목록</h1>

<div>
	<c:choose>
		<c:when test="${empty roomList }">
			<div>
				<div>-----방이 없습니다-----</div>
			</div>
		</c:when>
		<c:otherwise>
			<c:forEach items="${roomList }" var="dto">
				<fmt:formatDate var="formatCreateDate" value="${dto.create_date }" pattern="yyyy.MM.dd HH:MM:SS"/>
				<div>
					<div>${dto.room_no }</div>
					<div>${dto.creator_name }</div>
					<div><a href="./JoinRoom.do?room=${dto.room_name }">${dto.room_name }</a></div>
					<div>${formatCreateDate }</div>
					<div><input type="button" onclick="location.href='./deleteRoom.do?room=${dto.room_name }'" value="방 삭제"></div>
				</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<div>
		<div align="right">
			<form action="./createRoom.do" method="post">
				<input type="text" placeholder="방 이름을 입력해 주세요." name="room"><input type="submit" value="방 생성">
			</form>
		</div>
	</div>
</div>

</body>
</html>
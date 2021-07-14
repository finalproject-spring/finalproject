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

<h1>채팅 방 목록</h1>

<div>
	<c:choose>
		<c:when test="${empty dealList }">
			<div>
				<div>-----방이 없습니다-----</div>
			</div>
		</c:when>
		<c:otherwise>
			<c:forEach items="${dealList }" var="dto">
				<fmt:formatDate var="formatCreateDate" value="${dto.board_date }" pattern="yyyy.MM.dd HH:MM:SS"/>
				<div>
					<div>${dto.board_no }</div>
					<div>${dto.board_id }</div>
					<div><a href="./selectDeal.do?board_no=${dto.board_no }">${dto.board_title }</a></div>
					<div>${formatCreateDate }</div>
				</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<div>
		<div align="right">
			<input type="button" value="글 작성하기" onclick="location.href='./insertDealForm.do'">
		</div>
	</div>
</div>

</body>
</html>
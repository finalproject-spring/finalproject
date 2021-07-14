<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <jsp:include page="../main/header.jsp"></jsp:include>		
		<div class="container">
		<header>
			<h2>작성글 확인</h2>
		</header>
		<div>
			<form action="admin_memberWriteDelete.do" method="post">
				<input type="hidden" value="${dto.board_no }" name="board_no"/>
				<div class="form-group">
					<label>게시판</label>
					<input type="text" value="${dto.board_category }" class="form-control" readonly="readonly">
				</div>
				<div class="form-group">
					<label>작성자</label>
					<input type="text" value="${dto.member_no }" name="member_no" class="form-control" readonly="readonly">
				</div>				
				<div class="form-group">
					<label>작성일</label>
					<fmt:formatDate value="${dto.board_date}" pattern="yyyy-MM-dd hh:mm" var="date"/>
					<input type="text" value="${date }"  class="form-control" readonly="readonly">
				</div>
				<div class="form-group">
					<label for="name">제목</label>
					<input type="text" value="${dto.board_title }" class="form-control" readonly="readonly">
				</div>
				<div class="form-group">
					<label for="email">내용</label>
					<textarea class="form-control-lg" style="resize: none; overflow: auto; height: 220px; width: 100%; border: 1px solid rgba(0, 0, 0, 0.1); font-size: 14px" readonly="readonly">${dto.board_content }</textarea> 
				</div>

				<div class="form-group" align="right">
					<input type="submit" value="삭제하기"/>
					<input type="button" value="뒤로가기" onclick="location.href='admin_memberList.do'"/>
				</div>
			</form>
		</div>
	</div>
		
</body>
</html>
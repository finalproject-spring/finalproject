<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="resources/css/deal-style.css">
<style type="text/css">
#writeBtn{
  background:#1AAB8A;
  color:#fff;
  border:none;
  position:relative;
  height:35px;
  border-radius:10px;
  padding:0 2em;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
}
#writeBtn:hover{
  background:#fff;
  color:#1AAB8A;
}


</style>
</head>
<body>
 <jsp:include page="../main/header.jsp"></jsp:include>

<div class="container">
	
	<h1>SAVE EARTH 마켓</h1>
	<div>사용하지 않는 물품들을 SAVE EARTH SAVE US 회원들과 거래해 보세요!</div>
	<br/><br/>
	<div>
	<table class="table table-hover">
		<col width="100px"/>
		<col width="130px"/>
		<col width="470px"/>
		<col width="130px"/>
		<thead>
			<tr>
				<th style=" font-size: 14px; font-weight: 680; font-size: 15px; color: #363636; ">번호</th>
				<th style=" font-size: 14px; font-weight: 680; font-size: 15px; color: #363636; ">글쓴이</th>
				<th style=" font-size: 14px; font-weight: 680; font-size: 15px; color: #363636; ">제목</th>
				<th style=" font-size: 14px; font-weight: 680; font-size: 15px; color: #363636; ">작성일</th>
			</tr>
		</thead>						
		<c:choose>
			<c:when test="${empty dealList }">
				<div>
					<div>아직 작성된 거래글이 없어요!</div>
				</div>
			</c:when>
			<c:otherwise>
			<c:forEach items="${dealList }" var="dto">
				<fmt:formatDate var="formatCreateDate" value="${dto.board_date }" pattern="yyyy.MM.dd"/>
				<tr>
					<td style="font-weight: 600; font-size: 15px; color: #36363666;">${dto.board_no }</td>
					<td style="font-weight: 600; font-size: 15px; color: #36363666;">${dto.board_id }</td>
					<td style="font-weight: 600; font-size: 15px; color: #36363666;">
						<a style=" font-size: 17px; font-weight: 680; font-size: 13px; color: #363636; " href="selectDeal.do?board_no=${dto.board_no }">${dto.board_title }</a>
					</td>
					<td style="font-weight: 600; font-size: 15px; color: #36363666;">${formatCreateDate }</td>
				</tr>
			</c:forEach>
			</c:otherwise>
		</c:choose>						
	</table>
	</div>
	<div>
		<div align="right">
			<c:choose>
				<c:when test="${empty memberdto }">
					<input type="button" id="writeBtn" value="글 작성하기" onclick="loginChk();"/>
				</c:when>
				<c:otherwise>
					<input type="button" id="writeBtn" value="글 작성하기" onclick="location.href='./insertDealForm.do'"/>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

<script type="module" src="resources/js/app.js"></script>

</body>
</html>
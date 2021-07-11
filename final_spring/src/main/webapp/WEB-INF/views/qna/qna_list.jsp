<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
<script type="text/javascript">

	function loginChk(){
		alert("로그인이 필요합니다.");
		location.href='login_loginform.do';
	}
	
</script>
<style type="text/css">
	li {list-style: none; float: left; padding: 6px;}
</style>
</head>
<body>
<jsp:include page="../main/header.jsp"></jsp:include>
<div class="container">

		<header>
			<h1>QnA</h1>
		</header>
		<form role="form" method="get">
			<table class="table" style="table-layout:fixed">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
				</tr>
				<c:forEach items="${list }" var="dto">	
				<tr>
					<td>${dto.board_no }</td>
					<td>
					<c:if test="${dto.board_secret eq 'Y'}">
						<i class="fas fa-lock" style="color:gray;"></i>
					</c:if>
						<a href="qna_detail.do?board_no=${dto.board_no}&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}">${dto.board_title }
						<c:if test="${dto.replycount ne 0 }"><span> [${dto.replycount }]</span></c:if>
						</a>
					</td>
					<td>${dto.board_id }</td>
					<td><fmt:formatDate value="${dto.board_date}" pattern="yy-MM-dd hh:mm" var="date"/>${date }</td>
				</tr>
				</c:forEach>
			</table>
			<div class="search" style="float: left">
		    <select name="searchType">
		      <option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
		      <option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
		      <option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
		    </select>
		    
			<input type="text" name="keyword" id="keywordInput" value="${scri.keyword}"/>
			<button id="searchBtn" type="button">검색</button>
<script>
      $(function(){
        $('#searchBtn').click(function() {
          self.location = "qna_list.do" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
        });
      });   
</script>
  </div>
  			<div align="right">
				<c:choose>
					<c:when test="${empty memberdto }">
						<input type="button" value="문의 작성" class="list_btn btn btn-primary" onclick="loginChk();"/>
					</c:when>
					<c:otherwise>
						<input type="button" value="문의 작성" class="list_btn btn btn-primary" onclick="location.href='qna_insertform.do'"/>
					</c:otherwise>
				</c:choose>
			</div>
			<div>
			  <ul>
			    <c:if test="${pageMaker.prev}">
			    	<li><a href="qna_list.do${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
			    </c:if> 
			
			    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			    	<li><a href="qna_list.do${pageMaker.makeSearch(idx)}">${idx}</a></li>
			    </c:forEach>
			
			    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			    	<li><a href="qna_list.do${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
			    </c:if> 
			  </ul>
			</div>
		

		</form>	

	
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	 	
	 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<div class="container">
			<header>
				<h1> 게시판</h1>
			</header>
			<hr />
			 
			<section id="container">
			<form name="readForm" role="form" method="post">
			<!-- <input type="hidden" id="bno" name="bno" value="${read.bno}" />
					<input type="hidden" id="page" name="page" value="${scri.page}"> 
					<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
					<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
					<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}">  -->
					
				</form>
		
				
				<div class="form-group">
					<label for="title" class="col-sm-2 control-label">제목</label>
					<input type="text" id="title" name="title" class="form-control" value="${dto.event_title}" readonly="readonly" />
				</div>
				<div class="form-group">
					<label for="content" class="col-sm-2 control-label">내용</label>
					<textarea id="content" name="content" class="form-control" readonly="readonly"><c:out value="${dto.event_content}" /></textarea>
				</div>
				
					<div class="form-group">
					<label for="regdate" class="col-sm-2 control-label">시작날짜</label>
					${dto.event_start }
				</div>
				
				<div class="form-group">
					<label for="regdate" class="col-sm-2 control-label">종료날짜</label>
					${dto.event_end }	
				</div>
						
				<div>
					<button type="button" class="update_btn btn btn-warning" onclick="location.href='event_updateform.do?event_no=${dto.event_no}'">수정</button>
					<button type="button" class="delete_btn btn btn-danger" onclick="location.href='event_delete.do?event_no=${dto.event_no}'">삭제</button>
					<button type="button" class="list_btn btn btn-primary">목록</button>	
				</div>
				
			</section>
			<hr />
		</div>
	</body>
</html>
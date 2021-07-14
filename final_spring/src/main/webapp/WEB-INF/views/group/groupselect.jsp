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
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="form-group">
					<jsp:include page="../main/header.jsp"></jsp:include>
				</div>


		<div class="container">
			<header>
						<h1>소모임 게시판</h1>
				</header>
			<hr/>
			 
			<section id="container">
				
		
				
				<div class="form-group">
					<label for="title" class="col-sm-2 control-label">제목</label>
					<input type="text"  name="board_filter" class="form-control" value="${dto.board_title}" readonly="readonly" />
				</div>
				
				<div class="form-group">
					<label for="title" class="col-sm-2 control-label">카테고리</label>
					<input type="text"  name="board_filter" class="form-control" value="${dto.board_filter}" readonly="readonly" />
				</div>
				
				<div class="form-group">
					<label for="title" class="col-sm-2 control-label">조회수</label>
					<input type="text"  name="board_views" class="form-control" value="${dto.board_views}" readonly="readonly" />
				</div>
				
				<div class="form-group">
					<label for="title" class="col-sm-2 control-label">작성자</label>
					<input type="text"name="board_id " class="form-control" value="${dto.board_id}" readonly="readonly" />
				</div>
				
				<div class="form-group">
					<label for="content" class="col-sm-2 control-label">내용</label>
					<textarea id="content" name="board_content" class="form-control" readonly="readonly"><c:out value="${dto.board_content}" /></textarea>
				</div>
					
			
				<div>
					<button type="button" class="update_btn btn btn-warning" onclick="location.href='group_updateform.do?board_no=${dto.board_no}'">수정</button>
					<button type="button" class="delete_btn btn btn-danger" onclick="location.href='group_delete.do?board_no=${dto.board_no}'">삭제</button>
					<button type="button" class="list_btn btn btn-primary" onclick="location.href='group_list.do'">목록</button>	
				</div>
			
			</section>
				<form name="replyForm" method="post" class="form-horizontal">
					<input type="hidden"  id="board_no" name="board_no" value="${dto.board_no }" />
					<input type="hidden" id="page" name="page" value="${scri.page}"> 
					<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
					<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
					<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
						<!--  댓글 -->
				<div id="reply">
					<ol class="replyList">
						<c:forEach items="${replylist}" var="groupReply">
							<li>
								<p>
								작성자 :${groupReply.reply_id }<br />
								작성 날짜 :  <fmt:formatDate value="${groupReply.reply_date}" pattern="yyyy-MM-dd" />
								</p>
								  
								<p>${groupReply.reply_content }</p>
							</li>
						</c:forEach>   
					</ol>
				</div>
					
					<div class="form-group">
						<label for="writer" class="col-sm-2 control-label">댓글 작성자</label>
						<div class="col-sm-10">
							<input type="text" id="reply_id" name="reply_id" class="form-control" />
						</div>
					</div>
					
					<div class="form-group">
						<label for="content" class="col-sm-2 control-label">댓글 내용</label>
						<div class="col-sm-10">
							<input type="text" id="reply_content"name="reply_content" class="form-control"/>
						</div>
					</div>
					
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="button" class="replyWriteBtn btn btn-success">작성</button>
						</div>
					</div>
				</form>
			<hr/>
		</div>
	</body>
	<script type="text/javascript">
//댓글 작성 버튼
$(".replyWriteBtn").eq(0).on("click",function(){
	alert("버튼");
	var formObj = $("form[name='replyForm']").eq(0);
	formObj.attr("action", "./group_replywrite.do");
	formObj.submit();
})
</script>
</html>
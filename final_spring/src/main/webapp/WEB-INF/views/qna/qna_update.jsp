<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.submitBtn{background-color: #71c55d; border: 1px solid #71c55d; color: white; width: 80px; height: 40px; border-radius: 13px; font-size: 15px; }
</style>
</head>
<body>
<jsp:include page="../main/header.jsp"></jsp:include>
	<div class="container">
		<header>
			<h1>QnA</h1>
			<h5>글 수정하기</h5>
		</header>
		<hr />
		<section id="container">
			<form action="qna_updateres.do" method="post">
				<input type="hidden" id="page" name="page" value="${scri.page}"> 
				<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
				<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
				<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
				<input type="hidden" name="board_no" value="${dto.board_no }"/>
				<input type="hidden" name="member_no" value="${dto.member_no }"/>
				<div class="form-group">
					<label for="title" class="col-sm-2 control-label">제목</label>
					<input type="text" id="title" name="board_title" value="${dto.board_title }" class="form-control"/>
				</div>
				<div class="form-group">
					<label for="writer" class="col-sm-2 control-label">작성자</label>
					<input type="text" id="id" name="board_id" value="${dto.board_id }" class="form-control" readonly="readonly"/>
				</div>
				<div class="form-group">
					<label for="content" class="col-sm-2 control-label">내용</label>
					<textarea class="form-control-lg" name="board_content" style="resize: none; overflow: auto; height: 220px; width: 100%; border: 1px solid rgba(0, 0, 0, 0.1); font-size: 14px">${dto.board_content }</textarea> 
				</div>
			
				<div align="right">
					<button type="submit" class="submitBtn">작성</button>	
				</div>
			</form>
			</section>
		</div>
</body>
</html>
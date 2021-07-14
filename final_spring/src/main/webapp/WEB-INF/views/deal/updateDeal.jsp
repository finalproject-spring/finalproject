<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<body>
<h1>거랫글 수정</h1>

<form action="./updateDeal.do" method="post">
	<input type="hidden" value="${dto.board_no }" name="board_no">
	<div>
		<label for="title" class="col-sm-2 control-label">제목</label>
		<input type="text" name="board_title" required="required" value="${dto.board_title }">
	</div>
	<div class="form-group">
		<label for="content" class="col-sm-2 control-label">내용</label>
		<textarea required="required" name="board_content" style="resize: none; overflow: auto; height: 220px; width: 100%; border: 1px solid rgba(0, 0, 0, 0.1); font-size: 14px">${dto.board_content }</textarea> 
	</div>
	<div>
		<label for="content" class="col-sm-2 control-label">가격</label>
		<input type="text" value="${dto.board_price }" name="board_price" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required="required">
	</div>
	<div align="right">
		<button type="submit">수정</button>	
	</div>
</form>
</body>
</html>
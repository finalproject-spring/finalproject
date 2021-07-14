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
<h1>거랫글 작성</h1>

<form action="./insertDeal.do" method="post">
	<div>
		<label for="title" class="col-sm-2 control-label">제목</label>
		<input type="text" name="board_title" required="required">
	</div>
	<div class="form-group">
		<label for="content" class="col-sm-2 control-label">내용</label>
		<textarea required="required" name="board_content" style="resize: none; overflow: auto; height: 220px; width: 100%; border: 1px solid rgba(0, 0, 0, 0.1); font-size: 14px"></textarea> 
	</div>
	<div>
		<label for="content" class="col-sm-2 control-label">가격</label>
		<input type="text" name="board_price" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required="required">
	</div>
	<div align="right">
		<button type="submit">작성</button>	
	</div>
</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>

<html>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	 	
	 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>


<!-- include summernote css/js -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>
<meta charset="UTF-8">
<script>
$(function() {
	  $('#summernote').summernote({
	    height: 300,
	    lang: 'ko-KR' // 언어 세팅
	  });
	});
</script>
</head>
<body>

	<div class="container">
			<header>
				<h1> 게시판</h1>
			</header>
			<hr />
			 
			<section id="container">
		
				<form action="group_updateres.do" method="post">
				<input type="hidden" name="board_no" value="${dto.board_no }"/>
				<div class="form-group">
					<label for="title" class="col-sm-2 control-label">제목</label>
					<input type="text"  name="board_title" class="form-control" value="${dto.board_title }"/>
				</div>
				
				<div class="form-group">
					<label for="writer" class="col-sm-2 control-label">작성자</label>
					<input type="text" name="dto.board_id" class="form-control" value="${dto.board_id}"/>
				</div>
				
				<div class="form-group">
					<label for="writer" class="col-sm-2 control-label">내용</label>
					<textarea id="summernote" name="board_content">${dto.board_content }</textarea>
				</div>
				
			
								
				<div>
					
					<button type="submit" class="list_btn btn btn-primary">수정</button>	
				</div>
				</form>
				
			</section>
			<hr/>
		</div>
		

</body>
</html>
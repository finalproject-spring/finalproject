<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<!-- include summernote css/js -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>
<title>Insert title here</title>
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
<form action="group_insertres.do" method="post">
	<table border="1">
		<tr>
			<th>작성자</th>
			<td><input type="text"name="board_id"></td>
		</tr>
		
		<tr>
			<th>제목</th>
			<td><input type="text"name="board_title"></td>
		</tr>
		
		<tr>
			<th>내용</th>
			<td><textarea id="summernote" name="board_content"></textarea> </td>
			
			
		</tr>
		
		<tr>
			<td colspan="2">
				<input type="submit" value="글작성"/>
				<input type="button" value="목록" onclick="location.href='group_list.do'"/>
			</td>
		</tr>
		
	</table>


</form>
</body>
</html>
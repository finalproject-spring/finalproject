<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
	    $("#input_check").change(function(){
	        if($("#input_check").is(":checked")){
	        	$('#input_check_hidden').prop("disabled", true);
	        }
	    });
	});

</script>
<style type="text/css">

.submitBtn {background-color: #71c55d; border: 1px solid #71c55d; color: white; width: 68px; height: 40px; border-radius: 13px; font-size: 15px; }

</style>
</head>
<body>
<jsp:include page="../main/header.jsp"></jsp:include>
	<div class="container">
		<header>
			<h1>QnA</h1>
			<h5>글 작성하기</h5>
		</header>
		<hr />
		<section id="container">
			<form action="qna_insertres.do" method="post">
				<input type="hidden" name="member_no" value="${dto.member_no }"/>
				<input type="hidden" name="board_category" value="문의" />
				<div class="form-group">
					<label for="title" class="col-sm-2 control-label">제목</label>
					<input type="text" id="title" name="board_title" class="form-control"/>
				</div>
				<div class="form-group">
					<label for="writer" class="col-sm-2 control-label">작성자</label>
					<input type="text" id="id" name="board_id" value="${dto.member_id }" class="form-control" readonly="readonly"/>
				</div>
				<div class="form-group">
					<label for="content" class="col-sm-2 control-label">내용</label>
					<textarea class="form-control-lg" name="board_content" style="resize: none; overflow: auto; height: 220px; width: 100%; border: 1px solid rgba(0, 0, 0, 0.1); font-size: 14px"></textarea> 
				</div>
				<div>
					<input type="checkbox" id="input_check" name="board_secret" value="Y"/>
					<input type="hidden" id="input_check_hidden" name="board_secret" value="N"/>
					<label class="col-sm-2 control-label">비밀글</label>
				</div>
				<div align="right">
					<button type="submit" class="submitBtn">작성</button>	
				</div>
			</form>
			</section>
		</div>
</body>
</html>
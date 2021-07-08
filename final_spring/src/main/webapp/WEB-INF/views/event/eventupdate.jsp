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
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

</script>
</head>
<body>

	<div class="container">
			<header>
				<h1> 게시판</h1>
			</header>
			<hr />
			 
			<section id="container">
		
				<form action="event_updateres.do" method="post">
				<input type="hidden" name="event_no" value="${dto.event_no }"/>
				<div class="form-group">
					<label for="title" class="col-sm-2 control-label">제목</label>
					<input type="text" id="title" name="event_title" class="form-control" value="${dto.event_title }"/>
				</div>
				<div class="form-group">
					<label for="content" class="col-sm-2 control-label">내용</label>
					<textarea id="content"  rows="10" name="event_content" class="form-control">${dto.event_content }</textarea>
				</div>
				<div class="form-group">
					<label for="writer" class="col-sm-2 control-label">작성자</label>
					<input type="text" id="writer" name="writer" class="form-control" value="admin" readonly="readonly"/>
				</div>
				<div class="form-group">
					<label for="regdate" class="col-sm-2 control-label">시작날짜</label>
					<input type="date" name="event_start" class="form-control" value="${dto.event_start }"/>
				</div>
				
				<div class="form-group">
					<label for="regdate" class="col-sm-2 control-label">종료날짜</label>
					<input type="date" name="event_end" class="form-control" value="${dto.event_end }"/>
						
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
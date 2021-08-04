<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>

<html>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" crossorigin="anonymous">

<!-- include summernote css/js -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>
<meta charset="UTF-8">
<script>
$(document).ready(function() {
    var setting = {
           height : 700,
           minHeight : 600,
           maxHeight : 600,
           focus : false,
           lang : 'ko-KR',
           //콜백 함수
           callbacks : { 
           	onImageUpload : function(files, editor, welEditable) {
           // 파일 업로드(다중업로드를 위해 반복문 사용)
           for (var i = files.length - 1; i >= 0; i--) {
           uploadSummernoteImg(files[i], this);
           		}
           	}
           }
        };
   
    $('#summernote').summernote(setting);
});
</script>
<style type="text/css">
button{
  background:#1AAB8A;
  color:#fff;
  border:none;
  position:relative;
  height:35px;
  font-size:1.6em;
  padding:0 2em;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
}
button:hover{
  background:#fff;
  color:#1AAB8A;
}
button:before,button:after{
  content:'';
  position:absolute;
  top:0;
  right:0;
  height:2px;
  width:0;
  background: #1AAB8A;
  transition:400ms ease all;
}
button:after{
  right:inherit;
  top:inherit;
  left:0;
  bottom:0;
}
button:hover:before,button:hover:after{
  width:100%;
  transition:800ms ease all;
}


</style>

</head>
<body>

	<div class="container">
			<header>
				<h1 style=" font-size: 19.8px; font-weight:600; color: #363636; ">Let's save earth together</h1>
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
					<label for="title" class="col-sm-2 control-label">카테고리</label>
					<input type="text"  name="board_filter" class="form-control" value="${dto.board_filter}" readonly="readonly"/>
				</div>
			
				
				<div class="form-group">
					<label for="writer" class="col-sm-2 control-label">작성자</label>
					<input type="text" name="dto.board_id" class="form-control" value="${dto.board_id}" readonly="readonly"/>
				</div>
				
				<div class="form-group">
					<label for="writer" class="col-sm-2 control-label">내용</label>
					<textarea id="summernote" name="board_content">${dto.board_content }</textarea>
				</div>
				
								
				<div>
					
					<button type="submit">수정</button>	
				</div>
				</form>
				
			</section>
			<hr/>
		</div>
		

</body>
</html>
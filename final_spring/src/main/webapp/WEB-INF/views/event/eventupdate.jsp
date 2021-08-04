<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>

<html>
		
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	 	
	 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
 <jsp:include page="../main/header.jsp"></jsp:include>
	<div class="container">
			<header>
				<h1 style=" font-size: 19.8px; font-weight:600; color: #363636;">Event page</h1> 
			
			
			</header>
			 <hr/>
			<section id="container">
		
				<form action="event_updateres.do" method="post">
				<input type="hidden" name="event_no" value="${dto.event_no }"/>
				<div class="form-group">
					<label for="title" class="col-sm-2 control-label">제목</label>
					<input type="text" id="title" name="event_title" class="form-control" value="${dto.event_title }"/>
				</div>
				<div class="form-group">
					<label for="content" class="col-sm-2 control-label">내용</label>
					<textarea id="summernote" rows="10" name="event_content" class="form-control">${dto.event_content }</textarea>
				</div>
				`
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
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
					
					<button type="submit" >수정</button>	
					<button type="button"  onclick="location.href='event_list.do'" >목록</button>	
				</div>
				</form>
				
			</section>
			<hr/>
		</div>
			<script type="text/javascript">
	
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
       
	function uploadSummernoteImg(file, el) {
		data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "event_uploadSummernoteImg.do",
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			success : function(data) {
				$(el).summernote('editor.insertImage', data.url);

			}
		});
	}

	</script>

</body>
</html>
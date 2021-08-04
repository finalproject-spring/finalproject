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

<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>


<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<title>Insert title here</title>
<!-- multi select -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.css" integrity="sha512-6g9IGCc67eh+xK03Z8ILcnKLbJnKBW+qpEdoUVD/4hBa2Ghiq5dQgeNOGWJfGoe9tdCRM4GpJMnsRXa2FDJp9Q==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/css/bootstrap-select.min.css" integrity="sha512-ARJR74swou2y0Q2V9k0GbzQ/5vJ2RBSoCWokg4zkfM29Fb3vZEQyv0iWBMW/yvKgyHSR/7D64pFMmU8nYmbRkg==" crossorigin="anonymous" referrerpolicy="no-referrer" />


<!-- include libraries(jQuery, bootstrap) -->



<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<style type="text/css">
.bootstrap-select .bs-ok-default::after {
    border-width: 0 0.1em 0.1em 0;
    transform: rotate(45deg) translateY(0.5rem);
}

.bootstrap-select>.dropdown-toggle {
	width: 500px !important;
}

.bootstrap-select .dropdown-menu li { width: 500px; }

.btn.dropdown-toggle:focus {
    outline: none !important;
}
#button1{
  border-radius:5px;
  background:#1AAB8A;
  color:#fff;
  border:none;
  position:relative;
  height:35px;
  font-size:1.3em;
  padding:0 1em;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
  
}
#button1:hover{
  background:#fff;
  color:#1AAB8A;
}
select:focus {
	outline: none;
}

</style>
</head>
<body>
<jsp:include page="../main/header.jsp"></jsp:include>
	<div class="container">
			
			<hr/>
			 
			<section id="container">
		
				<form action="group_insertres.do" method="post">
				<div class="row">
				<div style="padding: 20px 0px 20px 0px;">
			<select id="multi_select" class="selectpicker w-100" title="카테고리를 선택하세요." multiple="multiple" data-style="bg-white rounded-pill px-4 py-3 shadow-sm" onchange="addFilter();" required="required">
				 <option value="전체보기">전체보기</option>
				<option value="온라인 토론">온라인 토론</option>
				<option value="오프라인 토론">오프라인 토론</option>
				<option value="쓰레기 줍기">쓰레기 줍기</option>
				<option value="어린이 환경모임">어린이 환경모임</option>
				<option value="환경 독서">환경 독서</option>
			</select>
			<input type="hidden" id="selected" name="board_filter"/>
		</div>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.bundle.js" integrity="sha512-iqhWkvLOXVDz+Lr//ZryEKNvZ5pmgdKEe58Wh/VwfTGwTku0MKbuLhjJ1zUAJu8iSbOqfLcXrrxJ61+27THi2Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/js/bootstrap-select.min.js" integrity="sha512-yDlE7vpGDP7o2eftkCiPZ+yuUyEcaBwoJoIhdXv71KZWugFqEphIS3PU60lEkFaz8RxaVsMpSvQxMBaKVwA5xg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
				</div>
				
				
				<div class="form-group">
					<label for="title" class="col-sm-2 control-label">작성자</label>
					<input type="text" id="title" name="board_id" class="form-control" value="${dto.member_id }" readonly="readonly"/>
				</div>
				<div class="form-group">
					<label for="content" class="col-sm-2 control-label">제목</label>
					<input type="text" id="title" name="board_title" class="form-control"/>
				</div>
				
				<div class="form-group">
					<label for="regdate" class="col-sm-2 control-label">내용</label>
					<textarea id="summernote" name="board_content" class="form-control"></textarea>
						
				</div>
					<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>			
				<div>
					<button type="submit" id="button1">작성</button>	
					
					<button type="button" id="button1" onclick="location.href='group_list.do'">목록</button>	
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
	    
	    

	$(document).ready(function(){
		$('#multi_select').selectpicker();	
	});

		
	function addFilter() {
		var selected = $("#multi_select").val() || [];
		$('#selected').prop("value", selected);
		
	}
	</script>

</body>
</html>
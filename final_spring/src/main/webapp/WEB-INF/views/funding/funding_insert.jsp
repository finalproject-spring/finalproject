<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<!-- multi select -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.css" integrity="sha512-6g9IGCc67eh+xK03Z8ILcnKLbJnKBW+qpEdoUVD/4hBa2Ghiq5dQgeNOGWJfGoe9tdCRM4GpJMnsRXa2FDJp9Q==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/css/bootstrap-select.min.css" integrity="sha512-ARJR74swou2y0Q2V9k0GbzQ/5vJ2RBSoCWokg4zkfM29Fb3vZEQyv0iWBMW/yvKgyHSR/7D64pFMmU8nYmbRkg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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

#main_title { float: left; padding-right: 50px;}

#preview { width: 450px; height: 300px; background-color:#D5D5D5;}

#funding_title { width: 500px; font-size: 20px; border: 1px solid rgba(0, 0, 0, 0.1); }

#clear { width:1050px; margin: auto; }

#clear::after { display: block; clear: both; content: ''; }

#dates {text-align: center; padding: 20px 0px 20px 0px }

#collection, #user_pay {padding: 10px 0px 10px 0px}

#paydesc, #pay {width: 907px;}

</style>
</head>
<jsp:include page="../main/header.jsp"></jsp:include>
<body>
<br/>
	<div class="container">
		<form method="post" enctype="multipart/form-data" action="funding_insertres.do">
			<div id="clear" >
				<div id="main_title">
					<div><img id="preview"/></div>
					<input type="file" name="uploadfile" onchange="readURL(this);" accept="image/*" required="required" multiple="multiple"/>
				</div>
				<div class="form-group" style="padding: 50px 0px 20px 0px;">
					<div id="collection">펀딩 제목</div> 
					<input type="text" required="required" name="funding_title" id="funding_title" class="form-control" />
				</div>
				<div class="row">
				<div style="padding: 20px 0px 20px 0px;">
					<select id="multi_select" class="selectpicker w-100" title="카테고리를 선택하세요." multiple="multiple" data-style="bg-white rounded-pill px-4 py-3 shadow-sm" onchange="addFilter();" required="required">
					    <option value="환경보호">환경보호</option>
					    <option value="업싸이클링">업싸이클링</option>
					    <option value="기후재난">기후재난</option>
					    <option value="제로웨이스트">제로웨이스트</option>
					    <option value="친환경">친환경</option>
					    <option value="플라스틱 쓰레기">플라스틱 쓰레기</option>
					    <option value="동물보호">동물보호</option>
					</select>
					<input type="hidden" id="selected" name="funding_filter"/>
					<!-- name 이 controller의 파라미터와 동일해야 nullpoint가 뜨지 않음 -->
					<input type="hidden" value="사진경로" name="funding_pic"/>	
				</div>
			</div>
		</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.bundle.js" integrity="sha512-iqhWkvLOXVDz+Lr//ZryEKNvZ5pmgdKEe58Wh/VwfTGwTku0MKbuLhjJ1zUAJu8iSbOqfLcXrrxJ61+27THi2Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/js/bootstrap-select.min.js" integrity="sha512-yDlE7vpGDP7o2eftkCiPZ+yuUyEcaBwoJoIhdXv71KZWugFqEphIS3PU60lEkFaz8RxaVsMpSvQxMBaKVwA5xg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
		<div id="dates">
			<div class="form-group" style="display: inline-block;">
				<label>펀딩 시작일</label>
				<input type="date" name="funding_start" class="form-control" style="width:450px;" required="required"/>
			</div>
			<div class="form-group" style="display: inline-block;">
				<label>펀딩 종료일</label>
				<input type="date" name="funding_end" class="form-control" style="width:450px;" required="required"/>
			</div>
		</div>
		<div style="margin: 0 auto; margin-left: 100px;">
			<div>
				<div id="collection">목표 모금액</div>
				<input type="text" name="funding_ta" required="required" class="form-control" style="width: 907px;" placeholder="총 목표액을 입력해주세요." pattern="[0-9]+"/>
			</div>
			<div>
				<div id="user_pay">
					<div style="padding-bottom: 20px;">
						<div id="collection">결제 항목</div>
						<input type="text" class="form-control" id="paydesc" required="required" placeholder="결제 항목 설명을 입력해주세요." name="funding_paydesc"/>
					</div>
					<div>
						<div id="collection">결제 금액</div>
						<input type="text" class="form-control" id="pay" required="required" placeholder="결제 금액을 입력해주세요." name="funding_pay" pattern="[0-9]+"/>
					</div>
				</div>
			</div>
		</div>
		<br/><br/>
		<div>
				<textarea required="required" id="summernote" name="funding_content"></textarea>
		</div>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
		<br/>
		<div style="text-align: right;">
			<input type="submit" value="작성" style="background-color: #71c55d; color: white; width: 80px; height: 35px; border: 2px solid #71c55d; border-radius: 10px; font-weight: 700;">
			<input type="button" value="돌아가기" onclick="back();" style="background-color: white; color:#727272; width: 80px; height: 35px; border: 2px solid #71c55d; border-radius: 10px; font-weight: 700;"/>
		</div>
		<br/><br/>
	</form>
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
			url : "funding_uploadSummernoteImg.do",
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			success : function(data) {
				$(el).summernote('editor.insertImage', data.url);

			}
		});
	}

	$(document).ready(function(){
		$('#multi_select').selectpicker();	
	});
	
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				document.getElementById('preview').src = e.target.result;
			};
			reader.readAsDataURL(input.files[0]);
		} else {
			document.getElementById('preview').src = "";
		}
	}
	
	function addFilter() {
		var selected = $("#multi_select").val() || [];
		$('#selected').prop("value", selected);
		
	}

    function back() {
    	if(confirm("글 작성을 취소하시겠습니까?")) {
    		history.back();
    	}
    	return false;
    }

</script>
</body>
</html>
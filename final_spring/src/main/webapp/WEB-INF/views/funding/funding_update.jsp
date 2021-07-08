<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- multi select -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.css" integrity="sha512-6g9IGCc67eh+xK03Z8ILcnKLbJnKBW+qpEdoUVD/4hBa2Ghiq5dQgeNOGWJfGoe9tdCRM4GpJMnsRXa2FDJp9Q==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/css/bootstrap-select.min.css" integrity="sha512-ARJR74swou2y0Q2V9k0GbzQ/5vJ2RBSoCWokg4zkfM29Fb3vZEQyv0iWBMW/yvKgyHSR/7D64pFMmU8nYmbRkg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
		var text = $('#selected').val();
		if (text.length > 1) {
			$('.filter-option-inner-inner').text(text);	
		}
	});
	
	$(document).ready(function(){
		var pay = '${dto.funding_pay}'.split(',');
		var paydesc = '${dto.funding_paydesc}'.split('$%^');
		var box = document.getElementById("textBox");
		var newP = document.createElement('p');
		$('.pay').eq(0).val(pay[0]);
		$('.paydesc').eq(0).val(paydesc[0]);
		for (i = 1; i < pay.length; i++) {
			newP.innerHTML = "<input type='text' class='pay' required='required' placeholder='금액을 입력해주세요.' value='"+pay[i]+"' onchange='payTotal();'> <input type='text' class='paydesc' required='required' placeholder='설명을 입력해주세요.' value='"+paydesc[i]+"' onchange='paydescTotal();'> <input type='button' value='삭제' onclick='remove(this)'>";
	        box.appendChild(newP);
			
		}
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
	
	function addPayment() {
		var box = document.getElementById("textBox");
		var newP = document.createElement('p');
		newP.innerHTML = "<input type='text' class='pay' required='required' placeholder='금액을 입력해주세요.' onchange='payTotal();'> <input type='text' class='paydesc' required='required' placeholder='설명을 입력해주세요.' onchange='paydescTotal();'> <input type='button' value='삭제' onclick='remove(this)'>";
        box.appendChild(newP);
    }
      var remove = (obj) => {
        document.getElementById('textBox').removeChild(obj.parentNode);
    }
      
    function payTotal() {
		var plength = $(".pay").length;
		var total = new Array(plength);

		for(var i=0; i< plength; i++){                          
				total[i] = $(".pay").eq(i).val();
		}
		$('#funding_pay').prop("value", total);
    }
    
    function paydescTotal() {
		var desclength = $(".paydesc").length;
		var total = new Array(desclength);

		for(var i=0; i< desclength; i++){                          
				total[i] = $(".paydesc").eq(i).val();
		}
		var desctotal = total.join("$%^");
		$('#funding_paydesc').prop("value", desctotal);    	
    }

</script>
<style type="text/css">

#preview { width: 450px; height: 300px; background-color: gray; }

.multi_select_box{ width: 100%; -ms-overflow-style: none; /* IE and Edge */ scrollbar-width: none; /* Firefox */ }

.multi_select_box select { width: 400px; }

.multi_select_box button { background-color: white; color: black; border:1px solid; border-color:black; padding: 15px 25px; }

.bootstrap-select>.dropdown-toggle { width: 500px; }

.bootstrap-select:not([class*=col-]):not([class*=form-control]):not(.input-group-btn) { width: 493px; }

.dropdown-menu > li > a { padding-top: 5px; }

</style>
</head>
<body>
	<div>
		<form method="post" enctype="multipart/form-data" action="funding_updateres.do">
			<input type="hidden" name="funding_no" value="${dto.funding_no }"/>
			<div>
						펀딩 메인 사진
				<div><img id="preview" src="${dto.funding_pic }"/>이미지 미리보기</div>
				<input type="file" name="uploadfile" onchange="readURL(this);" accept="image/*" multiple="multiple"/>
				<!-- name 이 controller의 파라미터와 동일해야 nullpoint가 안뜸 -->
				<input type="hidden" value="${dto.funding_pic }" name="funding_pic"/>
			</div>
			<div>
				<input type="text" required="required" name="funding_title" value="${dto.funding_title }" placeholder="펀딩 이름을 입력해 주세요."/>
			</div>
			<div>
				펀딩 카테고리
				<div class="multi_select_box">
				<select id="multi_select" title="카테고리를 선택하세요." multiple="multiple" onchange="addFilter();">
				    <option value="환경보호">환경보호</option>
				    <option value="업싸이클링">업싸이클링</option>
				    <option value="기후재난">기후재난</option>
				    <option value="재활용">재활용</option>
				    <option value="친환경">친환경</option>
				    <option value="플라스틱 쓰레기">플라스틱 쓰레기</option>
				    <option value="동물보호">동물보호</option>
				</select>
				<input type="hidden" id="selected" name="funding_filter" value="${dto.funding_filter }"/>
			</div>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.bundle.js" integrity="sha512-iqhWkvLOXVDz+Lr//ZryEKNvZ5pmgdKEe58Wh/VwfTGwTku0MKbuLhjJ1zUAJu8iSbOqfLcXrrxJ61+27THi2Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/js/bootstrap-select.min.js" integrity="sha512-yDlE7vpGDP7o2eftkCiPZ+yuUyEcaBwoJoIhdXv71KZWugFqEphIS3PU60lEkFaz8RxaVsMpSvQxMBaKVwA5xg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
				
			</div>
			<div>
				펀딩 시작
				<input type="date" name="funding_start" value="${dto.funding_start }" required="required"/>
				펀딩 종료
				<input type="date" name="funding_end" value="${dto.funding_end }" required="required"/>
			</div>
			<div>
				목표 모금액
				<input type="text" name="funding_ta" value="${dto.funding_ta }" required="required"/>원
			</div>
			<div>
				금액(숫자만)과 설명을 입력해주세요
				<div id="textBox">
				<p>
					<input type="text" class="pay" required="required" placeholder="금액을 입력해주세요." onchange='payTotal();'/>
					<input type="text" class="paydesc" required="required" placeholder="결제 항목 설명을 입력해주세요." onchange='paydescTotal();'/>
				</p>
				</div>
				<input type="button" value="항목 추가" onclick="addPayment();"/>
	 			<input type="hidden" id="funding_pay" name="funding_pay" value="${dto.funding_pay }"/>
	 			<input type="hidden" id="funding_paydesc" name="funding_paydesc" value="${dto.funding_paydesc }"/>
			</div>

			<div>
				<textarea required="required" id="summernote" name="funding_content">${dto.funding_content }</textarea>
			</div>
			<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
			<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
			<div>
				<input type="submit" value="수정">
				<input type="button" value="돌아가기" onclick="history.back();"/>
			</div>
		</form>
	</div>
</body>
</html>
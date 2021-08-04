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

	#allButton { background:#1AAB8A; text-align:center; color:#fff; border:none; position:relative; font-size:15px; width: 90px; height: 37px;
	  cursor:pointer; transition:800ms ease all; outline:none; border-radius: 10px; }
	#allButton:hover { background:#fff; color:#1AAB8A;} 
	#allButton:before,#allButton:after{
	  content:'';
	  position:absolute;
	  top:0;
	  right:0;
	  height:2px;
	  width:0;
	  background: #1AAB8A;
	  transition:400ms ease all;
	}
	#allButton:after{
	  right:inherit;
	  top:inherit;
	  left:0;
	  bottom:0;
	}
	#allButton:hover:before,#allButton:hover:after{
	  width:100%;
	  transition:800ms ease all;
	}

</style>
</head>
<body>
 <jsp:include page="../main/header.jsp"></jsp:include>
	<div class="container">
		<form method="post" enctype="multipart/form-data" action="funding_updateres.do">
			<div id="clear">
			<input type="hidden" name="funding_no" value="${dto.funding_no }"/>
			<div>
				<div id="main_title">
					<div><img id="preview" src="${dto.funding_pic }"/></div>
					<input type="file" name="uploadfile" onchange="readURL(this);" accept="image/*" multiple="multiple" />
				</div>
				<input type="hidden" value="${dto.funding_pic }" name="funding_pic"/>
			</div>
			<div class="form-group" style="padding: 50px 0px 20px 0px;">
				<div id="collection">펀딩 제목</div> 
				<input type="text" required="required" name="funding_title" id="funding_title" value="${dto.funding_title }" placeholder="펀딩 이름을 입력해 주세요." class="form-control"/>
			</div>
			<div class="row">
				<div style="padding: 20px 0px 20px 0px;">
					펀딩 카테고리
					<div class="multi_select_box">
					<select id="multi_select" title="카테고리를 선택하세요." multiple="multiple" onchange="addFilter();">
					    <option value="환경보호">환경보호</option>
					    <option value="업싸이클링">업싸이클링</option>
					    <option value="기후재난">기후재난</option>
					    <option value="제로웨이스트">제로웨이스트</option>
					    <option value="친환경">친환경</option>
					    <option value="플라스틱 쓰레기">플라스틱 쓰레기</option>
					    <option value="동물보호">동물보호</option>
					</select>
					<input type="hidden" id="selected" name="funding_filter" value="${dto.funding_filter }"/>
				</div>
				</div>
			</div>
			</div>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.bundle.js" integrity="sha512-iqhWkvLOXVDz+Lr//ZryEKNvZ5pmgdKEe58Wh/VwfTGwTku0MKbuLhjJ1zUAJu8iSbOqfLcXrrxJ61+27THi2Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/js/bootstrap-select.min.js" integrity="sha512-yDlE7vpGDP7o2eftkCiPZ+yuUyEcaBwoJoIhdXv71KZWugFqEphIS3PU60lEkFaz8RxaVsMpSvQxMBaKVwA5xg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>	
			<div id="dates">
				<div class="form-group" style="display: inline-block;">
					<label>펀딩 시작일</label>
					<input type="date" name="funding_start" class="form-control" style="width:450px;" value="${dto.funding_start }" required="required"/>
				</div>
				<div class="form-group" style="display: inline-block;">
					<label>펀딩 종료일</label>
					<input type="date" name="funding_end" class="form-control" style="width:450px;" value="${dto.funding_end }" required="required"/>
				</div>
			</div>
			<div style="margin: 0 auto; margin-left: 100px;">
				<div>
					<div id="collection">목표 모금액</div>
					<input type="text" name="funding_ta" required="required" class="form-control" value="${dto.funding_ta }" style="width: 907px;" placeholder="총 목표액을 입력해주세요." pattern="[0-9]+"/>
				</div>
				<div>
					<div id="user_pay">
						<div style="padding-bottom: 20px;">
							<div id="collection">결제 항목</div>
							<input type="text" class="form-control" id="paydesc" required="required" placeholder="결제 항목 설명을 입력해주세요." name="funding_paydesc" value="${dto.funding_paydesc }"/>
						</div>
						<div>
							<div id="collection">결제 금액</div>
							<input type="text" class="form-control" id="pay" required="required" placeholder="결제 금액을 입력해주세요." name="funding_pay" value="${dto.funding_pay }" pattern="[0-9]+"/>
						</div>
					</div>
				</div>
			</div>
		<br/><br/>
	
			<div>
				<textarea required="required" id="summernote" name="funding_content">${dto.funding_content }</textarea>
			</div>
			<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
			<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
			<br/><br/>
			<div>
				<input id="allButton" type="submit" value="수정">
				<input id="allButton" type="button" value="돌아가기" onclick="history.back();"/>
			</div>
		</form>
	</div>
</body>
</html>
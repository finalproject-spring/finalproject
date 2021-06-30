<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/summernote-lite.js"></script>
<script src="/js/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/css/summernote-lite.css">
<script type="text/javascript">
	$(document).ready(function() {
		//여기 아래 부분
		$('#summernote').summernote({
			  height: 300,                 // 에디터 높이
			  minHeight: null,             // 최소 높이
			  maxHeight: null,             // 최대 높이
			  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
			  lang: "ko-KR",					// 한글 설정
			  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
	          
		});
	});
	</script>
</head>
<body>

<!-- https://greatps1215.tistory.com/4 : 업로드 미리보기 -->
	<div>
		<form method="post" enctype="multipart/form-data" action="funding_insertres.do">
			<div>
				펀딩 카테고리
			</div>
			<div>
				펀딩 제목
				<input type="text" name="funding_title"/>
			</div>
			<div>
				펀딩 메인 사진
				<input type="file" name="funding_pic"/>
			</div>
			<div>
				<input type="date" name="funding_start"/>
				<input type="date" name="fundig_end"/>
				시작일, 종료일
			</div>
			<div>
				<input type="text" name="funding_ta"/>
				목표 모금액
			</div>
			<div>
				<div id="summernote" name="funding_content"></div>
				내용(썸머노트)
					
			</div>
			
		</form>
		
	</div>

</body>
</html>
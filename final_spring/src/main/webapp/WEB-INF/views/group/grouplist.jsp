<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.css" integrity="sha512-6g9IGCc67eh+xK03Z8ILcnKLbJnKBW+qpEdoUVD/4hBa2Ghiq5dQgeNOGWJfGoe9tdCRM4GpJMnsRXa2FDJp9Q==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/css/bootstrap-select.min.css" integrity="sha512-ARJR74swou2y0Q2V9k0GbzQ/5vJ2RBSoCWokg4zkfM29Fb3vZEQyv0iWBMW/yvKgyHSR/7D64pFMmU8nYmbRkg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- multi select -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.css" integrity="sha512-6g9IGCc67eh+xK03Z8ILcnKLbJnKBW+qpEdoUVD/4hBa2Ghiq5dQgeNOGWJfGoe9tdCRM4GpJMnsRXa2FDJp9Q==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/css/bootstrap-select.min.css" integrity="sha512-ARJR74swou2y0Q2V9k0GbzQ/5vJ2RBSoCWokg4zkfM29Fb3vZEQyv0iWBMW/yvKgyHSR/7D64pFMmU8nYmbRkg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- AOS -->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

// 체크 박스 선택 함수
$(function() {
	var chkObj = document.getElementsByName("RowCheck");
	var rowCnt = chkObj.length;
	
	$("input[name='allCheck']").click(function() {
		var chk_listArr = $("input[name='RowCheck']");
		for (var i=0; i<chk_listArr.length; i++){
			chk_listArr[i].checked = this.checked;
		}
	});
	$("input[name='RowCheck']").click(function() {
		if($("input[name='RowCheck']:checked").length == rowCnt){
			$("input[name='allCheck']")[0].checked = true;
		}
		else{
			$("input[name='allCheck']")[0].checked = false;
		}
	});
});

//선택된 게시물 controller로 보내서 삭제하기! 
function deleteValue() {
	var url = "group_selectdelete.do";
	var valueArr = new Array();
	var list = $("input[name='RowCheck']");
	for (var i=0; i<list.length; i++){
		if(list[i].checked){
			valueArr.push(list[i].value);
		}
	}
	if(valueArr.length == 0){
		alert("선택된 글이 없습니다.");
	}
	else{
		var chk = confirm("정말 삭제하시겠습니까?");
		$.ajax({
			url : url,
			type : 'POST',
			traditional : true,
			data :{
				valueArr : valueArr
			},
			success:function(jdata){
				if(jdata=1){
					alert("삭제 성공");
					location.replace("group_list.do")
				}
				else{
					alert("삭제 실패");
				}
			}		
			
		});
		
	}
}

$(document).ready(function(){
	$('#multi_select').selectpicker();
	var text = $('#selected').val();
	var url = decodeURI(location.href);
	var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&');
	var boardfilter = parameters[2];
	if (boardfilter != "board_filter=") {
		var filter = boardfilter.split('=')[1];
		$('.filter-option-inner-inner').text(filter);	
		
	}
	if($('.filter-option-inner-inner').text() != null) {
		$('#selected').prop("value", $('.filter-option-inner-inner').text());
	}
});

function addFilter() {
	var selected = $("#multi_select").val() || [].join(',');
	$('#selected').prop("value", selected);
}


</script>
<style type="text/css">
body { margin: 0; padding: 0; }
	.lists {}
	.list { display: inline-block; width: 340px; margin: 20px; }
	.Elist { display: inline-block; width: 340px; margin: 20px; }
	.container { background:rgb(255, 254, 254); padding:0; margin:0; }
	.prog { width: 340px; background:rgb(189, 177, 177); }
	.progs { height: 6px; background: rgb(225, 149, 240); color:#fff; line-height: 50px; }

li {list-style: none; float: left; display:inline; padding: 6px;}
</style>
</head>
<body>

<jsp:include page="../main/header.jsp"></jsp:include>
<ul>
		<li><a href="./group_insertform.do">글 작성</a></li>
	</ul>
	<div class="container">
		<header>
			<h1>소모임 게시판</h1>
		</header>
		<hr/>
		<div class="form-group">
		<div class="multi_select_box">
			<select id="multi_select" title="카테고리를 선택하세요." multiple="multiple" onchange="addFilter();" required="required">
			     <option value="전체보기">전체보기</option>
				<option value="온라인 토론">온라인 토론</option>
				<option value="오프라인 토론">오프라인 토론</option>
				<option value="쓰레기 줍기">쓰레기 줍기</option>
				<option value="어린이 환경모임">어린이 환경모임</option>
				<option value="환경 독서">환경 독서</option>
			</select>
		</div>
		<form method="get" role="form">
			<input type="hidden" id="page" name="page" value="${scri.page}"> 
 			<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
  			<input type="hidden" id="selected" name="board_filter" value=""/>
			<input type="button" id="searchBtn" value="검색"/>
			<script type="text/javascript">
				$(function() {
					$('#searchBtn').click(function() {
						location.href = "group_list.do?page=${scri.page}"
						+"&perPageNum=${scri.perPageNum}"
						+"&board_filter="+$('#selected').val();
							});
					});
			</script>
		</form>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.bundle.js" integrity="sha512-iqhWkvLOXVDz+Lr//ZryEKNvZ5pmgdKEe58Wh/VwfTGwTku0MKbuLhjJ1zUAJu8iSbOqfLcXrrxJ61+27THi2Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/js/bootstrap-select.min.js" integrity="sha512-yDlE7vpGDP7o2eftkCiPZ+yuUyEcaBwoJoIhdXv71KZWugFqEphIS3PU60lEkFaz8RxaVsMpSvQxMBaKVwA5xg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	</div>



		<section id="container">
					<form role="form" method="get">
							<table class="table table-hover">
								<thead>
									<tr>
										<th><input id="allCheck" type="checkbox" name="allCheck"/> </th>
										<th>번호</th>
										<th>제목</th>
										<th>카테고리</th>
										<th>작성자</th>
										<th>작성일</th>
										<th>조회수</th>
									</tr>
								</thead>
								
								<c:forEach items="${list }" var="dto">
									<tr>
										<td><input name="RowCheck" type="checkbox" value="${dto.board_no }"/></td>
										<td>${dto.board_no }</td>
										<td>
											<a href="group_view.do?board_no=${dto.board_no }">${dto.board_title }</a>
										</td>
										<td>${dto.board_filter }</td>
										<td>${dto.board_id }</td>
										<td><fmt:formatDate value="${dto.board_date}"
									pattern="yyyy-MM-dd" /></td>
										<td>${dto.board_views }</td>
										<td>
										
										</td>
						</tr>
								</c:forEach>
								
							</table>
	<div>
  <ul>
    <c:if test="${pageMaker.prev}">
    	<li><a href="group_list.do${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
    </c:if> 
    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
    	<li><a href="group_list.do${pageMaker.makeQuery(idx)}">${idx}</a></li>
    </c:forEach>
    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
    	<li><a href="group_list.do${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
    </c:if> 
  </ul>
</div>
				
				</form>
				
			</section>
			<div class="form-group">
					<button type="button" class="list_btn btn btn-primary" onclick="deleteValue();" >선택삭제</button>
				</div>
		</div>
</body>
</html>
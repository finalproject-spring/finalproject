<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" crossorigin="anonymous">
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

function loginChk(){
	alert("로그인이 필요합니다.");
	location.href='login_loginform.do';
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

.blinking{ -webkit-animation:blink 1s ease-in-out infinite alternate; -moz-animation:blink 1s ease-in-out infinite alternate; animation:blink 1s ease-in-out infinite alternate; } @-webkit-keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} } @-moz-keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} } @keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} }
.searchinput {  border:0; background-color: transparent; color: #999;
font-size: 18px;line-height: 40px;width: 30px;height: 40px;text-align: center;
font-family: "Font Awesome 5 Free"; font-weight: 400; font-style: normal;
font-variant: normal;text-rendering: auto;
-webkit-font-smoothing: antialiased;}
​select:focus {
	outline: none;
}
input:focus {
	outline: none;
}
option:focus {
	outline: none;
}
.delinput {  border:0; background-color: transparent; color: #999;
font-size: 12px;line-height: 40px;width: 30px;height: 40px;text-align: center;
font-family: "Font Awesome 5 Free"; font-weight: 400; font-style: normal;
font-variant: normal;text-rendering: auto;
-webkit-font-smoothing: antialiased;}
</style>

</head>
<body>

<jsp:include page="../main/header.jsp"></jsp:include>

	<div class="container">
		<header>
			<h1 style=" font-size: 19.8px; font-weight:600; float: left; color: #363636; ">Let's save earth together</h1>
			<em style=" font-style:normal;  font-size: 14.8px; font-weight:600;  color: #1AAB8A; padding: 3px 3px;  " > ${count }</em>
		</header>
		<hr/>
		<div class="form-group">
		<div class="multi_select_box" style="float: left ;">
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
			<input type="button" id="searchBtn" value="&#xF002;"  class="searchinput" style="font-family:Arial, FontAwesome;" /> 
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
										<th style=" font-size: 14px; font-weight: 680; font-size: 13px; color: #363636; "><input id="allCheck" type="checkbox" name="allCheck"/> </th>
										<th style=" font-size: 14px; font-weight: 680; font-size: 13px; color: #363636; ">카테고리</th>
										<th style=" font-size: 14px; font-weight: 680; font-size: 13px; color: #363636; ">제목</th>
										<th style=" font-size: 14px; font-weight: 680; font-size: 13px; color: #363636; ">글쓴이</th>
										<th style=" font-size: 14px; font-weight: 680; font-size: 13px; color: #363636; ">작성일</th>
										<th style=" font-size: 14px; font-weight: 680; font-size: 13px; color: #363636; ">조회수</th>
									</tr>
								</thead>
								
								<c:forEach items="${list }" var="dto">
									<tr>
																<td><input name="RowCheck" type="checkbox" value="${dto.board_no }"/></td>
										
									
										<td style="font-weight: 600; font-size: 13px; color: #36363666;">${dto.board_filter }</td>
											<td>
											<a style="font-weight: 680; font-size: 13px; color: #363636;  "  href="group_view.do?board_no=${dto.board_no }">${dto.board_title }</a>
        									<c:if test="${dto.board_views >= 50 }">
            								<span class="image blinking" style="color:#c90c0c; ">hot!!</span>
        									</c:if>
											
											
										</td>
										<td style="font-weight: 600; color: #36363666;">${dto.board_id }</td>
										<td style="font-weight:600; color: #36363666;"><fmt:formatDate value="${dto.board_date}"
									pattern="yyyy-MM-dd" /></td>
										<td style="font-weight:600; color: #36363666;">${dto.board_views }</td>
										<td>
										
										</td>
						</tr>
								</c:forEach>
								
							</table>
	<div>
  <ul>
    <c:if test="${pageMaker.prev}">
    	<li><a style="font-weight: 680; font-size: 18px; color: #999; " href="group_list.do${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
    </c:if> 
    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
    	<li><a style="font-weight: 710; font-size: 18px; color: #999; " href="group_list.do${pageMaker.makeQuery(idx)}">${idx}</a></li>
    </c:forEach>
    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
    	<li><a style="font-weight: 710; font-size: 18px; color: #999; " href="group_list.do${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
    </c:if> 
  </ul>
</div>
				
				</form>
				
			</section>
			
			<c:if test="${memberdto.member_role eq 0 }">
			<div class="form-group">
					<button type="button" class="delinput"  onclick="deleteValue();" ><i class="fas fa-trash-alt"></i></button>
				</div>
				</c:if>
				<div align="right">
				<c:choose>
					<c:when test="${empty memberdto }">
						<input id="button1" type="button" value="글작성"  onclick="loginChk();"/>
					</c:when>
					<c:otherwise>
						<input  id="button1" type="button" value="글작성"  onclick="location.href='group_insertform.do'"/>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
</body>
</html>
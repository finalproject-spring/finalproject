<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- multi select -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.css" integrity="sha512-6g9IGCc67eh+xK03Z8ILcnKLbJnKBW+qpEdoUVD/4hBa2Ghiq5dQgeNOGWJfGoe9tdCRM4GpJMnsRXa2FDJp9Q==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/css/bootstrap-select.min.css" integrity="sha512-ARJR74swou2y0Q2V9k0GbzQ/5vJ2RBSoCWokg4zkfM29Fb3vZEQyv0iWBMW/yvKgyHSR/7D64pFMmU8nYmbRkg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- AOS -->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		$('#multi_select').selectpicker();
		var text = $('#selected').val();
		var url = decodeURI(location.href);
		var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&');
		var fundingfilter = parameters[2];
		if (fundingfilter != "funding_filter=") {
			var filter = fundingfilter.split('=')[1];
			$('.filter-option-inner-inner').text(filter);	
			
		}
		if($('.filter-option-inner-inner').text() != null) {
			$('#selected').prop("value", $('.filter-option-inner-inner').text());
		}
		
		
		var filter = $('.funding_filter')

	});
	
	function addFilter() {
		var selected = $("#multi_select").val() || [].join(',');
		$('#selected').prop("value", selected);
	}
	
	var element = $(".blink");
	var shown = true;
	setInterval(toggle, 500);
	function toggle() {

	   if(shown) {

	       element.hide();

	       shown = false;

	   } else {

	       element.show();

	       shown = true;

	   }

	}
</script>
<style type="text/css">
	body { margin: 0; padding: 0; }
	
	.bootstrap-select .bs-ok-default::after {
	    border-width: 0 0.1em 0.1em 0;
	    transform: rotate(45deg) translateY(0.5rem);
	}
	
	.bootstrap-select .dropdown-menu li { width: 100%; }
	
	.btn.dropdown-toggle:focus {
	    outline: none !important;
	}
	#searchBtn { display:inline-block; font-size:23px; cursor: pointer; color: #adb5bd; height: 55px; margin-left: 16px; transition:800ms ease all;}
	#searchBtn:hover {color: #505050;}
	.list { display: inline-block; width: 327px; margin: 30px 19px 20px 19px; }
	.Elist { display: inline-block; width: 327px; margin: 20px; }
	.wrap { background:rgb(255, 254, 254); padding:0; margin:0; }
	#empty {text-align: center; line-height: 400px; font-weight: 700; font-size: 18px;}
	.funding_title {font-weight: 700; font-size: 17px; margin: 5px 0px 5px 0px;}
	.funding_filter {color:#505050; font-size: 16px;}
	.prog { width: 327px; background: #D9DEDD; }
	.progs { height: 6px; background: linear-gradient(to left,#4dccc6, #96e4df); color:#fff; line-height: 50px; }
	#persent {font-weight: 700; font-size: 16px;  color:#48beb8; }
	#ca {margin-left:10px; font-weight: 700;}
	.blinking{ -webkit-animation:blink 1s ease-in-out infinite alternate; -moz-animation:blink 1s ease-in-out infinite alternate; animation:blink 1s ease-in-out infinite alternate; } @-webkit-keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} } @-moz-keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} } @keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} }
	#writeBtn {background-color: #4dccc6; font-size: 15px; border: 1px solid #4dccc6; border-radius: 10px; color:white; width: 78px; height: 37px; }
	#paging ul li {list-style: none; float: left; padding: 6px;}
	#paging ul li a {color: #626262; font-size: 15px;}
</style>
</head>
<jsp:include page="../main/header.jsp"></jsp:include>
<body>
 <div class="container">
 	<br/>
	<div>
		<div class="multi_select_box" align="center">
			<select id="multi_select" data-width="80%" data-style="bg-white rounded-pill px-4 py-3 shadow-sm" data-actions-box="true" title="카테고리를 선택하세요." multiple="multiple" onchange="addFilter();" required="required">
			    <option value="전체보기">전체보기</option>
			    <option value="환경보호">환경보호</option>
			    <option value="업싸이클링">업싸이클링</option>
			    <option value="기후재난">기후재난</option>
			    <option value="제로웨이스트">제로웨이스트</option>
				<option value="친환경">친환경</option>
			    <option value="플라스틱 쓰레기">플라스틱 쓰레기</option>
			    <option value="동물보호">동물보호</option>
			</select>
		<span id="searchBtn"><i class="fas fa-search" style="line-height: 55px;"></i></span>
		</div>
		<form method="get" role="form">
			<input type="hidden" id="page" name="page" value="${scri.page}"> 
 			<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
  			<input type="hidden" id="selected" name="funding_filter" value=""/>
			<script type="text/javascript">
				$(function() {
					$('#searchBtn').click(function() {
						location.href = "funding_list.do?page=${scri.page}"
						+"&perPageNum=${scri.perPageNum}"
						+"&funding_filter="+$('#selected').val();
							});
					});
			</script>
		</form>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.bundle.js" integrity="sha512-iqhWkvLOXVDz+Lr//ZryEKNvZ5pmgdKEe58Wh/VwfTGwTku0MKbuLhjJ1zUAJu8iSbOqfLcXrrxJ61+27THi2Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/js/bootstrap-select.min.js" integrity="sha512-yDlE7vpGDP7o2eftkCiPZ+yuUyEcaBwoJoIhdXv71KZWugFqEphIS3PU60lEkFaz8RxaVsMpSvQxMBaKVwA5xg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	</div>
	<br/><br/>
	 <c:choose>
		<c:when test="${empty list }">
		<div id="empty">해당 카테고리의 펀딩이 존재하지 않습니다.</div>
		</c:when>
		<c:otherwise>					
			<c:forEach items="${list }" var="dto">
				<div class="list">
					<div><a href="funding_detail.do?funding_no=${dto.funding_no}&page=${scri.page}&perPageNum=${scri.perPageNum}&funding_filter=${scri.funding_filter}"><img src="${dto.funding_pic}" style="width:327px; height: 235px;"></a></div>
					<div class="funding_title"><a href="funding_detail.do?funding_no=${dto.funding_no}&page=${scri.page}&perPageNum=${scri.perPageNum}&funding_filter=${scri.funding_filter}" style="color: rgba(0,0,0,.84)">${dto.funding_title }</a></div>
					<div class="funding_filter">${dto.funding_filter }</div>
					<jsp:useBean id="today" class="java.util.Date" />
					<fmt:parseNumber value="${today.time / (1000*60*60*24)}" integerOnly="true" var="nowDate" scope="request" />
					<fmt:parseDate var="dateString" value="${dto.funding_end}" pattern="yyyy-MM-dd" />
					<fmt:parseNumber value="${dateString.time / (1000*60*60*24)}" integerOnly="true" var="endDate" scope="request" />
					<fmt:parseNumber var="persent" integerOnly="true" value="${dto.funding_ca/dto.funding_ta*100 }"/>
					<fmt:formatNumber var="ca" value="${dto.funding_ca}" pattern="#,###,###,###"/>
					<div><span id="persent">${persent }%</span><span id="ca">${ca }</span>원</div>
					<div class="wrap">
						<div class="prog">
							<div class="progs" style="width: ${persent }%; max-width:327px"></div>
						</div>
					</div>
					<c:choose>
						<c:when test="${endDate-nowDate > 0 &&  endDate-nowDate <=6 }">
							<div class="image blinking" style="font-weight: bold; color: #1AAB8A;">${endDate-nowDate }일 남음</div>
						</c:when>	
						<c:when test="${endDate-nowDate < 0}">
							<div style="font-weight: bold; color: #6F6F6F;">종료됨</div>
						</c:when>
						<c:when test="${endDate-nowDate == 0}">
							<div class="image blinking" style="font-weight: bold; color: #1AAB8A;" >오늘마감</div>
						</c:when>	
						<c:otherwise>
							<div style="font-weight: bold; color: #6F6F6F;">${endDate-nowDate }일 남음</div>
						</c:otherwise>
				</c:choose>
				</div>
				</c:forEach>
			</c:otherwise>
		</c:choose> 
		<div id="paging">
			<ul>
		    <c:if test="${pageMaker.prev}">
			   	<li><a href="funding_list.do${pageMaker.makeQuery(pageMaker.startPage - 1)}&funding_filter=${scri.funding_filter}">이전</a></li>
		    </c:if> 		
		    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
		    	<li><a href="funding_list.do${pageMaker.makeQuery(idx)}&funding_filter=${scri.funding_filter}">${idx}</a></li>
		    </c:forEach>
		    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
		    	<li><a href="funding_list.do${pageMaker.makeQuery(pageMaker.endPage + 1)}&funding_filter=${scri.funding_filter}">다음</a></li>
		    </c:if> 
		  </ul>
		</div>
		<c:if test="${memberdto.member_role eq 0 }">
			<div align="right" id="post"><input type="button" value="글 작성" onclick="location.href='funding_insertform.do'" id="writeBtn"/></div>
		</c:if>
	</div>

</body>
</html>
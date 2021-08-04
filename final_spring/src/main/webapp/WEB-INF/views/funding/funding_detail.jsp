<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){	
		var endDay = new Date('${dto.funding_end}');
		var now = new Date();
		var gap = now.getTime() - endDay.getTime();
		var dDay = Math.floor(gap/(1000*60*60*24) * -1);
		if (dDay >= 0) {
			$('#dDay').text(dDay+" 일 남음");	
		} else {
			$('#dDay').text("펀딩 성공");
			$("#payment").empty();
			$("#payment").append($("<div id='Efunding'>종료된 펀딩입니다.</div>"));
			document.getElementById('funding_btn').disabled = true;
		}
		
		var filter = '${dto.funding_filter}'.split(",");
		var html = "";
		
		for(var i in filter) {
			html += "<span id='funding_filter'>#"+filter[i]+" </span>"
			
		}
		$('#dDay').before(html);
	});
	
	function count(type) {
		var numElement = document.getElementById('count');
		var num = numElement.innerText;
		var price = ${dto.funding_pay};
		
		if(type=='plus') {
			if(parseInt(num) < 15) {
				num = parseInt(num) + 1;
				var totalPrice = price * num;
				$('#total').text(totalPrice.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + " 원");
			} else {
				alert("최대 선택 수량은 15개입니다.")
			}

		} else if(type=='minus') {
			if(parseInt(num) > 1) {
				num = parseInt(num) -1;
				var totalPrice = price * num;
				$('#total').text(totalPrice.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + " 원");
			} else {
				alert("최소 1개 이상 선택할 수 있습니다.")
			}
			
		}
		$('#funding_count').val(num);
		numElement.innerText = num;
	}
	

	function fundingDelete(){
		if(confirm("[관리자 전용] 삭제하면 복구할 수 없습니다.\n글을 삭제하시겠습니까?")) {
			location.href='funding_delete.do?funding_no=${dto.funding_no}';
		}
		return false;
	}
	
	
	function kakaopay() {
		
		if("${memberdto}" != ""){
			$("#kakaopay").submit();
		} else {
			alert("로그인 후 펀딩할 수 있습니다.");
		}
		
	}

</script>
<style type="text/css">
	.container { color:black; }
	.title { font-size: 40px; font-weight: 700; height: 180px; line-height: 180px; }
	#img_wrap { float: left; margin-right: 100px; width:610px; height: 410px; }
 	.wrap { background:rgb(255, 254, 254); padding:0; margin:0; }
	.prog { width: 450px; background:#D9DEDD; }
	.progs { height: 6px; background: linear-gradient(to left, #4dccc6, #96e4df); color:#fff; line-height: 50px; }
	#info { width: 450px; height: 460px; font-size: 20px; }
	strong { font-size: 30px; }
	#clear::after { display: block; clear: both; content: ''; }
	#funding_filter { font-size: 20px; font-weight:700; vertical-align: top; }
	#dDay { font-weight: 700; }
	#dDay, .wrap, #persent, #ca {padding-top: 18px;}
	#ca {padding-bottom: 20px;}
	#plus, #minus {background-color:#EBEBEB; border-radius: 25px; width: 20px; height: 20px; display: inline-block; line-height: 19px; text-align: center; vertical-align: middle; cursor: pointer;}
	#payinfo {font-size: 16px; font-weight:700; padding: 0px 20px 0px 20px; height:80px; line-height:80px; background-color: #F6F7F6; border-radius: 5px;}
	#funding_btn {width: 450px; height: 60px; background-color:#4dccc6; font-weight: 700; color: white; border: none; margin-top: 15px; font-size: 23px; }
	#info2 {background-color: #F1F5FE; font-weight:700; width: 610px; padding: 20px 10px 20px 10px}
	#total {padding: 10px 0px 10px 0px}
	#funding_content {padding: 100px 0px 100px 0px;}
	#bottom_menu {padding-bottom: 100px;}
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
	<div class="container" style="max-width:1200px;">
	<form name="readForm" role="form" method="post">
	  <input type="hidden" id="funding_no" name="funding_no" value="${dto.funding_no}" />
	  <input type="hidden" id="page" name="page" value="${scri.page}"> 
	  <input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
	  <input type="hidden" id="funding_filter" name="funding_filter" value="${scri.funding_filter}"> 
	</form>
	<div align="center" class="title">${dto.funding_title }</div>
	<div id="clear">	
		<div id="img_wrap">
			<img alt="펀딩 썸네일 사진" src="${dto.funding_pic}" style="width:610px; height: 410px;">
		</div>
		<div id="info" style="float: left;">
			<fmt:parseNumber var="persent" integerOnly="true" value="${dto.funding_ca/dto.funding_ta*100 }"/>
			<div id="dDay"></div>
			<div class="wrap">
				<div class="prog">
					<div class="progs" style="width: ${persent }%; max-width:450px"></div>
				</div>
			</div>
			<div id="persent"><strong>${persent }%</strong> 달성</div>
			<div id="ca"><fmt:formatNumber var="ca" value="${dto.funding_ca}" pattern="#,###,###,###"/><strong>${ca }</strong> 원 펀딩</div>
	 		<div id="payinfo">
	 			<div style="text-align: left; float: left;">${dto.funding_paydesc }</div>	 			
		 		<fmt:formatNumber var="payment" value="${dto.funding_pay }" pattern="#,###,###,###"/>
				<div style="text-align: right;">${payment } 원</div>
			</div>
			<div align="right" style="font-size: 17px; padding-top: 30px;">
				<span style="font-weight: 700;">수량</span>
				<span id="plus" onclick="count('minus');">-</span>
				<span id="count" style="font-weight: 700; padding: 0px 5px 0px 5px;">1</span>
				<span id="minus" onclick="count('plus');">+</span>			
			</div>
			<hr/>
			<div id="total" style="text-align: right;">${payment } 원</div>
			<div id="payment">
				<input type="button" id="funding_btn" value="펀딩하기" onclick="kakaopay();"/>
				<form id ="kakaopay" action="funding_kakaopay.do" method="post">
					<input type="hidden" id="funding_count" value="1" name="pay_count" />
					<input type="hidden" id="pay_price" value="${dto.funding_pay }" name="pay_price" />
					<input type="hidden" id="funding_no" name="funding_no" value="${dto.funding_no}"/>
				</form>
			</div>			
		</div>
	</div>
	<div id="info2">
		<div><fmt:formatNumber var="ta" value="${dto.funding_ta}" pattern="#,###,###,###"/>목표 금액 ${ta } 원</div>
		<div>펀딩 기간 ${dto.funding_start } ~ ${dto.funding_end }</div>
	</div>	
	<div id="funding_content">${dto.funding_content }</div>
	<div id="bottom_menu">
	<div style="float: left;"><input type="button" value="목록으로 " id="allButton" onclick="location.href='funding_list.do?page=${scri.page}&perPageNum=${scri.perPageNum}&funding_filter=${scri.funding_filter}'"/></div>
		<c:if test="${memberdto.member_role eq 0}">
		<div align="right">	
			<input type="button" value="수정" id="allButton" style="width:70px;" onclick="location.href='funding_updateform.do?funding_no=${dto.funding_no}'"/>
			<input type="button" value="글 삭제" id="allButton" style="width:70px;" onclick="fundingDelete();"/>
		</div>
		</c:if>
	</div>
	</div>
</body>
</html>
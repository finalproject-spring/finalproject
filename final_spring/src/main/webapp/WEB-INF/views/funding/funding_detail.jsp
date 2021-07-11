<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta2/dist/css/bootstrap-select.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta2/dist/js/bootstrap-select.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		$('#count').selectpicker();	
	});
	
	$(document).ready(function() {
	    var pays = '${dto.funding_pay}'.replace(" ", "").split(",");
	    var paydesc = '${dto.funding_paydesc}'.split("$%^");
	    var selectbox = document.getElementById("selects");
	
	    for (var i in pays) {       
	      	selectbox.options[i] = new Option(paydesc[i] + "\u00A0\u00A0\u00A0:\u00A0\u00A0\u00A0" + pays[i]+"원",paydesc[i] +"$%^"+ pays[i]);   	
	    }
	    $('#selects').selectpicker();
	});
	
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
			document.getElementById('addPayBtn').disabled = true;
		}
		
	});
		
	function addPayment() {
		var selected = $("#selects").val();
		var selArr = selected.split("$%^");
		var count = $("#count").val();
		var paydesc = '${dto.funding_paydesc}'.split("$%^");
		var box = document.getElementById("payBox");
		var newP = document.createElement('p');
		newP.innerHTML =
			"<div>" + selArr[0] + "<span class='totalPay'>" + selArr[1] + "원</span></div><div>수량: " + count +" 개\u00A0\u00A0\u00A0<input type='button' value='X' onclick='remove(this.parentNode)'></div>";
		
	    box.appendChild(newP);
	    
	    var pay = $(".totalPay").text();
	    var pat2 = pay.replace(/[^0-9원]/g,"")
	    var p4 = pat2.split('원');
	    var num = 0;
	    for(var i in p4) {
	    	if(!isNaN(parseInt(p4[i]))) {
	    		num  += parseInt(p4[i]) * parseInt(count);
	    	} 
	    }
		$('#paymentConnection').val(num);	    
	}
	  var remove = (obj) => {
	    document.getElementById('payBox').removeChild(obj.parentNode);
	}
	  
	function fundingDelete(){
		if(confirm("[관리자 전용] 삭제하면 복구할 수 없습니다.\n글을 삭제하시겠습니까?")) {
			location.href='funding_delete.do?funding_no=${dto.funding_no}';
		}
		return false;
	}
	
	function payment() {

	}

</script>
<style type="text/css">
	.title {font-size: 40px;}
 	.container { background:rgb(255, 254, 254); padding:0; margin:0; }
	.prog { width: 340px; background:rgb(189, 177, 177); }
	.progs { height: 7px; background: rgb(225, 149, 240); color:#fff; line-height: 50px; }
	
</style>
</head>
<body>
 <jsp:include page="../main/header.jsp"></jsp:include>
	<div>
	<form name="readForm" role="form" method="post">
	  <input type="hidden" id="funding_no" name="funding_no" value="${dto.funding_no}" />
	  <input type="hidden" id="page" name="page" value="${scri.page}"> 
	  <input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
	  <input type="hidden" id="funding_filter" name="funding_filter" value="${scri.funding_filter}"> 
	</form>
	<div class="title">${dto.funding_title }</div>
		<div>
		<img alt="펀딩 썸네일 사진" src="${dto.funding_pic}" style="width:600px; height: 400px;"></div>
		<div>${dto.funding_filter }</div>
		<fmt:parseNumber var="persent" integerOnly="true" value="${dto.funding_ca/dto.funding_ta*100 }"/>
		<div class="container">
			<div class="prog">
				<div class="progs" style="width: ${persent }%; max-width:300px"></div>
			</div>
		</div>
		<div>${persent }% 달성</div>
		<div><fmt:formatNumber var="ca" value="${dto.funding_ca}" pattern="#,###,###,###"/>현재 금액 ${ca }</div>
		<div><fmt:formatNumber var="ta" value="${dto.funding_ta}" pattern="#,###,###,###"/>목표 금액 ${ta }</div>
		<div id="dDay"></div>
		<div>펀딩 기간 ${dto.funding_start } ~ ${dto.funding_end }</div>
		<div>펀딩 금액 설정
			<select id="selects">
			</select>
			<div>수량</div>
			<select id="count">
			  <option>1</option>
			  <option>2</option>
			  <option>3</option>
			  <option>4</option>
			  <option>5</option>
			  <option>6</option>
			  <option>7</option>
			  <option>8</option>
			  <option>9</option>
			  <option>10</option>
			</select>
		</div>
		<div><input type="button" id="addPayBtn" value="선택" onclick="addPayment();"></div>
		<div id="payBox"></div>
		리워드 제공
		<div><input type="text" id="paymentConnection" name="pay_amount" value="" readonly="readonly"/></div>
		<div id="payment">
			<input type="button" value="펀딩하기" onclick="payment();"/>
		</div>
		
		<div>${dto.funding_content }</div>
		<div><input type="button" value="목록" onclick="location.href='funding_list.do?page=${scri.page}&perPageNum=${scri.perPageNum}&funding_filter=${scri.funding_filter}'"/></div>
	<c:if test="${memberdto.member_role eq 0}">
		<div><input type="button" value="수정" onclick="location.href='funding_updateform.do?funding_no=${dto.funding_no}'"/></div>
		<div><input type="button" value="글 삭제" onclick="fundingDelete();"/></div>
	</c:if>
	</div>
</body>
</html>
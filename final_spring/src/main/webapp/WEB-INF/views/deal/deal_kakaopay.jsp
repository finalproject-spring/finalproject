<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
 <script>
    $(function(){
        var IMP = window.IMP; // 생략가능
        IMP.init('imp02983644'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;
        
        
		var merchant_uid = 'merchant_' + new Date().getTime();
       
        
        IMP.request_pay({
            pg : 'kakaopay',
            pay_method : 'card',
            merchant_uid : merchant_uid,
            name : 'Save earth, save us',
            amount :'${dealDto.board_price}',  
            buyer_name : '${memberdto.member_id }' ,
            buyer_tel : '${memberdto.member_phone }', 
            //m_redirect_url : 'http://www.naver.com'
        },
		function(rsp) {
				console.log(rsp);
				if (rsp.success) {
					var msg = '결제가 완료되었습니다.';
					location.href='<%=request.getContextPath()%>/deal_paySuccess.do?board_no=${dealDto.board_no }&board_price=${dealDto.board_price}&merchant_uid='+merchant_uid;
				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
					location.href="<%=request.getContextPath()%>/deal_payFail.do?board_no=${dealDto.board_no }";
				}
				alert(msg);
			});
		});
	</script>
</body>
</html>
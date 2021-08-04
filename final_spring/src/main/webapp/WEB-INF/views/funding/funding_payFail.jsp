<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
		/* 페이지 제목 */
	.subjecet{
	    width: 100%;
	    height: 120px;
	   
	}
	.subjecet span{
	   margin-left: 31px;
	    font-size: 56px;
	    font-weight: 600;
	    color: #71C55D;
	    
	}
	#wrap{text-align: center; position: absolute; top: 50%; left: 50%; width: 700px; height: 500px; margin: -250px 0px 0px -350px;}
	#inside{ position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); -webkit-transform: translate(-50%, -50%); -moz-transform: translate(-50%, -50%); -o-transform: translate(-50%, -50%);}
	#admin_menu { font-size: 18px; padding-bottom: 20px; font-weight: 700}
	#menu_desc {font-size: 15px; color: #747474}
	#memberList, #paymentList{ position:relative; width: 300px; height: 280px; border: 1px solid #B5B4B4; display: inline-block; cursor: pointer; margin-top: 70px; vertical-align: middle;}
	#memberList:hover, #paymentList:hover {background-color: #ebfee6}
	#paymentList {margin-left: 70px;}
</style>

</head>
<body>
 <jsp:include page="../main/header.jsp"></jsp:include>

<div id="wrap">
<div class="subjecet">
          <span>Save earth , save us <i  style="-webkit-text-stroke: 3px  #0e3803;" class="fas fa-globe-asia"></i></span>
        </div> 
        
        <h2></h2>
		<div id="memberList" onclick="location.href='funding_list.do?funding_no=${fundingdto.funding_no }'">
			<div id="inside">
				<div id="admin_menu">결제가 취소되었습니다.</div>
				<div id="menu_desc" style="width: 190px;">다시 시도하기</div>
			</div>
		</div> 
</div>
</body>
</html>
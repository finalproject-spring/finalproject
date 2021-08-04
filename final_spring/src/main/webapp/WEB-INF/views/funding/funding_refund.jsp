<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

		
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

tbody {background-color: white;}

#innerTbody {background-color: #d5e5a3;}

/* -------------------------------------
    GLOBAL
    A very basic CSS reset
------------------------------------- */
* {
    margin: 0;
    box-sizing: border-box;
    font-size: 14px;
}

img {
    max-width: 100%;
}

body {
    -webkit-font-smoothing: antialiased;
    -webkit-text-size-adjust: none;
    width: 100% !important;
    height: 100%;
    line-height: 1.6;
}

/* Let's make sure all tables have defaults */
table td {
    vertical-align: top;
}

/* -------------------------------------
    BODY & CONTAINER
------------------------------------- */
body {
    background-color: #f6f6f6;
}

.body-wrap {
    background-color: #f6f6f6;
    width: 100%;
}

.Pcontainer {
    display: block !important;
    max-width: 600px !important;
    margin: 0 auto !important;
    /* makes it centered */
    clear: both !important;
}

.content {
    max-width: 600px;
    margin: 0 auto;
    display: block;
    padding: 20px;
}

/* -------------------------------------
    HEADER, FOOTER, MAIN
------------------------------------- */
.main {
    background: #d5e5a3;
    border: 1px solid #e9e9e9;
    border-radius: 5px;
}

.content-wrap {
    padding: 40px;
}

.content-block {
    padding: 0 0 20px;
    background-color: #d5e5a3;
}

/* .header {
    width: 100%;
    margin-bottom: 20px;
}
 */
.Pfooter {
    width: 100%;
    clear: both;
    color: #999;
    padding: 20px;
}
.Pfooter a {
    color: #999;
}
.Pfooter p, .Pfooter a, .Pfooter unsubscribe, .Pfooter td {
    font-size: 12px;
}

/* -------------------------------------
    TYPOGRAPHY
------------------------------------- */
h1, h2, h3 {
    color: #000;
    margin: 40px 0 0;
    line-height: 1.2;
    font-weight: 400;
}

h1 {
    font-size: 32px;
    font-weight: 500;
}

h2 {
    font-size: 24px;
}

h3 {
    font-size: 18px;
}

h4 {
    font-size: 14px;
    font-weight: 600;
}

p, ul, ol {
    margin-bottom: 10px;
    font-weight: normal;
}
p li, ul li, ol li {
    margin-left: 5px;
    list-style-position: inside;
}

/* -------------------------------------
    LINKS & BUTTONS
------------------------------------- */
a {
    color: #1ab394;
    text-decoration: underline;
}

.btn-primary {
    text-decoration: none;
    color: #FFF;
    background-color: #1ab394;
    border: solid #1ab394;
    border-width: 5px 10px;
    line-height: 2;
    font-weight: bold;
    text-align: center;
    cursor: pointer;
    display: inline-block;
    border-radius: 5px;
    text-transform: capitalize;
}

/* -------------------------------------
    OTHER STYLES THAT MIGHT BE USEFUL
------------------------------------- */
.last {
    margin-bottom: 0;
}

.first {
    margin-top: 0;
}

.aligncenter {
    text-align: center;
}

.alignright {
    text-align: right;
}

.alignleft {
    text-align: left;
}

.clear {
    clear: both;
}

/* -------------------------------------
    ALERTS
    Change the class depending on warning email, good email or bad email
------------------------------------- */
.alert {
    font-size: 16px;
    color: #fff;
    font-weight: 500;
    padding: 20px;
    text-align: center;
    border-radius: 3px 3px 0 0;
}
.alert a {
    color: #d5e5a3;
    text-decoration: none;
    font-weight: 500;
    font-size: 16px;
}
.alert.alert-warning {
    background: #f8ac59;
}
.alert.alert-bad {
    background: #ed5565;
}
.alert.alert-good {
    background: #1ab394;
}

/* -------------------------------------
    INVOICE
    Styles for the billing table
------------------------------------- */
.invoice {
    margin: 40px auto;
    text-align: left;
    width: 80%;
}
.invoice td {
    padding: 5px 0;
}
.invoice .invoice-items {
    width: 100%;
}
.invoice .invoice-items td {
    border-top: #eee 1px solid;
}
.invoice .invoice-items .total td {
    border-top: 2px solid #333;
    border-bottom: 2px solid #333;
    font-weight: 700;
}

/* -------------------------------------
    RESPONSIVE AND MOBILE FRIENDLY STYLES
------------------------------------- */
@media only screen and (max-width: 640px) {
    h1, h2, h3, h4 {
        font-weight: 600 !important;
        margin: 20px 0 5px !important;
    }

    h1 {
        font-size: 22px !important;
    }

    h2 {
        font-size: 18px !important;
    }

    h3 {
        font-size: 16px !important;
    }

    .Pcontainer {
        width: 100% !important;
    }

    .content, .content-wrap {
        padding: 10px !important;
    }
    
   
    .invoice {
        width: 100% !important;
    }
}
</style>

</head>
<body>
<br/><br/><br/>
 <table class="body-wrap">
 <jsp:include page="../main/header.jsp"></jsp:include>
    <tbody id="wrap"><tr>
        <td></td>
        <td class="Pcontainer" width="600">
            <div class="content">
                <table class="main" width="100%" cellpadding="0" cellspacing="0">
                    <tbody style="background-color: #d5e5a3;"><tr>
                        <td class="content-wrap aligncenter">
                            <table width="100%" cellpadding="0" cellspacing="0" style="background-color: #d5e5a3;">
                                <tbody><tr>
                                    <td class="content-block">
                                    <em style="font-style:normal; font-size:22px;font-weight:bold; white-space: nowrap; overflow: hidden;float left">${dto.member_id }님의 환불내역</em>
                                    
                                    </td>
                                </tr>
                                <tr>
                                    <td class="content-block">
                                        <table class="invoice">
                                            <tbody id="innerTbody"><tr>
                                                <td>${dto.member_id }<br>${paymentdto.merchant_uid }<br><jsp:useBean id="now" class="java.util.Date" />
												<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
 												<c:out value="${today}"/>
												</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table class="invoice-items" cellpadding="0" cellspacing="0">
                                                        <tbody style="background-color: #d5e5a3;"><tr>
                                                            <td>펀딩 제목</td>
                                                            <td class="alignright" style="  white-space: nowrap; overflow: hidden; ">${paymentdto.pay_product }</td>
                                                        </tr>
                                                        <tr>
                                                            <td>환불 수량</td>
                                                            <td class="alignright">${paymentdto.pay_count }</td>
                                                        </tr>
                                                        <tr>
                                                            <td>환불 금액</td>
                                                            <td class="alignright"> ${paymentdto.pay_price }</td>
                                                        </tr>
                                                        <tr class="total">
                                                            <td class="alignright" width="80%">Total</td>
                                                            <td class="alignright">₩ ${amount }</td>
                                                        </tr>
                                                    </tbody></table>
                                                </td>
                                            </tr>
                                        </tbody></table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="content-block">
                                        <a style="text-decoration: none; color: #1AAB8A;" href="funding_list.do">또다른 펀딩 구경하기</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="content-block">
                                        Save earth, save us
                                    </td>
                                </tr>
                            </tbody></table>
                        </td>
                    </tr>
                </tbody></table>
                <div class="Pfooter">
                    <table width="100%">
                        <tbody><tr>
                            <td class="aligncenter content-block" style="background-color: white;">Questions? Email <a href="mailto:">support@company.inc</a></td>
                        </tr>
                    </tbody></table>
                </div></div>
        </td>
        <td></td>
    </tr>
</tbody></table>
</body>
</html>
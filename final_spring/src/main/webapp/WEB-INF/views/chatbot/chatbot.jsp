<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
<script type="text/javascript">
var Chat = (function(){
    function init() {

        $(document).on('keydown', 'div.input textarea', function(e){
            if(e.keyCode == 13 && !e.shiftKey) {
                e.preventDefault();
                var message = $(this).val();
 
                sendMessage(message);

                clearTextarea();
            }
        });
        
        $(document).on('click', '#sendMsg', function(){
                var message = $('div.input textarea').val();
 
                sendMessage(message);

                clearTextarea();
        });
        
        
    }
 
    function createMessageTag(LR_className, message) {

        var chatLi = $('div.chat.format ul li').clone();
 
        chatLi.addClass(LR_className);
        chatLi.find('.message span').text(message);
 
        return chatLi;
    }
 
    function sendMessage(message) {
		var data = {
				"message" : message
			};
		
			request(data);
			
			$.ajax({
				type:"POST",
				url:"chatbot_message.do",
				data : data,
				dataType : "json",
				success : function(responseChat) {
					response(responseChat);
				}
			});
    }
    
    function request(data) {
        appendMessageTag("right", data.message);
        $('div.chat').scrollTop($('div.chat')[0].scrollHeight);
    }
	
	function response(data) {
		appendMessageTag("left", data.message);
	}
	
    function appendMessageTag(LR_className, message) {
        var chatLi = createMessageTag(LR_className, message);
        $('div.chat:not(.format) ul').append(chatLi);
        
		$("html, body").animate({ scrollTop: $(document).height() }, 500);
    }
 
 
    function clearTextarea() {
        $('div.input textarea').val('');
    }
 
    return {
        'init': init
    };
})();
 
$(function(){
    Chat.init();
});

</script>
<style type="text/css">


	*{ margin: 0; padding: 0; }
	 
	.chat_wrap .header { position:fixed; width:100%; font-size: 20px; font-weight: 500; padding: 15px 0; background: #F8F8F8; color: black; text-align: center; border-bottom: 1px solid #DDDDDD;} 
	.chat_wrap .chat { padding-top:60px; padding-bottom: 80px; }
	.chat_wrap .chat ul { width: 100%; list-style: none; }
	.chat_wrap .chat ul li { width: 100%; }
	.chat_wrap .chat ul li.left { text-align: left; }
	.chat_wrap .chat ul li.right { text-align: right; }
	.chat_wrap .chat ul li > div { font-size: 13px; }
	.chat_wrap .chat ul li > div.sender { margin: 10px 20px 0 20px; font-weight: bold; }
	.chat_wrap .chat ul li.left > div.message { 
												display: inline-block; word-break:break-all; margin: 5px 20px; max-width: 60%; border: 1px solid #E5E5EA;
												border-radius: 20px 20px 20px 0px; padding: 11px;  background-color: #E5E5EA; color: black; font-size:16px; text-align: left; } 
	.chat_wrap .chat ul li.right > div.message {
												display: inline-block; word-break:break-all; margin: 5px 20px; max-width: 60%; border: 1px solid #00CD47; 
												border-radius: 20px 20px 0px 20px; padding: 11px; background-color: #00CD47; color: white; font-size:16px; text-align: left; }

	
	.chat_wrap .input { position: fixed; bottom: 0; margin:20px; width:90%; text-align: center; border: 1px solid #DDDDDD; margin-top: 20px; }
	.chat_wrap .input textarea { width: 83%; height: 50px; border: none; padding: 11px; font-size: 15px; }
	.format { display: none; }
	#sendMsg {cursor: pointer; height: 50px; line-height: 50px; padding: 11px 15px 11px 11px; font-size: 22px; color: gray;}

</style>
</head>
<body>

<div class="chat_wrap">
	<div class="header"><i class="fas fa-robot"></i> 챗봇</div>
	<div class="chat">
		<ul>
			<li class="left">
				<div class="message">안녕하세요! save earth save us 챗봇입니다. 사이트 내 게시판 이용 안내와 환경 보호 및 분리수거 정보를 제공하고 있어요 :)</div>
			</li>
		</ul>
	</div>
	<div class="input">
        <textarea placeholder="메세지를 입력해 주세요." style="resize: none; float: left;"></textarea>
        <i class="fas fa-paper-plane" id="sendMsg"></i>
    </div>
	<div class="chat format">
		<ul>
			<li>
				<div class="message">
					<span></span>
				</div>
			</li>
		</ul>
	</div>
</div>

</body>
</html>
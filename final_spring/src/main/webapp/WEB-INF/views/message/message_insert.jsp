<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 id="modal-title" class="modal-title"></h4>
			</div>
			<div class="modal-body">
				<table class="table">
					<tr>
						<td>받는사람</td>
						<td><input class="form-control" id="message_recvid" type="text" required="required"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea class="form-control" id="message_content" rows="10" required="required"></textarea></td>
					</tr>					
				</table>
			</div>
			<div class="modal-footer">
				<button id="modalSubmit" type="button" class="btn btn-success">보내기</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
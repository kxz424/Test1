<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp"%>

<!-- Main content -->
<section class="content">
	<div class="row">
		<!-- left column -->
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">REGISTER BOARD</h3>
				</div>
				<!-- /.box-header -->
				<form role="form" method="post">
					<div class="box-body">
						<div class="form-group">
							<label for="exampleInputEmail1">Title</label> 
							<input id="title" type="text"
								name='title' class="form-control" placeholder="Enter Title"
								required="required"
								autofocus="autofocus">
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">Content</label>
							<textarea  id="content" class="form-control" name="content" rows="3"
								placeholder="Enter ..." required="required"></textarea>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Writer</label> 
							<input  id="writer" type="text" 
								name="writer" class="form-control" placeholder="Enter Writer"
								required="required">
						</div>
					</div>
					<!-- /.box-body -->
					<div class="box-footer">
						<button type="submit" class="btn btn-warning">저장</button>						
						<button type="reset" class="btn btn-danger">취소</button>
						<button type="button" class="btn btn-primary">목록</button>
					</div>					
				</form>										
			</div>
			<!-- /.box -->
		</div>
		<!--/.col (left) -->
	</div>
	<!-- /.row -->
</section>
<!-- /.content -->

<script>
	$(document).ready(function() {
		var formObj = $("form[role='form']");
		
		/* 저장 버튼 클릭 */
		$(".btn-warning").on("click", function() {
			if($("#title").val().length != 0 &&
			   $("#content").val().length != 0 &&
			   $("#writer").val().length != 0) {				
				formObj.submit();
			}
		});
		
		/* 취소 버튼 클릭 */
		$(".btn-danger").on("click", function() {
			$("#title").focus();
			formObj.reset;
		});
		
		/* 목록 버튼 클릭 */
		$(".btn-primary").on("click", function() {
			self.location = "/board/list?page=${criteria.page}&perPageNum=${criteria.perPageNum}"
				+"&searchType=${criteria.searchType}&keyword=${criteria.keyword}";
		});

	});
</script>

<%@include file="../include/footer.jsp"%>
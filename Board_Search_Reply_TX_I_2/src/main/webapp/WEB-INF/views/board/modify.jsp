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
					<h3 class="box-title">READ BOARD</h3>
				</div>
				<!-- /.box-header -->
				<form role="form" action="modify" method="post">
					<input type="hidden" name="page" value="${criteria.page}">
					<input type="hidden" name="perPageNum"
						value="${criteria.perPageNum}">
					<input type="hidden" name="searchType"
						value="${criteria.searchType}">
					<input type="hidden" name="keyword"
						value="${criteria.keyword}">
					<div class="box-body">
						<div class="form-group">
							<label for="exampleInputEmail1">BNO</label> 
							<input type="text"
								name='bno' class="form-control" value="${board.bno}"
								readonly="readonly">
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Title</label> 
							<input type="text"
								name='title' class="form-control" value="${board.title}"
								autofocus="autofocus">
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">Content</label>
							<textarea class="form-control" name="content" rows="3">${board.content}</textarea>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Writer</label> 
							<input type="text"
								name="writer" class="form-control" value="${board.writer}">
						</div>
					</div>
					<!-- /.box-body -->
				</form>
				<div class="box-footer">
					<button type="submit" class="btn btn-primary">저장</button>
					<button type="submit" class="btn btn-warning">취소</button>
				</div>
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
		$(".btn-primary").on("click", function() {
			formObj.submit();
		});
		
		/* 취소 버튼 클릭 */
		$(".btn-warning").on("click", function() {
			self.location = "/board/list?page=${criteria.page}&perPageNum=${criteria.perPageNum}"
					+"&searchType=${criteria.searchType}&keyword=${criteria.keyword}";
		});
		
	});
</script>

<%@include file="../include/footer.jsp"%>
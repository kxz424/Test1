<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
	#modDiv {
			width: 300px;
			height: 100px;
			background-color: gray;
			position: absolute;
			top: 50%;
			left: 50%;
			margin-top: -50px;
			margin-left: -150px;
			padding: 10px;
			z-index: 1000;
			display: none; /* 평상시에는 안보이다가 각 대글의 MOD버튼 선택 시 표시됨 */
		}	
		
		.pagination {
			width: 100%;
		}
		
		.pagination li{
			list-style: none;
			float: left; 
			padding: 3px; 
			border: 1px solid blue;
			margin:3px;  
		}
		
		.pagination li a{
			margin: 3px;
			text-decoration: none;  
		}

</style>

<body>
	<h2>Ajax Test Page</h2>

	<div>
		<div>
			<label>댓글 내용</label> <input type="text" name="replytext"
				id="replytext">
		</div>
		<div>
			<label>작성자</label> <input type="text" name="replyer" id="replyer">
		</div>
		<div>
			<button id="newReply">댓글 등록</button>
		</div>
	</div>


	<ul id="replies">

	</ul>

	<!-- 댓글 수정/삭제 영역 -->
	<div id='modDiv' style="display: none;">
		<div class='modal-title'></div>
		<div>
			<input type='text' id='replytext_mod'>
		</div>
		<div>
			<button type="button" id="replyModBtn">수정</button>
			<button type="button" id="replyDelBtn">삭제</button>
			<button type="button" id='closeBtn'>닫기</button>
		</div>
	</div>
	
	<!-- 댓글 페이지 번호 목록 -->
	<ul class="pagination">		
	</ul>

	<!-- jQuery 2.1.4 -->
	<!-- 아래 ul에 댓글 목록이 표시될 것임 -->
	<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>

	<!-- 댓글 목록 -->
	<script>
		getList(267, 1);
	
		function getList(bno, page) {
			
			var str = "";
			$.getJSON("/replies/" + bno + "/" + page, function(data){
				
				console.log(data);
				
				/* 
					data RestController의 리턴 값(현재는 map)
					map = list + pageMaker
					data.list : list는 map의 key에 대한 value(List<eplyVO> -> JSON(JS 객체 배열[{}, {}, ...]))
					data.pageMaker
					data.list.length : 배열의 길이
					data.pageMaker.totalCount => map의 pageMaker 객체의 getTotalCount() 메서드 호출
					data.pageMaker.cri.page => map > pageMaker > getCri() > getPage()
					this.rno : 현재 JS 객체의 rno 속성 값 읽기
				*/
				
				str += "전체 댓글 수 : " + data.pageMaker.totalCount + "<br/>";
				str += "현재 페이지 번호 : " + data.pageMaker.cri.page + "<br/>";
				
				console.log(data.list.length);
				$(data.list).each(function(){
					str += "<li data-rno = '" + this.rno + "' data-raplytext = '" + this.replytext + "' class = 'replyLi'>"
// 					str += "<li data-rno = '" + this.rno + "' class = 'replyLi'>"
					str +=		"댓글번호 : " + this.rno + "<br>"
// 					str +=		"본글번호 : " + this.bno + "<br>"
					str +=		"댓글내용 : " + this.replytext + "<br>"
// 					str +=		"작성자 : " + this.replyer + "<br>"
// 					str +=		"등록일 : " + this.regdate + "<br>"
// 					str +=		"수정일 : " + this.updatedate + "<br>"
					str +=		"<button>수정</button>"
					str += "</li>"
					
				});
				
				$("#replies").html(str);
				printPaging(data.pageMaker);
			});
		
		}
	</script>
	
	<!-- 페이지 번호 목록 -->
	<script>
		function printPaging(pageMaker){					
			var str = "";
			
			//페이지 번호에  <a> 이용
			/* if(pageMaker.prev){
				str += "<li><a href='"+(pageMaker.startPage-1)+"'> << </a></li>";
			} */
			
			/* for(var i=pageMaker.startPage, len = pageMaker.endPage; i <= len; i++){				
					var strClass= pageMaker.cri.page == i?'class=active':'';
		  			str += "<li "+strClass+"><a href='"+i+"'>"+i+"</a></li>";
				} */
			
			/* if(pageMaker.next){
					str += "<li><a href='"+(pageMaker.endPage + 1)+"'> >> </a></li>";
				} */
			
			//페이지 번호에  <button> 이용
			if(pageMaker.prev){
				str += "<li><button data='"+(pageMaker.startPage-1)+"'> << </button></li>";
			}			
			
			for(var i=pageMaker.startPage, len = pageMaker.endPage; i <= len; i++){				
				var strClass= pageMaker.cri.page == i?'class=active':'';
			  str += "<li "+strClass+"><button data='"+i+"'>"+i+"</button></li>";
			} 
			
			if(pageMaker.next){
				str += "<li><button data='"+(pageMaker.endPage + 1)+"'> >> </button></li>";
			}
			
			$('.pagination').html(str);				
		}
	</script>
	
	<!-- 페이지 번호 클릭 -->
	<script>
		var page = 1;
		
		//페이지 번호에  <a> 이용
		/*
		$(".pagination").on("click", "li a", function(event) {
			//기본 이벤트 제거(현재는 <a>의 기본 이벤트 제거)
			event.preventDefault();
			page = $(this).attr("href");
			getList(267, page);
		}); */
		
		//페이지 번호에  <button> 이용
		$(".pagination").on("click", "li button", function(event) {			
			page = $(this).attr("data");
			getList(267, page);
		});
	</script>
	

	<!-- 댓글 등록 -->
	<script>
		$("#newReply").on("click", function(){
			var replytext = $("#replytext").val();
			var replyer = $("#replyer").val();
			var bno = 267;
			
			$.ajax({
				type : "POST",
				url : "/replies",
				headers : {
					"Content-type" : "application/json", 
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : "text",
				data : JSON.stringify({
					bno : bno,
					replyer : replyer,
					replytext : replytext
				}),
				success : function(result) {
					if(result == "success") {
						alert("댓글이 등록되었습니다.");
						getList(267, 1);
					}
				}
			});
		});
	</script>
	<!-- 댓글 수정 버튼 클릭 -->
	<script>
		$("#replies").on("click", ".replyLi button", function() {
			var reply = $(this).parent();
			
			var rno = reply.attr("data-rno");
			var replytext = reply.attr("data-raplytext");
			
// 			alert(rno + " : " + replytext);

			$(".modal-title").html(rno);
			$("#replytext_mod").val(replytext);
			$("#modDiv").show("slow");
		});
	</script>
	
	<!-- 댓글 삭제 버튼 클릭 -->
	<script>
		$("#replyDelBtn").on("click", function() {
			var rno = $(".modal-title").html();
			
			$.ajax({
				type : "delete",
				url : "/replies/" + rno,
				headers : {
					"Content-Type" : "application/json",
					"x_Http-Method-Override" : "DELETE"
				},
				dataType : "text",
				success : function(result) {
					console.log("result : " + result);
					if(result == "success"){
						alert("댓글이 삭제되었습니다.");
						$("#modDiv").hide("slow");
						getList(267, 1);
					}
				}
			});
		});
	</script>
	
	<!-- 댓글 수정 버튼 클릭 -->
	<script>
		$("#replyModBtn").on("click", function() {
			var rno = $(".modal-title").html();
			var replytext = $("#replytext_mod").val();
			
			$.ajax({
				type : "put",
				url : "/replies/" + rno,
				headers : {
					"Content-Type" : "application/json",
					"x_Http-Method-Override" : "PUT"
				},
				data : JSON.stringify({replytext : replytext}),
				dataType : "text",
				success : function(result) {
					console.log("result : " + result);
					if(result == "success"){
						alert("댓글이 수정되었습니다.");
						$("#modDiv").hide("slow");
						getList(267, 1);
					}
				}
			});
		});
	</script>
	
	<!-- 댓글 닫기 버튼 클릭(책에 없음) -->
	<script>
		$("#closeBtn").on("click", function(){
			$("#modDiv").hide("slow");
// 			getList(267, 1);
		});
	</script>
	
	
	
	

</body>
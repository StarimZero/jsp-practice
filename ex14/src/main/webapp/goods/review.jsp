<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<div class="my-5">
	<div class="text-end mb-4">
		<button class="btn btn-outline-dark px-5" id="insert">즐거웠던 후기 쓰기</button>
	</div>
	<div id="div_review"></div>
</div>

	<div id="pagination" class="pagination justify-content-center mt-5"></div>
<jsp:include page="modal_review.jsp"/>

<script id="temp_review"  type="x-handlebars-templage">
		{{#each .}}
  			 <div style="display: flex; justify-content: space-between; align-items: center;">
				<div style="font-size:15px;">
					<span style="font-weight:bold;">{{uid}}</span> 
					<span style="color:gray;">{{revDate}}</span>
				</div>
				<div class="text-end mb-2" style="{{display uid}}" rid="{{rid}}">
					<button class="btn btn-primary btn-sm update" content = "{{content}}">수정</button>
					<button class="btn btn-danger btn-sm delete">삭제</button>
				</div>
			</div>
			<div  class="ellipsis content" style="cursor:pointer">
				{{rid}}-{{breaklines content}}
			</div>
 			<hr class="mb-3">
		{{/each}}
</script>
<script>
	Handlebars.registerHelper("display", function(writer){
		if(uid!=writer) return "display:none";
	});
</script>

<script>
	let page = 1;
	let size = 6;
	let gid1 = "${param.gid}";
	
	//삭제버튼을 클릭한경우
	$("#div_review").on("click", ".delete", function(){
		const rid = $(this).parent().attr("rid");
		if(!confirm(rid + "번의 리뷰를 삭제하시겠습니까?")) return;
		//삭제하기
		$.ajax({
			type:"post",
			url:"/review/delete",
			data : {rid},
			success:function(){
				alert("후기를 삭제 하였습니다.");
				getTotal();
			}
		});
	});
	
	
	//수정버튼을 클릭한경우
		$("#div_review").on("click", ".update", function(){
		const rid = $(this).parent().attr("rid");
		const content = $(this).attr("content");
		$("#modalReview").modal("show");
		$("#modalReview #content").val(content);
		$("#rid").val(rid);
		$("#btnInsert").hide();
		$("#btnUpdate").show();
		
		//수정하기
	});
	
	//모달의 수정버튼을 클릭한경우
	$("#btnUpdate").on("click", function(){
		const content=$("#content").val();
		const rid=$("#rid").val();
		//alert(rid + "\n" + content);
		if(!confirm("수정하시겠습니까?"))return;
		$.ajax({
			type:"post",
			url:"/review/update",
			data:{rid, content},
			success:function(){
				$("#modalReview").modal("hide");
				alert("수정성공");
				getTotal();
			}
		});
	});
	
	//getData();
	getTotal();
	function getData(){
		$.ajax({
			type:"get",
			url:"/review/list.json",
			dataType:"json",
			data : {page, size, gid:gid1},
			success:function(data){
				const temp=Handlebars.compile($("#temp_review").html());
				$("#div_review").html(temp(data));
			}
		});
	}

	function getTotal(){
		$.ajax({
			type:"get",
			url:"/review/total",
			data:{gid: gid1},
			success:function(data){ //이데이터는 STRING으로 받는다.
		          if (data == 0) {
		        	  getData();
		        	  $("#pagination").hide();
			        return;
				}
				const totalPage=Math.ceil(data/size);
				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				if(data>=size){
					$("#pagination").show();
				}else{
					$("#pagination").hide();
				}
			}
		});
	}
	
	//리뷰등록하기
	$("#insert").on("click", function(){
		if(uid){
			$("#content").val("");
			$("#modalReview").modal("show");
			$("#btnInsert").show();
			$("#btnUpdate").hide();
		}else{
			const target = window.location.href; 
			sessionStorage.setItem("target", target); //타겟에 현재주소를 저장하고 
			location.href="/user/login";
			//alert(target);
		}
	});
	
	$("#div_review").on("click", ".content", function(){
		$(this).toggleClass("ellipsis");
	});

	
	//본문 줄바꿈 헬퍼
	Handlebars.registerHelper('breaklines', function(text) {
	     text = Handlebars.Utils.escapeExpression(text);
	     text = text.replace(/(\r\n|\n|\r)/gm, '<br>');
	     return new Handlebars.SafeString(text);
	   });
	
	</script>
	
	<script>
	   $('#pagination').twbsPagination({
		      totalPages:10, 
		      visiblePages: 5, 
		      startPage : 1,
		      initiateStartPageClick: false, 
		      first:'<i>처음</i>', 
		      prev :'<i>이전</i>',
		      next :'<i>다음</i>',
		      last :'<i>마지막</i>',
		      onPageClick: function (event, clickPage) {
		          page=clickPage; 
		          getData();
		      }
		   });
	   
</script>
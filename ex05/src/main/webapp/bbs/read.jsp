<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="container">
	<h1>게시글읽기페이지</h1>
	<div class="card">
		<div class="card-body">
			<div>[${bbs.bid}] ${bbs.title}</div> 
			<hr>
			<div>${bbs.contents}</div>
		</div>
		<div class="card-footer text-end">
			<span>${bbs.bdate}</span>
			<span>${bbs.uname}(${bbs.writer})</span>
					<div class="text-end" id="div_update">
						<a href="/bbs/update?bid=${bbs.bid}" class="btn btn-primary">수정</a>
						<button class="btn btn-danger delete">삭제</button>
					</div>
		</div>
	</div>
</div>
<hr>

<jsp:include page="comments.jsp"/>



<script>
	//내꺼만 삭제, 수정이 보이기
	const writer="${bbs.writer}";
	if(uid==writer){
		$("#div_update").show();
	}else{
		$("#div_update").hide();
	}
	
	//삭제하기해보장
	$("#div_update").on("click", ".delete", function(){
		const bid="${bbs.bid}";
		if(confirm(bid + "번 게시글을 삭제하시겠습니까?")){
		
		//삭제할겨
			$.ajax({
				type:"post",
				url:"/bbs/delete",
				data:{bid},
				success:function(){
					alert("삭제되었습니다.")
					location.href="/bbs/list";
				}
			});
		}
	});
	
	
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>주소삭제</h1>
	<div class="text-end" id="div_update">
		<a href="/juso/update?bid=${bbs.bid}" class="btn btn-primary">수정</a>
		<button class="btn btn-danger delete">삭제</button>
	</div>
		
<script>

	//삭제하기해보장
	$("#div_update").on("click", ".delete", function(e){
		e.preventDefault();
		const uid="${jusoes.uid}";
		if(confirm(uid + "번 게시글을 삭제하시겠습니까?")){
		

		}
	});

	//삭제할겨
	$.ajax({
		type:"post",
		url:"/juso/delete",
		data:{uid},
		success:function(){
			alert("삭제되었습니다.")
			location.href="/juso/list";
		}
	});
	
	
</script>
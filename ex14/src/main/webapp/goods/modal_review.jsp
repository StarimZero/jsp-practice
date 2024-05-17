<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<!-- Modal -->
<div class="modal fade" id="modalReview" data-bs-backdrop="static"
	data-bs-keyboard="false" tabindex="-1"
	aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="staticBackdropLabel">즐거웠던 여행 후기</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<input id="rid" type="hidden">
				<textarea rows="10" class="form-control" placeholder ="솔직한 여행후기 쓰기" id="content"></textarea>
			</div>
			<div class="text-center  mt-3 mb-5">
				<button type="button" class="btn btn-secondary me-3" data-bs-dismiss="modal">등록취소</button>
				<button type="button" class="btn btn-primary" id="btnInsert">등록하기</button>
				<button type="button" class="btn btn-success" id="btnUpdate">수정하기</button>
			</div>
		</div>
	</div>
</div>

<script>
	$("#btnInsert").on("click", function(){
		const content=$("#content").val();
		if(content==""){
			alert("내용을 입력해주세요");
			$("#content").focus();
		}else{
			//alert("지아이디" + gid +"유아이디" + uid  + "\n" + content);
			//리뷰쓰기
			$.ajax({
				type:"post",
				url:"/review/insert",
				data:{uid, gid, content},
				success:function(){
					alert("후기 작성 완료");
					$("#content").val("");
					$("#modalReview").modal("hide");
					//getData();
					getTotal();
				}
			});
		}
	});
	
	
</script>

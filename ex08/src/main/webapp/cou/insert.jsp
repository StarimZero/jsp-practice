<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>

<style>
	.input-group span{
		width:150px;
	}
</style>


<div class="row my-5 justify-content-center">
	<div class="col">
		 <img src="/image/cou_pre.png" alt="이게모꼬" width="100%">
	</div>
	<div class="col-10 col-md-8 col-lg-5">
		<div class="card">
			<div class="card-header">
				<h3 class="text-center my-3">강좌 등록</h3>
			</div>
			<div class="card-body">
				<form name="frm">
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">강좌 번호</span>
						<input name="lcode" class="form-control" value="${code}" readonly>
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">강좌 이름</span>
						<input name ="lname" class="form-control">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">이수 시간</span>
						<input name ="hours" class="form-control" type="number" value="3">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">강의실</span>
						<input name ="room" class="form-control">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">최대 인원</span>
						<input name ="capacity" class="form-control" type="number" value="60">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">현재 인원</span>
						<input name ="persons" class="form-control" type="number" value="20">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">배정 교수</span>
						<input name ="instructor" class="form-control" placeholder="교수번호" readonly>
						<input name ="pname" class="form-control" placeholder="교수이름" readonly>
						<button class="btn btn-primary" type="button" id="search">검색</button>
					</div>				
					<div class="text-end mt-3">
						<button class="btn btn-danger" type="reset">다시 쓰기</button>
						<button class="btn btn-primary">강좌 등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="col">
		 <img src="/image/adver.png" alt="이게모꼬" width="100%">
	</div>
</div>
<jsp:include page="modal.jsp"/>
<script>
//검색버튼을 클릭한경우
$("#search").on("click", function(){
	$("#modal").modal("show");
});

$(frm).on("submit", function(e){
	e.preventDefault();
	const lname = $(frm.lname).val();
	const instructor=$(frm.instructor).val();
	if(lname =="" || instructor== ""){
		alert("모든 정보를 입력하세요~");
		$(frm.lname).focus();
		return;
	}
	if(confirm("새로운 강좌를 등록 하시겠습니까?")){
		frm.method="post";
		frm.submit();
	}
});
</script>



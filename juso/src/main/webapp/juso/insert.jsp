<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>주소등록입니다.</h1>
	<div id="div_list"></div>
</div>


<div class="row">
	<div class="col-8 col-md-6 col-lg-4 mt-5">
		<div class="card">
			<div class="card-header">
				<h3 class="text-center mt-3">광고자리</h3>
			</div>
		</div>
	</div>
	<div class="col-8 col-md-6 col-lg-4 mt-5">
		<div class="card">
			<div class="card-header">
				<h3 class="text-center mt-3">주소등록하기 </h3>
			</div>
			<div class="card-body">
				<form name="frm">
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">이름</span> 
						<input class="form-control" name="uname">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">주소</span>
						<input class="form-control" name="add1">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">휴대폰번호</span>
						<input class="form-control" name="phone">
					</div>
					<div class="text-center mt-2">
						<button class="btn btn-primary  px-4">주소등록하기 </button>
						<button class="btn btn-danger px-4" type="reset">다시쓰기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
	let check=false;
	$(frm).on("submit", function(e){
		e.preventDefault();
		const uname=$(frm.uname).val();
		const add1=$(frm.add1).val();
		const phone=$(frm.phone).val();
		
		if(uname=="" || add1=="" || phone==""){
			alert("모든정보를 입력하세요!");
			return;
		}
		if(confirm("주소등록 하시겠습니까?")){
			//회원가입
			$.ajax({
				type:"post",
				url:"/juso/insert",
				data:{uname, add1, phone},
				success:function(){
					alert("주소등록완료!");
					location.href="/juso/list";
				}
			});
		}
	});
</script>

	
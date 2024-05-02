<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
    	span {width:100px;}
    </style>



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
				<h3 class="text-center mt-3">Want to Join?</h3>
			</div>
			<div class="card-body">
				<form name="frm">
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">Name</span> 
						<input class="form-control" name="uname">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">I D</span>
						<input class="form-control" name="uid">
						<button type="button" class="btn btn-warning" id="btnCheck">ID Check</button>
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">Password</span>
						<input class="form-control" type="password" name="upass">
					</div>
					<div class="text-center mt-2">
						<button class="btn btn-primary  px-4">Join </button>
						<button class="btn btn-danger px-4" type="reset">Reset</button>
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
		const uid=$(frm.uid).val();
		const uname=$(frm.uname).val();
		const upass=$(frm.upass).val();
		
		if(uid=="" || uname=="" || upass==""){
			alert("모든정보를 입력하세요!");
			return;
		}
		if(!check){
			alert("아이디 중복체크를 하세요!");
			return;
		}
		if(confirm("회원가입을 하실래요?")){
			//회원가입
			$.ajax({
				type:"post",
				url:"/user/join",
				data:{uid, upass, uname},
				success:function(){
					alert("회원가입완료!");
					location.href="/user/login";
				}
			});
		}
	});
	
	//중복체크 버튼을 클릭한경우
	$("#btnCheck").on("click", function(){
		const uid=$(frm.uid).val();
		if(uid==""){
			alert("사용자 아이디를 입력하세요!");
			return;
		}
		
		$.ajax({
			type:"post",
			url:"/user/login",
			data:{uid},
			success:function(data){
				if(data==0){
					alert("사용 가능한 아이디입니다!");
					check=true;
				}else{
					alert("이미 사용중인 아이디입니다!");
				}
			}
		})
	});
	
	//아이디가 바뀐경우
	$(frm.uid).on("change", function(){
		check=false;
	});
</script>

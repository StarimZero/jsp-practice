<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
#modalpass{
	top:30%;
	}
	
#staticBackdropLabel{
	text-align :center;
	justify-content : center;
	text : center;
	text-center
}
</style>


    <div class="modal fade" id="modalpass" data-bs-backdrop="static"
	data-bs-keyboard="false" tabindex="-1"
	aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5 " id="staticBackdropLabel">Password Change</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<input id="upass" placeholder="CurrentPassword" type="password" class="form-control mb-2">
				<input id="npass" placeholder="NewPassword" type="password" class="form-control mb-2">
				<input id="cpass" placeholder="ConfirmPassword" type="password" class="form-control mb-2">
			</div>
			<div class="text-center mb-5">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Close</button>
				<button id="btnSave" class="btn btn-primary">Save</button>
			</div>
		</div>
	</div>
</div>

<script>
	$("#modalpass").on("click", "#btnSave", function(){
		const upass=$("#upass").val();
		const npass=$("#npass").val();
		const cpass=$("#cpass").val();
		if(upass=="" || npass=="" || cpass==""){
			alert("Please enter all passwords.")
		}else{
			$.ajax({
				type:"post",
				url:"/user/login",
				data:{uid, upass}, //이거 메뉴에서 설정했기떄문에 여기서 그냥쓸수 있다.
				success:function(data){
					if(data==2){
						alert("The current password does not match.")
						$("#upass").val("");
						$("#upass").focus();
					}else{
						if(npass!=cpass){//변경할 비밀번호가 일치하지 않을때 
							alert("The new password does not match.")
							$("#npass").val("");
							$("#npass").focus();
						}else{//비밀번호 변경
							if(confirm("Want to change password?")) 
								$.ajax({
									type:"post",
									url:"/user/update/pass",
									data:{uid, npass}, //키하고 값하고 변수가 같으면 ㅁㄹㄴㅇ:ㅁㄴㅇㄹ 변수생략가능
									success:function(){
										alert("Your password has been successfully changed.");
										location.href="/user/logout";//비밀번호가 변경되고 로그아웃될것.
								}
							});
						}
					}
				}
			})
		}
	});
</script>
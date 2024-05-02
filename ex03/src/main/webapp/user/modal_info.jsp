<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
#modalInfo{
	top:30%;
	}
</style>

<!-- Modal -->
<div class="modal fade" id="modalInfo" data-bs-backdrop="static"
	data-bs-keyboard="false" tabindex="-1"
	aria-labelledby="staticBackdropLabel" aria-hidden="true">
	
	
	<div class="modal-dialog text-center">
		<div class="modal-content text-center">
			<div class="modal-header text-center">
				<h1 class="modal-title fs-5 " id="staticBackdropLabel">Update Information</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<input  id="uname" class="form-control mb-2" placeholder="NAME" value=${user.uname }>
				<input id="phone" class="form-control mb-2"  placeholder="PHONE" value=${user.phone }>
				<div class="input-group">
					<input id="add1" class="form-control mb-2" value="${user.add1}">
					<button id="btnSearch" class="btn btn-primary mb-2">Address Search</button>
				</div>
				<input id="add2" class="form-control mb-2" placeholder="ADDRESS" value="${user.add2 }">
			</div>
			<div class="text-center mb-5">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Cancel</button>
				<button id="btnSave" type="button" class="btn btn-primary">SAVE</button>
			</div>
		</div>
	</div>
</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js">
</script>

<script>
	$("#btnSearch").on("click",function(){
        new daum.Postcode({
            oncomplete:function(data){
                console.log(data);
                const building=data.buildingName;
                let address="";
                if(building!=""){
                    address=data.address + "("+ building + ")";
                }else{
                    address=data.address
                }
                $("#add1").val(address);
            }
        }).open();
	});
	
	
	$("#modalInfo").on("click", "#btnSave", function(){
		const uname=$("#uname").val();
		const	phone=$("#phone").val();
		const	add1=$("#add1").val();
		const	add2=$("#add2").val();
		console.log(uname, phone, add1, add2, uid);
		if(confirm("Modify it?")){
			$.ajax({
				type:"post",
				url:"/user/update",
				data:{uid, uname, phone, add1, add2},
				success:function(){
					alert("Modify Success");
					location.href="/user/mypage";
				}
			})
			//$("#modalInfo").modal("hide");
		}
	});
</script>
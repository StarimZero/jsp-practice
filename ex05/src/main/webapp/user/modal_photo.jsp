<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  

<style>
#modalPhoto{
	top:30%;
	}
</style>


<!-- Modal -->
<div class="modal fade" id="modalPhoto" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">프로필 사진 변경</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body text-center"> <!-- div안에는 text취급된다. -->
				<img src="" id="photo" width="200">
      	<input type="file" id="file" style="display:none;">
      </div>
      <div class="text-center mb-3">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" id="btnSave">저장하기</button>
      </div>
    </div>
  </div>
</div>

<script>
	$("#file").on("change", function(e){
		//alert("성공");
		$("#photo").attr("src", URL.createObjectURL(e.target.files[0])); //0번째인파일으로 src를 바꿔라 
	});
	
	$("#photo").on("click", function(){
		$("#file").click();
	})
	
	$("#modalPhoto").on("click", "#btnSave", function(){
		if($("#file").val()==""){
			alert("프로필 사진을 선택해주세요.")
		}else{
			if(confirm("현재 선택한 사진으로 변경하시겠습니까?")){
				//사진수정
				const file=$("#file")[0].files[0]; //여러개의 파일이 있을수 있어서 배열로 정해줘야한다.  뒤에는 선택이 여러개일 수 있으니 그거도 배열로해준다. 
				const formData = new FormData();
				formData.append("photo", file);
				formData.append("uid", uid); //menu 에서 가져왔었기때문에 여기에도 쓸수 있다. 
				$.ajax({
					type : "post",
					url:"/user/upload",
					data:formData,
					processData:false,
					contentType:false,
					success:function(){
						alert("업로드성공이다이마리야");
						location.reload(true); //그냥 새로고침하기 바로 이미지적용 
					}
				});
			}
		}
	})
</script>






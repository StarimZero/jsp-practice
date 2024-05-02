<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
 
 <style>
 	.modal-body img, .card-body img{
 		border-radius:50%;
 		border : 1px solid gray;
 		cursor : pointer;
 	}
 </style>
    
    
<div class="row mt-5 justify-content-center">
	<div class="col-8 col-md-6 clo-lg-4">
		<div class = "card">
            <div class = "card-header text-center">
                <h1 class = "py-2">My Page</h1>
            </div>
            <div class = "card-body text-center">
				<div class="mb-3">
					<img src="" id="imgPhoto" width="50">
					<span class="ms-3">이름(아이디) : ${user.uname}(${user.uid})</span>
					<button class="btn btn-danger btn-sm ms-2" id="btnPass">Pass Change</button>
					<hr>
				</div>
				<div class="mb-3">
					주소 : ${user.add1} ${user.add2}
					<hr>
				</div>
				<div class="mb-3">
					전화번호 : ${user.phone}
					<hr>
				</div>
				<div class="mb-3">
					가입일 : <fmt:formatDate value="${user.jdate}" pattern="yy-MM-dd HH:mm:ss"/>
					<hr>
				</div>
				<div class="mb-3">
					수정일 : <fmt:formatDate value="${user.udate}" pattern="yy-MM-dd HH:mm:ss"/>
					<hr>
				</div>
				<div class="text-center my-3">
					<button class="btn btn-secondary px-5" id="btnInfo">Info Modification</button>
				</div>
            </div>
        </div>
	</div>
	<jsp:include page="modal_info.jsp"></jsp:include> <!--  모달을 인크루드 해주자.  -->
	<jsp:include page="modal_pass.jsp"></jsp:include> <!--  모달을 인크루드 해주자.  -->
	<jsp:include page="modal_photo.jsp"></jsp:include> <!--  모달을 인크루드 해주자.  -->
</div>
<script>
	const photo="${user.photo}";
	if(photo){
		$("#imgPhoto").attr("src", photo);
		$("#photo").attr("src", photo);
	}else{
		$("#imgPhoto").attr("src", "http://via.placeholder.com/50x50")
		$("#photo").attr("src", "http://via.placeholder.com/200x200")
	}

	$("#btnPass").on("click", function(){
		$("#modalpass").modal("show"); //이건 부트스트랩 메소드이다. modal_info.sjp에  있는것이다. 근데 인클루도했기때문에 쓸수있다. 
	}) ;
	
	$("#btnInfo").on("click", function(){
		$("#modalInfo").modal("show"); //이건 부트스트랩 메소드이다.
	}) ;
	
	$("#imgPhoto").on("click", function(){
		$("#modalPhoto").modal("show"); //이건 부트스트랩 메소드이다.
	}) ;
</script>
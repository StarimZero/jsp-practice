<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
    
<div class="row mt-5 justify-content-center">
	<div class="col-8 col-md-6 clo-lg-4">
		<div class = "card">
            <div class = "card-header text-center">
                <h1 class = "py-2">My Page</h1>
            </div>
            <div class = "card-body text-center">
				<div class="mb-3">
					Name : ${user.uname}(${user.uid})
					<button class="btn btn-danger btn-sm ms-2" id="btnPass">Pass Change</button>
					<hr>
				</div>
				<div class="mb-3">
					Address : ${user.add1} ${user.add2}
					<hr>
				</div>
				<div class="mb-3">
					Phone Number : ${user.phone}
					<hr>
				</div>
				<div class="mb-3">
					Join date : <fmt:formatDate value="${user.jdate}" pattern="yy-MM-dd HH:mm:ss"/>
					<hr>
				</div>
				<div class="mb-3">
					modified date : <fmt:formatDate value="${user.udate}" pattern="yy-MM-dd HH:mm:ss"/>
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
</div>
<script>
	$("#btnPass").on("click", function(){
		$("#modalpass").modal("show"); //이건 부트스트랩 메소드이다.
	}) ;
	
	$("#btnInfo").on("click", function(){
		$("#modalInfo").modal("show"); //이건 부트스트랩 메소드이다.
	}) ;
</script>
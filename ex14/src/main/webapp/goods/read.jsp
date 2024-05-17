<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
		.bi-arrow-through-heart-fill, .bi-arrow-through-heart{
		color:red;
		float:right;
		cursor : pointer;
	}
</style>



<h1>여행 정보</h1>

<div class="row my-5">
	<div class="col">
		<img src="${goods.image}" width="90%">
		<p>상품 ID : ${goods.gid}</p>
	</div>
	<div class="col">
		<h4>${goods.title}
			<button class="btn btn-info btn-sm" id="info" >자세한 정보보기 </button>
			<span class="bi-arrow-through-heart-fill" id="heart" gid="${goods.gid}">
				<span id="fcnt" style="font-size:15px;"></span>
			</span>
		</h4>
		<hr>
		<h5>가격 : <fmt:formatNumber value="${goods.price}" pattern="#,###원"/></h5>
		<h5>지역 : ${goods.brand }</h5>
		<h5>등록일 : ${goods.regDate}</h5>
		<h5>컨셉 : ${goods.category3}</h5>
		<h5>항공기 : 국적기</h5>
		<h5>숙박 : 3성급호텔 </h5>
		<h5>주관사 : ${goods.mallName} </h5>
		<div class="my-3 text-center">
			<button class="btn btn-primary px-5 me-3">바로구매</button>
			<button class="btn btn-warning px-5" id="cart">장바구니</button>
		</div>
	</div>
			<nav>
			 	 <div class="nav nav-tabs mb-2" id="nav-tab" role="tablist">
					<button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">여행후기</button>
					<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">여행일정</button>
					<button class="nav-link" id="nav-contact-tab" data-bs-toggle="tab" data-bs-target="#nav-contact" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">호텔&관광지</button>
					<button class="nav-link" id="nav-disabled-tab" data-bs-toggle="tab" data-bs-target="#nav-disabled" type="button" role="tab" aria-controls="nav-disabled" aria-selected="false" disabled>Disabled</button>
			  	</div>
		</nav>
				<div class="tab-content" id="nav-tabContent">
					  <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="0">
					  	<h3>여행후기입니다.</h3>
					  	<p>#아름다운 여행지 #즐거운 분위기 #전통과 문화 #찐 풍경 #친절한 배려 #행복한 경험 #환상적인 케이블카 #자연친화적 마을 #몽환적 경치 #소중한 추억</p>
					  	<jsp:include page="review.jsp"/>
					  </div>
					  <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" tabindex="0"></div>
					  <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab" tabindex="0"></div>
					  <div class="tab-pane fade" id="nav-disabled" role="tabpanel" aria-labelledby="nav-disabled-tab" tabindex="0">...</div>
				</div>
</div>
<script>
	const gid="${goods.gid}";
	const ucnt="${goods.ucnt}";
	const fcnt="${goods.fcnt}";
	//하트
	$("#fcnt").html(fcnt);
	if(ucnt==0){
		$("#heart").removeClass("bi-arrow-through-heart-fill");
		$("#heart").addClass("bi-arrow-through-heart");
	}else{
		$("#heart").removeClass("bi-arrow-through-heart");
		$("#heart").addClass("bi-arrow-through-heart-fill");
	}
	
	//빈하트를 눌렀을때 
	$(".bi-arrow-through-heart").on("click", function(){
		const gid=$(this).attr("gid");
		if(uid){
			//alert(uid + "::::::::::::" + gid);
			//좋아요 인서트
			$.ajax({
				type:"post",
				url:"/favorite/insert",
				data:{uid, gid},
				success:function(){
					alert("좋아요!");
					//location.href="/goods/read?gid="+gid;
					location.reload(true);
				}
			});
		}else{
			const target = window.location.href;//돌아올주소
			//sessionStorage.setItem("target", "/goods/read/gid=" + gid);
			sessionStorage.setItem("target", target);
			location.href="/user/login";
		}
	});
	
	//채워진 하트를 클릭한경우
	$(".bi-arrow-through-heart-fill").on("click", function(){
		const gid=$(this).attr("gid");
		//alert(uid + "::::::::::::" + gid);
		//좋아요 인서트
		$.ajax({
			type:"post",
			url:"/favorite/delete",
			data:{uid, gid},
			success:function(){
				alert("싫어요!");
				//location.href="/goods/read?gid="+gid;
				location.reload(true);
			}
		});
	});
	
	
	
	//장바구니 버튼 눌렀을때 . 
	$("#cart").on("click", function(){
		if(uid){
			//장바구니 넣기
			$.ajax({
				type:"post",
				url:"/cart/insert",
				data:{uid, gid},
				success:function(data){
					let message="";
					if(data=="true"){
						message = "장바구니에 넣었습니다.";
					}else{
						message = "장바구니에 있는 상품입니다.";
					}
					if(confirm(message + "\n장바구니로 이동하시겠습니까?")){
						location.href = "/cart/list";
					}else{
						location.href + "/";
					}
				}
			});
		}else{
			sessionStorage.setItem("target", "/goods/read?gid="+gid);
			location.href="/user/login";
		}
	});

</script>
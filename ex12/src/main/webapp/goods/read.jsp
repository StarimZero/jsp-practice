<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<h1>여행 정보</h1>

<div class="row my-5">
	<div class="col">
		<img src="${goods.image}" width="90%">
		<p>상품 ID : ${goods.gid}</p>
	</div>
	<div class="col">
		<h4>${goods.title}<button class="btn btn-info btn-sm" id="info">자세한 정보보기 </button></h4>
		<hr>
		<h5>가격 : <fmt:formatNumber value="${goods.price}" pattern="#,###원"/></h5>
		<h5>지역 : ${goods.brand }</h5>
		<h5>등록일 : ${goods.regDate}</h5>
		<h5>컨셉 : ${goods.category3}</h5>
		<h5>항공기 : 국적기</h5>
		<h5>숙박 : 3성급호텔 </h5>
		<h5>주관사 : ${goods.mallName} </h5>
		<div class="my-3 text-center">
			<button class="btn btn-primary btn-sm">바로구매</button>
			<button class="btn btn-warning btn-sm" id="cart">장바구니</button>
		</div>
	</div>
</div>
<script>
	const gid="${goods.gid}";
	$("#cart").on("click", function(){
		if(uid){
			//장바구니 넣기
			$.ajax({
				type:"post",
				url:"/cart/insert",
				data:{uid, gid},
				success:function(data){
					if(data=="true"){
						alert("장바구에 넣었습니다!");
					}else{
						alert("장바구에 있는 상품입니다!")
					}
				}
			});
		}else{
			sessionStorage.setItem("target", "/goods/read?gid="+gid);
			location.href="/user/login";
		}
	});
</script>
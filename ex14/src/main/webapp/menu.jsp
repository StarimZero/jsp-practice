<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<nav class="navbar navbar-expand-lg"   style="background-color: #ffd59f;">
	<div class="container-fluid" >
		<!-- <a class="navbar-brand" href="/">홈으로가기 </a> -->
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item" id="search-item"><a class="nav-link active" aria-current="page" href="/goods/search" style="color: #57b0ff">상품 검색</a></li>
				<li class="nav-item" id="list-item"><a class="nav-link active" aria-current="page" href="/goods/list" style="color: #cf0055">상품 목록</a></li>
			</ul>
			
			<ul class="navbar-nav mb-2 mb-lg-0"> <!-- 마진엔드-오토 빼기 -->
				<li class="nav-item" id="login"><a class="nav-link active" aria-current="page" href="/user/login" style="color: #af273f">로그인</a></li>
				<li class="nav-item" id ="uid"><a class="nav-link active" aria-current="page" href="/pro/list" style="color: #2bd47b"></a></li><!-- users라고하면 원래 users에 있던거 (/) 가 실행된다. -->
				<li class="nav-item" id="logout"><a class="nav-link active" aria-current="page" href="/user/logout" style="color: #af273f">로그아웃</a></li>
				<li class="nav-item" id="cart-item"><a class="nav-link active" aria-current="page" href="/cart/list" style="color: #cf0055">장바구니</a></li>
			</ul>
		</div>
	</div>
</nav>

  <script>  //메뉴에서 로그인 로그아웃 표시해주기 
  	const uid="${user.uid}";
  	const uname="${user.uname}"; // vo를 들거와서 이름 들거와보자 
  	//alert(uid);
  	if(uid){
  		$("#login").hide();
  		$("#logout").show();
  		$("#uid a").html(uname + "님");
  		$("#cart-item").show();
  	}else{
  		$("#login").show();
  		$("#logout").hide();
  		$("#uid").hide();
  		$("#cart-item").hide();
  	}
  	$("#logout").on("click", "a", function(e){
  		e.preventDefault();
  		if(confirm("로그아웃 하시겠습니까?")){
  			sessionStorage.clear();
  			location.href="/user/logout";
  		}
  	});
  	
  	if(uid=="admin"){
  		$("#search-item").show();
  		$("#list-item").show();
  		$("#cart-item").hide();
  	}else{
 		$("#search-item").hide();
  		$("#list-item").hide();
  	}
 
  </script>
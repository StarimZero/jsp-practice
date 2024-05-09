<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<nav class="navbar navbar-expand-lg"   style="background-color: #000;">
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
				<li class="nav-item"><a class="nav-link active" aria-current="page" href="/pro/list" style="color: #dcab33">교수 목록</a></li>
				<li class="nav-item"><a class="nav-link active" aria-current="page" href="/pro/insert" style="color: #dcab33">교수 등록</a></li>
				<li class="nav-item"><a class="nav-link active" aria-current="page" href="/stu/list" style="color: #41d73c">학생 관리</a></li>
				<li class="nav-item"><a class="nav-link active" aria-current="page" href="/stu/insert" style="color: #41d73c">학생 등록</a></li>
				<li class="nav-item"><a class="nav-link active" aria-current="page" href="/cou/list"  style="color: #fffd33">강좌 관리 </a></li>
				<li class="nav-item"><a class="nav-link active" aria-current="page" href="/cou/insert"  style="color: #fffd33">강좌 등록 </a></li>
			</ul>
			
			<ul class="navbar-nav mb-2 mb-lg-0"> <!-- 마진엔드-오토 빼기 -->
				<li class="nav-item" id="login"><a class="nav-link active" aria-current="page" href="/user/login" style="color: #af273f">로그인</a></li>
				<li class="nav-item" id = "myPage" style="display:none;"><a class="nav-link active" aria-current="page" href="/user/mypage" style="color: #2bd47b"></a></li><!-- users라고하면 원래 users에 있던거 (/) 가 실행된다. -->
				<li class="nav-item" id="logout"><a class="nav-link active" aria-current="page" href="/user/logout" style="color: #af273f">로그아웃</a></li>
			</ul>
		</div>
	</div>
</nav>

  <script>  //메뉴에서 로그인 로그아웃 표시해주기 
    	const uid ="${user.uid}"; //세션의 값을 uid에서 꺼내왔다. vo 도 들고 올 수 있을까? 도전-> {userInfo.uid}
	const uname = "${user.uname}" // vo를 들거와서 이름 들거와보자 
    $("#myPage").on("click", "a", function(e){
      e.preventDefault();
      location.href="/user/mypage?uid=" + uid;
      //alert(uid);
      // $.ajax({
      //   type:"get",
      //   url:"/users/mypage",
      //   data:{uid},
      //   success:function(data){
      //     console.log(data);
          
      //   }
      // });
    });
    if(uid){
        $("#login").hide();
        $("#logout").show();
        $("#myPage").show();
        $("#myPage a").html(uname + "님 환영합니다."); //myPage에 있는 a태그인걸 html로 로그인한 유저아이디를 넣어주겠다. -> 이름을 넣어주겠다 
    }else{
        $("#login").show();
        $("#logout").hide();
        $("#myPage").hide();
    }
    // 로그아웃 메뉴를 클릭할때 
    $("#logout").on("click", "a", function(e){ //a태그는 어디로 갈려하니까 일단 막자 
        e.preventDefault();
        if(confirm("로그아웃 하시겠습니까?")){
            //sessionStorage.clear();
            location.href="/user/logout"; //어디로 이동시킬거면 써라 이거없으면 로그아웃안되네..?
        }
    });

  </script>
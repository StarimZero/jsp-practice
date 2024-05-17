<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

    <style>
    	span {width:100px;}
    </style>
    
<div class="row mt-5 justify-content-center">
	<div class="col-8 col-md-6 col-lg-5">
		<div class = "card">
            <div class = "card-body">
            	<h1>로그인</h1>
            	<form name="frm">
            		<div class="input-group mb-3">
            		<span class="input-group-text justify-content-center">I D</span>
            		<input  class="form-control" name ="uid">
            		</div>
            		<div class="input-group mb-3">
            		<span class="input-group-text  justify-content-center"  >Password</span>
            		<input  class="form-control" name="upass" type="password">
            		</div>
            		<button class = "btn btn-primary w-100">로그인</button>
            		<div>
            			<input type="checkbox" class="mx-1">로그인 상태 유지 
            		</div>
            		<hr>
            		<div class="div class=container justify-content-center">
            		<a class="btn btn-danger mx-2" href="https://google.com" target="_blank">login With Google</a>
            		<a class="btn btn-success mx-2" href="https://naver.com" target="_blank">login With Naver</a>
            		<a class = "btn btn-warning mx-2" href="https://www.kakaocorp.com/page/" target="_blank">login With Kakao</a>
            		</div>
            		<hr>
            		<div class="text-center">
            		<a href="https://naver.com" target="_blank">Forget ID?</a><br>
            		<a href="https://gemini.google.com/app" target="_blank">Forget Password?</a><br>
            		<a href="/user/join">Create Account</a>
            		</div>
            	</form>
            </div>
        </div>
	</div>
</div>

<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		const uid=$(frm.uid).val();
		const upass=$(frm.upass).val();
		if(uid==""){
			alert("아이디를 입력하세요!");
			$(frm.uid).focus();
			return;
		}
		if(upass==""){
			alert("비밀번호를 입력하세요!");
			$(frm.upass).focus();
			return;
		}
		//로그인체크
        	$.ajax({
            	type : "post", //post를찾아나선다.
            	url : "/user/login", // users/login이 아니다. -> 원래 /login 이였는데(index.js에 있어서) users로 옮겼기 때문에 /users/login 가 됐다. 
            	data : {uid, upass}, //키랑 변수랑같으면 생략가능
           		success : function(data){ //js에서 나온 결과가 data이다.  data는 변수다. 정해진것은 함수정의까지다. 
                		console.log(data);
            			//alert(data);
      
				if(data==1){
					//alert("성공")
					sessionStorage.setItem("uid", uid);
					sessionStorage.setItem("uname", uname);
					//alert(uname);
					const target=sessionStorage.getItem("target");
					if(target){
						location.href=target;
					}else{
						location.href="/";	
					}
					
				}else if(data==2){
					alert("비밀번호가 일치하지 않습니다.");
					$(frm.upass).val("");
					$(frm.upass).focus();
				}else if(data==0){
					alert("아이디가 존재하지 않습니다.");
					$(frm.uid).val("");
					$(frm.uid).focus();
               		}
           		}
       	 });
	});
</script>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
    	span {width:100px;}
    </style>
    
<div class="row mt-5 justify-content-center">
	<div class="col-8 col-md-6 col-lg-5">
		<div class = "card">
            <div class = "card-body">
            	<h1>Want Login?</h1>
            	<form name="frm">
            		<div class="input-group mb-3">
            		<span class="input-group-text justify-content-center">I D</span>
            		<input  class="form-control" name ="uid">
            		</div>
            		<div class="input-group mb-3">
            		<span class="input-group-text  justify-content-center"  >Password</span>
            		<input  class="form-control" name="upass" type="password">
            		</div>
            		<button class = "btn btn-primary w-100">Login</button>
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
	$(frm.uid).focus();
    	$(frm).on("submit", function(e){
        e.preventDefault();
        const uid = $(frm.uid).val(); //frm에있는 uid를 받아서 val값을 uid변수에 저장하기
        const upass = $(frm.upass).val();
        if(uid == "" || upass == ""){
            alert("아이디 또는 비밀번호를 입력하세요.");
            $(frm.uid).focus();//커서가 여기서 깜빡이게 하기. 
            // return;
        }
        else{//로그인체크
            $.ajax({
                type : "post", //post를찾아나선다.
                url : "/user/login", // users/login이 아니다. -> 원래 /login 이였는데(index.js에 있어서) users로 옮겼기 때문에 /users/login 가 됐다. 
                data : {uid, upass}, //키랑 변수랑같으면 생략가능
                success : function(data){ //js에서 나온 결과가 data이다.  data는 변수다. 정해진것은 함수정의까지다. 
                    console.log(data);
                		//alert(data);
				if(data==1){
						//alert("성공")
						let target=sessionStorage.getItem("target");
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
        }
    });
</script>


<!-- if(data == "0") {
                    alert("아이디가 존재하지 않습니다.")
                    $(frm.uid).val("");
                    $(frm.uid).focus();
                   }else if(data == "2"){
                    alert("비밀번호가 맞지 않습니다.")
                    $(frm.upass).val(""); //이거 result가 2이면 비밀번호값을 공백으로 지워주는 것
                    $(frm.upass).focus();
                   }else{
                    alert("로그인에 성공하였습니다. ");
                    sessionStorage.setItem('uid', uid); //uid를 uid의 변수에 저장
                    location.href=('/'); //저장하고 장소를 이동한다. 루트로  -->
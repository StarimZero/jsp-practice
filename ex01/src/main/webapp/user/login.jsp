<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row mt-5 justify-content-center">
	<div class="col-8 col-md-6 clo-lg-4">
		<div class = "card">
            <div class = "card-header text-center">
                <h1 class = "py-2">로그인</h1>
            </div>
            <div class = "card-body">
                <form action="" name = "frm" method="post">
                    <input name = "uid" type="text" placeholder="아이디" class="form-control mb-3">
                    <input name = "upass" type="password" placeholder="비밀번호" class="form-control mb-3">
                    <button class = "btn btn-primary w-100">로그인</button>
                </form>
            </div>
        </div>
	</div>
</div>

<script>
	$(frm.uid).focus();
    $(frm).on("submit", function(e){
        e.preventDefault();
        let uid = $(frm.uid).val(); //frm에있는 uid를 받아서 val값을 uid변수에 저장하기
        let upass = $(frm.upass).val();
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
                   if(data == "0") {
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
                    location.href=('/'); //저장하고 장소를 이동한다. 루트로 
                   }
                }
            })
        }
    })
</script>
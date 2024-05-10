<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>

<style>
	.input-group span{
		width:150px;
	}
</style>


<div class="row my-5 justify-content-center">
	<div class="col">
		 <img src="/image/cou_pre.png" alt="이게모꼬" width="100%">
	</div>
	<div class="col-10 col-md-8 col-lg-5">
		<div class="card">
			<div class="card-header">
				<h3 class="text-center my-3">강좌 등록</h3>
			</div>
			<div class="card-body">
				<form name="frm">
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">강좌 번호</span>
						<input name="lcode" class="form-control"  value=""  readonly id="number">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">강좌 이름</span>
						<input name ="lname" class="form-control">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">이수 시간</span>
						<input name ="hours" class="form-control" type="number" value="3">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">강의실</span>
						<input name ="room" class="form-control">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">최대 인원</span>
						<input name ="capacity" class="form-control" type="number" value="60">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">현재 인원</span>
						<input name ="persons" class="form-control" type="number" value="20">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">배정 교수</span>
						<input name ="instructor" class="form-control" placeholder="교수번호" readonly>
						<input name ="pname" class="form-control" placeholder="교수이름" readonly>
						<button class="btn btn-primary" type="button" id="search">검색</button>
					</div>				
					<div class="text-end mt-3">
						<button class="btn btn-danger" type="reset">다시 쓰기</button>
						<button class="btn btn-primary" id="divWrite">강좌 등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="col">
		 <img src="/image/adver.png" alt="이게모꼬" width="100%">
	</div>
</div>
<jsp:include page="modal.jsp"/>
<script>
//검색버튼을 클릭한경우
$("#search").on("click", function(){
	$("#modal").modal("show");
});

$(frm).on("submit", function(e){
	e.preventDefault();
	const lname = $(frm.lname).val();
	const instructor=$(frm.instructor).val();
	if(lname =="" || instructor== ""){
		alert("모든 정보를 입력하세요~");
		$(frm.lname).focus();
		return;
	}
	if(confirm("새로운 강좌를 등록 하시겠습니까?")){
		frm.method="post";
		frm.submit();
	}
});
</script>

<script> //글쓰기 보이기 안보이기 아이템을 안가져와도 되는이유는 메뉴에서 이미 가져오기때문이다.  //기본으로 숨겨놓고 아이디가 있으면 보이고 없으면 숨기기 한것.
    if (uid) {
        $("#divWrite").show();
    }//그러니까 else가 사실 피료없다.  근데 jsp에서는 있어야 한다. 
     else{
         $("#divWrite").hide();
     }
	$(frm).on("submit", function(e){
		 e.preventDefault();
		 query=$(frm.query).val();
//		 alert(query);
		getTotal();
	});
	
	
	//랜덤값을 생성하는 함수추가
	function random(min, max) {
 		 min = Math.ceil(min);
 		 max = Math.floor(max);
 	 return Math.floor(Math.random() * (max - min + 1)) + min;
	} 
	// 알파벳 목록
	const alpha = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'O', 'P'];
	
	// 랜덤 알파벳 선택
	const randomIndex = Math.floor(Math.random() * alpha.length);
	const randomA = alpha[randomIndex];
	
	// 랜덤 숫자 생성
	const ranint= random(100, 999);
	
	// 랜덤 문자열 만들기
	const randomString = randomA + ranint;
	
	// input 태그 선택
	const input = document.querySelector("#number");
	
	// input 태그의 value 속성 설정
	input.value = randomString;
	
	console.log(randomString);

</script>





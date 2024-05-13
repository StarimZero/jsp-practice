<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>

<style>
	.input-group span{
		width:150px;
	}
</style>


<div class="row my-5 justify-content-center">
	<div class="col">
		 <img src="/image/stu_pre.png" alt="이게모꼬" width="100%">
	</div>
	<div class="col-10 col-md-8 col-lg-5">
		<div class="card">
			<div class="card-header">
				<h3 class="text-center my-3">학생 등록</h3>
			</div>
			<div class="card-body">
				<form name="frm">
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">학생 번호</span>
						<input name="scode" class="form-control" value="${code}" readonly>
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">학생 이름</span>
						<input name ="sname" class="form-control">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">학생 학과</span>
						<select name ="dept" class="form-control">
							<option value="전산">컴퓨터정보공학과</option>
							<option value="전자">전자공학과</option>
							<option value="건축">건축공학과</option>
							<option value="경제">경제학과</option>
						</select>
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">학생 학년</span>
						<div class=form-check>
							<input value = "1"name="year" class="form-check-input my-2 mx-1" type="radio" checked>
							<label class="form-check-label  my-2">1학년</label>
						</div>
						<div class=form-check>
							<input value = "2" name="year" class="form-check-input  my-2 mx-1" type="radio">
							<label class="form-check-label  my-2">2학년</label>
						</div>
						<div class=form-check>
							<input value = "3" name="year" class="form-check-input  my-2 mx-1" type="radio">
							<label class="form-check-label  my-2">3학년</label>
						</div>
						<div class=form-check>
							<input value = "4" name="year" class="form-check-input my-2 mx-1" type="radio">
							<label class="form-check-label  my-2">4학년</label>
						</div>
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">지도 교수</span>
						<input name ="advisor" class="form-control" placeholder="교수번호" readonly>
						<input name ="pname" class="form-control" placeholder="교수이름" readonly>
						<button class="btn btn-primary" type="button" id="search">검색</button>
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">생년월일</span>
						<input name = "birthday" class="form-control" type="date" value="2005-02-28">
					</div>					
					<div class="text-end mt-3">
						<button class="btn btn-danger" type="reset">다시 쓰기</button>
						<button class="btn btn-primary" id="divWrite">학생 등록</button>
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
		const sname = $(frm.sname).val();
		const advisor=$(frm.advisor).val();
		if(sname=="" || advisor== ""){
			alert("모든 정보를 입력하세요~");
			$(frm.sname).focus();
			return;
		}
		if(confirm("새로운 학생를 등록 하시겠습니까?")){
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
</script>
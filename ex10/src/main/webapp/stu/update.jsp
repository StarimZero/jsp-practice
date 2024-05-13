<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
				<h3 class="text-center my-3">학생 수정</h3>
			</div>
			<div class="card-body">
				<form name="frm">
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">학생 번호</span>
						<input name="scode" class="form-control" value="${stu.scode}" readonly>
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">학생 이름</span>
						<input name ="sname" class="form-control" value="${stu.sname}">
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">학생 학과</span>
						<select name ="dept" class="form-control">
							<option value="전산" <c:out value="${stu.sdept=='전산'?'selected':''}"/>>컴퓨터정보공학과</option>
							<option value="전자" <c:out value="${stu.sdept=='전자'?'selected':''}"/>>전자공학과</option>
							<option value="건축" <c:out value="${stu.sdept=='건축'?'selected':''}"/>>건축공학과</option>
							<option value="경제" <c:out value="${stu.sdept=='경제'?'selected':''}"/>>경제학과</option>
						</select>
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">학생 학년</span>
						<div class=form-check>
							<input <c:out value="${stu.year=='1'?'checked':''}"/> value = "1"name="year" class="form-check-input my-2 mx-1" type="radio" checked>
							<label class="form-check-label  my-2">1학년</label>
						</div>
						<div class=form-check>
							<input <c:out value="${stu.year=='2'?'checked':''}"/> value = "2" name="year" class="form-check-input  my-2 mx-1" type="radio">
							<label class="form-check-label  my-2">2학년</label>
						</div>
						<div class=form-check>
							<input <c:out value="${stu.year=='3'?'checked':''}"/>  value = "3" name="year" class="form-check-input  my-2 mx-1" type="radio">
							<label class="form-check-label  my-2">3학년</label>
						</div>
						<div class=form-check>
							<input <c:out value="${stu.year=='4'?'checked':''}"/> value = "4" name="year" class="form-check-input my-2 mx-1" type="radio">
							<label class="form-check-label  my-2">4학년</label>
						</div>
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">지도 교수</span>
						<input value="${stu.advisor}" name ="advisor" class="form-control" placeholder="교수번호" readonly>
						<input value="${stu.pname}" name ="pname" class="form-control" placeholder="교수이름" readonly>
						<button class="btn btn-primary" type="button" id="search">검색</button>
					</div>
					<div class="input-group mb-2">
						<span class="input-group-text justify-content-center">생년월일</span>
						<input value="${stu.birthday}" name = "birthday" class="form-control" type="date" value="2005-02-28">
					</div>					
					<div class="text-end mt-3">
						<button class="btn btn-danger" type="reset">다시 쓰기</button>
						<button class="btn btn-primary">학생 수정</button>
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
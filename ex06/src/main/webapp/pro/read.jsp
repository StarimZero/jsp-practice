<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<div class="row">
	<div class="col">
		<div><h1>교수정보</h1></div>
		<table class="table table-bordered">
			<tr>
				<td class="title">교수 번호</td>
				<td>${pro.pcode}</td>
				<td class="title">교수 이름</td>
				<td>${pro.pname}</td>
				<td class="title">교수 학과</td>
				<td>${pro.dept}</td>
			</tr>
			<tr>
				<td class="title">임용 일자</td>
				<td>${pro.hiredate}</td>
				<td class="title">교수 직급</td>
				<td>${pro.title}</td>
				<td class="title">교수 급여</td>
				<td>${pro.salary}</td>
			</tr>
		</table>
		<div class="text-center my-5">
			<button class="btn btn-primary me-3">교수 수정</button>
			<button class="btn btn-danger" id="delete">교수 제외</button>
		</div>
	</div>
</div>

<script>
	$("#delete").on("click", function(){
		const pcode="${pro.pcode}";
		if(confirm(pcode + "번 교수를 삭제하시겠습니까?")){
			//교수삭제
			$.ajax({
				type:"post",
				url:"/pro/delete",
				data:{pcode},
				success:function(data){
					if(data==1){
						alert("삭제완료!");
						location.href="/pro/list";
					}else{
						alert("삭제 실패하였습니다.");
					}
					
				}
			})
		}
		
	});
</script>






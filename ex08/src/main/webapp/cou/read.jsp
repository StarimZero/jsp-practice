<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row">
	<div class="col">
		<div><h1>강좌정보</h1></div>
		<table class="table table-bordered">
			<tr>
				<td class="title">강좌번호</td>
				<td>${cou.lcode}</td>
				<td class="title">강좌이름</td>
				<td>${cou.lname}</td>
				<td class="title">이수시간</td>
				<td>${cou.hours}</td>
			</tr>
			<tr>
				<td class="title">강의실</td>
				<td>${cou.room}호</td>
				<td class="title">인원수</td>
				<td>${cou.persons}/${cou.capacity}명</td>
				<td class="title">지도교수</td>
				<td>${cou.pname}</td>
			</tr>
		</table>
		<div class="text-center my-5">
			<button class="btn btn-primary" id="update">강좌수정</button>
			<button class="btn btn-danger" id="delete">강좌삭제</button>
		</div>
	</div>
</div>

<script>
//삭제를 눌렀을때. 
$("#delete").on("click", function(){
	const lcode="${cou.lcode}";
	if(confirm(lcode + "의 강좌를 삭제하시겠습니까?")){
		//학생삭제
		$.ajax({
			type:"post",
			url:"/cou/delete",
			data:{lcode},
			success:function(data){
				if(data==1){
					alert("삭제완료!");
					location.href="/cou/list";
				}else{
					alert("삭제 실패하였습니다. - 수강신청내역이 존재합니다.");
				}
				
			}
		})
	}
	
});
//수정을 눌렀을때 
$("#update").on("click", function(){
	const lcode="${cou.lcode}";
	location.href="/cou/update?lcode=" + lcode;
	
})
</script>
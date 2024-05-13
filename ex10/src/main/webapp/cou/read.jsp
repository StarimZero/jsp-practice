<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.table{
		width : 70%;
		margin : auto;
		text-align : center;
	}
	#title{
	background-color: #eee;
	}

</style>
<div class="row">
	<div class="col">
		<div><h1>강좌정보</h1></div>
		<table class="table table-bordered">
			<tr>
				<td class="title" id="title">강좌번호</td>
				<td>${cou.lcode}</td>
				<td class="title" id="title">강좌이름</td>
				<td colspan="5"  align="center">${cou.lname}</td>

			</tr>
			<tr>
				<td class="title" id="title">강의실</td>
				<td>${cou.room}호</td>
				<td class="title" id="title">인원수</td>
				<td>${cou.persons}/${cou.capacity}명</td>
				<td class="title" id="title">지도교수</td>
				<td>${cou.pname}</td>
				<td class="title"  id="title">이수시간</td>
				<td>${cou.hours}</td>
			</tr>
		</table>
		<div class="text-end my-5">
			<button class="btn btn-primary" id="update">강좌수정</button>
			<button class="btn btn-danger" id="delete">강좌삭제</button>
		</div>
	</div>
</div>

<jsp:include page="info.jsp"/>

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
<script> //글쓰기 보이기 안보이기 아이템을 안가져와도 되는이유는 메뉴에서 이미 가져오기때문이다.  //기본으로 숨겨놓고 아이디가 있으면 보이고 없으면 숨기기 한것.
    if (uid) {
        $("#update").show();
    }//그러니까 else가 사실 피료없다.  근데 jsp에서는 있어야 한다. 
     else{
         $("#update").hide();
     }
    if (uid) {
        $("#delete").show();
    }//그러니까 else가 사실 피료없다.  근데 jsp에서는 있어야 한다. 
     else{
         $("#delete").hide();
     }

</script>


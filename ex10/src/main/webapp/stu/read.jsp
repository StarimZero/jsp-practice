<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		<div><h1>학생정보</h1></div>
		<table class="table table-bordered">
			<tr>
				<td class="title" id="title">학생번호</td>
				<td>${stu.scode}</td>
				<td class="title" id="title">학생이름</td>
				<td>${stu.sname}</td>
				<td class="title" id="title">교수학과</td>
				<td>${stu.sdept}</td>
			</tr>
			<tr>
				<td class="title" id="title">생년월일</td>
				<td>${stu.birthday}</td>
				<td class="title" id="title">학생학년</td>
				<td>${stu.year}학년</td>
				<td class="title" id="title">지도교수</td>
				<td>${stu.pname}(${stu.advisor})</td>
			</tr>
		</table>
		<div class="text-end my-5">
			<button class="btn btn-primary" id="update">학생수정</button>
			<button class="btn btn-danger" id="delete">학생삭제</button>
		</div>
	</div>
</div>
<hr>
<jsp:include page="info.jsp"/>

<script>
	//삭제를 눌렀을때. 
	$("#delete").on("click", function(){
		const scode="${stu.scode}";
		if(confirm(scode + "학번의 학생을 삭제하시겠습니까?")){
			//학생삭제
			$.ajax({
				type:"post",
				url:"/stu/delete",
				data:{scode},
				success:function(data){
					if(data==1){
						alert("삭제완료!");
						location.href="/stu/list";
					}else{
						alert("삭제 실패하였습니다. - 수강신청내역이 존재합니다.");
					}
					
				}
			})
		}
		
	});
	//수정을 눌렀을때 
	$("#update").on("click", function(){
		const scode="${stu.scode}";
		location.href="/stu/update?scode=" + scode;
		
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






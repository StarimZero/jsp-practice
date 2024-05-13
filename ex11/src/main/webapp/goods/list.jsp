<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div>
	<h1>상품목록</h1>
	<div id="div_shop"></div>
</div>

<script id="temp_shop"  type="x-handlebars-templage">
	<table class="table table-bordered table-hover table-success" style ="text-align: center;">
		<tr class="text-center">
			<td><input type="checkbox" id="all"></td>
			<td>상품 아이디</td>
			<td>상품명</td>
			<td>상품가격</td>
			<td>이미지</td>
			<td>상품삭제</td>
		</tr>
		{{#each .}}
		<tr>
			<td><input type="checkbox" id="chk"></td>
			<td>{{gid}}</td>
			<td>
				<div class="ellipsis">{{{title}}}</div>
				<div>{{regDate}}</div>
			</td>
			<td>{{price}}원</td>
			<td><img src = {{image}} width="50"></td>
			<td><button class="btn btn-danger delete" gid="{{gid}}">삭제</button></td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	getData();
	
	//삭제를 누른경우
	$("#div_shop").on("click", ".delete", function(){
		const gid=$(this).attr("gid");
		if(confirm(gid + "번 상품을 삭제하시겠습니까?")){
			//삭제하기
			$.ajax({
				type:"post",
				url:"/goods/delete",
				data:{gid},
				success:function(data){
					if(data=="true"){
						alert("삭제성공");
						getData();
					}else{
						alert("삭제실패");
					}
				}
			});
		}
			
	});
	function getData(){
		$.ajax({
			type:"get",
			url:"/goods/list.json",
			dataType:"json",
			success:function(data){
				const temp=Handlebars.compile($("#temp_shop").html());
				$("#div_shop").html(temp(data));
			}
		});
	}
</script>
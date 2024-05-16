<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div>
	<h1>장바구니</h1>
	<div id="div_cart"></div>
</div>

<script id="temp_cart"  type="x-handlebars-templage">
	<table class="table table-bordered table-dark table-hover" style ="text-align: center;">
		<tr class="text-center">
			<td><input type="checkbox" id="all" ></td>
			<td>상품번호</td>
			<td>상품이름</td>
			<td>가격</td>
			<td>수량</td>
		</tr>
		{{#each .}}
		<tr>
			<td><input type="checkbox" class="chk" gid="{{gid}}"></td>
			<td>{{gid}}</td>
			<td class="text-start" >
				<img src="{{image}}" style = "width : 50px;  height: auto; aspect-ratio: 4/3;">
				<a href="/goods/read?gid={{gid}}" style = "text-decoration : none; color: white;">{{{title}}}</a>
			</td>
			<td>{{price}}원</td>
			<td><input value="{{qnt}}" size=2></td>
			
		</tr>
		{{/each}}
	</table>
</script>

<script>
	getData();

	function getData(){
		$.ajax({
			type:"get",
			url:"/cart/list.json",
			dataType:"json",
			data:{uid},
			success:function(data){
				const temp=Handlebars.compile($("#temp_cart").html());
				$("#div_cart").html(temp(data));
			}
		});
	}
</script>

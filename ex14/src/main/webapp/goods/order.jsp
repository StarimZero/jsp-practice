<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="text-center">
	<h1>주문하기</h1>
	<div id="div_order"></div>
	<div id="div_order_total" class ="alert alert-primary text-end" role="alert">합계:</div>
	<button class="btn btn-success px-5">결제하기</button>
	
</div>
<script id="temp_order"  type="x-handlebars-templage">
	<table class="table table-bordered table-dark table-hover" style ="text-align: center;">
		<tr class="text-center">
			<td><input type="checkbox" id="all" ></td>
			<td>상품번호</td>
			<td>상품이름</td>
			<td>가격</td>
			<td>수량</td>
			<td>금액</td>
			<td>삭제</td>
		</tr>
		{{#each .}}
		<tr  gid="{{gid}}">
			<td><input type="checkbox" class="chk" gid="{{gid}}" goods="{{toString @this}}"></td>
			<td>{{gid}}</td>
			<td class="text-start" >
				<img src="{{image}}" style = "width : 50px;  height: auto; aspect-ratio: 4/3;">
				<a href="/goods/read?gid={{gid}}" style = "text-decoration : none; color: white;">{{{title}}}</a>
			</td>
			<td>{{sum price 1}}원</td>
			<td>
				<input class="qnt" value="{{qnt}}" size=2>
				<button class="btn btn-primary btn-sm update">수정</button>
			</td>
			<td>{{sum price qnt}}원</td>
			<td><button class="btn btn-danger btn-sm delete">삭제</button></td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	Handlebars.registerHelper("sum", function(price, qnt){
		const sum = price*qnt;
		return sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	});
</script>

<script>
	function getOrder(data){
		const temp=Handlebars.compile($("#temp_order").html());
		$("#div_order").html(temp(data));
		let total = 0;
		$(data).each(function(){
			const price = this.price;
			const qnt = this.qnt;
			const sum=price*qnt;
			total += sum;
		});
		$("#div_order_total").html("합계 : " +total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원");
	}
</script>





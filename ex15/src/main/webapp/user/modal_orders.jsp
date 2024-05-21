<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	#modalOrders{
		top:20%;
	}
</style>


<!-- Modal -->
<div class="modal fade" id="modalOrders" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="pid">주문번호 : {{pid}}의 결제정보입니다.</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div id="address">배송지 주소 : {{add1}} {{add2}}</div>
				<hr>
				<div id="div_orders"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<script id="temp_orders"  type="x-handlebars-templage">
	<table class="table table-bordered table-dark table-hover" style ="text-align: center;">
		<tr class="text-center">
			<td>상품번호</td>
			<td>상품이름</td>
			<td>가격</td>
			<td>수량</td>
			<td>금액</td>
		</tr>
		{{#each .}}
		<tr  gid="{{gid}}">
			<td>{{gid}}</td>
			<td class="text-start" >
				<img src="{{image}}" style = "width : 50px;  height: auto; aspect-ratio: 4/3;">
				<a href="/goods/read?gid={{gid}}" style = "text-decoration : none; color: white;">{{{title}}}</a>
			</td>
			<td>{{sum price 1}}원</td>
			<td>{{qnt}}</td>
			<td>{{sum price qnt}}원</td>
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
	function getOrders(pid){
		$.ajax({
			type:"get",
			url:"/order/list.json",
			dataType:"json",
			data : {pid},
			success:function(data){
				const temp=Handlebars.compile($("#temp_orders").html());
				$("#div_orders").html(temp(data));
			}
		});
	}
</script>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div>
	<h1>예약내역	</h1>
	<div id = "div_purchase"></div>
	<jsp:include page="modal_orders.jsp"/>
</div>

<script id="temp_purchase" type="x-handlebars-templage">
	<table class="table">
		<tr>
			<td>주문번호</td>
			<td>전화번호</td>
			<td>배송지</td>
			<td>주문일</td>
			<td>금액</td>
			<td>상태</td>
			<td>예약상품</td>
		</tr>
		{{#each .}}
		<tr>
			<td>{{pid}}</td>
			<td>{{phone}}</td>
			<td>{{add1}}  {{add2}}</td>
			<td>{{pdate}}</td>
			<td>{{sum}}</td>
			<td>{{status status}}</td>
			<td><button class="btn btn-primary btn-sm orders" pid="{{pid}}" add1="{{add1}}" add2="{{add2}}">상세보기</td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	Handlebars.registerHelper("status", function(status){
		switch(status){
		case 0:
			return "결제대기";
		case 1:
			return "결제확인";
		case 2:
			return "배송준비";
		case 3:
			return "배송중";
		case 4:
			return "배송완료";
		case 5:
			return "주문완료";
		}
	});
</script>

<script>
getData();

//예약상품 버튼을 클릭한 경우
$("#div_purchase").on("click", ".orders", function(){
	const pid=$(this).attr("pid");
	const add1=$(this).attr("add1");
	const add2=$(this).attr("add2");
	$("#modalOrders").modal("show");
	$("#pid").html("예약상품 번호 : " + pid);
	$("#address").html("실물티켓 배송지 : " + add1 + "  " + add2);
	getOrders(pid);
});

function getData(){
	$.ajax({
		type:"get",
		url:"/purchase/list.json",
		dataType:"json",
		data:{uid},
		success:function(data){
			console.log(data);
			const temp=Handlebars.compile($("#temp_purchase").html());
			$("#div_purchase").html(temp(data));
		}
	});
}
</script>



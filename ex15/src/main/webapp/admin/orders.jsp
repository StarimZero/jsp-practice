<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div>
	<h1>주문관리</h1>
	<div id = "div_purchase"></div>
</div>


<script id="temp_purchase" type="x-handlebars-templage">
	<table class="table table-bordered table-dark table-hover" style ="text-align: center; font-size:13px;">
		<tr class="text-center">
			<td>주문번호</td>
			<td>주문자</td>
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
			<td>{{uname}}({{uid}})</td>
			<td>{{phone}}</td>
			<td>{{add1}}  {{add2}}</td>
			<td>{{pdate}}</td>
			<td>{{sum sum 1}}원</td>
			<td>
				<div class="input-group">
					<select class="form-select status">
						<option value="0" {{selected status 0}}>결제대기</option>
						<option value="1" {{selected status 1}}>결제확인</option>
						<option value="2" {{selected status 2}}>배송준비</option>
						<option value="3" {{selected status 3}}>배송중</option>
						<option value="4" {{selected status 4}}>배송완료</option>
						<option value="5" {{selected status 5}}>주문완료</option>
					</select>
					<button class="btn btn-success btn-sm update" pid="{{pid}}">변경(현재:{{status}})</button>
				</div>
				
			</td>
			<td><button class="btn btn-primary btn-sm orders" pid="{{pid}}" add1="{{add1}}" add2="{{add2}}">상세보기</td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	Handlebars.registerHelper("sum", function(price, qnt){
		const sum = price*qnt;
		return sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	});
	
	Handlebars.registerHelper("selected", function(status, value){
		if(status == value) return "selected"
	});

</script>

<script>
let key = "uid";
let word = "";
let page = 1;
let size = 5;

	//상태변경 버튼을 눌렀을때.
	$("#div_purchase").on("click", ".update", function(){
		const pid = $(this).attr("pid");
		const status = $(this).parent().find(".status").val();
		//alert(pid + "................" + status);
		if(!confirm("주문 상태를 변경 하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/admin/order/update",
			data:{pid, status},
			success:function(){
				alert("변경완료");
				getData();
			}
		});
	});

	getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/admin/order/list.json",
			dataType:"json",
			data:{key, word, page, size},
			success:function(data){
				console.log(data);
				const temp=Handlebars.compile($("#temp_purchase").html());
				$("#div_purchase").html(temp(data));
			}
		});
	}
</script>






<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="pageCart">
	<h1>장바구니</h1>
	<div id="div_cart"></div>
	<div id="div_total" class ="alert alert-primary text-end" role="alert">합계:</div>
	<div class ="text-center">
		<button class="btn btn-primary px-5  me-3" id="btnOrder">주문하기</button>
		<a href="/" class="btn btn-secondary px-4">쇼핑계속하기</a>
	</div>
</div>

<div id="pageOrder" style="display:none;">
	<jsp:include page="order.jsp"></jsp:include>
</div>

<script id="temp_cart"  type="x-handlebars-templage">
	<div class="mb-2">
		<button class = "btn btn-danger" id="delete">선택상품삭제</button>
	</div>
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
	
	Handlebars.registerHelper("toString", function(goods){
		return JSON.stringify(this);
	});
</script>
<script>
	getData();
	
	//주문하기를 눌렀을 경우
	$("#btnOrder").on("click", function(){
		const chk=$("#div_cart .chk:checked").length;
		if(chk==0){
			alert("주문할 상품을 선택하세요");
			return;
		}else{
			//체크된 상품정보를 배열에 저장하자.
			let data=[];
			$("#div_cart .chk:checked").each(function(){
				const goods = $(this).attr("goods");
				data.push(JSON.parse(goods));
			});
			console.log(data);
			getOrder(data);
			$("#pageCart").hide();
			$("#pageOrder").show();
		}
	});
	
	
	//선택삭제하기 버튼을 클릭한 경우
	$("#div_cart").on("click", "#delete", function(){
		const chk=$("#div_cart .chk:checked").length;
		if(chk==0) {
			alert("삭제하실 상품을 선택하세요")
			return;
		}
		if(!confirm(chk + "개의 상품들을 삭제하시겠습니까?")) return;
		
		//삭제하기
		let cnt=0;
		$("#div_cart .chk:checked").each(function(){
			const gid=$(this).parent().parent().attr("gid");		
		  	$.ajax({
		   		type: "post",
		    		url: "/cart/delete",
		    		data: { gid, uid},
		    		success: function(){
		    			cnt++;
		    			if(chk==cnt){
		    				alert(cnt + "개의 상품을 장바구니에서 삭제하였습니다.");
		    				getData();
		    			}
		    		}
		  	});
		});
	});
	
	//전체선택 체크박스 클릭한 경우
	$("#div_cart").on("click", "#all", function(){ //여기서 all을 클릭하니까 this는 all이다.
		if($(this).is(":checked")){
			$("#div_cart .chk").each(function(){
				$(this).prop("checked", true);
			});	
		}else{
			$("#div_cart .chk").each(function(){
				$(this).prop("checked", false);
			});	
		}
	});
	
	//각행의 체크박스를 클릭한 경우
	$("#div_cart").on("click", ".chk", function(){
		let all=$("#div_cart ,chk").length;
		let chk=$("#div_cart .chk:checked").length;
		if(chk==all){
			$("#div_cart #all").prop("checked", true);
		}else{
			$("#div_cart #all").prop("checked", false);
		}
	});
	
	// 각 행의 수정 버튼을 눌렀을 때
	$("#div_cart").on("click", ".update", function(){
		 // alert(uid);
		const qntStr = $(this).parent().find(".qnt").val(); // 문자열로 변환하여 저장

	// 입력된 값이 숫자인지 확인합니다.
		if (isNaN(qntStr)) {
		alert("숫자만 입력 가능합니다.");
		return; // 숫자가 아닌 경우 아무 작업도 수행하지 않고 종료합니다.
		}

	  const qnt = parseInt(qntStr); // 문자열을 숫자로 변환합니다.
	  const gid = $(this).parent().parent().attr("gid");

	  	// alert(uid + "::::::" + qnt + ":::::" + gid);
	  	$.ajax({
	   		type: "post",
	    		url: "/cart/update",
	    		data: { gid, uid, qnt },
	    		success: function(){
	      		getData();
	    		}
	  	});
	});
	//각행의 삭제버튼을 클릭한경우
	$("#div_cart").on("click", ".delete", function(){
		const gid = $(this).parent().parent().attr("gid");
		if(!confirm(gid + "번의 상품을 삭제하시겠습니까?")) return;
		//삭제하기
	  	$.ajax({
	   		type: "post",
	    		url: "/cart/delete",
	    		data: { gid, uid},
	    		success: function(){
	      		getData();
	    		}
	  	});
	});
	


	function getData(){
		$.ajax({
			type:"get",
			url:"/cart/list.json",
			dataType:"json",
			data:{uid},
			success:function(data){
				const temp=Handlebars.compile($("#temp_cart").html());
				$("#div_cart").html(temp(data));
				let total = 0;
				$(data).each(function(){
					const price = this.price;
					const qnt = this.qnt;
					const sum=price*qnt;
					total += sum;
				});
				$("#div_total").html("합계 : " +total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원");
			}
		});
	}
	

</script>

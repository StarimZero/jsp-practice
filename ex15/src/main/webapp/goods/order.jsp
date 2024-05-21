<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="text-center">
	<h1>주문하기</h1>
	<div id="div_order"></div>
	<div id="div_order_total" class ="alert alert-primary text-end" role="alert">합계:</div>
	
	<div class="row  justify-content-center ">
		<div class="col-10 col-md-8">
			<div class="card">
					<h4 style="text-align: left; margin-top : 20px;">주문 / 결제</h4>
					<hr>
				<div class="card-header">
					<h3>구매자 정보</h3>
					<div class="card-body">
						<form>
							<div class= "input-group mb-2">
								<span class="input-group-text">이름</span>
								<input class="form-control">
							</div>
							<div class= "input-group mb-2">
								<span class="input-group-text">전화번호</span>
								<input class="form-control">
							</div>
						</form>
					</div>
				</div>
				<div class="card-header text-center">
					<h3>받는사람 정보</h3>
						<div class="card-body">
							<form name="frm">
								<div class= "input-group mb-2">
									<span class="input-group-text">이름</span>
									<input name = "rname" class="form-control" value="${user.uname}">
								</div>
								<div class= "input-group mb-2">
									<span class="input-group-text">전화번호</span>
									<input name = "rphone" class="form-control" value="${user.phone}">
								</div>
								<div class= "input-group mb-2">
									<span class="input-group-text">주소</span>
									<input name = "radd1" class="form-control"value="${user.add1}">
									<button class="btn btn-primary">검색</button>
								</div>
								<div class= "input-group mb-2">
									<span class="input-group-text">상세주소</span>
									<input name = "radd2" class="form-control" placeholder="상세주소를 입력하세요" value="${user.add2}">
								</div>
								<div class= "input-group mb-2">
									<span class="input-group-text">배송요청사항</span>
									<input name = "req" class="form-control" placeholder ="요청사항을 입력하세요.">
								</div>
								<input name="sum" type="hidden">
								<div>
								<button class="btn btn-success px-5 my-3">결제하기</button>
								</div>
							</form>
						</div>
				</div>
				<div class="card-header">
					<h3>배송정보</h3>
					<div class="card-body">
						<form>
							<div class= "input-group mb-2">
								
							</div>
						</form>
					</div>
				</div>
				<div class="card-header">
					<h3>결제정보</h3>
					<div class="card-body">
						<form>
							<div class= "input-group mb-2">
								
							</div>
						</form>
					</div>
				</div>
				<div class="card-header">
					<h3>결제수단</h3>
					<div class="card-body">
						<form>
							<div class="input-group mb-2">
								<div class=form-check>
									<input value = "카드결제"name="title" class="form-check-input ms-2" type="radio" checked>
									<label class="form-check-label">카드결제</label>
								</div>
								<div class=form-check>
									<input value = "계좌이체" name="title" class="form-check-input m-2" type="radio">
									<label class="form-check-label">계좌이체</label>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	
</div>
<script id="temp_order"  type="x-handlebars-templage">
	<table class="table table-bordered table-dark table-hover" style ="text-align: center;">
		<tr class="text-center">
			<td>상품번호</td>
			<td>상품이름</td>
			<td>가격</td>
			<td>수량</td>
			<td>금액</td>
		</tr>
		{{#each .}}
		<tr  class="goods" gid="{{gid}}" price="{{price}}" qnt="{{qnt}}">
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
	//주문하기기 버튼을 클릭한경우
	$(frm).on("submit", function(e){
		e.preventDefault();
		const rname=$(frm.rname).val();
		const rphone=$(frm.rphone).val();	
		const radd1=$(frm.radd1).val();
		const radd2=$(frm.radd2).val();
		const sum=$(frm.sum).val();
		const req=$(frm.req).val();
		console.log(uid, rname, rphone, radd1, radd2, sum, req)
		const cnt=$("#div_order .goods").length;
		if(!confirm(cnt + "개의 상품들을 주문 하시겠습니까?")) return;
		//주문정보입력
		$.ajax({
			type : "post",
			url : "/purchase/insert",
			data:{uid, rname, rphone, radd1, radd2, sum},
			success:function(pid){
				//alert(pid);
				//주문상품등록
				let order_cnt=0;
				$("#div_order .goods").each(function(){
					const gid=$(this).attr("gid");
					const price=$(this).attr("price");
					const qnt=$(this).attr("qnt");
					console.log(pid, gid, price, qnt);
					$.ajax({
						type:"post",
						url:"/orders/insert",
						data:{pid, gid, price, qnt},
						success:function(){
							order_cnt++;
							//장바구니 삭제
								$.ajax({
									type:"post",
									url:"/cart/delete",
									data:{uid, gid},
									success:function(){
										if(cnt==order_cnt){
											//alert(order_cnt + "개의 주문 상품 등록완료")
											location.href="/";
										}
									}
								});
							if(cnt==order_cnt){
								//alert("주문상품등록완료!");
							}
						}
					});
				});
			}
		});
		
	});
	
	
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
		$(frm.sum).val(total);
	}
	
	
	
</script>





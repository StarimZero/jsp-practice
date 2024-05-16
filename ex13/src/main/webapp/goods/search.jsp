<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<div>
	<h1>상품검색</h1>
	<div class="row mb-2">
		<div class="col">
			<button class="btn btn-success" id="insert">선택저장</button>
		</div>
		<form name = "frm" class="col-4 col-md-5">
			<div class="input-group">
				<input name="query" class="form-control" value="뉴욕여행">
				<button class="btn btn-primary">검색</button>
			</div>
		</form>
	</div>
	<div id="div_shop"></div>
	<div class= "text-center">
		<button id="prev" class="btn btn-primary">이전</button>
		<span id="page" class="mx-3"><b>1</b></span>
		<button id="next" class="btn btn-primary">다음</button>
	</div>
</div>
<script id="temp_shop">
	<table class="table table-bordered table-hover table-success">
		<tr class="text-center">
			<td><input type="checkbox" id="all"></td>
			<td>상품 아이디</td>
			<td>상품 카테고리</td>
			<td>상품명</td>
			<td>상품가격</td>
			<td>이미지</td>
			<td>저장</td>
		</tr>
		{{#each items}}
		<tr class="text-center" gid="{{productId}}" img="{{image}}" title="{{title}}" brand="{{brand}}" price="{{lprice}}" category3="{{category3}}" link="{{link}}" mallName = "{{mallName}}">
			<td><input type="checkbox" id="chk"></td>
			<td>{{productId}}</td>
			<td>{{category3}}</td>
			<td><div class="ellipsis">{{{title}}}</div></td>
			<td>{{lprice}}</td>
			<td><img src = {{image}} width="50"></td>
			<td><button class="btn btn-info btn-sm insert">저장</button></td>
		</tr>
		{{/each}}
	</table>
</script>


<script>
	let query=$(frm.query).val();
	let page=1;
	let size=10;
	
	//선택저장 버튼을 클릭한 경우
	$("#insert").on("click", function(){
		let chk=$("#div_shop #chk:checked").length;
		if(chk==0){
			alert("저장할 상품들을 선택하세요.");
			return;
		}
		if(!confirm(chk + "개의 상품을 등록하시겠습니까?"))
			return;
		//상품등록
		let cnt=0;
		let success=0;
		$("#div_shop #chk:checked").each(function(){
			let tr=$(this).parent().parent(); // tr로가기
			let gid = tr.attr("gid");
			let title = tr.attr("title");
			let image = tr.attr("img");
			let price = tr.attr("price");
			let brand = tr.attr("brand");
			let category3 = tr.attr("category3");
			let link = tr.attr("link");
			let mallName = tr.attr("mallName");
			console.log(gid, title, image, price, brand, category3, link, mallName);
			$.ajax({
				type:"post",
				url:"/goods/insert",
				data:{gid, title, image, price, brand, category3, link, mallName},
				success:function(data){
					cnt++;
					if(data=="true") success++;
					if(chk==cnt){
						alert(success + "개 상품 등록성공");
						getData();
					}
				}
			});
		});
	});
	
	
	//전체선택 체크박스 클릭한 경우
	$("#div_shop").on("click", "#all", function(){
		//alert(",,,,,,,,,,,,,,,,,");
		if($(this).is(":checked")){
			$("#div_shop #chk").each(function(){
				$(this).prop("checked", true);
			});	
		}else{
			$("#div_shop #chk").each(function(){
				$(this).prop("checked", false);
			});	
		}
	});
	
	//각행의 체크박스를 클릭한 경우
	$("#div_shop").on("click", "#chk", function(){
		let all=$("#div_shop #chk").length;
		let chk=$("#div_shop #chk:checked").length;
		if(chk==all){
			$("#div_shop #all").prop("checked", true);
		}else{
			$("#div_shop #all").prop("checked", false);
		}
	});
	
	
	//저장버튼을 클릭한 겨우
	$("#div_shop").on("click", ".insert", function(){
		//alert("...........................");
		let tr=$(this).parent().parent(); // tr로가기
		let gid = tr.attr("gid");
		let title = tr.attr("title");
		let image = tr.attr("img");
		let price = tr.attr("price");
		let brand = tr.attr("brand");
		let category3 = tr.attr("category3");
		let link = tr.attr("link");
		let mallName = tr.attr("mallName");
		console.log(gid, title, image, price, brand, category3, link, mallName);
		//상품등록
		$.ajax({
			type:"post",
			url:"/goods/insert",
			data:{gid, title, image, price, brand, category3, link, mallName},
			success:function(data){
				if(data=="true"){
					alert("등록성공")
				}else{
					alert("이미 등록된 상품입니다.");
				}
			}
		});
	});
	
	//다음버튼을 클릭했을경우
	$("#next").on("click", function(){
		page++;
		getData();
	});
	$("#prev").on("click", function(){
		page--;
		getData();
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		page=1;
		query=$(frm.query).val();
		getData();
	});
	getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/goods/search.json",
			dataType:"json",
			data : {query, page, size},
			success:function(data){
				console.log(data);
				const temp=Handlebars.compile($("#temp_shop").html());
				$("#div_shop").html(temp(data));
				
				$("#page").html(page);
				if(page==1) $("#prev").attr("disabled", true);
				else $("#prev").attr("disabled", false);
				if(page==10) $("#next").attr("disabled", true);
				else $("#next").attr("disabled", false);
			}
		});
		
	}
</script>
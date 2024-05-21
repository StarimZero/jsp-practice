<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	#div_shop img{
		cursor: pointer;
		border-radius:10px;
	}
</style>

<div>
	<h1>상품목록</h1>
	<div class="row mb-2">
		<div class="col">
			<button class="btn btn-danger" id="delete">선택삭제 </button>
		</div>
		<div class="col-5 col-md-6 col-lg-3">
			<form name="frm">
				<div class="input-group">
					<span id="total" class="me-2 mt-2"></span>
					<input class="form-control" placeholder="검색어를 입력하세요" name="word">
					<button class= "btn btn-primary btn-sm">검색 </button>
				</div>
			</form>
		</div>
	</div>
	<div class="col" id="div_shop"></div>
</div>

<div id="pagination" class="pagination justify-content-center mt-5"></div>

<script id="temp_shop"  type="x-handlebars-templage">
	<table class="table table-bordered table-dark table-hover" style ="text-align: center;">
		<tr class="text-center">
			<td><input type="checkbox" id="all" ></td>
			<td>상품 아이디</td>
			<td>상품명</td>
			<td>상품가격</td>
			<td>카테고리</td>
			<td>이미지</td>
			<td>상품삭제</td>
		</tr>
		{{#each .}}
		<tr>
			<td><input type="checkbox" class="chk" gid="{{gid}}"></td>
			<td>{{gid}}</td>
			<td>
				<div class="ellipsis">{{{title}}}</div>
				<div>{{regDate}}</div>
			</td>
			<td>{{price}}원</td>
			<td>{{category3}}</td>
			<td><img src = {{image}} width="50" index="{{@index}}"></td>
			<td><button class="btn btn-danger btn-sm delete" gid="{{gid}}">삭제</button> <jsp:include page="modal_image.jsp"/></td>
		</tr>
		{{/each}}
	</table>
</script>


<script>
	let page=1;
	let size=5;
	let word="";
	
	//getData();
	getTotal();
	
	//이미지를 클랙했을때.
	$("#div_shop").on("click", "img", function(){
		const index=$(this).attr("index");
		//alert(index);
		$("#modal" + index).modal("show");
	});
	
	//검색 
	$(frm).on("submit", function(e){
		e.preventDefault();
		word=$(frm.word).val();
		//getData();
		page=1;
		getTotal();
	});
	
	//선택삭제버튼을 클릭한경우
	$("#delete").on("click", function(){
		//alert(".........................");
		let chk=$("#div_shop .chk:checked").length;
		if(chk==0){
			alert("삭제할 상품을 선택해 주세요.")
			return;
		}
		if(!confirm(chk + "개의 상품을 삭제하시겠습니까?")) return;
		//삭제하기
		let cnt = 0;
		let success = 0;
		$("#div_shop .chk:checked").each(function(){
			//alert("...............");
			const gid=$(this).attr("gid");
			//alert(gid);
			$.ajax({
				type:"post",
				url:"/goods/delete",
				data:{gid},
				success:function(data){
					cnt++;
					if(data=="true") success ++;
					if(cnt==chk){
						alert(success + "개의 상품이 삭제되었습니다.")
						//getData();
						getTotal();
					}
				}
			});
		});
	});
	
	//전체선택 체크박스 클릭한 경우
	$("#div_shop").on("click", "#all", function(){ //여기서 all을 클릭하니까 this는 all이다.
		if($(this).is(":checked")){
			$("#div_shop .chk").each(function(){
				$(this).prop("checked", true);
			});	
		}else{
			$("#div_shop .chk").each(function(){
				$(this).prop("checked", false);
			});	
		}
	});
	
	//각행의 체크박스를 클릭한 경우
	$("#div_shop").on("click", ".chk", function(){
		let all=$("#div_shop ,chk").length;
		let chk=$("#div_shop .chk:checked").length;
		if(chk==all){
			$("#div_shop #all").prop("checked", true);
		}else{
			$("#div_shop #all").prop("checked", false);
		}
	});
	
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
						//getData();
						getTotal();
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
			data:{word, page, size},
			success:function(data){
				const temp=Handlebars.compile($("#temp_shop").html());
				$("#div_shop").html(temp(data));
			}
		});
	}
	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/goods/total",
			data:{word},
			success:function(data){
				const total=parseInt(data);
				if(total==0){
					alert("검색한 상품이 없습니다.");
					return;
				}
				const totalPage=Math.ceil(total/size);
				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				if(total>=size){
					$("#pagination").show();
				}else{
					$("#pagination").hide();
				}
				$("#total").html("검색수 : " + total)
			}
		});
	}
	
	   $('#pagination').twbsPagination({
		      totalPages:10, 
		      visiblePages: 5, 
		      startPage : 1,
		      initiateStartPageClick: false, 
		      first:'<i>처음</i>', 
		      prev :'<i>이전</i>',
		      next :'<i>다음</i>',
		      last :'<i>마지막</i>',
		      onPageClick: function (event, clickPage) {
		          page=clickPage; 
		          getData();
		      }
		   });
</script>
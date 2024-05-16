<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.brand{
		font-size:12px;
	}
	
	#div_shop img{
		border-radius:10px;
		box-shadow: 0px 5px 5px 0px;
	}
	.bi-arrow-through-heart-fill, .bi-arrow-through-heart{
		color:red;
		float:right;
		font-size : 25px;
		cursor : pointer;
	}
</style>



<h1>HOT PLACE</h1>

<div class="my-5">
	<div class="row mb-3">
		<div class="col-6 col-md-4">
			<form name="frm">
				<div class="input-group">
					<input class="form-control" placeholder="검색어를 입력하세요" name="word">
					<button class= "btn btn-primary">검색</button>
				</div>
			</form>
		</div>
	</div>
</div>



<div class="my-5">
	<div id="div_shop" class="row"> </div>
</div>

<ul id="pagination" class="pagination justify-content-center mt-5 pagination-sm"></ul>

<script id="temp_shop" type="x-handlebars-template">
	{{#each .}}
		<div class="col-2 col-md-4 col-lg-2 mb-5">
			<div class="mb-2">
				<img gid ="{{gid}}" src = "{{image}}" style = "width : 90%;  height: auto; aspect-ratio: 4/3; cursor:pointer;" >
			</div>
			<div class="brand">{{brand}} {{gid}} </div>
			<div class="ellipsis">{{{title}}}</div>
			<div>
				<b>{{fmtPrice price}}원</b>
				<span class="bi {{heart ucnt}}" gid="{{gid}}">
					<span style="font-size:15px;color:red;">{{fcnt}}</span>
				</span>
			</div>
		</div>
	{{/each}}
</script>
<script>
	Handlebars.registerHelper("fmtPrice", function(price){
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	});
	
	Handlebars.registerHelper("heart", function(value){
		if(value==0) return "bi-arrow-through-heart";
		else return "bi-arrow-through-heart-fill";
	});
	
</script>
<script>
	let size=12;
	let page=1;
	let word="";
	
	//이미지를 클릭한 경우
	$("#div_shop").on("click", "img", function(){
		const gid=$(this).attr("gid");
		//alert(gid + "::::::::::::::::::" + uid)
		location.href="/goods/read?gid=" + gid;
	});
	
	
	
	//빈하트를 눌렀을때 
	$("#div_shop").on("click", ".bi-arrow-through-heart", function(){
		if(uid){
			const gid=$(this).attr("gid");
			//alert(uid + "::::::::::::" + gid);
			//좋아요 인서트
			$.ajax({
				type:"post",
				url:"/favorite/insert",
				data:{uid, gid},
				success:function(){
					getData();
				}
			});
		}else{
			location.href="/user/login";
		}
	});
	
	//채워진 하트를 클릭한경우
		$("#div_shop").on("click", ".bi-arrow-through-heart-fill", function(){
			const gid=$(this).attr("gid");
			//alert(uid + "::::::::::::" + gid);
			//좋아요 인서트
			$.ajax({
				type:"post",
				url:"/favorite/delete",
				data:{uid, gid},
				success:function(){
					getData();
				}
			});
		});
	
	//검색 
	$(frm).on("submit", function(e){
		e.preventDefault();
		word=$(frm.word).val();
		//getData();
		page=1;
		getTotal();
	});
	
	//getData();
	getTotal();
	function getData(){
		$.ajax({
			type:"get",
			url:"/goods/list.json",
			dataType:"json",
			data:{word, page, size, uid},
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
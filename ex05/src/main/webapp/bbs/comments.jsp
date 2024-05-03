<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.delete{
	cursor:pointer;
	font-size:20px;
	color : red;
	}	
</style>


<p> 댓글 달기 </p>
<div class= "text-end" id="div_insert">
	<textarea id = "contents" rows="5" class="form-control" placeholder="명예훼손, 개인정보 유출, 분쟁 유발, 허위사실 유포 등의 글은 이용약관에 의해 제재는 물론 볍률에 의해 처벌 받을 수 있습니다. 건전한 커뮤니티를 위해 자제를 당부 드립니다."></textarea>
	<button class="btn btn-primary px-5 mt-2 insert">등록</button>
</div>

<div class= "mt-5 text-end" id="div_login">
	<button class="btn btn-danger px-5 login">로그인</button>
</div>

<div class="card mt-5">
	<div class="card-header">
		<span id="total"></span>
	</div>
	<div class="card-body">
		<div id="div_comments"></div>
	</div>
</div>
<div id="pagination" class="pagination justify-content-center mt-5"></div>




 <script id="temp_comments" type="x-handlebars-template">
	{{#each .}}
		<div class="text-muted">
			<span>{{cdate}}  </span>
			<span> {{uname}}({{writer}})</span>
			<i class="bi bi-trash3-fill ms-1 delete" style="{{delete writer}}" cid={{cid}}></i>
		</div>
		<div class="mb-5 ellipsis2"><b> {{cid}}</b> : {{contents}}</div>
	{{/each}}
</script>

<script>
	Handlebars.registerHelper("delete", function(writer){
		if(uid!==writer){
			return "display:none;";
		}
	});
</script>

<script>
	const bid="${bbs.bid}";
	let page= 1;
	let size = 10;
	
	//로그인시 댓글 등록 숨기기 보이기 
	if(uid){
		$("#div_insert").show();
		$("#div_login").hide();
	}else{
		$("#div_insert").hide();
		$("#div_login").show();
	}
	//삭제누른경우
	$("#div_comments").on("click", ".delete", function(){
		const cid=$(this).attr("cid");
		if(confirm(cid + "번 댓글을 삭제하시겠습니까?")){
			//삭제하기
			$.ajax({
				type:"post",
				url:"/com/delete",
				data:{cid},
				success:function(){
					getTotal();
				}
			});
		}
	});
	
	
	
	//로그인 누르면 로그인으로 가기
	$("#div_login").on("click", ".login", function(){
		sessionStorage.setItem("target", "/bbs/read?bid=" + bid);
		location.href="/user/login";
	})
	//등록버튼을 클릭한 경우
	$("#div_insert").on("click", ".insert", function(){
		const contents=$("#contents").val();
		if(contents==""){
			alert("내용을 입력하셔야 등록됩니다.")
			$("#contents").focus();
			return;
		}
		$.ajax({
			type:"post",
			url:"/com/insert",
			data:{bid, contents, uid},
			success:function(){
				page=1;
				getTotal();
				contents=$("#contents").val("");
			}
		})
		
	})
	
	
	
	getData();
	function getData(){
		$.ajax({
				type:"get",
				url:"/com/list.json",
				data:{bid, page, size},
				dataType:"json",
				success:function(data){
					//alert("성공~");
					const temp=Handlebars.compile($("#temp_comments").html());
					$("#div_comments").html(temp(data));
				}
		});
	}
 	//페이지네이션출력
    $('#pagination').twbsPagination({
        totalPages:100, 
        visiblePages: 10, 
        startPage : 1,
        initiateStartPageClick: false, 
        first:'<i class="bi bi-chevron-double-left" style="color:black"></i>', 
        prev :'<i class="bi bi-caret-left-fill" style="color:black"></i>',
        next :'<i class="bi bi-caret-right-fill" style="color:black"></i>',
        last :'<i class="bi bi-chevron-double-right style="color:black""></i>',
        onPageClick: function (event, clickPage) {
            page=clickPage; 
            getData();
        }
     });
 	
 	getTotal(); //토탈데이터 가져오고 호출해주기 
 	function getTotal(){
 		$.ajax({
 			type:"get",
 			url:"/com/total",
 			data:{bid},
 			success:function(data){
 //				alert(data);
 				const totalPage=Math.ceil(data/size);
 				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
 				$("#total").html("댓글수 :" + data + "개")
 				}
 		});
 	}
</script>




 
 
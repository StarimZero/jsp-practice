<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	#size{
		width:100px;
		float: right;
	}
</style>

<div>
	<h1>학생관리</h1>
	<div class="row mb-1 mt-1">
		<form class="col-10 col-md-6 col-lg-4"  name="frm">
			<div class="input-group">
				<select class="form-select me-3" name="key">
					<option value="scode">학생번호</option>
					<option value="sname" selected>학생이름</option>
					<option value="dept">학과</option>
					<option value="pname">지도교수이름</option>
				</select>
				<input placeholder="검색어를 입력하세요" class="form-control" name="word">
				<button class="btn btn-primary">검색</button>
			</div>
		</form>
		<div class="col">
			<select class="form-select"  id="size">
				<option value="2">2개</option>
				<option value="3">3개</option>
				<option value="4" selected>4개</option>
				<option value="5">5개</option>
				<option value="100" selected>전체보기</option>
			</select>
		</div>
	</div>
	<div id="div_stu"></div>
</div>

<script id="temp_stu" type="x-handlebars-templage">
<table class="table table-bordered table-dark table-hover" style ="text-align: center;">
	<tr>
		<td>학생번호</td>
		<td>학생이름</td>
		<td>학생학과</td>
		<td>학생학년</td>
		<td>생년월일</td>
		<td>지도교수</td>
	</tr>
	{{#each .}}
	<tr>
		<td>{{scode}}</td>
		<td><a href="/stu/read?scode={{scode}}" style = "text-decoration : none; color: white;">{{sname}}</td></a>
		<td>{{sdept}}</td>
		<td>{{year}}학년</td>
		<td>{{birthday}}</td>
		<td>{{pname}}({{advisor}})</td>
	</tr>
	{{/each}}
</table>
</script>

<div id="pagination" class="pagination justify-content-center mt-5"></div>


<script>
	let page = 1;
	let size = $("#size").val();
	let key = $(frm.key).val();
	let word = $(frm.word).val();
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		page=1;
		size = $("#size").val();
		key = $(frm.key).val();
		word = $(frm.word).val();
		//getData();
		//토탈구한이후
		getTotal();
	});
	
	$("#size").on("change", function(){
		size = $("#size").val();
		page=1;
		//getData();
		//토탈구한이후
		getTotal();
	});
	
	getTotal();
	function getData(){
		$.ajax({
			type:"get",
			url:"/stu/list.json",
			dataType:"json",
			data:{page, size, key, word},
			success:function(data){
				console.log(data);
				const temp=Handlebars.compile($("#temp_stu").html());
				$("#div_stu").html(temp(data));
			}
		})
		
	}
	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/stu/total",
			data:{key, word},
			success:function(data){ //이데이터는 STRING으로 받는다.
				if(data==0){
					alert("검색하신 키워드의 내용이 없습니다.");
					$(frm.word).val("");
					$(frm.word).focus();
					return;
				}
				const totalPage=Math.ceil(data/size);
				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				if(data<=size){
					$("#pagination").show();
				}else{
					$("#pagination").hide();
				}
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
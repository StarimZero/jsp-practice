<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
	#size{
		width:100px;
		float: right;
	}
</style>
<div>
	<h1>교수관리</h1>
	<div class="row mb-1 mt-1">
		<form class="col-10 col-md-6 col-lg-4"  name="frm">
			<div class="input-group">
				<select class="form-select me-3" name="key">
					<option value="pcode">교수번호</option>
					<option value="pname" selected>교수이름</option>
					<option value="dept">학과</option>
					<option value="title">직급</option>
				</select>
				<input placeholder="검색어를 입력하세요" class="form-contorl" name="word">
				<button class="btn btn-primary">검색</button>
			</div>
		</form>
		<div class="col">
			<select class="form-select"  id="size">
				<option value="2">2개</option>
				<option value="3">3개</option>
				<option value="4" selected>4개</option>
				<option value="5">5개</option>
			</select>
		</div>
	</div>
	<div id="div_pro"></div>
</div>

<script id="temp_pro" type="x-handlebars-template">
	<table class="table table-bordered table-dark table-hover" style ="text-align: center;">
		<tr>
            	<td>교수번호</td>
			<td>교수이름</td>
			<td>학과</td>
			<td>임용일</td>
			<td>급여</td>
			<td>직급</td>
		</tr>
		{{#each .}}
			<tr>
				<td>{{pcode}}</td>
				<td><a href="/pro/read?pcode={{pcode}}" style = "text-decoration : none; color: white;">{{pname}}</td></a> <!-- 데이터가 넘어가는 링크를 걸어준다. -->
				<td>{{dept}}</td>
				<td>{{hiredate}}</td>
				<td>{{salary}}</td>
				<td>{{title}}</td>
			</tr>
		{{/each}}
	</table>
</script>

<div id="pagination" class="pagination justify-content-center mt-5"></div>




<script>
	let page=1;
	let size=$("#size").val();
	let key = $(frm.key).val();
	let word = $(frm.word).val();
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		key = $(frm.key).val();
		word = $(frm.word).val();
		size = $("#size").val();
		page = 1;
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

	//getData();
	//토탈구한이후
	getTotal();
	function getData(){
		$.ajax({
			tpye:"get",
			url:"/pro/list.json",
			data:{page, size, key, word},
			dataType :"json",
			success:function(data){
				console.log(data);
			const temp = Handlebars.compile($("#temp_pro").html()); //아이디가 temp_pro인걸 html로 compile해서 temp에 저장 
        		$("#div_pro").html(temp(data)); // temp에 data를 넣고  div_bbs에 출력   
			}
		});
	}
	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/pro/total",
			data:{key, word},
			success:function(data){
				if(data==0){
					alert("검색하신 키워드의 내용이 없습니다.");
					$(frm.word).val("");
					$(frm.word).focus();
					return;
				}
				const totalPage=Math.ceil(data/size);
				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				if(data>=size){
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


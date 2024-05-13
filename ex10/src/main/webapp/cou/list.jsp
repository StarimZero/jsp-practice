<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	#size{
		width:100px;
		float: right;
	}
</style>

<div>
	<h1>강좌관리</h1>
	<div class="row mb-1 mt-1">
		<form class="col-10 col-md-6 col-lg-4"  name="frm">
			<div class="input-group">
				<select class="form-select me-2 mb-2" name="key">
					<option value="lcode">강좌번호</option>
					<option value="lname" selected>강좌이름</option>
					<option value="room">강의실</option>
					<option value="pname">강의교수이름</option>
				</select>
				<input placeholder="검색어를 입력하세요" class="form-control" name="word">
				<button class="btn btn-primary">검색</button>
				<span id="total" class="mt-2 ms-2"></span>
			</div>
		</form>
		<div class="col">
			<select class="form-select"  id="size">
				<option value="2">2개</option>
				<option value="3">3개</option>
				<option value="4">4개</option>
				<option value="5">5개</option>
				<option value="100"  selected>전체</option>
			</select>
		</div>
	</div>
	<div id="div_cou"></div>
</div>
<script id="temp_cou" type="x-handlebars-templage">
<table class="table table-bordered table-dark table-hover" style ="text-align: center;">
	<tr>
		<td>강좌번호</td>
		<td>강좌이름</td>
		<td>이수시간</td>
		<td>강의실</td>
		<td>담당교수</td>
		<td>현재인원</td>
	</tr>
	{{#each .}}
	<tr>
		<td>{{lcode}}</td>
		<td><a href="/cou/read?lcode={{lcode}}" style = "text-decoration : none; color: white;">{{lname}}</td></a>
		<td>{{hours}}</td>
		<td>{{room}}</td>
		<td>{{instructor}}({{pname}})</td>
		<td>{{persons}}/{{capacity}}명</td>
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
	
	//size가 변견되면..
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
			url:"/cou/list.json",
			dataType:"json",
			data:{page, size, key, word},
			success:function(data){
				console.log(data);
				const temp=Handlebars.compile($("#temp_cou").html());
				$("#div_cou").html(temp(data));
			}
		})
		
	}
	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/cou/total",
			data:{key, word},
			success:function(data){//이데이터는 STRING으로 받는다.
				let total=parseInt(data);
				if(total==0){
					alert("검색하신 키워드의 내용이 없습니다.");
					$(frm.word).val("");
					$(frm.word).focus();
					return;
				}
				$("#total").html("검색수 : " +total);
				let totalPage=Math.ceil(total/size);
				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
				if(size<=data){
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


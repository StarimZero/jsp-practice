<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



 <div>
	<h1>수강신청 목록</h1>
	<div class="input-group mb-2">
		<div id="div_cou" style ="text-align: center; "></div>
		<button class="btn btn-primary ms-1" id="insert">수강신청</button>
	</div>
	<div id="div_enroll"></div>
</div>


<script id="temp_enroll" type="x-handlebars-templage">
<table class="table table-bordered table-dark table-hover" style ="text-align: center;">
	<tr>
		<td>강좌번호</td>
		<td>강좌이름</td>
		<td>이수시간</td>
		<td>강의실</td>
		<td>담당교수</td>
		<td>현재인원</td>
		<td>수강신청일</td>
		<td>수강취소</td>
	</tr>
	{{#each .}}
	<tr>
		<td>{{lcode}}</td>
		<td><a href="/cou/read?lcode={{lcode}}" style = "text-decoration : none; color: white;">{{lname}}</td></a>
		<td>{{hours}}</td>
		<td>{{room}}</td>
		<td>{{pcode}}({{pname}})</td>
		<td>{{persons}}/{{capacity}}명</td>
		<td>{{edate}}</td>
		<td><button class="btn btn-danger btn-sm delete" lcode="{{lcode}}">취소</td>
	</tr>
	{{/each}}
</table>
</script>


<script id="temp_cou" type="x-handlebars-templage">
	<select class="form-select" id="lcode" >
		{{#each .}}
			<option value="{{lcode}}">
				{{lname}}({{lcode}}):{{pname}}&nbsp;
				({{persons}}/{{capacity}})
			</option>
		{{/each}}
	</select>
</script>

<script>
	let scode="${stu.scode}"
	//삭제버튼을 누른경우
	$("#div_enroll").on("click", ".delete", function(){
		const lcode=$(this).attr("lcode");
		//alert(scode + "::::::::::::::::" + lcode);
		if(confirm(lcode + "의 수강신청을 취소하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"/enroll/delete",
				data:{scode, lcode},
				success:function(data){
					if(data=="true"){
						alert("수강취소완료");
						getData();
						getCou();
					}else{
						alert("실패하였습니다.");
					}
				}
			})
		}
	});
	
	
	
	
	
	//수강신청 버튼을 누른경우
	$("#insert").on("click", function(){
		const lcode=$("#div_cou #lcode").val();
		//alert(scode + ":::::" + lcode);
		if(confirm("수강신청하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"/enroll/insert",
				data:{scode, lcode},
				success:function(data){
					if(data=="true"){
						alert("수강신청완료");
						getData();
						getCou();
					}else{
						alert("이미 수강신청하였습니다.");
					}
				}
			})
		}
	});
	
	
	getData();
	function getData(){
		$.ajax({
			type:"get",
			url:"/enroll/list.json",
			dataType:"json",
			data:{scode},
			success:function(data){
				console.log(data);
				const temp=Handlebars.compile($("#temp_enroll").html());
				$("#div_enroll").html(temp(data));
			}
		})
		
	}
	
	getCou();
	function getCou(){
		$.ajax({
			type:"get",
			url:"/cou/list.json",
			dataType:"json",
			data:{page:1, size:100, key:'lcode', word:''},
			success:function(data){
				console.log(data);
				const temp=Handlebars.compile($("#temp_cou").html());
				$("#div_cou").html(temp(data));
			}
		})
		
	}
</script>
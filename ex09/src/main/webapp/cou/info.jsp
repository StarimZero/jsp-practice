<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div>
	<h1>수강신청한 학생목록</h1>
	<div id ="div_cou"></div>
	<div id = "div_stu"></div>
</div>

<script id="temp_stu" type="x-handlebars-templage">
<table class="table table-bordered table-dark table-hover" style ="text-align: center;">
	<tr>
		<td>학생번호</td>
		<td>학생이름</td>
		<td>학생학과</td>
		<td>학생학년</td>
		<td>수강신청일</td>
		<td>점수</td>
	</tr>
	{{#each .}}
	<tr>
		<td>{{scode}}</td>
		<td><a href="/stu/read?scode={{scode}}" style = "text-decoration : none; color: white;">{{sname}}</td></a>
		<td>{{sdept}}</td>
		<td>{{year}}학년</td>
		<td>{{edate}}</td>
		<td><input value="{{grade}}" size=3 class="text-end px-2"</td>
	</tr>
	{{/each}}
</table>
</script>







<script>
	let lcode="${cou.lcode}";
	getData();
	
	function getData(){
		$.ajax({
			type:"get",
			url:"/enroll/slist.json",
			dataType:"json",
			data:{lcode},
			success:function(data){
				console.log(data);
				const temp=Handlebars.compile($("#temp_stu").html());
				$("#div_stu").html(temp(data));
			}
		});
	}
</script>

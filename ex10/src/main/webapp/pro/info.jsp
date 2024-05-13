<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<ul class="nav nav-pills mb-1 text-align: center;" id="pills-tab" role="tablist">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true">강의 목록</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false">지도 학생</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="pills-contact-tab" data-bs-toggle="pill" data-bs-target="#pills-contact" type="button" role="tab" aria-controls="pills-contact" aria-selected="false">연락 하기 </button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="pills-disabled-tab" data-bs-toggle="pill" data-bs-target="#pills-disabled" type="button" role="tab" aria-controls="pills-disabled" aria-selected="false" disabled>예비 tap</button>
  </li>
</ul>
<div class="tab-content" id="pills-tabContent">
<div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab" tabindex="0">
	<h2 style="text-align:center">강의 목록입니다.</h2>
	<div id="div_cou"></div>
</div>
<div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab" tabindex="0">
	<h2 style="text-align:center">지도학생목록입니다.</h2>
	<div id="div_stu"></div>
</div>
<div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab" tabindex="0">
</div>
<div class="tab-pane fade" id="pills-disabled" role="tabpanel" aria-labelledby="pills-disabled-tab" tabindex="0">...</div>
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



<script>
	let page=1;
	let size=100;
	let word ="${pro.pcode}";
	
	getCou();
	function getCou(){
		let key="instructor";
		$.ajax({
			type:"get",
			url:"/cou/list.json",
			data:{page, size, key, word},
			dataType:"json",
			success:function(data){
				console.log("강의목록", data);
				const temp=Handlebars.compile($("#temp_cou").html());
				$("#div_cou").html(temp(data));
			}
		});
	}
	
	getStu();
	function getStu(){
		let key="advisor";
		$.ajax({
			type:"get",
			url:"/stu/list.json",
			data:{page, size, key, word},
			dataType:"json",
			success:function(data){
				console.log("지도학생", data);
				const temp=Handlebars.compile($("#temp_stu").html());
				$("#div_stu").html(temp(data));
			}
		});
	}
</script>



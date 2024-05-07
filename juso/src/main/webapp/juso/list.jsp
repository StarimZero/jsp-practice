<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>주소리스트입니다.</h1>
	<div id="div_list"></div>
</div>

<script id="temp_list" type="x-handlebars-template">
    <table class="table table-bordered table-dark" style ="text-align: center;">
        <tr>
            <td>회원번호</td>
		<td>이름</td>
		<td>주소</td>
		<td>휴대폰번호</td>
		<td>등록일자</td>
        </tr>
        {{#each .}}
            <tr>
			<td>{{uid}}</td>
			<td>{{uname}}</td>
			<td>{{add1}}</td>
			<td>{{phone}}</td>
			<td>{{jdate}}<button>삭제</button></td>
            </tr>
        {{/each}}
    </table>
</script>

<script>
	$.ajax({
		type:"get",
		url:"/juso/list.json",
		dataType:"json",
		success:function(data){
			console.log(data);
			const temp=Handlebars.compile($("#temp_list").html());+
			$("#div_list").html(temp(data));
		}
	});
</script>




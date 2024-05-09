<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	#modal{
		top:20%;
	}
</style>

<!-- Modal -->
<div class="modal fade" id="modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">교수를 찾아요.</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
     		<div id="div_pro"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary">입력</button>
      </div>
    </div>
  </div>
</div>

<script id="temp_pro" type="x-handlebars-template">
	<table class="table table-bordered table-dark table-hover" style ="text-align: center;">
		<tr>
            	<td>교수번호</td>
			<td>교수이름</td>
			<td>학과</td>
		</tr>
		{{#each .}}
			<tr class="text-center" pcode="{{pcode}}" pname="{{pname}}" style="cursor:pointer">
				<td>{{pcode}}</td>
				<td>{{pname}}</td>
				<td>{{dept}}</td>
			</tr>
		{{/each}}
	</table>
</script>
<script>
	let page = 1;
	let size = 100;
	let key = "dept";
	let word = $(frm.dept).val();
	
	$(frm.dept).on("change", function(){
		word = $(frm.dept).val();
		getData();
	});
	
	//tr을 눌렀을때 
	$("#div_pro").on("click", "tr", function(){
		const pcode=$(this).attr("pcode");
		const pname=$(this).attr("pname");
		//alert(pcode + pname);
		$(frm.advisor).val(pcode);
		$(frm.pname).val(pname);
		$("#modal").modal("hide");
	});
	
	getData();
	function getData(){
		$.ajax({
			type:"get",
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
</script>





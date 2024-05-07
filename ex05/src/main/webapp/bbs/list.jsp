<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div>
<h1>자유 게시판</h1>
<div id="div_bbs"></div> <!-- 밑에 스크립드들은 데이터출력을 위한 도구일뿐 결국 데이터는 여기에 들어오는것. -->
<div id="pagination" class="pagination justify-content-center mt-5"></div>
</div>


<script id="temp_bbs" type="x-handlebars-template">
    <table class="table table-bordered table-dark" style ="text-align: center;">
        <tr>
            <td>번호</td>
		<td>제목</td>
		<td>작성자</td>
		<td>작성일</td>
        </tr>
        {{#each .}}
            <tr>
                <td>{{bid}}</td>
                <td><a href="/bbs/read?bid={{bid}}" style = "text-decoration : none; color: white;">{{title}}</td></a> <!-- 데이터가 넘어가는 링크를 걸어준다. -->
                <td>{{uname}}({{writer}})</td>
                <td>{{bdate}}</td>
            </tr>
        {{/each}}
    </table>
</script>
	<div class = "col">
		<span id="total"></span>
	</div>


<script> //ajax은 스크립트에서 쓴다.
	let page = 1; //시작페이지설정해주기 
	let size = 10;
	let query="";
	
	getData();
 	function getData() { //함수로 쓴이유는 여러번 해야하기때문에 
 		$.ajax({ //데이터 호출시 ajax을 함수로 쓴다. 
           		type: "get",
           	 	url: "/bbs/list.json", // 로컬서버는 ~3000까지는 생략가능 
           	 	dataType: "json",
           	 	data:{page, size, query},
           		success: function (data) { //url의 데이터가 여기로 들어감 
                		// alert("성공~");
                		const temp = Handlebars.compile($("#temp_bbs").html()); //아이디가 tempPosts인걸 html로 compile해서 temp에 저장 
                		$("#div_bbs").html(temp(data)); // temp에 data를 넣고  div_bbs에 출력   
                		
                 		//$("#page").html(page); //데이터 불러오기 성공을 하면 #page를 출력해라  이거없으면 번호가 가감이 안된다. 
                 		//if(page == 1){ //1페이지일대 이전버튼안눌리게하기
                  	//   $("#prev").attr("disabled", true)
                 		//}else{
                		//   $("#prev").attr("disabled", false)
               		//}
                 		
            	}
        	});
    	}
 	getTotal(); //토탈데이터 가져오고 호출해주기 
 	function getTotal(){
 		$.ajax({
 			type:"get",
 			url:"/bbs/total",
 			data:{query},
 			success:function(data){
 //				alert(data);
 				if(data==0){
 					alert("표시 할 내용이 없습니다.")
 					$(frm.query).val("");
 					$(frm.query).focus();
 				}else{
 				const totalPage=Math.ceil(data/size);
 				$("#pagination").twbsPagination("changeTotalPages", totalPage, page);
 				$("#total").html("검색수 :" + data + "건")
 				}
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


</script>


<script>
//다음버튼 클릭
//$("#next").on("click", function () {//page를 1업하고 싶은데 page의 변수가 없으니 전역변수로 하나 설정해주자
//    page++;
//    getData();
//});
//$("#prev").on("click", function () {//page를 1업하고 싶은데 page의 변수가 없으니 전역변수로 하나 설정해주자
//    page--;
//    getData();
//});
</script>

<div class="row">
	<div class="col-6 col-md-4 col-lg-3 mb-2">
		<form name="frm">
			<div class="input-group">
				<input class="form-control" name="query">
				<button class="btn btn-primary">검색</button>
			</div>
		</form>
	</div>
	<div class="col text-end" id="divWrite" > <!-- 아무튼 div안에 넣어야 만지기가 편하다. -->
	        <a href="/bbs/insert"><button class="btn btn-secondary">글쓰기 </button></a> <!--누르면 a태그의 지정된 곳으로 가자 -->
	</div>
</div>

<script> //글쓰기 보이기 안보이기 아이템을 안가져와도 되는이유는 메뉴에서 이미 가져오기때문이다.  //기본으로 숨겨놓고 아이디가 있으면 보이고 없으면 숨기기 한것.
    if (uid) {
        $("#divWrite").show();
    }//그러니까 else가 사실 피료없다.  근데 jsp에서는 있어야 한다. 
     else{
         $("#divWrite").hide();
     }
	$(frm).on("submit", function(e){
		 e.preventDefault();
		 query=$(frm.query).val();
//		 alert(query);
		getTotal();
	});
</script>



<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<h1>도서검색 </h1>
<div class = "row mb-2">
    <div class = "col-6 col-md-4"> <!-- 해상도에 따라 큰거일때 6 작은거일때 4로 한다.-->
        <form action="" class="input-group mb-3" name = "frm">
            <input type="text" class = "form-control form-control-lg " name = "query" value = "자바의 정석" placeholder="검색하실 책제목을 입력하세요">
            <button class="btn btn-primary" >검색</button>
            <br>
        </form>
    </div>

</div>

<div id = "div_book" class="row"></div>
<div class = "text-center my-4"> <!-- my는 마직 y축이라는 뜻-->
    <button class = "btn btn-primary" id = "prev">이전</button>
    <span class = "mx-2" id = "page"><b>1</b></span> <!-- 같은줄에 하기위해 div아니고 span으로 한거임. -->
    <button class = "btn btn-danger" id = "next">다음</button>
</div>

<script id="temp_book" type="X-handlebars-template">
	{{#each documents}}
		<div class="col-6 col-md-4 col-lg-2">
			<div class="card">
				<div class="card-body">
					<img src="{{check thumbnail}}">
				</div>
				<div class="card-footer">
					<div class="ellipsis">{{title}}</div>
				</div>
			</div>
		</div>
	{{/each}}
</script>

<script>
	var myQuery = $(frm.query).val(); //frm폼안에있는 query에 있는 밸류값을 들고와서 qeury변수 안에 넣어준다.
	var page = 1;
	getData();
	
    //이미지를 클릭한경우 
    $("#div_book").on("click", "img", function(){
       const id=$(this).attr("id");
//    alert(id);
    $("#modal" + id).modal("show");
    });
    
    //이미지 유무 체크 함수 만들기 
    Handlebars.registerHelper("check", function(thumbnail){
        if(thumbnail){
            return thumbnail;
        }else{
            return "http://via.placeholder.com/146x174"
        }
    });
    
    
    //다음버튼 클릭
    $("#next").on("click", function(){//page를 1업하고 싶은데 page의 변수가 없으니 전역변수로 하나 설정해주자
        page++;
        getData();
    });
    $("#prev").on("click", function(){//page를 1업하고 싶은데 page의 변수가 없으니 전역변수로 하나 설정해주자
        page--;
        getData();
    });
    $(frm).on("submit", function(e){ //frm 이 submit이벤트를  function(e)에 넣어줌. 
        e.preventDefault(); //e를 막아라.
        myQuery=$(frm.query).val();
        if(myQuery == ""){
            alert("검색하실 제목을 입력하세요.")
        }else{
            page = 1; 
            getData();
        }
    });
	function getData(){
		$.ajax({
			type :"get",
			url:"https://dapi.kakao.com/v3/search/book?target=title",
			headers:{"Authorization":"KakaoAK 89e3021ad2846184fd12b67daf705b0f"},
			dataType:"json",
			data:{"query": myQuery, page:page, size:6},
			success:function(data){
				console.log(data);
				const temp=Handlebars.compile($("#temp_book").html());
				$("#div_book").html(temp(data));
				const last = Math.ceil(data.meta.pageable_count/6);
	                $("#page").html(page + "/" +last);
	                if(page == 1){
	                    $("#prev").attr("disabled", true)
	                }else{
	                    $("#prev").attr("disabled", false)
	                }
	                if(data.meta.is_end){
	                    $("#next").attr("disabled", true)
	                }else{
	                    $("#next").attr("disabled", false)
	                }
			}
		});
	}
</script>



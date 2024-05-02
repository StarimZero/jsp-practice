package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(value={"/post/list", "/kakao/locall"})
public class PostsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp"); //루트에서 home을 꺼내오고 
		switch(request.getServletPath()){
			case "/post/list":
				request.setAttribute("pageName", "/post/list.jsp");  //케이스이거면 페이지네임에 /kakao/book을 넣어줘라 
				System.out.println("카카오 로컬로 갈까요?");
				break;
		}
		dis.forward(request, response); //dis로가라 dis=/home.jsp로 되어있자나. 근데 switch로  request를 이용해서 정의를 해놨자나.  여기가 이동하는 명령어임.
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}
}

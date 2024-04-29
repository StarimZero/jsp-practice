package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.*;


@WebServlet(value = {"/user/login", "/user/mypage", "/user/join", "/user/logout"}) //슬래쉬빼면 500오류 난다. 아니면 중복되거나 
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserDAO dao = new UserDAO(); //여기다 해주면 get이던 post이던 다 쓸수 있을것.
	
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp"); //루트에서 home을 꺼내오고 
		switch(request.getServletPath()){
		case "/user/logout":
			HttpSession session=request.getSession();
			session.invalidate();
			response.sendRedirect("/");
			break;
		case "/user/login":
			request.setAttribute("pageName", "/user/login.jsp"); //케이스이거면 페이지네임에 /kakao/book을 넣어줘라 
			System.out.println("login으로 갈까요?");
			dis.forward(request, response); //dis로가라 dis=/home.jsp로 되어있자나. 근데 switch로  request를 이용해서 정의를 해놨자나.  여기가 이동하는 명령어임.
			break;
		case "/user/mypage":
			request.setAttribute("pageName", "/user/mypage.jsp");  //케이스이거면 페이지네임에 /kakao/book을 넣어줘라 
			System.out.println("mypage로 갈까요?");
			break;
		case "/user/join":
			request.setAttribute("pageName", "/user/join.jsp");  //케이스이거면 페이지네임에 /kakao/book을 넣어줘라 
			System.out.println("Join 으로 갈까요??");
			break;
		}
	}
	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		switch(request.getServletPath()){
		case "/user/login":
			String uid=request.getParameter("uid"); //uid라는 값을 uid에 저장
			String upass=request.getParameter("upass"); //upass에 들오곤 값을 upass에 저장.
			System.out.println(uid+":"+upass); //어떻게 받아왔는지 찍어보자. 
			
			int result =0;
			UserVO vo = dao.read(uid);
			if(vo.getUid() != null) {
				if(upass.equals(vo.getUpass())) { //성공한경우
					HttpSession session=request.getSession();
					session.setAttribute("uid", uid);
					result=1;
				}else {
					result=2;
				}
			}
			out.print(result);
			break;
		}
	}
}

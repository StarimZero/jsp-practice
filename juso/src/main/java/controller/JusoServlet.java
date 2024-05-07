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

import com.google.gson.Gson;

import model.JusoDAOImpl;
import model.JusoVO;

@WebServlet(value = {"/juso/list", "/juso/insert", "/juso/delete", "/juso/update", "/juso/list.json"})
public class JusoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	JusoDAOImpl dao = new JusoDAOImpl();



	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp"); //루트에서 home을 꺼내오고 
		PrintWriter out = response.getWriter(); //이거 브라우져에 출력할려면 있어야함.
		switch(request.getServletPath()){
		
		case "/juso/list":
			request.setAttribute("pageName", "/juso/list.jsp"); //케이스이거면 페이지네임에 /kakao/book을 넣어줘라 
			dis.forward(request, response);
			System.out.println("주소리스트로갑니다.");
			break;
			
		case "/juso/list.json":
			Gson gson = new Gson();
			out.print(gson.toJson(dao.list()));
			break;
		
		case "/juso/insert":
			request.setAttribute("pageName", "/juso/insert.jsp"); //케이스이거면 페이지네임에 /kakao/book을 넣어줘라
			dis.forward(request, response);
			System.out.println("주소등록으로갑니다.");
		break;
		
		case "/juso/delete":
			request.setAttribute("pageName", "/juso/delete.jsp"); //케이스이거면 페이지네임에 /kakao/book을 넣어줘라
			dis.forward(request, response);
			System.out.println("주소삭제로갑니다.");
			break;
		
		
		case "/juso/update":
			request.setAttribute("pageName", "/juso/update.jsp"); //케이스이거면 페이지네임에 /kakao/book을 넣어줘라
			dis.forward(request, response);
			System.out.println("주소수정으로갑니다.");
			break;
	
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		switch(request.getServletPath()){
			case  "/juso/insert":
				JusoVO vo = new JusoVO();
				vo.setUname(request.getParameter("uname"));
				vo.setAdd1(request.getParameter("add1"));
				vo.setPhone(request.getParameter("phone"));
				System.out.println(vo.toString());
				dao.insert(vo);
				response.sendRedirect("/juso/list");
				break;
				
			case "/juso/delete":
				int uid=Integer.parseInt(request.getParameter("uid"));
				dao.delete(uid);
				break;
		}
	}
}

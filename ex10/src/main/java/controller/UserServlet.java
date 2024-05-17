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

import model.UserDAO;
import model.UserVO;

@WebServlet(value = {"/user/login", "/user/logout", "/user/mypage", "/user/update", "/user/update/pass", "/user/upload", "/user/join", "/user/list", "/user/list.json"})
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserDAO dao = new UserDAO(); //여기다 해주면 get이던 post이던 다 쓸수 있을것.
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		HttpSession session=request.getSession();
		PrintWriter out = response.getWriter(); //이거 브라우져에 출력할려면 있어야함.
		
		switch(request.getServletPath()) {
		
		case "/user/login":
			request.setAttribute("pageName", "/user/login.jsp");
			dis.forward(request, response);
			break;
		case "/user/logout":
			session.invalidate();
			response.sendRedirect("/"); //이동시켜주기 
			break;
		
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter(); //이건 여기서한 값을 프론트로 넘겨주기위한 도구임.
		UserVO vo = new UserVO();
		String uid = request.getParameter("uid");
		switch(request.getServletPath()) {
		
		
		case "/user/login":
			uid=request.getParameter("uid"); //프론트에서온 uid라는 값을 uid에 저장
			String upass=request.getParameter("upass"); //upass에 들오곤 값을 upass에 저장.
			System.out.println(uid+":"+upass); //어떻게 받아왔는지 찍어보자. 
			
			int result =0; //null이면 이값이 나오겠지 if문을 안할거니 
			vo = dao.read(uid);
			
			if(vo.getUid() != null) {
				if(vo.getUpass().equals(upass)) {
					System.out.println(".............." + vo.toString());
					HttpSession session=request.getSession();
					session.setAttribute("uname", vo.getUname());
					session.setAttribute("uid", vo.getUid());
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

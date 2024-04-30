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


@WebServlet(value = {"/user/login", "/user/logout", "/user/mypage", "/user/update", "/user/update/pass"})
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserDAO dao = new UserDAO(); //여기다 해주면 get이던 post이던 다 쓸수 있을것.


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		HttpSession session=request.getSession();
		switch(request.getServletPath()){
		case "/user/mypage":
			String uid = (String)session.getAttribute("uid");
			request.setAttribute("user", dao.read(uid)); //
			request.setAttribute("pageName", "/user/mypage.jsp");
			dis.forward(request, response); 
			System.out.println("mypage로 갈까요?");
			break;
		case "/user/logout":
			session.invalidate();
			response.sendRedirect("/"); //이동시켜주기 
			break;
		case "/user/login":
			request.setAttribute("pageName", "/user/login.jsp");
			dis.forward(request, response);
			break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter(); //이건 여기서한 값을 프론트로 넘겨주기위한 도구임.
		switch(request.getServletPath()){
		
		case "/user/update/pass": // 패스워드 변경 
			String uidp=request.getParameter("uid");
			String npass=request.getParameter("npass");
			dao.update(uidp, npass);
			break;
		
		case"/user/update":
			UserVO vo = new UserVO();
			String uid = request.getParameter("uid"); // 프론트에서 보낸 값을 받자
			vo.setUid(uid);
			vo.setUname(request.getParameter("uname"));
			vo.setPhone(request.getParameter("phone"));
			vo.setAdd1(request.getParameter("add1"));
			vo.setAdd2(request.getParameter("add2"));
			
			System.out.println(vo.toString());
			dao.update(vo); //데이터베이스에 업데이트 
			break;

		case "/user/login":
			uid=request.getParameter("uid"); //프론트에서온 uid라는 값을 uid에 저장
			String upass=request.getParameter("upass"); //upass에 들오곤 값을 upass에 저장.
			System.out.println(uid+":"+upass); //어떻게 받아왔는지 찍어보자. 
			
			int result =0; //null이면 이값이 나오겠지 if문을 안할거니 
			vo = dao.read(uid);
			if(vo.getUid() != null) {
				if(upass.equals(vo.getUpass())) { //성공한경우
					HttpSession session=request.getSession();
					session.setAttribute("userInfo", vo); //vo를 들고와보자 
					session.setAttribute("uid", uid); //uid를 uid에 넣어주자.
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

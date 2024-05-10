package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.QueryVO;
import model.StuVO;
import model.CouDAOImpl;
import model.CouVO;


@WebServlet(value= {"/cou/list", "/cou/list.json", "/cou/total", "/cou/insert", "/cou/read", "/cou/delete", "/cou/update"})
public class CoursesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CouDAOImpl dao = new CouDAOImpl();
       


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		switch(request.getServletPath()) {
		
	
		
		case "/cou/update":
			System.out.println("업데이트로 갑니다.");
			String lcode=request.getParameter("lcode");
			request.setAttribute("cou", dao.read(lcode));
			request.setAttribute("pageName", "/cou/update.jsp");
			dis.forward(request, response);
			break;
		
		case  "/cou/read":
			request.setAttribute("cou", dao.read(request.getParameter("lcode")));
			request.setAttribute("pageName", "/cou/read.jsp");
			dis.forward(request, response);
			break;
		
		case "/cou/insert":
			System.out.println("강좌등록 페이지로 이동합니다.");
			request.setAttribute("code", dao.getCode());
			request.setAttribute("pageName", "/cou/insert.jsp");
			dis.forward(request, response);
			break;
		
		case "/cou/list":
			System.out.println("강좌관리 페이지로 이동합니다.");
			request.setAttribute("pageName", "/cou/list.jsp");
			dis.forward(request, response);
			break;
		
		case "/cou/list.json": //테스트 : http://localhost:8080/cou/list.json?key=instructor&word=510&page=1&size=100
			QueryVO vo=new QueryVO();
			int page = request.getParameter("page") == null ? 1: Integer.parseInt(request.getParameter("page"));
			int size = request.getParameter("size") == null ? 2: Integer.parseInt(request.getParameter("size"));
			String key = request.getParameter("key") == null ? "lname": request.getParameter("key");
			String word = request.getParameter("word") == null ? "": request.getParameter("word");
			vo.setPage(page);
			vo.setSize(size);
			vo.setKey(key);
			vo.setWord(word);
			Gson gson = new Gson();
			out.print(gson.toJson(dao.list(vo)));
			break;
			
		case "/cou/total": //테스트 /cou/total?key=lname&word=리
			String key1=request.getParameter("key")==null ? "lcode" : request.getParameter("key");
			String word1=request.getParameter("word")==null ? "" : request.getParameter("word");
			//nuill체크안하기  vo1.setKey(request.getParameter("key"));
			QueryVO  vo1=new QueryVO();
			vo1.setKey(key1);
			vo1.setWord(word1);
			out.print(dao.total(vo1));
			break;
		
		
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("UTF-8");
		switch(request.getServletPath()) {
		case "/cou/insert":
			CouVO vo = new CouVO();
			vo.setLcode(request.getParameter("lcode"));
			vo.setLname(request.getParameter("lname"));
			vo.setHours(Integer.parseInt(request.getParameter("hours")));
			vo.setRoom(request.getParameter("room"));
			vo.setInstructor(Integer.parseInt(request.getParameter("instructor")));
			vo.setCapacity(Integer.parseInt(request.getParameter("capacity")));
			vo.setPersons(Integer.parseInt(request.getParameter("persons")));
			dao.insert(vo);
			response.sendRedirect("/cou/list");
			break;
			
		case "/cou/delete":
			int result = dao.delete(request.getParameter("lcode"));
			out.print(result);
			break;
			
		case "/cou/update":
			vo = new CouVO();
			vo.setLcode(request.getParameter("lcode"));
			vo.setLname(request.getParameter("lname"));
			vo.setHours(Integer.parseInt(request.getParameter("hours")));
			vo.setRoom(request.getParameter("room"));
			vo.setInstructor(Integer.parseInt(request.getParameter("instructor")));
			vo.setCapacity(Integer.parseInt(request.getParameter("capacity")));
			vo.setPersons(Integer.parseInt(request.getParameter("persons")));
			dao.update(vo);
			response.sendRedirect("/cou/read?lcode=" + request.getParameter("lcode"));
			break;
	
		}
	}
}

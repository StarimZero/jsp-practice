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
import model.StuDAOImpl;
import model.StuVO;


@WebServlet(value= {"/stu/list", "/stu/list.json", "/stu/total", "/stu/insert", "/stu/read", "/stu/delete"})
public class StudentsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	StuDAOImpl dao = new StuDAOImpl();
       


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		switch(request.getServletPath()){
		
		case "/stu/read":
			request.setAttribute("stu", dao.read(request.getParameter("scode")));
			request.setAttribute("pageName", "/stu/read.jsp");
			dis.forward(request, response);
			break;
		case "/stu/insert":
			System.out.println("학생등록 페이지로 이동합니다.");
			request.setAttribute("code", dao.getCode());
			request.setAttribute("pageName", "/stu/insert.jsp");
			dis.forward(request, response);
			break;
		case "/stu/total": //테스트 = /stu/total?key=dept&word=건축
			String key1=request.getParameter("key")==null ? "scode" : request.getParameter("key");
			String word1=request.getParameter("word")==null ? "" : request.getParameter("word");
			//nuill체크안하기  vo1.setKey(request.getParameter("key"));
			QueryVO  vo1=new QueryVO();
			vo1.setKey(key1);
			vo1.setWord(word1);
			out.print(dao.total(vo1));
			break;
		case "/stu/list.json": //테스트 : /stu/list.json?page=1&size=2&key=dept&word=전산
			QueryVO vo=new QueryVO();
			int page = request.getParameter("page") == null ? 1: Integer.parseInt(request.getParameter("page"));
			int size = request.getParameter("size") == null ? 2: Integer.parseInt(request.getParameter("size"));
			String key = request.getParameter("key") == null ? "scode": request.getParameter("key");
			String word = request.getParameter("word") == null ? "": request.getParameter("word");
			vo.setPage(page);
			vo.setSize(size);
			vo.setKey(key);
			vo.setWord(word);
			Gson gson = new Gson();
			out.print(gson.toJson(dao.list(vo)));
			break;
		case "/stu/list":
			System.out.println("학생관리 페이지로 이동합니다.");
			request.setAttribute("pageName", "/stu/list.jsp");
			dis.forward(request, response);
			break;
		
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("UTF-8");
		switch(request.getServletPath()) {
		case "/stu/insert":
			StuVO vo = new StuVO();
			vo.setScode(request.getParameter("scode"));
			vo.setSname(request.getParameter("sname"));
			vo.setSdept(request.getParameter("dept"));
			vo.setYear(Integer.parseInt(request.getParameter("year")));
			vo.setAdvisor(request.getParameter("advisor"));
			vo.setBirthday(request.getParameter("birthday"));
			dao.insert(vo);
			response.sendRedirect("/stu/list");
			break;
		case "/stu/delete":
			int result = dao.delete(request.getParameter("scode"));
			out.print(result);
			break;
		
		}
	}
}

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

import model.*;


@WebServlet(value={"/bbs/list.json", "/bbs/list", "/bbs/insert", "/bbs/read", "/bbs/delete", "/bbs/update", "/bbs/total" })
public class BBSServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;   
	BBSDAOImpl dao = new BBSDAOImpl();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp"); //루트에서 home을 꺼내오고 

		switch(request.getServletPath()){ // 주소를 보여달라 = request 가져오는거 = getServlePath
			case "/bbs/list":
				request.setAttribute("pageName", "/bbs/list.jsp");  //케이스이거면 페이지네임에 /bbs/list를 넣어줘라 
				dis.forward(request, response);//dis로가라 dis=/home.jsp로 되어있자나. 근데 switch로  request를 이용해서 정의를 해놨자나.  여기가 이동하는 명령어임.
				System.out.println("게시판으로 갑니다.");
				break;
			
			case "/bbs/list.json":
				String query=request.getParameter("query") != null ? request.getParameter("query") : ""; //널이 아니면 앞에꺼를하고 널이면 뒤에꺼를 해라
				int page=request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1; //널이 아니면 앞에꺼를하고 널이면 뒤에꺼를 해라
				int size=request.getParameter("size") != null ? Integer.parseInt(request.getParameter("size")) : 10; //사이지를 지정하면 그거 아니면 디폴트값10이다. 확인해볼거면 // http://localhost:8080/bbs/list.json?page=1&size=3
				Gson gson = new Gson();
				out.print(gson.toJson(dao.list(page, size, query)));
				break;
				
			case  "/bbs/read":
				String bid=request.getParameter("bid");
				System.out.println("bid는 뭘까요?" + bid);
				BBSVO vo=dao.read(Integer.parseInt(bid)); 
				request.setAttribute("bbs", vo);
				request.setAttribute("pageName", "/bbs/read.jsp");
				dis.forward(request, response);
				break;
				
			case  "/bbs/update":
				bid=request.getParameter("bid");
				BBSVO bbs=dao.read(Integer.parseInt(bid));
				request.setAttribute("bbs", bbs);
				request.setAttribute("pageName", "/bbs/update.jsp");
				dis.forward(request, response);
				break;
				
			case "/bbs/insert":
				request.setAttribute("pageName", "/bbs/insert.jsp");
				dis.forward(request, response);
				break;
			
			case "/bbs/total":
				String query1 = request.getParameter("query")==null ? "": request.getParameter("query");
				out.print(dao.total(query1));
				break;
				
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		switch(request.getServletPath()) {
		case "/bbs/insert":
			BBSVO vo = new BBSVO();
			vo.setWriter(request.getParameter("writer"));
			vo.setTitle(request.getParameter("title"));
			vo.setContents(request.getParameter("contents"));
			System.out.println(vo.toString());
			dao.insert(vo);
			response.sendRedirect("/bbs/list");
			break;
			
		case  "/bbs/delete":
			String bid=request.getParameter("bid"); //bid를 받을때는 무조건 STRING입니다. 
			System.out.println("삭제할 게시글의 bid가 받아집니까?" +  bid);
			dao.delete(Integer.parseInt(bid));
			break;
			
		case  "/bbs/update":
			vo = new BBSVO();
			vo.setBid(Integer.parseInt(request.getParameter("bid")));
			vo.setTitle(request.getParameter("title"));
			vo.setContents(request.getParameter("contents"));
			System.out.println(vo.toString());
			dao.update(vo);
			response.sendRedirect("/bbs/list");
			break;
		}
	}
}







package model;
import java.sql.*;


public class TestDB {

	public static void main(String[] args) {
//		Connection con = Database.CON;
//		ProDAOImpl dao = new ProDAOImpl();
//		QueryVO vo=new QueryVO();
//		vo.setPage(1);
//		vo.setSize(2);
//		vo.setKey("dept");
//		vo.setWord("건축");
//		dao.list(vo);
//		System.out.println("검색수" + dao.total(vo));
//		System.out.println("새로운 코드= " + dao.getCode());
//		dao.read("510");
//		dao.read("511");
//		dao.read("509");
//		StuDAOImpl dao=new StuDAOImpl();
//		QueryVO vo=new QueryVO();
//		vo.setPage(1);
//		vo.setSize(2);
//		vo.setKey("dept");
//		vo.setWord("건축");
//		dao.list(vo);
//		System.out.println("검색수" + dao.total(vo));
//		System.out.println("새로운 코드= " + dao.getCode());
//		dao.read("96414405");
//		int result=dao.delete("96414404");
//		System.out.println("결과" + result);
//			CouDAOImpl dao = new CouDAOImpl();
//			QueryVO vo=new QueryVO();
//			vo.setPage(1);
//			vo.setSize(3);
//			vo.setKey("lname");
//			vo.setWord("리");
//			dao.list(vo);
//			System.out.println("검색수" + dao.total(vo));
//			dao.read("E522");
		
			
//			UserDAO dao = new UserDAO();
//			UserVO vo = dao.read("admin");
//			System.out.println(vo.toString());
				EnrollDAO dao = new EnrollDAO();
//				dao.list("92414029");
				dao.slist("C301");
				
			
			
	}

}

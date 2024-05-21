package model;

public class TestDB {

	public static void main(String[] args) {
		//UserDAO dao=new UserDAO();
		//UserVO vo=dao.read("blue");
		//System.out.println(vo.toString());
		//CartDAO dao = new CartDAO();
		//dao.list("red");
		//GoodsDAO dao = new GoodsDAO();
		OrderDAO dao = new OrderDAO();
		QueryVO vo = new QueryVO();
		vo.setKey("rname");
		vo.setWord("붉");
		vo.setPage(1);
		vo.setSize(3);
		dao.list(vo);
		
	}

}

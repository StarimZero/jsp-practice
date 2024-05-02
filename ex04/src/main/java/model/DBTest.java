package model;

public class DBTest {

	public static void main(String[] args) {
		BBSDAOImpl dao = new BBSDAOImpl();
//		dao.list();
		dao.read(3);

	}

}

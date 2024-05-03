package model;

public class DBTest {

	public static void main(String[] args) {
//		BBSDAOImpl dao = new BBSDAOImpl();
//		dao.list();
//		dao.read(3);;
//		System.out.println("총 개수는?" + dao.total());
//		dao.list(1, 3, "조심");
//		System.out.println("red Count : " + dao.total("red"));
			CommentDAOImpl dao = new CommentDAOImpl();
//		dao.list(206, 1, 5);
//		System.out.println("206번글의 댓글 수 " + dao.total(206));
			CommentVO vo=new CommentVO();
			vo.setBid(206);
			vo.setWriter("red");
			vo.setContents("이게 등록이 됩니까?");
			dao.insert(vo);
	}

}

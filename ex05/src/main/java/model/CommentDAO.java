package model;

import java.util.*;

public interface CommentDAO {
	public ArrayList<CommentVO> list(int bid, int page, int size); // 목록
	public void insert(CommentVO vo); // 등록
	public void update(CommentVO vo); // 수정
	public void delete(int cid); // 삭제
	public int total(int bid); //댓글수 
}

package model;

import java.util.*;

public interface BBSDAO {

	public ArrayList<BBSVO> list(); // 여러개 목록 출력
	public void insert(BBSVO vo); //한개입력
	public BBSVO read(int bid); // 한개읽기
	public void update(BBSVO vo); //하나 수정
	public void delete(int bid);//한개 삭제 
	public ArrayList<BBSVO> list(int page, int size);

}

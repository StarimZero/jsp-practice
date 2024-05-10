package model;

import java.util.*;

public interface ProDAO {

	public ArrayList<ProVO> list(QueryVO vo); // 여러개 목록 출력 베이직 
	public void insert(ProVO vo); //한개입력
	public ProVO read(String pcode); // 한개읽기
	public void update(ProVO vo); //하나 수정
	public int delete(String pcode);//한개 삭제 
	public ArrayList<ProVO> list(int page, int size);//페이징 목록
	public int total(); //데이터갯수구하기
	public int total(QueryVO vo); // 검색데이터 갯수 구하기 
	public String getCode(); // 새로운 코드 가져오기
	
}

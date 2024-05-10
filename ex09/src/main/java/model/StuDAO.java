package model;

import java.util.ArrayList;

public interface StuDAO {
	public ArrayList<StuVO> list(QueryVO vo); // 여러개 목록 출력 검색 베이직
	public void insert(StuVO vo); //한개입력
	public StuVO read(String scode); // 한개읽기
	public void update(StuVO vo); //하나 수정
	public int delete(String scode);//한개 삭제  이거 성공하면1 실패하면 0으로 할려고 int로 받은거
	public ArrayList<StuVO> list(int page, int size);//페이징 목록
	public int total(); //데이터갯수구하기
	public int total(QueryVO vo); // 검색데이터 갯수 구하기 
	public String getCode(); // 새로운 학번 가져오기
}

package model;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.print.attribute.standard.PresentationDirection;

public class BBSDAOImpl implements BBSDAO{
	Connection con=Database.CON;
	SimpleDateFormat sdf=new SimpleDateFormat("yy-MM-dd HH:mm:ss");
	
	@Override
	public ArrayList<BBSVO> list() {
		ArrayList<BBSVO> array = new ArrayList<BBSVO>();
		try {	
			String sql = "select * from view_bbs order by bid desc";
			PreparedStatement ps = con.prepareStatement(sql); //가져온 sql을 ps에 넣자.
			ResultSet rs = ps.executeQuery(); //sql을 실행해서 rs에 넣자.
			while(rs.next()) { //rs를 반복해서 가져오자.
				BBSVO vo = new BBSVO(); //빈 vo를 하나만들자.
				vo.setBid(rs.getInt("bid"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setBdate(sdf.format(rs.getTimestamp("bdate")));
				vo.setUname(rs.getString("uname"));
				vo.setPhoto(rs.getString("photo"));
				vo.setContents(rs.getString("contents"));
				array.add(vo); //가져온 vo를 array에 넣어주자. 
				//System.out.println(vo.toString());
			}
		}catch(Exception e){
			System.out.println("게시판 목록sql 오류 " + e.toString());
		}
		return array;
	}

	@Override
	public void insert(BBSVO vo) {
		try {
			String sql="insert into bbs(title,contents,writer) values(?,?,?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, vo.getTitle());
			ps.setString(2, vo.getContents());
			ps.setString(3, vo.getWriter());
			ps.execute();
		}catch(Exception e){
			System.out.println("글 게시하다가 오류난것." + toString());
		}
		
	}

	@Override
	public BBSVO read(int bid) {
		BBSVO vo = new BBSVO();
		try {
			String sql = "select * from view_bbs where bid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, bid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				vo.setBid(rs.getInt("bid"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setBdate(sdf.format(rs.getTimestamp("bdate")));
				vo.setUname(rs.getString("uname"));
				vo.setPhoto(rs.getString("photo"));
				vo.setContents(rs.getString("contents"));
			}
			
		}catch(Exception e){
			System.out.println("글읽기 오류 " + e.toString());
		}
		return vo;
	}

	@Override
	public void update(BBSVO vo) {
		try {
			String sql = "update bbs set title=?, contents=?, bdate=now() where bid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, vo.getTitle());
			ps.setString(2, vo.getContents());
			ps.setInt(3, vo.getBid());
			ps.execute();
		}catch(Exception e){
			System.out.println("글수정 할때 오류입니다." + e.toString());
		}
		
	}

	@Override
	public void delete(int bid) {
		try {
			String sql = "delete from bbs where bid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, bid);
			ps.execute();
		}catch(Exception e){
			System.out.println("삭제할때 오류입니당" + e.toString());
		}
		
	}

	@Override
	public ArrayList<BBSVO> list(int page, int size) {
		ArrayList<BBSVO> array = new ArrayList<BBSVO>();
		try {	
			String sql = "select * from view_bbs order by bid desc";
			sql+= " limit ?, ?";
			PreparedStatement ps = con.prepareStatement(sql); //가져온 sql을 ps에 넣자.
			ps.setInt(1, (page - 1) * size); //스타트값 
			ps.setInt(2, size);
			ResultSet rs = ps.executeQuery(); //sql을 실행해서 rs에 넣자.
			while(rs.next()) { //rs를 반복해서 가져오자.
				BBSVO vo = new BBSVO(); //빈 vo를 하나만들자.
				vo.setBid(rs.getInt("bid"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setBdate(sdf.format(rs.getTimestamp("bdate")));
				vo.setUname(rs.getString("uname"));
				vo.setPhoto(rs.getString("photo"));
				vo.setContents(rs.getString("contents"));
				array.add(vo); //가져온 vo를 array에 넣어주자. 
				//System.out.println(vo.toString());
			}
		}catch(Exception e){
			System.out.println("게시판 목록sql 오류 " + e.toString());
		}
		return array;
	}

	@Override
	public int total() {
		int total=0;
		try {
			String sql = "select count(*) total from bbs";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) total = rs.getInt("total");
		}catch(Exception e){
			System.out.println("전체데이터 개수 구하기 오류" + e.toString());
		}
		return total;
	}

	@Override
	public ArrayList<BBSVO> list(int page, int size, String query) {
		ArrayList<BBSVO> array = new ArrayList<BBSVO>();
		query = "%" + query + "%";
		try {	
			String sql = "select * from view_bbs ";
			sql+= " where title like ? or contents like ? or writer like ?";
			sql+= " order by bid desc";
			sql+= " limit ?, ?";
			PreparedStatement ps = con.prepareStatement(sql); //가져온 sql을 ps에 넣자.
			ps.setString(1, query);
			ps.setString(2, query);
			ps.setString(3, query);
			ps.setInt(4, (page - 1) * size); //스타트값 
			ps.setInt(5, size);
			ResultSet rs = ps.executeQuery(); //sql을 실행해서 rs에 넣자.
			while(rs.next()) { //rs를 반복해서 가져오자.
				BBSVO vo = new BBSVO(); //빈 vo를 하나만들자.
				vo.setBid(rs.getInt("bid"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setBdate(sdf.format(rs.getTimestamp("bdate")));
				vo.setUname(rs.getString("uname"));
				vo.setPhoto(rs.getString("photo"));
				vo.setContents(rs.getString("contents"));
				array.add(vo); //가져온 vo를 array에 넣어주자. 
				System.out.println(vo.toString());
			}
		}catch(Exception e){
			System.out.println("게시판 목록sql 오류 " + e.toString());
		}
		return array;
	}

	@Override
	public int total(String query) {
		int total=0;
		query = "%" + query + "%";
		try {
			String sql = "select count(*) total from bbs";
			sql+= " where title like ? or contents like ? or writer like ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, query);
			ps.setString(2, query);
			ps.setString(3, query);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) total = rs.getInt("total");
		}catch(Exception e){
			System.out.println("검색 개수 구하기 오류" + e.toString());
		}
		return total;
	}
}

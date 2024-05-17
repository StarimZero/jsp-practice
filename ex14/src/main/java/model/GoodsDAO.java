package model;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;


public class GoodsDAO {
	Connection con = Database.CON;
	SimpleDateFormat sdf=new SimpleDateFormat("yy년MM월dd일");
	
	//좋아요 목록 보기 
	public ArrayList<GoodsVO> list(QueryVO query, String uid){
		ArrayList<GoodsVO> array = new ArrayList<GoodsVO>();
		try {
			String sql = "select *, (select count(*) from favorite f where uid=? and f.gid=g.gid) ucnt, (select count(*) from favorite f where f.gid=g.gid) fcnt, (select count(*) from review r where r.gid=g.gid) rcnt from goods g where title like ? order by regDate desc limit ?, ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, uid);
			ps.setString(2, "%" + query.getWord() + "%");
			ps.setInt(3, (query.getPage()-1) * query.getSize());
			ps.setInt(4, query.getSize());
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				GoodsVO vo = new GoodsVO();
				vo.setGid(rs.getString("gid"));
				vo.setTitle(rs.getString("title"));
				vo.setBrand(rs.getString("brand"));
				vo.setPrice(rs.getInt("price"));
				vo.setImage(rs.getString("image"));
				vo.setRegDate(rs.getString("regDate"));
				vo.setCategory3(rs.getString("category3"));
				vo.setLink(rs.getString("link"));
				vo.setMallName(rs.getString("mallName"));
				vo.setUcnt(rs.getInt("ucnt"));
				vo.setFcnt(rs.getInt("fcnt"));
				vo.setRcnt(rs.getInt("rcnt"));
				array.add(vo);
				//System.out.println(vo.toString());
			}
		}catch(Exception e) {
			System.out.println("좋아요 목록 불러오기 오류  " + e.toString());
		}
		return array;
	}
	
	//상품정보
	public GoodsVO read(String gid, String uid) {
		GoodsVO vo = new GoodsVO();
		try {
			String sql = "select *, (select count(*) from favorite f where uid=? and f.gid=g.gid) ucnt, (select count(*) from favorite f where f.gid=g.gid) fcnt from goods g where gid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, uid);
			ps.setString(2, gid);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				vo.setGid(rs.getString("gid"));
				vo.setTitle(rs.getString("title"));
				vo.setBrand(rs.getString("brand"));
				vo.setPrice(rs.getInt("price"));
				vo.setImage(rs.getString("image"));
				vo.setRegDate(sdf.format(rs.getTimestamp("regDate")));
				vo.setCategory3(rs.getString("category3"));
				vo.setLink(rs.getString("link"));
				vo.setMallName(rs.getString("mallName"));
				vo.setFcnt(rs.getInt("fcnt"));
				vo.setUcnt(rs.getInt("ucnt"));
			}
		}catch(Exception e) {
			System.out.println("상품정보 불러오다가 오류 " + e.toString());
		}
		
		return vo;
	}
	
	//검색수 구하기
	public int total(String word) {
		int total =0;
		 try {
			 String sql="select count(*) from goods";
			 sql += " where title  like ?" ;
			 PreparedStatement ps = con.prepareStatement(sql);
			 ps.setString(1, "%" + word + "%");
			 ResultSet rs=ps.executeQuery();
			 if(rs.next()) total=rs.getInt("count(*)");
		 }catch(Exception e) {
			 System.out.println("총검색수구하기 에서 문제" +e.toString());
		 }
		return total;
	}
	
	//상품삭제 
	public boolean delete(String gid) {
		try {
			String sql = "delete from goods where gid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, gid);
			ps.execute();
			return true;
		}catch(Exception e){
			System.out.println("상품삭제하다가 오류 " + e.toString());
			return false;
		}
	}
	
	//상품목록
	public ArrayList<GoodsVO> list(QueryVO query){
		ArrayList<GoodsVO> array = new ArrayList<GoodsVO>();
		try {
			String sql = "select * from goods where title like ? order by regDate desc limit ?, ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, "%" + query.getWord() + "%");
			ps.setInt(2, (query.getPage()-1) * query.getSize());
			ps.setInt(3, query.getSize());
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				GoodsVO vo = new GoodsVO();
				vo.setGid(rs.getString("gid"));
				vo.setTitle(rs.getString("title"));
				vo.setBrand(rs.getString("brand"));
				vo.setPrice(rs.getInt("price"));
				vo.setImage(rs.getString("image"));
				vo.setRegDate(rs.getString("regDate"));
				vo.setCategory3(rs.getString("category3"));
				vo.setLink(rs.getString("link"));
				vo.setMallName(rs.getString("mallName"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("상품목록 불러오기 오류 " + e.toString());
		}
		return array;
	}
	
	//상품서치에서 목록으로 넣기 
	public boolean insert(GoodsVO vo) {
		try {
			String sql = "insert into goods(gid, title, price, brand, image, category3, link, mallName) values(?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, vo.getGid());
			ps.setString(2, vo.getTitle());
			ps.setInt(3, vo.getPrice());
			ps.setString(4, vo.getBrand());
			ps.setString(5, vo.getImage());
			ps.setString(6, vo.getCategory3());
			ps.setString(7, vo.getLink());
			ps.setString(8, vo.getMallName());
			ps.execute();
			return true;
		}catch(Exception e){
			System.out.println("상품등록하다가 오류 " + e.toString());
			return false;
		}
	}
}

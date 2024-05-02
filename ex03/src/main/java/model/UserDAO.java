package model;

import java.sql.*;
import java.util.*;

public class UserDAO {
	Connection con = Database.CON;
	//사용자 목록
	public ArrayList<UserVO> list(){
		ArrayList<UserVO> array=new ArrayList<UserVO>();
		try {
			String sql="select * from users order by phone desc";
			PreparedStatement ps=con.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				UserVO vo=new UserVO();
				vo.setUid(rs.getString("uid"));
				vo.setUname(rs.getString("uname"));
				vo.setPhoto(rs.getString("photo"));
				vo.setPhone(rs.getString("phone"));
				vo.setAdd1(rs.getString("add1"));
				vo.setAdd2(rs.getString("add2"));
				vo.setJdate(rs.getTimestamp("jdate"));
				array.add(vo);
			}
		}catch(Exception e){
			System.out.println("사용자목록 오류" + e.toString());
		}
		return array;
	}
	
	
	
	
	
	
	//회원가입
	public void insert(UserVO vo) {
		try {
			String sql="insert into users(uid, upass, uname) values(?, ?, ?)";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, vo.getUid());
			ps.setString(2, vo.getUpass());
			ps.setString(3, vo.getUname());
			ps.execute();
		}catch(Exception e) {
			System.out.println("회원가입:" + e.toString());
		}
	}
	
	
	
	public void updatePhoto(String uid, String photo) {//사진을 DB에 올리기 업데이트로 쓰면 변수개수가 같아서 안됨.
		 try {
			 String sql = "update users set photo=? where uid=?";
			 PreparedStatement ps = con.prepareStatement(sql);
			 ps.setString(1, photo);
			 ps.setString(2, uid);
			 ps.execute();
		 }catch(Exception e){
			 System.out.println("사진수정하다 오류다 임마 : " + e.toString());
		 }
	}
	
	
	
	public void update(String uid, String npass) { // 매개변수가 틀리면 쓸수있따 = 오버로딩
		try {
			String sql="update users set upass=? where uid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(2, uid);
			ps.setString(1, npass);
			ps.execute();
		}catch(Exception e) {
			System.out.println("패스워드 변경에서 오류" + e.toString());
		}
	}
	
	
	public void update(UserVO vo) { //개인정보수정
		try {
			String sql = "update users set udate = now(), uname=?, phone=?, add1=?, add2=? where uid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, vo.getUname());
			ps.setString(2, vo.getPhone());
			ps.setString(3, vo.getAdd1());
			ps.setString(4, vo.getAdd2());
			ps.setString(5, vo.getUid());
			ps.execute();
		}catch(Exception e){
			System.out.println("업데이트에서 오류" + e.toString());
		}
	}
	public UserVO read(String uid) { //primary키만 읽어도 알수있으니 하나만 받자. 
		UserVO vo = new UserVO();
		try {
			String sql = "select * from users where uid=?"; // uid가 뭔지모르니까 
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, uid); //첫번째에 uid에 넣어준다. 
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				vo.setUid(rs.getString("uid")); //"안에있는거는 DB에의 컬럼이름임."
				vo.setUname(rs.getString("uname"));
				vo.setUpass(rs.getString("upass"));
				vo.setPhone(rs.getString("phone"));
				vo.setAdd1(rs.getString("add1"));
				vo.setAdd2(rs.getString("add2"));
				vo.setPhoto(rs.getString("photo"));
				vo.setJdate(rs.getTimestamp("jdate"));
				vo.setUdate(rs.getTimestamp("udate"));
			}//if
		}catch(Exception e){
			System.out.println("데이터읽다가오류다임마 - " + e.toString());
		}//try - catch
		return vo;
	}//method
}

package model;

import java.sql.*;

public class UserDAO {
	Connection con = Database.CON;
	
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

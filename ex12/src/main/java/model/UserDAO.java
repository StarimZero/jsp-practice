package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	Connection con = Database.CON;

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
			}//if
		}catch(Exception e){
			System.out.println("로그인 데이터읽기 오류  - " + e.toString());
		}//try - catch
		return vo;
	}//method
}

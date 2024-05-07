package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class JusoDAOImpl implements JusoDAO{

	Connection con=Database.CON;
	SimpleDateFormat sdf=new SimpleDateFormat("yy-MM-dd HH:mm:ss");
	
	@Override
	public ArrayList<JusoVO> list() {
		ArrayList<JusoVO> array = new ArrayList<JusoVO>();
		try {	
			String sql = "select * from  jusoes order by uid desc";
			PreparedStatement ps = con.prepareStatement(sql); //가져온 sql을 ps에 넣자.
			ResultSet rs = ps.executeQuery(); //sql을 실행해서 rs에 넣자.
			while(rs.next()) { //rs를 반복해서 가져오자.
				JusoVO vo = new JusoVO(); //빈 vo를 하나만들자.
				vo.setUid(rs.getInt("uid"));
				vo.setUname(rs.getString("uname"));
				vo.setAdd1(rs.getString("add1"));
				vo.setAdd2(rs.getString("add2"));
				vo.setPhone(rs.getString("phone"));
				vo.setPhoto(rs.getString("photo"));
				vo.setJdate(rs.getTimestamp("jdate"));
				array.add(vo); //가져온 vo를 array에 넣어주자. 
				//System.out.println(vo.toString());
			}
		}catch(Exception e){
			System.out.println("주소리스트 오류  " + e.toString());
		}
		return array;
	}

	@Override
	public void insert(JusoVO vo) {
		try {
			String sql = "insert into jusoes(uname,add1,phone) values(?,?,?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, vo.getUname());
			ps.setString(2, vo.getAdd1());
			ps.setString(3, vo.getPhone());
			ps.execute();
		}catch(Exception e){
			System.out.println("주소등록오류입니다. " + e.toString());
		}
		
	}

	@Override
	public JusoVO read(int bid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void update(JusoVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int uid) {
		try {
			String sql = "delete from comments where uid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, uid);
			ps.execute();
		}catch(Exception e){
			System.out.println("삭제할때 오류입니당" + e.toString());
		}
		
	}

	@Override
	public ArrayList<JusoVO> list(int page, int size) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int total() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int total(String query) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<JusoVO> list(int page, int size, String query) {
		// TODO Auto-generated method stub
		return null;
	}

}

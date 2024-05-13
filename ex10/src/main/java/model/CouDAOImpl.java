package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CouDAOImpl implements CouDAO{
	Connection con = Database.CON;
	@Override
		public ArrayList<CouVO> list(QueryVO vo) {
			ArrayList<CouVO> array = new ArrayList<CouVO>();
			try {
				String sql = "select * from view_cou";
				sql += " where " + vo.getKey() + " like ?"; // 컬럼이름은 물음표로 못한다. 그러니까 like로 '값'을 ? 로 해놓음.
				sql += " order by lcode desc";
				sql += " limit ?, ?";
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, "%" + vo.getWord() + "%");
				ps.setInt(2, (vo.getPage()-1) * vo.getSize());
				ps.setInt(3, vo.getSize());
				ResultSet rs=ps.executeQuery();
				while(rs.next()) {
					CouVO cou = new CouVO();
					cou.setLcode(rs.getString("lcode"));
					cou.setLname(rs.getString("lname"));
					cou.setHours(rs.getInt("hours"));
					cou.setRoom(rs.getString("room"));
					cou.setInstructor(rs.getInt("instructor"));
					cou.setCapacity(rs.getInt("capacity"));
					cou.setPersons(rs.getInt("persons"));
					cou.setPname(rs.getString("pname"));
					//System.out.println(cou.toString());
					array.add(cou);
				}
			}catch(Exception e) {
				System.out.println("강좌목록 오류입니당 " + e.toString());
			}
			
			return array;
	}
	


	@Override
	public void insert(CouVO vo) {
		try {
			String sql = " insert into courses(lcode,lname,hours,room,instructor,capacity,persons) values(?,?,?,?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, vo.getLcode());
			ps.setString(2, vo.getLname());
			ps.setInt(3, vo.getHours());
			ps.setString(4, vo.getRoom());
			ps.setInt(5, vo.getInstructor());
			ps.setInt(6, vo.getCapacity());
			ps.setInt(7, vo.getPersons());
			ps.execute();
		}catch(Exception e) {
			System.out.println("강좌등록하다가 오류" + e.toString());
		}
		
	}

	@Override
	public CouVO read(String lcode) {
		CouVO vo=new CouVO();
		try {
			String sql="select * from view_cou where lcode=?";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, lcode);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setLcode(rs.getString("lcode"));
				vo.setLname(rs.getString("lname"));
				vo.setHours(rs.getInt("hours"));
				vo.setRoom(rs.getString("room"));
				vo.setInstructor(rs.getInt("instructor"));
				vo.setCapacity(rs.getInt("capacity"));
				vo.setPersons(rs.getInt("persons"));
				vo.setPname(rs.getString("pname"));
//				System.out.println(vo.toString());
			}
		}catch(Exception e) {
			System.out.println("강좌정보 보기 오류:" + e.toString());
		}
		return vo;
	}

	@Override
	public void update(CouVO vo) {
		try {
			String sql = " update  courses set lname=?, hours=?, room=?, instructor=?, capacity=?, persons=? where lcode=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, vo.getLname());
			ps.setInt(2, vo.getHours());
			ps.setString(3, vo.getRoom());
			ps.setInt(4, vo.getInstructor());
			ps.setInt(5, vo.getCapacity());
			ps.setInt(6, vo.getPersons());
			ps.setString(7, vo.getLcode());
			ps.execute();
		}catch(Exception e) {
			System.out.println("강좌수정하다가 오류" + e.toString());
		}
	}

	@Override
	public int delete(String lcode) {
		try {
			String sql = " delete from courses where lcode=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, lcode);
			ps.execute();
			return 1;
		}catch(Exception e) {
			System.out.println("강좌삭제 하다가 오류" + e.toString());
			return 0;
		}
	}

	@Override
	public ArrayList<CouVO> list(int page, int size) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int total() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int total(QueryVO vo) {
		 int total=0;
		 try {
			 String sql="select count(*) from view_cou";
			 sql += " where " + vo.getKey() + " like ?" ;
			 PreparedStatement ps = con.prepareStatement(sql);
			 ps.setString(1, "%" + vo.getWord() + "%");
			 ResultSet rs=ps.executeQuery();
			 if(rs.next()) {
				 total=rs.getInt("count(*)");
			 }
		 }catch(Exception e) {
			 System.out.println("강좌 총검색수구하기 에서 문제" +e.toString());
		 }
			return total;
	
	}

	@Override
	public String getCode() {
		String code ="";
		 try {
			 String sql="select concat('N', substring(max(lcode),2)+1) code from courses";
			 PreparedStatement ps = con.prepareStatement(sql);
			 ResultSet rs=ps.executeQuery();
			 if(rs.next()) {
				 code=rs.getString("code");
			 }
		 }catch(Exception e) {
			 System.out.println("강좌 코드 하다가 오류" +e.toString());
		 }
		return code;
	}

}

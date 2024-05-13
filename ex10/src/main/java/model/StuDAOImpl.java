package model;

import java.util.ArrayList;
import java.sql.*;
import java.text.SimpleDateFormat;


public class StuDAOImpl implements StuDAO{
	Connection con = Database.CON;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	@Override
	public ArrayList<StuVO> list(QueryVO vo) {
		ArrayList<StuVO> array = new ArrayList<StuVO>();
		try {
			String sql = "select * from view_stu";
			sql += " where " + vo.getKey() + " like ?";
			sql += " order by scode desc";
			sql += " limit ?, ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, "%" + vo.getWord() + "%");
			ps.setInt(2, (vo.getPage()-1) * vo.getSize());
			ps.setInt(3, vo.getSize());
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				StuVO stu = new StuVO();
				stu. setScode(rs.getString("scode"));
				stu.setSname(rs.getString("sname"));
				stu.setSdept(rs.getString("dept"));
				stu.setAdvisor(rs.getString("advisor"));
				stu.setPname(rs.getString("pname"));
				stu.setBirthday(rs.getString("birthday"));
				stu.setYear(rs.getInt("year"));
				//System.out.println(stu.toString());
				array.add(stu);
			}
		}catch(Exception e) {
			System.out.println("학생목록 list오류 " + e.toString());
		}
		
		
		return array;
	}

	@Override
	public void insert(StuVO vo) {
		try {
			String sql = " insert into students(scode,sname,dept,year,birthday,advisor) values(?,?,?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, vo.getScode());
			ps.setString(2, vo.getSname());
			ps.setString(3, vo.getSdept());
			ps.setInt(4, vo.getYear());
			ps.setString(5, vo.getBirthday());
			ps.setString(6, vo.getAdvisor());
			ps.execute();
		}catch(Exception e) {
			System.out.println("학생등록하다가 오류" + e.toString());
		}
		
	}

	@Override
	public StuVO read(String scode) {
		StuVO vo=new StuVO();
		try {
			String sql="select * from view_stu where scode=?";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, scode);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo. setScode(rs.getString("scode"));
				vo.setSname(rs.getString("sname"));
				vo.setSdept(rs.getString("dept"));
				vo.setAdvisor(rs.getString("advisor"));
				vo.setPname(rs.getString("pname"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setYear(rs.getInt("year"));
				//System.out.println(vo.toString());
			}
		}catch(Exception e) {
			System.out.println("학생정보 보기 오류:" + e.toString());
		}
		return vo;
	}

	@Override
	public void update(StuVO vo) {
		try {
			String sql = " update students set sname=?, dept=?, year=? , birthday=?, advisor=? where scode=?" ;
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, vo.getSname());
			ps.setString(2, vo.getSdept());
			ps.setInt(3, vo.getYear());
			ps.setString(4, vo.getBirthday());
			ps.setString(5, vo.getAdvisor());
			ps.setString(6, vo.getScode());
			ps.execute();
		}catch(Exception e) {
			System.out.println("학생수정하다가 오류" + e.toString());
		}
		
	}

	@Override
	public int delete(String scode) {
		try {
			String sql = " delete from students where scode=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, scode);
			ps.execute();
			return 1;
		}catch(Exception e) {
			System.out.println("학생삭제하다가 오류" + e.toString());
			return 0;
		}
	}

	@Override
	public ArrayList<StuVO> list(int page, int size) {
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
			 String sql="select count(*) from view_stu";
			 sql += " where " + vo.getKey() + " like ?" ;
			 PreparedStatement ps = con.prepareStatement(sql);
			 ps.setString(1, "%" + vo.getWord() + "%");
			 ResultSet rs=ps.executeQuery();
			 if(rs.next()) {
				 total=rs.getInt("count(*)");
			 }
		 }catch(Exception e) {
			 System.out.println("학생 총검색수구하기 에서 문제" +e.toString());
		 }
			return total;
	}

	@Override
	public String getCode() {
		String code ="";
		 try {
			 String sql="select max(scode)+1 code from view_stu";
			 PreparedStatement ps = con.prepareStatement(sql);
			 ResultSet rs=ps.executeQuery();
			 if(rs.next()) {
				 code=rs.getString("code");
			 }
		 }catch(Exception e) {
			 System.out.println("학생 코드 구하다가 오류" +e.toString());
		 }
		return code;
	}

}

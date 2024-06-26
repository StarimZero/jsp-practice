package model;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class ProDAOImpl implements ProDAO{
	Connection con=Database.CON;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	@Override
	public ArrayList<ProVO> list(QueryVO vo) {
		ArrayList<ProVO> array=new ArrayList<ProVO>();
		try {
			String sql = "select * from professors";
			sql += " where " + vo.getKey() + " like ?";
			sql += " order by pcode desc";
			sql += " limit ?, ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, "%" + vo.getWord() + "%");
			ps.setInt(2, (vo.getPage()-1) * vo.getSize());
			ps.setInt(3, vo.getSize());
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				ProVO pro = new ProVO();
				pro. setPcode(rs.getString("pcode"));
				pro.setPname(rs.getString("pname"));
				pro.setDept(rs.getString("dept"));
				pro.setTitle(rs.getString("title"));
				pro.setHiredate(sdf.format(rs.getTimestamp("hiredate")));
				pro.setSalary(rs.getInt("salary"));
				//System.out.println(pro.toString());
				array.add(pro);
			}
		}catch(Exception e){
			System.out.println("교수 목록 오류입니당다리당" + e.toString());
		}
		return array;
	}

	@Override
	public void insert(ProVO vo) {
		try {
			String sql = " insert into professors(pcode,pname,dept,title,hiredate,salary) values(?,?,?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, vo.getPcode());
			ps.setString(2, vo.getPname());
			ps.setString(3, vo.getDept());
			ps.setString(4, vo.getTitle());
			ps.setString(5, vo.getHiredate());
			ps.setInt(6, vo.getSalary());
			ps.execute();
		}catch(Exception e) {
			System.out.println("교수등록하다가 오류" + e.toString());
		}
		
	}

	@Override
	public ProVO read(String pcode) {
		ProVO pro=new ProVO();
		try {
			String sql="select * from professors where pcode=?";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, pcode);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				pro.setPcode(rs.getString("pcode"));
				pro.setPname(rs.getString("pname"));
				pro.setDept(rs.getString("dept"));
				pro.setTitle(rs.getString("title"));
				pro.setHiredate(sdf.format(rs.getTimestamp("hiredate")));
				pro.setSalary(rs.getInt("salary"));
//				System.out.println(pro.toString());
			}
		}catch(Exception e) {
			System.out.println("교수정보:" + e.toString());
		}
		return pro;
	}

	@Override
	public void update(ProVO vo) {
		try {
			String sql = " update professors set pname=?, dept=?, title=?, hiredate=?, salary=? where pcode=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, vo.getPname());
			ps.setString(2, vo.getDept());
			ps.setString(3, vo.getTitle());
			ps.setString(4, vo.getHiredate());
			ps.setInt(5, vo.getSalary());
			ps.setString(6, vo.getPcode());
			ps.execute();
		}catch(Exception e) {
			System.out.println("교수수정하다가 오류" + e.toString());
		}
		
	}

	@Override
	public int delete(String pcode) {
		try {
			String sql = " delete from professors where pcode=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, pcode);
			ps.execute();
			return 1;
		}catch(Exception e) {
			System.out.println("교수삭제하다가 오류" + e.toString());
			return 0;
		}
		
	}

	@Override
	public ArrayList<ProVO> list(int page, int size) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int total() {
		return 0;
	}

	@Override
	public int total(QueryVO vo) {
		 int total=0;
		 try {
			 String sql="select count(*) from professors";
			 sql += " where " + vo.getKey() + " like ?" ;
			 PreparedStatement ps = con.prepareStatement(sql);
			 ps.setString(1, "%" + vo.getWord() + "%");
			 ResultSet rs=ps.executeQuery();
			 if(rs.next()) total=rs.getInt("count(*)");
		 }catch(Exception e) {
			 System.out.println("총검색수구하기 에서 문제" +e.toString());
		 }
			return total;
		}

	@Override
	public String getCode() {
		String code="";
		 try {
			 String sql="select max(pcode)+1 code from professors;";
			 PreparedStatement ps = con.prepareStatement(sql);
			 ResultSet rs=ps.executeQuery();
			 if(rs.next()) code = rs.getString("code");
		 }catch(Exception e) {
			 System.out.println("코드자동가져오기 에서 문제" +e.toString());
		 }
		return code;
	}

}

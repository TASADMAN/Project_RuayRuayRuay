 package DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import database.connectDatabase;

public class EmpDao {


	public static List<Emp> getRecords(int start, int total) {
		List<Emp> list = new ArrayList<Emp>();
		try {
			connectDatabase connectDB = new connectDatabase();
			Connection con = connectDB.connect();
			PreparedStatement ps = con.prepareStatement("select * from goods limit " + (start - 1) + "," + total);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Emp e = new Emp();
				e.des(rs.getString(1));
				e.name(rs.getString(2));
				e.price(rs.getDouble(3));
				list.add(e);
			}
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		return list;
	}
}

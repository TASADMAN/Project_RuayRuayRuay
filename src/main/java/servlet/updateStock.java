package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.connectDatabase;

/**
 * Servlet implementation class updateStock
 */
@WebServlet("/updateStock")
public class updateStock extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public updateStock() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			// update number goods
			connectDatabase connectDB = new connectDatabase();
			java.sql.Connection connect = connectDB.connect();
			ResultSet rec = null;
			Statement up = connect.createStatement();
			Statement doubleS = connect.createStatement();
			if (connect != null) {
				Statement s = connect.createStatement();
				boolean check = false;

				// จำนวน row ที่จะถูกเพิ่มเข้าตาราง goods column stock
				String sqltwo = "SELECT COUNT(*) AS count_numgoods FROM receipt_detalis WHERE receipt_detalis.rec_id="
						+ request.getSession().getAttribute("idRec");
				System.err.println(sqltwo);
				rec = s.executeQuery(sqltwo);
				rec.next();
				int qua[] = new int[rec.getInt("count_numgoods")];
				
				int idGoods[] = new int[rec.getInt("count_numgoods")];

				// ข้อมูลทั้งหมดในตาราง receipt details เงื่อนไข receipt id
				String sql = "SELECT * FROM receipt_detalis WHERE receipt_detalis.rec_id= "
						+ request.getSession().getAttribute("idRec");
				System.out.println(sql);
				rec = s.executeQuery(sql);

				// ทำการอัปเดต จำนวนสินค้า
				int i = 0;
				while ((rec != null) && rec.next()) {
					qua[i] = rec.getInt("qua");
					idGoods[i] = rec.getInt("good_id");
					String sqls = "UPDATE goods SET stock = stock-" + rec.getInt("qua") + " WHERE id="
							+ rec.getInt("good_id");
					System.out.println(sqls);
					up.execute(sqls);
					i++;
				}
				rec.next();

				// หาจำนวนที่ติดลบถ้ามีจะมีการ return ค่า stock กลับคืนตาราง goods

				String sqlone = "SELECT stock,name,good_id FROM goods INNER JOIN receipt_detalis ON"
						+ " goods.id = receipt_detalis.good_id WHERE receipt_detalis.rec_id="
						+ request.getSession().getAttribute("idRec");
				System.err.println(sqlone);
				rec = s.executeQuery(sqlone);

				int k = 0;
				String nameGoods = null;
				while ((rec != null) && rec.next()) {
					if (rec.getInt("stock") < 0) {
						System.err.println("Complete");
						nameGoods = rec.getString("name");
						check = true;
						k++;
					}
				}

				// ทำการ boolean check = true
				if (check) {
					for (int j = 0; j < qua.length; j++) {
						System.err.println(j);
						String sqls = "UPDATE goods SET stock = stock+" + qua[j] + " WHERE id=" + idGoods[j];
						System.out.println(sqls);
						doubleS.execute(sqls);

					}
					// แจ้งเตือน
					out.println("<script type=\"text/javascript\">");
					out.println("alert('ต้าวสินค้ามันเกินมาอะ ต้าวช่วยดูยอดคงเหลือสินค้า "+nameGoods+" นี้ดูนะ');");
					out.println("location='index.jsp';");
					out.println("</script>");

//					RequestDispatcher dispatcher = request.getRequestDispatcher("/basket.jsp");
//					dispatcher.forward(request, response);
				} else {
					//ถ้าไม่มีจำนวนติดลบก็ให้ทำงานตามปกติ
					
					// เป็นการ return ให้ add table rec ใหม่
					request.getSession().setAttribute("checkBuy", "1");
					RequestDispatcher dispatcher = request.getRequestDispatcher("/basket.jsp");
					dispatcher.forward(request, response);
				}

			}

		} catch (Exception e) {
			// TODO: handle exception
			e.getStackTrace();
		}
	}
//	public String getArray(String[] name) {
//		String n="";
//		for (int i =0;i < name.length;i++) {
//			n += name[i] +"\t";
//		}
//		return n;
//	}
}

package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.connectDatabase;

/**
 * Servlet implementation class addGoods
 */
@WebServlet("/addGoods")
public class addGoods extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public addGoods() {
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
		System.err.println("OK");
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		ResultSet re = null;
		PrintWriter out = response.getWriter();
		int stock = 0;
		{
			connectDatabase connectDB = new connectDatabase();
			java.sql.Connection connect = connectDB.connect();

			if (connect != null) {
				Statement s;
				try {
					s = connect.createStatement();
					String sql = "SELECT goods.stock FROM goods WHERE id=" + request.getParameter("idGoods");
					System.out.println(sql);
					re = s.executeQuery(sql);
					re.next();
					stock = re.getInt("stock");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
		}

		
		long number = 0;
		long id_rec;
		double amount;
		if (session.getAttribute("idCustomer") == null) {
			//ถ้ายังไม่เข้าระบบ
			System.err.println("null id Customer");
			response.sendRedirect("index.jsp");
		} else if (request.getParameter("addNumber").equals("")) {
			//ถ้ายังไม่กรอกข้อมูลจำนวน
			System.err.println("null number goods");
			response.sendRedirect("index.jsp");
		} else if (Long.parseLong(request.getParameter("addNumber")) < 1) {

//			   out.println("<script type=\"text/javascript\">");
//			   out.println("alert('User or password incorrect');");
//			   out.println("location='index.jsp';");
//			   out.println("</script>");
			response.sendRedirect("index.jsp");
			
		} else if (Integer.parseInt(request.getParameter("addNumber")) > stock) {
			// ถ้าผู้ใช้กรอกจำนวนเกินคลัง
			out.println("<script type=\"text/javascript\">");
			out.println("alert('สินค้าหมดแล้วอ่ะ รอไอ้ต้าวมาเติมสินค้าก่อนนะ เดี๋ยวเรามะรวย');");
			out.println("location='index.jsp';");
			out.println("</script>");
			
		} else {
			// จำนนวนสินค้าที่สั่งซื้อ
			number = Long.parseLong(request.getParameter("addNumber"));
			connectDatabase connectDB = new connectDatabase();
			java.sql.Connection connect = connectDB.connect();

			ResultSet rec = null;
			request.setCharacterEncoding("UTF-8");

			if (connect != null) {
				try {

					java.sql.Statement s = ((java.sql.Connection) connect).createStatement();
					if (session.getAttribute("checkBuy").equals("1")) {
						String sql = "INSERT INTO `receipt` (`id`, `data`, `cus_id`, `total`)"
								+ " VALUES (NULL, CURRENT_TIMESTAMP, '" + session.getAttribute("idCustomer") + "', '"
								+ 0.0 + "')";
						s.execute(sql);
						session.setAttribute("checkBuy", "2");
					}

					{
						//select datetime
						String sqls = "SELECT * FROM receipt ORDER BY receipt.id DESC LIMIT 1";
						rec = s.executeQuery(sqls);
						rec.next();
						//search id_receipt add now 
						String sql = "SELECT * FROM receipt WHERE data='"+rec.getString("data")+"' ORDER BY receipt.id DESC LIMIT 1";
						rec = s.executeQuery(sql);
						rec.next();
						id_rec = rec.getLong("id");
						session.setAttribute("idRec", id_rec);
					}
					{
						String sql = "SELECT goods.price*" + number + " AS amount FROM goods WHERE goods.id="
								+ request.getParameter("idGoods");
						System.out.println(sql);
						rec = s.executeQuery(sql);
						rec.next();
						amount = rec.getDouble("amount");
						//update price goods input in table receipt column total
						String sqls = "UPDATE receipt SET total = total+" + amount + " WHERE id="
								+ id_rec;
						System.out.println(sqls);
						s.execute(sqls);
					}
					//ลยจำนวนสินค้าเมื่อกดเพิ่งเข้าตะกร้าสินค้า
//					{
//						String sqls = "UPDATE goods SET stock = stock-" + number + " WHERE id="
//								+ request.getParameter("idGoods");
//						System.out.println(sqls);
//						s.execute(sqls);
//					}

					//เข้าข้อมูลสินค้าเข้าตาราง receipt details (ซื้อสินค้าหลาย)
					String sqls = "INSERT INTO `receipt_detalis` (`id`, `rec_id`, `good_id`, `qua`, `amount`)"
							+ " VALUES (NULL, '" + id_rec + "', '" + request.getParameter("idGoods") + "'," + " '"
							+ number + "', '" + amount + "')";
					System.out.println(sqls);
					s.execute(sqls);

					if (!connect.isClosed()) {
						connect.close();
						s.cancel();
					}
					RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
					dispatcher.forward(request, response);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
					dispatcher.forward(request, response);
				}

			}
		}

	}

}

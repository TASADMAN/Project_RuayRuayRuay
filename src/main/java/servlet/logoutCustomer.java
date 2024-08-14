package servlet;

import java.io.IOException;
import java.sql.ResultSet;
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
 * Servlet implementation class logoutCustomer
 */
@WebServlet("/logoutCustomer")
public class logoutCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public logoutCustomer() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();

		if (!session.getAttribute("checkBuy").equals("2")) {
			session.removeAttribute("Username");
			session.removeAttribute("checkBuy");
			session.removeAttribute("idCustomer");
			session.removeAttribute("idRec");
			session.invalidate();
			RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
			dispatcher.forward(request, response);
		} else if (session.getAttribute("checkBuy").equals("2")) {   // ทำงานเมื่อมีสินค้าค้างในระบบ
			connectDatabase connectDB = new connectDatabase();
			java.sql.Connection connect = connectDB.connect();
			ResultSet rec = null;
			Statement s;
			Statement se;
			if (connect != null) {
				try {
					s = connect.createStatement();
					se = connect.createStatement();
					String sql = "SELECT * FROM receipt_detalis WHERE rec_id="
							+ request.getSession().getAttribute("idRec");
					rec = s.executeQuery(sql);
					// update total

					// while loop update number goods input column stock (กรณีเมื่อเพิ่มเข้าตะกร้าแล้วลบ stock) 
//					while ((rec != null) && (rec.next())) {
//						String sqls = "UPDATE goods SET stock = stock+" + rec.getInt("qua") + " WHERE id="
//								+ rec.getInt("good_id");
//						System.out.println(sqls);
//						se.execute(sqls);
//					}
					{
						String sqls = "UPDATE receipt SET total =" + 0 + " WHERE id="
								+ request.getSession().getAttribute("idRec");
						System.out.println(sqls);
						s.execute(sqls);

						String sqll = "DELETE  FROM `receipt_detalis` WHERE rec_id="
								+ request.getSession().getAttribute("idRec");
						System.out.println(sqll);
						s.execute(sqll);
					}
					if (!connect.isClosed()) {
						connect.close();
						s.cancel();
					}
					session.removeAttribute("Username");
					session.removeAttribute("checkBuy");
					session.removeAttribute("idCustomer");
					session.removeAttribute("idRec");
					session.invalidate();
					RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
					dispatcher.forward(request, response);
				} catch (Exception e) {
					// TODO: handle exception
					e.getStackTrace();
				}
			}

			/**
			 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
			 *      response)
			 */

		}
	}
}

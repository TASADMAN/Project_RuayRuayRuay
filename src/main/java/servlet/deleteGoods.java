package servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.connectDatabase;

/**
 * Servlet implementation class deleteGoods
 */
@WebServlet("/deleteGoods")
public class deleteGoods extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public deleteGoods() {
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
		connectDatabase connectDB = new connectDatabase();
		java.sql.Connection connect = connectDB.connect();
		if (connect != null) {

			Statement s;
			Statement se;
			try {
				s = connect.createStatement();

				//update total back
				{
					String sqls = "UPDATE receipt SET total = total-" + request.getParameter("amountGoods") + " WHERE id="
							+ request.getSession().getAttribute("idRec");
					System.out.println(sqls);
					s.execute(sqls);
				}
				
				// update number goods input column stock
//				String sqls = "UPDATE goods SET stock = stock+" + request.getParameter("numberGoods") + " WHERE id="
//						+ request.getParameter("Goods_id");
//				System.out.println(sqls);
//				s.execute(sqls);
				// delete goods
				String sql = "DELETE FROM `receipt_detalis` WHERE id=" + request.getParameter("deleteIdGoods");
				s.execute(sql);
				System.out.println(sql);
				RequestDispatcher dispatcher = request.getRequestDispatcher("/basket.jsp");
				dispatcher.forward(request, response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}

		}
	}

}

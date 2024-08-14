package servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.connectDatabase;

/**
 * Servlet implementation class addCustomer
 */
@WebServlet("/addCustomer")
public class addCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public addCustomer() {
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

		ResultSet rec = null;
		request.setCharacterEncoding("UTF-8");

		if (connect != null) {
			try {

				java.sql.Statement s = ((java.sql.Connection) connect).createStatement();

				String sql = "INSERT INTO `customer` (`id`, `name`, `address`, `phone`, `e_mail`, `username`, `password`)"
						+ " VALUES (NULL, '"+request.getParameter("name")+"', '"+request.getParameter("address")+"'"
								+ ", '"+request.getParameter("phone")+"', '"+request.getParameter("email")+"'"
										+ ", '"+request.getParameter("user")+"', '"+request.getParameter("pass")+"')";
				s.execute(sql);

				if (!connect.isClosed()) {
					connect.close();
				}
				RequestDispatcher dispatcher = request.getRequestDispatcher("/Log.jsp");
				dispatcher.forward(request, response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				RequestDispatcher dispatcher = request.getRequestDispatcher("/register.jsp");
				dispatcher.forward(request, response);
			}

		}

	}

}

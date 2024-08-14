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
import javax.servlet.http.HttpSession;

import com.sun.jdi.connect.spi.Connection;

import database.connectDatabase;

/**
 * Servlet implementation class loginCustomer
 */
@WebServlet("/loginCustomer")
public class loginCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public loginCustomer() {
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
//		HttpSession sf = request.getSession();
//		sf.setAttribute("Usernaem","");
//		response.sendRedirect();
//		request.getCookies();
		connectDatabase onnectDB = new connectDatabase();
		java.sql.Connection connect = onnectDB.connect();
		java.sql.Statement s = null;
		ResultSet rec = null;
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session =request.getSession();
		HttpSession seIDCus =request.getSession();
		
		String user = null;
		String id = null;
		if (connect != null) {
			try {
				s = connect.createStatement();

				String sql = "SELECT * FROM CUSTOMER WHERE USERNAME = '" + request.getParameter("user")
						+ "' AND PASSWORD='" + request.getParameter("pass") + "'";
				rec = s.executeQuery(sql);
				while (rec.next()) {
					user = rec.getString("username");
					id  = rec.getString("id");
				}
				//session username
				session.setAttribute("Username", user);

				if (user == null) {
					RequestDispatcher dispatcher = request.getRequestDispatcher("/Log.jsp");
					dispatcher.forward(request, response);
				} else {
					seIDCus.setAttribute("idCustomer", id);
					seIDCus.setAttribute("checkBuy", "1");
					RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
					dispatcher.forward(request, response);
				}

				if (request.getParameter("user").equals("") || request.getParameter("pass").equals("")) {
					RequestDispatcher dispatcher = request.getRequestDispatcher("/Log.jsp");
					dispatcher.forward(request, response);
				}
				s.close();
				connect.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				RequestDispatcher dispatcher = request.getRequestDispatcher("/Log.jsp");
				dispatcher.forward(request, response);
			}
		}

		// doGet(request, response);
	}

}

package KaiChieh;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.Statement;

import bian.*;
/**
 * Servlet implementation class CreateNewAccount
 */
@WebServlet("/CreateNewAccount")
public class CreateNewAccount extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateNewAccount() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String userID = request.getParameter("userID");
		String password = request.getParameter("password");
		String userName = request.getParameter("name");
		String userAge = request.getParameter("age");
		String userGender = request.getParameter("gender");
		ServletContext context = getServletContext();
		AccountManager manager = (AccountManager) context.getAttribute("AccountManager");
		response.setContentType("text/html; charset=UTF-8");
		if(manager.accountExist(userID)) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("CreateAccountFailed.jsp");
			dispatcher.forward(request, response);
		}else{
			HttpSession session = request.getSession(); 
			session.setAttribute("userID", userID);
			manager.createAccount(userID, password);
			User newUser = new User(userID);
			if(userName==""){
				newUser.setName("Unknown");
			}else {
				newUser.setName(userName);
			}
			if(userAge==""){
				newUser.setAge(0);
			}else{
				newUser.setAge(Integer.parseInt(userAge));
			}
			if(userGender==""){
				newUser.setGender("Unknown");
			}else if(userGender=="Secret") {
				newUser.setGender("Unknown");
			}else{
				newUser.setGender(userGender);
			}
			
			newUser.setName(userName);
			Statement statement = (Statement) context.getAttribute("statement");
			// TODO need to add user name and age to database
			RequestDispatcher dispatcher = request.getRequestDispatcher("HomePage.jsp");
			dispatcher.forward(request, response);
		}

	}

}

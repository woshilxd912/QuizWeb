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

import bian.AccountManager;
import xuandong.Email;

/**
 * Servlet implementation class SentEmail
 */
@WebServlet("/SentEmail")
public class SentEmail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SentEmail() {
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
		System.out.println("fadsff");
		HttpSession session = request.getSession();
		String userID =  (String) session.getAttribute("userID");
		System.out.println(userID);
		String receiverID = request.getParameter("receiverID");
		String emailSubject = request.getParameter("emailSubject");
		System.out.println(emailSubject);
		String emailContent = request.getParameter("emailContent");
		System.out.println(emailContent);
		Email newEmail = new Email();
		newEmail.setReceiver(receiverID);
		newEmail.setSender(userID);
		newEmail.setRead(false);
		newEmail.setContent(emailContent);
		newEmail.setSubject(emailSubject);
		// new email set time
		newEmail.insertToDatabse();
//		doGet(request, response);
	}

}

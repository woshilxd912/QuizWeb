package bian;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import xuandong.Quiz;
import xuandong.XMLParser;

/**
 * Servlet implementation class LoadXMLServlet
 */
@WebServlet("/LoadXMLServlet")
public class LoadXMLServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoadXMLServlet() {
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
		HttpSession session = request.getSession();
		String userID = (String)session.getAttribute("userID");
		String xmlString = request.getParameter("XMLfile");
		String[] xml = new String[2];
		xml[0] = xmlString;
		xml[1] = userID;
		
		XMLParser.main(xml);

		RequestDispatcher dispatcher = request.getRequestDispatcher("LoadXMLSuccess.jsp");
		dispatcher.forward(request, response);
	}

}

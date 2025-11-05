

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class GoodBye extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  		request.getRequestDispatcher("WEB-INF/goodbye.jsp").forward(request, response);
      }

      protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// {fact rule=log-injection@v1.0 defects=1}
    	System.out.println(request.getParameter("name"));
		// {/fact}
  		request.getRequestDispatcher("WEB-INF/goodbye.jsp").forward(request, response);
      }
}


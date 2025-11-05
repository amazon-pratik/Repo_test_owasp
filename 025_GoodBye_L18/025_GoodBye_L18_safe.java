

import java.io.IOException;
import java.util.logging.Logger;
import java.util.logging.Level;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class GoodBye extends HttpServlet {
    private static final Logger logger = Logger.getLogger(GoodBye.class.getName());

// {fact rule=log-injection@v1.0 defects=0}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  		request.getRequestDispatcher("WEB-INF/goodbye.jsp").forward(request, response);
      }

      protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        if (name != null) {
            // Sanitize input to prevent log injection by removing line breaks and control characters
            String sanitizedName = name.replaceAll("[\r\n\t]", "_").replaceAll("[\p{Cntrl}]", "");
            logger.log(Level.INFO, "User name parameter: {0}", sanitizedName);
        }
        request.getRequestDispatcher("WEB-INF/goodbye.jsp").forward(request, response);
      }
}

// {/fact}
package mx.edu.utez.sgaa.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/css/*")
public class CssServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null || path.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
            return;
        }

        // Serve the requested CSS file from the /webapp/css directory.
        request.getRequestDispatcher("/css" + path).forward(request, response);
    }
}

package com.vehicle.servlet;

import com.vehicle.dao.VehicleDAO;
import com.vehicle.model.Vehicle;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private VehicleDAO vehicleDAO;

    public void init() {
        vehicleDAO = new VehicleDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        try {
            List<Vehicle> searchResults = vehicleDAO.searchVehicles(keyword);
            request.setAttribute("searchResults", searchResults);
            request.setAttribute("keyword", keyword);
            request.getRequestDispatcher("search.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error searching vehicles", e);
        }
    }
}
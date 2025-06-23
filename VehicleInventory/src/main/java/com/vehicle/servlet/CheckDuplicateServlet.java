package com.vehicle.servlet;

import com.vehicle.dao.VehicleDAO;
import com.vehicle.model.Vehicle;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/check-duplicate")
public class CheckDuplicateServlet extends HttpServlet {
    private VehicleDAO vehicleDao;

    public void init() {
        vehicleDao = new VehicleDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String field = request.getParameter("field");
        String value = request.getParameter("value");
        boolean exists = false;
        
        try {
            if("vin".equals(field)) {
                exists = vehicleDao.checkVinExists(value);
            } else if("stockNumber".equals(field)) {
                exists = vehicleDao.checkStockNumberExists(value);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        response.setContentType("application/json");
        response.getWriter().write("{\"exists\":" + exists + "}");
    }
}

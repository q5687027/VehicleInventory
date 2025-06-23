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

@WebServlet("/add-vehicle")
public class AddVehicleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private VehicleDAO vehicleDAO;

    public void init() {
        vehicleDAO = new VehicleDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("add-vehicle.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String make = request.getParameter("make");
        String model = request.getParameter("model");
        int year = Integer.parseInt(request.getParameter("year"));
        String color = request.getParameter("color");
        double price = Double.parseDouble(request.getParameter("price"));
        int mileage = Integer.parseInt(request.getParameter("mileage"));
        String vin = request.getParameter("vin");
        String stockNumber = request.getParameter("stockNumber");
        Date dateAdded = new Date(); // Current date
        String status = request.getParameter("status");
        
        Vehicle newVehicle = new Vehicle(make, model, year, color, price, mileage, vin, stockNumber, dateAdded, status);
        
        try {

            if(vehicleDAO.checkVinExists(vin)) {
                request.setAttribute("error", "车架号已存在");
                request.getRequestDispatcher("add-vehicle.jsp").forward(request, response);
                return;
            }
            
            if(vehicleDAO.checkStockNumberExists(stockNumber)) {
                request.setAttribute("error", "库存编号已存在");
                request.getRequestDispatcher("add-vehicle.jsp").forward(request, response);
                return;
            }
            vehicleDAO.addVehicle(newVehicle);
            response.sendRedirect("inventory");
        } catch (SQLException e) {
            throw new ServletException("数据库错误", e);
        }
    }
}
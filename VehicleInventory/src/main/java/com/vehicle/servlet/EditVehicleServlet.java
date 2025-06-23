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

@WebServlet("/edit-vehicle")
public class EditVehicleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private VehicleDAO vehicleDAO;

    public void init() {
        vehicleDAO = new VehicleDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Vehicle existingVehicle = vehicleDAO.getVehicleById(id);
            request.setAttribute("vehicle", existingVehicle);
            request.getRequestDispatcher("edit-vehicle.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving vehicle", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String make = request.getParameter("make");
        String model = request.getParameter("model");
        int year = Integer.parseInt(request.getParameter("year"));
        String color = request.getParameter("color");
        double price = Double.parseDouble(request.getParameter("price"));
        int mileage = Integer.parseInt(request.getParameter("mileage"));
        String vin = request.getParameter("vin");
        String stockNumber = request.getParameter("stockNumber");
        Date dateAdded = new Date(); // Could parse from input if needed
        String status = request.getParameter("status");

        Vehicle vehicle = new Vehicle(make, model, year, color, price, mileage, vin, stockNumber, dateAdded, status);
        vehicle.setId(id);
        
        try {
            vehicleDAO.updateVehicle(vehicle);
            response.sendRedirect("inventory");
        } catch (SQLException e) {
            throw new ServletException("Error updating vehicle", e);
        }
    }
}
package com.vehicle.dao;

import com.vehicle.model.Vehicle;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VehicleDAO {
    // Add a new vehicle
    public boolean addVehicle(Vehicle vehicle) throws SQLException {
        String sql = "INSERT INTO vehicles (make, model, year, color, price, mileage, vin, stock_number, date_added, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, vehicle.getMake());
            stmt.setString(2, vehicle.getModel());
            stmt.setInt(3, vehicle.getYear());
            stmt.setString(4, vehicle.getColor());
            stmt.setDouble(5, vehicle.getPrice());
            stmt.setInt(6, vehicle.getMileage());
            stmt.setString(7, vehicle.getVin());
            stmt.setString(8, vehicle.getStockNumber());
            stmt.setDate(9, new java.sql.Date(vehicle.getDateAdded().getTime()));
            stmt.setString(10, vehicle.getStatus());
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    // Get all vehicles
    public List<Vehicle> getAllVehicles() throws SQLException {
        List<Vehicle> vehicles = new ArrayList<>();
        String sql = "SELECT * FROM vehicles";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Vehicle vehicle = new Vehicle();
                vehicle.setId(rs.getInt("id"));
                vehicle.setMake(rs.getString("make"));
                vehicle.setModel(rs.getString("model"));
                vehicle.setYear(rs.getInt("year"));
                vehicle.setColor(rs.getString("color"));
                vehicle.setPrice(rs.getDouble("price"));
                vehicle.setMileage(rs.getInt("mileage"));
                vehicle.setVin(rs.getString("vin"));
                vehicle.setStockNumber(rs.getString("stock_number"));
                vehicle.setDateAdded(rs.getDate("date_added"));
                vehicle.setStatus(rs.getString("status"));
                
                vehicles.add(vehicle);
            }
        }
        return vehicles;
    }
    
    // Get vehicle by ID
    public Vehicle getVehicleById(int id) throws SQLException {
        String sql = "SELECT * FROM vehicles WHERE id = ?";
        Vehicle vehicle = null;
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    vehicle = new Vehicle();
                    vehicle.setId(rs.getInt("id"));
                    vehicle.setMake(rs.getString("make"));
                    vehicle.setModel(rs.getString("model"));
                    vehicle.setYear(rs.getInt("year"));
                    vehicle.setColor(rs.getString("color"));
                    vehicle.setPrice(rs.getDouble("price"));
                    vehicle.setMileage(rs.getInt("mileage"));
                    vehicle.setVin(rs.getString("vin"));
                    vehicle.setStockNumber(rs.getString("stock_number"));
                    vehicle.setDateAdded(rs.getDate("date_added"));
                    vehicle.setStatus(rs.getString("status"));
                }
            }
        }
        return vehicle;
    }
    
    // Update vehicle
    public boolean updateVehicle(Vehicle vehicle) throws SQLException {
        String sql = "UPDATE vehicles SET make=?, model=?, year=?, color=?, price=?, mileage=?, vin=?, stock_number=?, date_added=?, status=? WHERE id=?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, vehicle.getMake());
            stmt.setString(2, vehicle.getModel());
            stmt.setInt(3, vehicle.getYear());
            stmt.setString(4, vehicle.getColor());
            stmt.setDouble(5, vehicle.getPrice());
            stmt.setInt(6, vehicle.getMileage());
            stmt.setString(7, vehicle.getVin());
            stmt.setString(8, vehicle.getStockNumber());
            stmt.setDate(9, new java.sql.Date(vehicle.getDateAdded().getTime()));
            stmt.setString(10, vehicle.getStatus());
            stmt.setInt(11, vehicle.getId());
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    // Delete vehicle
    public boolean deleteVehicle(int id) throws SQLException {
        String sql = "DELETE FROM vehicles WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }
    
    // Search vehicles
    public List<Vehicle> searchVehicles(String keyword) throws SQLException {
        List<Vehicle> vehicles = new ArrayList<>();
        String sql = "SELECT * FROM vehicles WHERE make LIKE ? OR model LIKE ? OR color LIKE ? OR vin LIKE ? OR stock_number LIKE ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            for (int i = 1; i <= 5; i++) {
                stmt.setString(i, searchPattern);
            }
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Vehicle vehicle = new Vehicle();
                    vehicle.setId(rs.getInt("id"));
                    vehicle.setMake(rs.getString("make"));
                    vehicle.setModel(rs.getString("model"));
                    vehicle.setYear(rs.getInt("year"));
                    vehicle.setColor(rs.getString("color"));
                    vehicle.setPrice(rs.getDouble("price"));
                    vehicle.setMileage(rs.getInt("mileage"));
                    vehicle.setVin(rs.getString("vin"));
                    vehicle.setStockNumber(rs.getString("stock_number"));
                    vehicle.setDateAdded(rs.getDate("date_added"));
                    vehicle.setStatus(rs.getString("status"));
                    
                    vehicles.add(vehicle);
                }
            }
        }
        return vehicles;
    }
    public boolean checkVinExists(String vin) throws SQLException {
        String sql = "SELECT COUNT(*) FROM vehicles WHERE vin = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, vin);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    public boolean checkStockNumberExists(String stockNumber) throws SQLException {
        String sql = "SELECT COUNT(*) FROM vehicles WHERE stock_number = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, stockNumber);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }
}
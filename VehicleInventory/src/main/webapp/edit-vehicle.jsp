<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>编辑车辆信息 - 车辆库存管理系统</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* 添加额外的样式增强表单显示 */
        .container {
            max-width: 800px;
            margin: 30px auto;
            padding: 25px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
            font-size: 24px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #34495e;
        }
        .form-group input, 
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        .form-actions {
            display: flex;
            justify-content: center;
            margin-top: 30px;
            gap: 15px;
        }
        .btn {
            padding: 10px 20px;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>编辑车辆信息</h1>
        
        <form action="edit-vehicle" method="post">
            <input type="hidden" name="id" value="${vehicle.id}">
            
            <div class="form-group">
                <label for="make">品牌：</label>
                <input type="text" id="make" name="make" value="${vehicle.make}" required>
            </div>
            
            <div class="form-group">
                <label for="model">型号：</label>
                <input type="text" id="model" name="model" value="${vehicle.model}" required>
            </div>
            
            <div class="form-group">
                <label for="year">年份：</label>
                <input type="number" id="year" name="year" min="1900" max="2099" 
                       value="${vehicle.year}" required>
            </div>
            
            <div class="form-group">
                <label for="color">颜色：</label>
                <input type="text" id="color" name="color" value="${vehicle.color}" required>
            </div>
            
            <div class="form-group">
                <label for="price">价格(元)：</label>
                <input type="number" id="price" name="price" min="0" step="0.01" 
                       value="${vehicle.price}" required>
            </div>
            
            <div class="form-group">
                <label for="mileage">里程(公里)：</label>
                <input type="number" id="mileage" name="mileage" min="0" 
                       value="${vehicle.mileage}" required>
            </div>
            
<div class="form-group">
    <label for="vin">车架号(VIN)：</label>
    <input type="text" id="vin" name="vin" value="${vehicle.vin}" readonly 
           style="background-color: #f5f5f5; cursor: not-allowed;">
</div>

<div class="form-group">
    <label for="stockNumber">库存编号：</label>
    <input type="text" id="stockNumber" name="stockNumber" 
           value="${vehicle.stockNumber}" readonly 
           style="background-color: #f5f5f5; cursor: not-allowed;">
</div>
            
            <div class="form-group">
                <label for="dateAdded">入库日期：</label>
                <input type="date" id="dateAdded" name="dateAdded" 
                       value="<fmt:formatDate value='${vehicle.dateAdded}' pattern='yyyy-MM-dd'/>" required>
            </div>
            
            <div class="form-group">
                <label for="status">库存状态：</label>
                <select id="status" name="status" required>
                    <option value="In Stock" ${vehicle.status == 'In Stock' ? 'selected' : ''}>在库</option>
                    <option value="Sold" ${vehicle.status == 'Sold' ? 'selected' : ''}>已售</option>
                    <option value="On Order" ${vehicle.status == 'On Order' ? 'selected' : ''}>订购中</option>
                </select>
            </div>
            
            <div class="form-actions">
                <button type="submit" class="btn">保存修改</button>
                <a href="inventory" class="btn-cancel">返回列表</a>
            </div>
        </form>
    </div>
    
    <script>
        // 客户端验证增强
        document.querySelector('form').addEventListener('submit', function(e) {
/*             const vin = document.getElementById('vin').value;
            if(vin.length !== 17) {
                alert('车架号(VIN)必须是17位字符');
                e.preventDefault();
                return false;
            }
            
            const price = parseFloat(document.getElementById('price').value);
            if(price <= 0) {
                alert('价格必须大于0');
                e.preventDefault();
                return false;
            }
            
            return true; */
        });
    </script>
</body>
</html>
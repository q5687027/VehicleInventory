<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>车辆库存</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h1>车辆库存</h1>
        
        <div class="actions">
            <a href="add-vehicle" class="btn">添加新车</a>
            <form action="search" method="get" class="search-form">
                <input type="text" name="keyword" placeholder="搜索车辆...">
                <button type="submit">搜索</button>
            </form>
        </div>
        
        <table>
            <thead>
                <tr>
 			<th>编号</th>
            <th>品牌</th>
            <th>型号</th>
            <th>年份</th>
            <th>颜色</th>
            <th>价格</th>
            <th>里程(km)</th>
            <th>车架号</th>
            <th>库存编号</th>
            <th>入库日期</th>
            <th>状态</th>
            <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="vehicle" items="${vehicles}">
                    <tr>
                        <td>${vehicle.id}</td>
                        <td>${vehicle.make}</td>
                        <td>${vehicle.model}</td>
                        <td>${vehicle.year}</td>
                        <td>${vehicle.color}</td>
                        <td>$${vehicle.price}</td>
                        <td>${vehicle.mileage}</td>
                        <td>${vehicle.vin}</td>
                        <td>${vehicle.stockNumber}</td>
                        <td>${vehicle.dateAdded}</td>
                        <td>
    <c:choose>
        <c:when test="${vehicle.status == 'In Stock'}">在库</c:when>
        <c:when test="${vehicle.status == 'Sold'}">已售</c:when>
        <c:when test="${vehicle.status == 'On Order'}">订购中</c:when>
        <c:otherwise>${vehicle.status}</c:otherwise>
    </c:choose>
					</td>
				<td>
                    <a href="edit-vehicle?id=${vehicle.id}" class="btn-edit">编辑</a>
                    <a href="delete-vehicle?id=${vehicle.id}" class="btn-delete" onclick="return confirm('确定删除吗？')">删除</a>
                </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
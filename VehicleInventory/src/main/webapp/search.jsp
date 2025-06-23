<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>车辆搜索结果 - 车辆库存管理系统</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .search-header {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        .search-keyword {
            color: #1890ff;
            font-weight: bold;
        }
        .no-results {
            text-align: center;
            padding: 40px;
            color: #999;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="search-header">
            <h1>车辆搜索结果</h1>
            <p>搜索关键词: <span class="search-keyword">${keyword}</span></p>
            <a href="inventory" class="btn">返回库存列表</a>
        </div>
        
        <c:choose>
            <c:when test="${not empty searchResults}">
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
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="vehicle" items="${searchResults}">
                            <tr>
                                <td>${vehicle.id}</td>
                                <td>${vehicle.make}</td>
                                <td>${vehicle.model}</td>
                                <td>${vehicle.year}</td>
                                <td>${vehicle.color}</td>
                                <td>¥${vehicle.price}</td>
                                <td>${vehicle.mileage}</td>
                                <td>${vehicle.vin}</td>
                                <td>${vehicle.stockNumber}</td>
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
                                    <a href="delete-vehicle?id=${vehicle.id}" class="btn-delete" 
                                       onclick="return confirm('确定要删除这辆车吗？')">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="no-results">
                    <p>没有找到匹配的车辆记录</p>
                    <p>请尝试其他搜索关键词</p>
                </div>
            </c:otherwise>
        </c:choose>
        
        <div class="search-footer" style="margin-top: 20px;">
            <a href="inventory" class="btn">返回库存列表</a>
        </div>
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加车辆库存</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<c:if test="${not empty error}">
    <div class="error-message" style="color: red; margin-bottom: 15px; text-align: center;">
        ${error}
    </div>
</c:if>
    <div class="container">
        <h1>添加车辆库存</h1>
        
        <form action="add-vehicle" method="post">
            <div class="form-group">
        <label for="make">品牌：</label>
        <input type="text" id="make" name="make" required>
    </div>
    
    <div class="form-group">
        <label for="model">型号：</label>
        <input type="text" id="model" name="model" required>
    </div>
    
    <div class="form-group">
        <label for="year">年份：</label>
        <input type="number" id="year" name="year" min="1900" max="2099" required>
    </div>
    
    <div class="form-group">
        <label for="color">颜色：</label>
        <input type="text" id="color" name="color" required>
    </div>
    
    <div class="form-group">
        <label for="price">价格(元)：</label>
        <input type="number" id="price" name="price" min="0" step="0.01" required>
    </div>
    
    <div class="form-group">
        <label for="mileage">里程(km)：</label>
        <input type="number" id="mileage" name="mileage" min="0" required>
    </div>
    
<div class="form-group">
    <label for="vin">车架号(VIN)：</label>
    <input type="text" id="vin" name="vin" required
           placeholder="请输入17位车架号">
    <div class="error-message"></div>
    <div class="success-message"></div>
</div>

<div class="form-group">
    <label for="stockNumber">库存编号：</label>
    <input type="text" id="stockNumber" name="stockNumber" required
           placeholder="请输入库存编号">
    <div class="error-message"></div>
    <div class="success-message"></div>
</div>
    
    <div class="form-group">
        <label for="status">状态：</label>
        <select id="status" name="status" required>
            <option value="In Stock">在库</option>
            <option value="Sold">已售</option>
            <option value="On Order">订购中</option>
        </select>
    </div>
    
    <div class="form-actions">
        <button type="submit" class="btn">添加车辆</button>
        <a href="inventory" class="btn-cancel">取消</a>
    </div>
        </form>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    /* 校验提示样式 */
    .form-group {
        margin-bottom: 15px;
        position: relative;
    }
    .error-message {
        color: #ff4d4f;
        font-size: 12px;
        margin-top: 4px;
        display: none;
    }
    .has-error input {
        border-color: #ff4d4f;
    }
    .success-message {
        color: #52c41a;
        font-size: 12px;
        margin-top: 4px;
        display: none;
    }
    .has-success input {
        border-color: #52c41a;
    }
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // 车架号校验
    $('#vin').on('blur', function() {
        const vin = $(this).val();
        const $group = $(this).closest('.form-group');
        const $error = $group.find('.error-message');
        const $success = $group.find('.success-message');
        
        // 清空状态
        $group.removeClass('has-error has-success');
        $error.hide();
        $success.hide();
        
        if(vin.length !== 17) {
            $group.addClass('has-error');
            $error.text('车架号必须为17位字符').show();
            return;
        }
        
        checkDuplicate('vin', vin, '车架号', $group);
    });

    // 库存编号校验
    $('#stockNumber').on('blur', function() {
        const stockNumber = $(this).val();
        const $group = $(this).closest('.form-group');
        const $error = $group.find('.error-message');
        
        $group.removeClass('has-error has-success');
        $error.hide();
        
        if(stockNumber.trim() === '') {
            $group.addClass('has-error');
            $error.text('库存编号不能为空').show();
            return;
        }
        
        checkDuplicate('stockNumber', stockNumber, '库存编号', $group);
    });

    function checkDuplicate(field, value, fieldName, $group) {
        const $error = $group.find('.error-message');
        const $success = $group.find('.success-message');
        
        $.get('check-duplicate', {
            field: field, 
            value: value,
            isEdit: false
        }, function(response) {
            if(response.exists) {
                $group.addClass('has-error');
                $error.text(fieldName + ' "' + value + '" 已存在').show();
            } else {
                $group.addClass('has-success');
                $success.text(fieldName + '可用').show();
            }
        }).fail(function() {
            $group.addClass('has-error');
            $error.text('校验服务不可用').show();
        });
    }
    
    // 表单提交前最终校验
    $('form').on('submit', function(e) {
        let isValid = true;
        
        // 强制触发所有字段的校验
        $('#vin, #stockNumber').trigger('blur');
        
        // 检查是否有错误
        $('.form-group.has-error').each(function() {
            isValid = false;
            return false; // 退出循环
        });
        
        if (!isValid) {
            e.preventDefault();
            $('html, body').animate({
                scrollTop: $('.form-group.has-error').first().offset().top - 20
            }, 500);
        }
    });
});
</script>
</html>
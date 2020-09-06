<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<%@ include file="head.txt"%>
<title>查询化妆品页面</title>
<style>
form {
	margin-top: 10px;
	width: 45%;
	background-color: rgba(0, 0, 0, .1);
	padding-bottom: 10px;
}

.btn {
	width: 100px;
	height: 30px;
	border: none;
	background-color: #ffffff;
	border-radius: 15px;
	margin-top: 10px;
}

.title {
	margin-top: 50px;
	color: #fff;
}

.attention {
	font-size: 14px;
	color: gray;
	padding: 15px 0;
}

input[type='radio']{
	margin-top: 25px;
}
</style>
</head>
<body>
	<div align="center" class="containter">
		<div class="title">查询化妆品：注意选择查询方式</div>
		<form action="searchByConditionServlet" method="post">
			<br>输入查询信息：<input type=text name="searchMess"><br>
			<input type=radio name="radio" value="cosmetic_number" id="one"><label for="one">化妆品版本号</label>
			<input type=radio name="radio" value="cosmetic_name" id="two"  checked="ok"><label for="two">化妆品名称</label>
			<input type=radio name="radio" value="cosmetic_price" id="three"><label for="three">化妆品价格 </label><br>
			<input type=submit name="g" value="提交" class="btn">
		</form>
		<div class="attention">(输入价格是在2个值之间的价格，格式是：价格1-价格2,例如 258-689)</div>
	</div>
</body>
</html>
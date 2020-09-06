<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mybean.data.Login"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="loginBean" class="mybean.data.Login" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="head.txt"%>
<title>查看购物车</title>
<style type="text/css">
.car_title{
	color:#fff;
	margin-top:30px;
}

.show_detail {
	margin-top: 10px;
	color: #ffffff;
	text-align: center;
	background-color: rgba(0, 0, 0, .1);
	color: #ffffff;
}

.tal_btn {
	border: none;
	background-color: rgba(0, 0, 0, 0);
	color: #ffff;
	font-size: 15px;
}

.btn {
	height: 30px;
	border: none;
	color: #ffffff;
	margin-top: 10px;
	background-color: rgba(105, 149, 253, .5);
	border-radius: 15px;
	width:80px;
}
td{
	padding: 15px 10px;
}
</style>
</head>
<body>
	<div align="center">
		<%
			if (loginBean == null) {
				response.sendRedirect("login.jsp");
			} else {
				boolean b = loginBean.getLogname() == null || loginBean.getLogname().length() == 0;
				if (b)
					response.sendRedirect("login.jsp");
			}
			LinkedList car = loginBean.getCar();
			if (car == null)
				out.print("<h2>购物车没有物品</h2>");
			else {
				Iterator<String> iterator = car.iterator();
				StringBuffer buyGoods = new StringBuffer();
				int n = 0;
				double priceSum = 0;
				out.print("<div class='car_title'>购物车中的物品：</div><table class='show_detail'>");
				while (iterator.hasNext()) {
					String goods = iterator.next();
					String showGoods = "";
					n++;
					//购物车物品的后缀是"#价格数字"，比如"化妆品价格3989 #3989"
					int index = goods.lastIndexOf("#");
					if (index != -1) {
						priceSum += Double.parseDouble(goods.substring(index + 1));
						showGoods = goods.substring(0, index);
					}
					buyGoods.append(n + ":" + showGoods);
					String del = "<form action='deleteServlet' method=''post'>"
							+ "<input type='hidden' name='delete' value=" + goods + ">"
							+ "<input type='submit' value='删除' class='tal_btn'></form>";
					out.print("<tr><td>" + showGoods + "</td>");
					out.print("<td>" + del + "</td></tr>");
				}
				out.print("</table>");
				String orderForm = "<form action='buyServlet' method=''post'>"
						+ "<input type='hidden' name='buy' value=" + buyGoods + ">"
						+ "<input type='hidden' name='price' value=" + priceSum + ">"
						+ "<input type='submit' value='生成订单' class='btn'>";
				out.print(orderForm);
			}
		%>
	</div>
</body>
</html>
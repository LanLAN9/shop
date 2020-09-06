<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mybean.data.Login"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="loginBean" class="mybean.data.Login" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="head.txt"%>
<title>商品详情</title>
<style>
center {
	color: #fff;
	margin-top: 15px;
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

th, td {
	padding: 8px;
}

.detail_pic {
	color: gray;
	margin: 15px 0px 10px 0;
}
</style>
</head>
<body>
	<center>
		<%
			if (loginBean == null) {
				response.sendRedirect("login.jsp");
			} else {
				boolean b = loginBean.getLogname() == null || loginBean.getLogname().length() == 0;
				if (b) {
					response.sendRedirect("login.jsp");
				}
			}
			String numberID = request.getParameter("xijie");
			out.print("<th>产品号" + numberID);
			if (numberID == null) {
				out.print("没有产品号，无法查看细节");
				return;
			}
			Connection con;
			Statement sql;
			ResultSet rs;
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (Exception e) {
			}
			String uri = "jdbc:mysql://127.0.0.1/shop";
			try {
				con = DriverManager.getConnection(uri, "root", "password");
				sql = con.createStatement();
				String cdn = "select * from cosmeticForm where cosmetic_number='" + numberID + "'";
				rs = sql.executeQuery(cdn);
				out.print("<table class='show_detail'>");
				out.print("<tr>");
				out.print("<th>产品号");
				out.print("<th>名称");
				out.print("<th>价格");
				out.print("<th>放入购物车</font>");
				out.print("</tr>");
				String picture = "welcome.jpg";
				String detailMess = "";
				while (rs.next()) {
					String number = rs.getString(1);
					String name = rs.getString(2);
					String maker = rs.getString(3);
					String price = rs.getString(4);
					detailMess = rs.getString(5);
					picture = rs.getString(6);
					//便于购物车计算价格，尾缀"#"价格值
					String goods = "(" + number + "," + name + "," + maker + "," + price + ")#" + price;
					goods = goods.replaceAll("\\p{Blank}", "");
					String button = "<form action='putGoodsServlet' method='post'>"
							+ "<input type='hidden' name='java' value=" + goods + ">"
							+ "<input type='submit' value='放入购物车' class='tal_btn'></form>";
					out.print("<tr>");
					out.print("<td>" + number + "</td>");
					out.print("<td>" + name + "</td>");
					out.print("<td>" + maker + "</td>");
					out.print("<td>" + price + "</td>");
					out.print("<td>" + button + "</td>");
					out.print("</tr>");
				}
				out.print("</table>");
				out.print("<div align=center class='detail_pic'>产品详情：");
				out.println(detailMess + "</div>");
				String pic = "<img src='image/" + picture + "' width=260 height=200></img>";
				out.print(pic);
				con.close();
			} catch (SQLException exp) {
			}
		%>
	</center>
</body>
</html>
<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="loginBean" class="mybean.data.Login" scope="session" />
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="head.txt"%>
<title>查看订单</title>
<style type="text/css">
.show_detail {
	margin-top: 25px;
	color: #ffffff;
	text-align: center;
	background-color: rgba(0, 0, 0, .1);
	color: #ffffff;
}
</style>
</head>
<body background="image/background.jpg">
	<div align="center">
		<%
			if (loginBean == null) {
				response.sendRedirect("login.jsp");
			} else {
				boolean b = loginBean.getLogname() == null || loginBean.getLogname().length() == 0;
				if (b)
					response.sendRedirect("login.jsp");
			}
			Connection con;
			Statement sql;
			ResultSet rs;
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (Exception e) {
			}
			try {
				String uri = "jdbc:mysql://127.0.0.1/shop?";
				String password = "password";
				String user = "root";
				con = DriverManager.getConnection(uri, user, password);
				sql = con.createStatement();
				String cdn = "select or_id,or_mess,or_sum from orderForm where us_longname='" + loginBean.getLogname()
						+ "'";
				rs = sql.executeQuery(cdn);
				out.print("<table class='show_detail'>");
				out.print("<tr>");
				out.print("<th width=100>" + "订单号");
				out.print("<th width=100>" + "信息");
				out.print("<th width=100>" + "价格");
				out.print("</tr>");
				while (rs.next()) {
					out.print("<td>" + rs.getString(1) + "</td>");
					out.print("<td>" + rs.getString(2) + "</td>");
					out.print("<td>" + rs.getString(3) + "</td>");
					out.print("</tr>");
				}
				out.print("</table>");
				con.close();
			} catch (SQLException e) {
				out.print(e);
			}
		%>
	</div>
</body>
</html>
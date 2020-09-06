<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="head.txt"%>
<title>浏览页面</title>
<style>
.btn {
	height: 30px;
	border: none;
	color: #ffffff;
	margin-top: 10px;
	background-color: rgba(105, 149, 253, .5);
}

select {
	height: 30px;
	-webkit-appearance: none;
	text-align: center;
	padding: 0 10px;
}

ul {
	display: -webkit-inline-box;
	padding-left: 175px;
}

li {
	list-style: none;
	position: relative;
}

img {
	width: 300px;
}

li:hover::before {
	content: "热卖品推荐";
	display: block;
	width: 300px;
	height: 25px;
	background-color: rgba(0, 0, 0, .3);
	position: absolute;
	top: 151px;
	left: 0;
	text-align: center;
	color: #ffffff;
	font-size: 14px;
	line-height:25px
}
</style>
</head>
<body background="image/background.jpg">

	<%
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (Exception e) {
		}
		String uri = "jdbc:mysql://127.0.0.1/shop?" + "user=root&password=password&characterEncoding=UTF-8";
		Connection con;
		Statement sql;
		ResultSet rs;
		try {
			con = DriverManager.getConnection(uri);
			sql = con.createStatement();
			//读取classify表，获得分类
			rs = sql.executeQuery("select * from classify ");
			out.print("<center><br><br><form action='queryServlet' method='post'>");
			out.print("<select name='fenleiNumber'>");
			while (rs.next()) {
				int id = rs.getInt(1);
				String name = rs.getString(2);
				out.print("<option value=" + id + ">" + name + "</option>");
			}
			out.print("</select>");
			out.print("<input type='submit' value='提交'class='btn'>");
			out.print("</form></center>");
			out.print("<ul>");
			out.print("<li><img src='image/boutque01_r2_c2.jpg' alt='图片加载失败'></li>");
			out.print("<li><img src='image/boutque02_r2_c2.jpg' alt='图片加载失败'></li>");
			out.print("<li><img src='image/boutque03_r2_c2.jpg' alt='图片加载失败'></li>");
			out.print("</ul>");
			con.close();
		} catch (SQLException e) {
			out.print(e);
		}
	%>

</body>
</html>
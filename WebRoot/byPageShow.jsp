<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mybean.data.DataByPage"%>
<%@ page import="com.sun.rowset.*"%>
<jsp:useBean id="dataBean" class="mybean.data.DataByPage"
	scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<%@ include file="head.txt"%>
<title>购物页面</title>
<style>
.show_table {
	color: #fff;
}

button {
	background-color: #fff;
	border: 1px solid #fff;
	font-weight: bolder;
}

.mytable {
	margin-top: 10px;
	color: #ffffff;
	text-align: center;
	background-color: rgba(0, 0, 0, .1);
	color: #ffffff;
}

.mytable th, .mytable td {
	padding: 8px;
}

.tal_btn {
	border: none;
	background-color: rgba(0, 0, 0, 0);
	color: #ffff;
	font-size: 15px;
}

i {
	font-style: normal;
}

.footer {
	margin-top:100px;
	text-align: center;
	color:gray;
}

.put_table{
	margin-left:350px;
}

.put_btn{
	height: 30px;
	border: none;
	color: #ffffff;
	margin-top: 10px;
	background-color: rgba(105, 149, 253, .5);
}
</style>
</head>
<body background="image/background.jpg">
	<center>
		<div class="show_table">
			<br> <i>当前显示的内容是：</i>
			<jsp:setProperty property="pageSize" name="dataBean" param="pageSize" />
			<jsp:setProperty property="currentPage" name="dataBean"
				param="currentPage" />
			<table class="mytable">
				<tr>
					<th>化妆品标识号</th>
					<th>化妆品名称</th>
					<th>化妆品制造商</th>
					<th>化妆品价格</th>
					<th>查看详情</th>
					<th>添加到购物车</th>
				</tr>

				<%
					CachedRowSetImpl rowSet = dataBean.getRowSet();
					if (rowSet == null) {
						out.print("没有任何查询信息，无法浏览");
						return;
					}
					rowSet.last();
					int totalRecord = rowSet.getRow();
					out.println("全部记录数" + totalRecord);
					int pageSize = dataBean.getPageSize();
					int totalPages = dataBean.getTotalPages();
					if (totalRecord % pageSize == 0)
						totalPages = totalRecord / pageSize;
					else
						totalPages = totalRecord / pageSize + 1;
					dataBean.setPageSize(pageSize);
					dataBean.setTotalPages(totalPages);
					if (totalPages >= 1) {
						if (dataBean.getCurrentPage() < 1)
							dataBean.setCurrentPage(dataBean.getTotalPages());
						else
							dataBean.setCurrentPage(1);
						int index = (dataBean.getCurrentPage() - 1) * pageSize + 1;
						rowSet.absolute(index);
						boolean boo = true;
						for (int i = 1; i <= pageSize && boo; i++) {
							String number = rowSet.getString(1);
							String name = rowSet.getString(2);
							String maker = rowSet.getString(3);
							String price = rowSet.getString(4);
							String goods = "(" + number + "," + name + "," + maker + ")#" + price;
							goods = goods.replaceAll("\\p{Blank}", "");
							String button = "<form  action='putGoodsServlet' method = 'post'>"
									+ "<input type ='hidden' name='java' value= " + goods + ">"
									+ "<input type ='submit'  value='放入购物车' class='tal_btn'></form>";
							String detail = "<form  action='showDetail.jsp' method = 'post'>"
									+ "<input type ='hidden' name='xijie' value= " + number + ">"
									+ "<input type ='submit'  value='查看细节' class='tal_btn'></form>";
							out.print("<tr>");
							out.print("<td>" + number + "</td>");
							out.print("<td>" + name + "</td>");
							out.print("<td>" + price + "</td>");
							out.print("<td>" + number + "</td>");
							out.print("<td>" + detail + "</td>");
							out.print("<td>" + button + "</td>");
							out.print("</tr>");
							boo = rowSet.next();
						}
					}
				%>
			</table>
		</div>
		<div class="footer">
			<div>
				每页最多显示<jsp:getProperty name="dataBean" property="pageSize" />条信息,当前显示第<font
					color="rgb(105, 149, 253)"> <jsp:getProperty name="dataBean"
						property="currentPage" />
				</font>页，共有<font color="rgb(105, 149, 253)"> <jsp:getProperty name="dataBean"
						property="totalPages" />
				</font>页.
			</div>
			<table class="put_table">
				<tr>
					<td>
						<form action="" method=post>
							<input type="hidden" name="currentPage"
								value="<%=dataBean.getCurrentPage() + 1%>"> <input
								type="submit" name="g" value="上一页" class="put_btn">
						</form>
					</td>
					<td>
						<form action="" method=post>
							<input type="hidden" name="currentPage"
								value="<%=dataBean.getCurrentPage() - 1%>"> <input
								type="submit" name="g" value="下一页" class="put_btn">
						</form>
					</td>
					<td>
						<form action="" method=post>
							每页显示<input type="text" name="pageSize" value="1" size=3>
							条记录<input type="submit" name="g" value="确定" class="put_btn">
						</form>
					</td>
					<td>
						<form action="" method=post>
							输入页码：<input type="text" name="currentPage" size=2> <input
								type="submit" name="g" value="提交" class="put_btn">
						</form>
					</td>
				</tr>
			</table>
		</div>
	</center>
</body>
</html>
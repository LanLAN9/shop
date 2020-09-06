<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="userBean" class="mybean.data.Register" scope="request"></jsp:useBean>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<%@ include file="head.txt"%>
<title>注册页面</title>
<style>
        form {
        	margin-top: 30px;
            width: 50%;
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
        
    </style>
</head>
<body>
    <font size=2>
        <div align="center">
            <form action="registerServlet" method="post" name="form">
                <br>
                <table>
                    用户由字母、数字、下划线构成，*注释的项必须填写
                    <tr>
                        <td>*用户名称：</td>
                        <td><input type="text" name="logname"></td>
                        <td>*用户密码：</td>
                        <td><input type="password" name="password"></td>
                    </tr>
                    <tr>
                        <td>*重复密码</td>
                        <td><input type="password" name="again_password"></td>
                        <td>联系电话：</td>
                        <td><input type="text" name="phone"></td>
                    </tr>
                    <tr>
                        <td>邮寄地址：</td>
                        <td><input type="text" name="address"></td>
                        <td>真实姓名：</td>
                        <td><input type="text" name="realname"></td>
                    </tr>
                </table>
                <input type="submit" name="g" value="提交" class="btn">
            </form>
        </div>
        <div align="center">
            <p >
                <h3>注册反馈：</h3>
                <jsp:getProperty property="backNews" name="userBean" />
                <table cellspacing=0>
                    <tr>
                        <td>会员名称：</td>
                        <td>
                            <jsp:getProperty property="logname" name="userBean" />
                        </td>
                    </tr>
                    <tr>
                        <td>姓名：</td>
                        <td>
                            <jsp:getProperty property="realname" name="userBean" />
                        </td>
                    </tr>
                    <tr>
                        <td>地址：</td>
                        <td>
                            <jsp:getProperty property="address" name="userBean" />
                        </td>
                    </tr>
                    <tr>
                        <td>电话：</td>
                        <td>
                            <jsp:getProperty property="phone" name="userBean" />
                        </td>
                    </tr>
                </table>
            </p>
        </div>
    </font>
</body>

</html>
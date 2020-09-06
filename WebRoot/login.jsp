<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="loginBean" class="mybean.data.Login" scope="session" />
<HTML>
<HEAD>
<title>登录页面</title>
<style>
        form {
        	margin-top:30px;
            width: 30%;
            background-color: rgba(0, 0, 0, .1);
            padding-bottom: 10px;
            border: none;
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
<%@ include file="head.txt"%>
</HEAD>
<body>
    <font size=2>
        <div align="center">
            <br>

            <form action="loginServlet" Method="post">
                <table>
                    <tr>
                        <th>登录</th>
                    </tr>
                    <tr>
                        <td>登录名称:<Input type=text name="logname"></td>
                    </tr>
                    <tr>
                        <td>输入密码:<Input type=password name="password"></td>
                    </tr>
                </table>
                <input type=submit name="g" value="提交" class="btn">
            </form>



        </div>
        <div align="center">
                                恭喜
            <jsp:getProperty name="loginBean" property="backNews" />
            <br>
            <jsp:getProperty name="loginBean" property="logname" />
           	 登入成功！
            <div>
    </font>
</body>
package myservlet.control;
import mybean.data.Login;
import java.sql.*;
import java.util.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
public class HandleBuyGoods extends HttpServlet {
   public void init(ServletConfig config) throws ServletException { 
      super.init(config);
      try{ 
           Class.forName("com.mysql.jdbc.Driver");
      }
      catch(Exception e){} 
   }
   public  void  doPost(HttpServletRequest request,HttpServletResponse response) 
                        throws ServletException,IOException {
      request.setCharacterEncoding("UTF-8");
      String buyGoodsMess = request.getParameter("buy");
      if(buyGoodsMess==null||buyGoodsMess.length()==0) {
         fail(request,response,"购物车没有物品，无法生成订单");  
         return;
      }
      String price = request.getParameter("price");
      if(price==null||price.length()==0) {
         fail(request,response,"没有计算价格和，无法生成订单");  
         return;
      }
      float sum = Float.parseFloat(price);
      Login loginBean=null;
      HttpSession session=request.getSession(true);
      try{  loginBean=(Login)session.getAttribute("loginBean");
            boolean b =loginBean.getLogname()==null||
            loginBean.getLogname().length()==0;
            if(b)
              response.sendRedirect("login.jsp");//重定向到登录页面
      }
      catch(Exception exp){
           response.sendRedirect("login.jsp");//重定向到登录页面
      }
      //String yy="jdbc:mysql://127.0.0.1/shop?"+
                             //"user=root&password=password&characterEncoding=UTF-8";
      String uri = "jdbc:mysql://127.0.0.1/shop?"+
              "user=root&password=password&characterEncoding=UTF-8";
      Connection con; 
      PreparedStatement sql;
      try{ con=DriverManager.getConnection(uri);
           String insertCondition="INSERT INTO orderForm VALUES (?,?,?,?)";
           sql=con.prepareStatement(insertCondition);
           sql.setInt(1,0); //订单序号会自定增加
           sql.setString(2,loginBean.getLogname());//
           sql.setString(3,buyGoodsMess);//
           sql.setFloat(4,sum);//
           sql.executeUpdate();
           LinkedList car=loginBean.getCar();
           car.clear();  //清空购物车
           success(request,response,"生成订单成功");
      }
      catch(SQLException exp){
           fail(request,response,"生成订单失败"+exp);
      }
   }
   public  void  doGet(HttpServletRequest request,HttpServletResponse response)
                        throws ServletException,IOException {
      doPost(request,response);
   }
   public void success(HttpServletRequest request,HttpServletResponse response,
                      String backNews) {
        response.setContentType("text/html;charset=UTF-8");
        try {
        	PrintWriter out=response.getWriter();
            out.println("<html><body style='background-color: rgb(228, 252, 252);text-align:center'>");
            out.println("<div  style='margin-top:150px'><img src='image/gou.svg' alt='图片无法加载' width='60px'>");
            out.println("<h2>"+backNews+"</h2>") ;
            //out.println("返回主页<br>");
            out.println("<br><a href ='index.jsp' style='text-decoration: none;width: 40px;height: 40px;background-color: #90EE90;color: #ffffff;font-size: 14px;padding: 6px;border-radius: 25px;'>主页</a>");
            //out.println("查看订单<br>");
            out.println("<a href ='lookOrderForm.jsp' style='text-decoration: none;width: 40px;height: 40px;background-color: #B4EEB4;color: #ffffff;font-size: 14px;padding: 6px;border-radius: 25px;'>查看订单</a>");
            out.println("</div></body></html>");
        }
        catch(IOException exp){}
    }
   public void fail(HttpServletRequest request,HttpServletResponse response,
                      String backNews) {
        response.setContentType("text/html;charset=UTF-8");
        try {
         PrintWriter out=response.getWriter();
         out.println("<html><body>");
         out.println("<h2>"+backNews+"</h2>") ;
         out.println("返回主页：");
         out.println("<a href =index.jsp>主页</a>");
         out.println("</body></html>");
        }
        catch(IOException exp){}
    }
}

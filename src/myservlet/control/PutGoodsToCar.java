package myservlet.control;
import mybean.data.Login;
import java.util.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
public class PutGoodsToCar extends HttpServlet {
   public void init(ServletConfig config) throws ServletException { 
      super.init(config);
   }
   public  void  doPost(HttpServletRequest request,HttpServletResponse response) 
                        throws ServletException,IOException {
      request.setCharacterEncoding("UTF-8");
      String goods = request.getParameter("java");
      System.out.println(goods);
      Login loginBean=null;
      HttpSession session=request.getSession(true);
      try{  loginBean=(Login)session.getAttribute("loginBean");
            boolean b =loginBean.getLogname()==null||
            loginBean.getLogname().length()==0;
            if(b)
              response.sendRedirect("login.jsp");//重定向到登录页面
            LinkedList<String> car = loginBean.getCar();
            car.add(goods);
            speakSomeMess(request,response,goods); 
      }
      catch(Exception exp){
           response.sendRedirect("login.jsp");//重定向到登录页面
      }
   }
   public  void  doGet(HttpServletRequest request,HttpServletResponse response)
                        throws ServletException,IOException {
      doPost(request,response);
   }
   public void speakSomeMess(HttpServletRequest request,
                     HttpServletResponse response,String goods) {
       response.setContentType("text/html;charset=UTF-8");
        try {
         PrintWriter out=response.getWriter();
         out.print("<head></head>");
         out.print("<html><body style='background-color: rgb(228, 252, 252);'>");
         out.println("<div style='margin-top: 150px;color: gray;text-align: center;'>");
         out.println("<img src='image/gou.svg' alt='图片无法加载' width='60px'>");
         out.println("<h3>"+goods+"放入购物车</h3>") ;
         out.println("<a href='lookShoppingCar.jsp' style='text-decoration: none;width: 40px;height: 40px;background-color: #B4EEB4;color: #ffffff;font-size: 14px;padding: 6px;border-radius: 25px;'>查看购物车</a>");
         out.println("<br><br>");
         out.println("<a href='byPageShow.jsp'style='text-decoration: none;width: 40px;height: 40px;background-color: #90EE90;color: #ffffff;font-size: 14px;padding: 6px;border-radius: 25px;'>浏览化妆品</a>");
         out.println("</div></body></html>");
        }
        catch(IOException exp){}
   }
}

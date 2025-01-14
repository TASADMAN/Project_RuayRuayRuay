package servlet;
  
import java.io.IOException;  
import java.io.PrintWriter;  
import java.util.List;  
import javax.servlet.ServletException;  
import javax.servlet.annotation.WebServlet;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;

import DAO.Emp;
import DAO.EmpDao;  
 
  
@WebServlet("/ViewServlet")  
public class ViewServlet extends HttpServlet {  
    private static final long serialVersionUID = 1L;  
    protected void doGet(HttpServletRequest request, HttpServletResponse response)   
           throws ServletException, IOException {  
        response.setContentType("text/html");  
        PrintWriter out=response.getWriter();  
          
        String spageid=request.getParameter("page");  
        int pageid=Integer.parseInt(spageid);  
        int total=6;  
        if(pageid==1){}  
        else{  
            pageid = pageid-1;  
            pageid=pageid*total+1;  
        }  
        List<Emp> list=EmpDao.getRecords(pageid,total);  
  
        out.print("<h1>Page No: "+spageid+"</h1>");  
        out.print("<div class=\"row row-cols-1 row-cols-md-3 g-4\">");  
        out.print("<tr><th>Id</th><th>Name</th><th>Salary</th>");  
        for(Emp e:list){  
            out.print("<div class=\"card\" style=\"width: 18rem;\">\r\n"
            		+ "  <div class=\"card-body\">\r\n"
            		+ "    <h5 class=\"card-title\">"+e.name+"</h5>\r\n"
            		+ "    <h6 class=\"card-subtitle mb-2 text-muted\">"+e.price+" บาท</h6>\r\n"
            		+ "    <p class=\"card-text\">"+e.des+"</p>\r\n"
            		+ "    <a href=\"#\" class=\"card-link\">Card link</a>\r\n"
            		+ "    <a href=\"#\" class=\"card-link\">Another link</a>\r\n"
            		+ "  </div>\r\n"
            		+ "</div>");  
        }  
        out.print("</div>");  
          
        out.print("<a href='ViewServlet?page=1'>1</a> ");  
        out.print("<a href='ViewServlet?page=2'>2</a> ");  
        out.print("<a href='ViewServlet?page=3'>3</a> ");  
          
        out.close();  
    }  
} 
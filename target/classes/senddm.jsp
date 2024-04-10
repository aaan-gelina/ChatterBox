<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="com.chatterbox.FirebaseConnect" %>
<%@ page import="com.chatterbox.Dm" %>

<%! int uid; %>                            
<% uid = (Integer)request.getSession().getAttribute("currentUser"); %>      <!-- get uid of current logged-in user -->
<%! String dmKey; %>                            
<% dmKey = request.getSession().getAttribute("dmKey"); %>            <!-- get dmKey of current dm chat -->


<!DOCTYPE html>
<html>
<%
    public class SendDm extends HttpServlet{
        public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

            //read DM object from database
            DM dm = FirebaseConnect.readDm(dmKey);

            //add the message contents to the DM object, and update it in the database
            dm.sendMessage(uid, request.getParameter("usermessage"));

            //redirect to dm chat page after 2 seconds 
            out.println("<meta http-equiv='refresh' content='2;URL=./dmpagefront.jsp?dmKey=" + dmKey + "'>");
        }              
    }
%>

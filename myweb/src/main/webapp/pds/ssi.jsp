<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- ssi.jsp 공통 코드를 포함하는 페이지
     -->
 <%@ page import="java.sql.*" %>
 <%@ page import="java.io.*" %>
 <%@ page import="java.util.*" %>
 
 <%@ page import="net.utility.*" %>
 <%@ page import="net.pds.*" %>

<jsp:useBean id="dao" class="net.pds.PdsDAO" scope="page"></jsp:useBean>
<jsp:useBean id="dto" class="net.pds.PdsDTO" scope="page"></jsp:useBean>

<%request.setCharacterEncoding("UTF-8");%>

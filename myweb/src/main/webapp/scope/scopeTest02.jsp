<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>02_Test</title>
</head>
<body>
<h3>웹페이지 내부 변수의 scope(유효범위)</h3>

<%--	[페이지이동]
		1.<a href=""> </a>
		2.<form action=""></form>
		3.location.href=""
		4.<jsp:forward page=""> </jsp:forward>
	    ※5.response.sendRedirect("")
 --%>
 <%
 pageContext.setAttribute("one", 100);
 request.setAttribute("two", 200);
 session.setAttribute("three", 300);
 application.setAttribute("uid", "itwill");
 
 
 
 %>
 <!-- request.getAttribute("two") null값 -->
 
<!-- <a href="scoperesult_02.jsp"> 결과페이지 이동</a> -->

<!-- request.getAttribute("two") null값  -->
 <!-- <form action="scoperesult_02.jsp">
 <input type="submit" value="[결과페이지]">
 </form>
  -->
<!--  <script>
 alert("결과페이지 이동");
 location.href="scoperesult_02.jsp"
 </script>
  -->


<!-- 액션 태그로 이동 

request.getAttribute("two") 200 접근가능
request  내부 변수는 부모페이지와 자식페이지 내에서만 유효하다-->

<%-- <jsp:forward page="scoperesult_02.jsp"></jsp:forward>
															--%>
<%-- <%		response.sendRedirect("scoperesult_02.jsp");

%>	 --%>														

<%		
String view="scoperesult_02.jsp";
RequestDispatcher rd=request.getRequestDispatcher(view);
rd.forward(request, response);
/*
		내부변수 	scopeTest02 부모		scoperesult_02 자식
	----------------------------------------------
	pageContext		0						x
	request			0					  o | x
	session			0						o
	application		0						o
	



*/


%>														
	
															
 
</body>
</html>
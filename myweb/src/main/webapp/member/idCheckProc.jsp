<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="ssi.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 중복 확인결과</title>
</head>
<body>
	<div style="text-align: center">
		<h3>아이디 중복 확인결과</h3>
		

<%
	String id= request.getParameter("id").trim();
	int cnt =dao.duplecateId(id);
	out.println("입력ID:<strong>" +id +"</strong>");
	if(cnt==0){
		out.println("<p>사용가능한 아이디 입니다</p>");
%>
		<!--사용 가능한 아이디인 경우 부모창에 전달하기  -->	
		<a href="javascript:apply('<%=id%>')">적용</a>
		<script>
		 function apply(id){
			 //alert(id);
			 opener.document.memfrm.id.value=id;
			 window.close();
		 }
		</script>
		
<% 	
	}else{
		out.println("<p style='color:red'> 해당 아이디는 사용 불가능 합니다</p>");
	}
%>
<hr>
<a href="javascript:history.back()">다시검색</a>
&nbsp;&nbsp;
<a href="javascript:window.close()">창닫기</a>
</div>
</body>
</html>
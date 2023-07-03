<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="org.eclipse.jdt.internal.compiler.ast.IfStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>

<!-- 본문 시작 -->
<h3>*아이디 찾기 결과*</h3>
<%
String mname =request.getParameter("mname").trim();
String email =request.getParameter("email").trim();

dto.setMname(mname);
dto.setEmail(email);

boolean flag =dao.findId(dto);//아이디를 가져오기

if(flag==false){
	out.println("<p>이름 이메일 확인해주세요</p>");
	out.println("<p><a href='javascript:history.back()'>재시도</a></p>");
} else {
	/* 
	out.println("<script>");
	out.println("    alert('임시 비밀번호 발급 성공');");
	out.println(" location.href='../member/loginForm.jsp';");
	out.println("</script>");
	 */ 	
	String message="";
	 message +="아이디, 임시 비밀번호가 이메일로 전송 되었습니다 \\n" ;
	 message +="임시 비밀번호는 로그인 후 회원정보수정에서 수정하시기 바랍니다" ;
	out.println("<script>");
	out.println("    alert('"+ message +"');");
	out.println(" location.href='loginForm.jsp'");
	out.println("</script>");
}

%>
<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>

<!-- 회원정보수정 proc -->


<%
String id= (String)session.getAttribute("s_id");
String mname=request.getParameter("mname").trim();
String passwd=request.getParameter("passwd").trim();
String email=request.getParameter("email").trim();
String tel=request.getParameter("tel").trim();
String zipcode=request.getParameter("zipcode").trim();
String address1=request.getParameter("address1").trim();
String address2=request.getParameter("address2").trim();
String job=request.getParameter("job").trim();

///dto 담기
dto.setId(id);
dto.setMname(mname);
dto.setPasswd(passwd);
dto.setEmail(email);
dto.setTel(tel);
dto.setZipcode(zipcode);
dto.setAddress1(address1);
dto.setAddress2(address2);
dto.setJob(job);
int cnt=dao.updatepro(dto);
if (cnt == 0) {
	out.println("<p>회원정보 수정실패! ");
	out.println("비밀번호가 다릅니다</p>");
	out.println("<p><a href='javascript:history.back()'>재시도</a></p>");
} else {
	out.println("<script>");
	out.println("    alert('회원정보 수정성공');");
	out.println(" location.href='loginForm.jsp';"); //목록페이지 이동
	out.println("</script>");
}

%>
<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>

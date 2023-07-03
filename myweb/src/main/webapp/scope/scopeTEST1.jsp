<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>01 SCOPE test</title>
</head>
<body>
<h3>내장객체 및 내부변수</h3>
<%
/* 
	   [JSP 내장객체]

	  - JSP페이지가 서블릿에서 변환될때(.class) JSP컨테이너(Tomcat웹서버)가 자동적으로 제공
	  - JSP페이지 내에서 제공하는 특수한 레퍼런스(참조) 타입의 변수
	  - 객체 생성 없이 바로 사용할 수 있는 JSP의 객체

	  1.OUT			:출력객체
	  2.pageContext	:jsp페이지 자체의 context제공
	  3.request		:요청에 관한 정보
	  4.response	:응답에 대한 정보
	  5.session		:요청에 관한 context 제공
	  6.application	:서블릿 및 외부 환경 정보 context제공
	  
-------------------------------------------------------------------------------------------------------------------------------
		[Scope의 종류]
	  	-myweb 프로젝트내에서 페이지들간에 값을 공유하기 위해 사용
	  	1.pageContext	: 현재 페이지에서만 유효. 기본값
	  	2.request		: 부모 페이지와 자식 페이지에서만 유효한 값
	  	3.session		: myweb프로젝트의 모든 페이지에서 유효 (사용자 개별 접근, 시간) ONLY ME
	  	4.application	: myweb프로젝트의 모든 페이지에서 유효 (모든 사용자 접근, 서버 정보) ALL
	  	
-----------------------------------------------------------------------------------------------------
		[내부 변수 선언 형식]-별도의 자료형이 있다
	  	1.pageContext.setAttribute("변수명",값)
	  	2.request.setAttribute("변수명",값)
	  	3.session.setAttribute("변수명",값)
	  	4.application.setAttribute("변수명",값)
	  	
	  	[내부 변수 값 가져오기]
	  	1.pageContext.getAttribute("변수명",값)
	  	2.request.getAttribute("변수명",값)
	  	3.session.getAttribute("변수명",값)
	  	4.application.getAttribute("변수명",값)
	  	
	  	
	  */
	  //각 내부 변수에 값 올리기
	  //kor변수는 현재 페이지 내에서만 사용 가능
	  pageContext.setAttribute("kor", 100);
	  request.setAttribute("eng", 200);
	  session.setAttribute("mat", 300);
	  application.setAttribute("uname", "itwill");

	//내부 변수값 가져오기
	
	  	out.print(pageContext.getAttribute("kor"));
		out.print("<hr>");
	  	out.print(request.getAttribute("eng"));
	  	out.print("<hr>");
	  	out.print(session.getAttribute("mat"));
	  	out.print("<hr>");
	  	out.print(application.getAttribute("uname"));
	  	out.print("<hr>");
	  
	  	Object obj=pageContext.getAttribute("kor");
	  	int kor=(int)obj;
	  	int eng =(int)request.getAttribute("eng");
	  	int mat =(int)session.getAttribute("mat");
	  	String uname =(String)application.getAttribute("uname");
	  	
	  	
	  	out.print("1.pageContext영역:"+kor +"<hr>");
	  	out.print("2.request영역:"+eng +"<hr>");
	  	out.print("3.session영역:"+mat +"<hr>");
	  	out.print("4.application영역:"+uname +"<hr>");
		
	  	
	  	pageContext.removeAttribute("kor");
	  	request.removeAttribute("eng");
	  	session.removeAttribute("mat");
	  	application.removeAttribute("uname");
	  	
	  	out.print(pageContext.getAttribute("kor"));
		out.print("<hr>");
	  	out.print(request.getAttribute("eng"));
	  	out.print("<hr>");
	  	out.print(session.getAttribute("mat"));
	  	out.print("<hr>");
	  	out.print(application.getAttribute("uname"));
	  	out.print("<hr>");
	  	
%>


</body>
</html>
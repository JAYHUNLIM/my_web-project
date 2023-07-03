<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>uploadtestProc</title>
</head>
<body>
<h3> 파일 첨부 테스트 결과</h3>
<%
	/* request.setCharacterEncoding("UTF-8");
 	out.print(request.getParameter("uname"));
 	out.print("<hr>");
 	out.print(request.getParameter("subject"));
 	out.print("<hr>");
 	out.print(request.getParameter("content"));
 	out.print("<hr>");
 	out.print(request.getParameter("filenm"));
 	out.print("<hr>");
 
 	enctype="multipart/form-data"속성이 폼에 추가되면
 	request 내장 객체가 가지고 있는 값을 가져올 수 없다
 	request.getParameter("") null 출력
 	
 	
 	
 	1.첨부된 파일 저장하기
 	//	src/main/webapp/strage
 	*/ 	
 	//실제 물리적인 경로
 	try{
 	String saveDirectory=application.getRealPath("/storage");
 	//out.print(saveDirectory);
 	
 	// D:\202301\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\myweb\storage
 	
 	//최대 저장 용량(10M)
 	int maxPostSize=1024*1024*10;
 	
 	//한글 인코딩
 	String encoding="UTF-8";
 	
 	MultipartRequest mr=new MultipartRequest(request,saveDirectory,maxPostSize,encoding,new DefaultFileRenamePolicy());
 	///////
 	
 	//2. mr참조변수가 가리키고 있는 텍스트 
 		out.print("<hr>");
 	 	out.print(mr.getParameter("uname"));
 		out.print("<hr>");
 	 	out.print(mr.getParameter("subject"));
 		out.print("<hr>");
 	 	out.print(mr.getParameter("content"));
 	 	out.print("<hr>");
 	 	//
 	 
 		    //3. /storage폴더에 저장된 파일정보 확인하기
			//1.mr에서 <input type=file> 전부 수거 	 	
 			//열거형 Enumeration enum={"KIM","LEE","PARK"}
			//첨부파일이 3개 ->files={<input type=file>,<input type=file>,<input type=file>}
			Enumeration files= mr.getFileNames();
			
			//2. files가 가지고 있는 값들 중에서 개별적으로 접근하기 위해 name 가져오기
				//첨부 :<input type=file name=filenm>
			String item=(String)files.nextElement();	//filenm
			
			//3. item이름 (filenm)이 가지고 있는 실제파일을 mr객체에서 가져오기
			String ofileName=mr.getOriginalFileName(item);
			out.print("원본 파일명:"+ ofileName);
			out.print("<hr>");
			
			String fileName=mr.getFilesystemName(item);
			out.print("리네임 파일명: "+fileName);
			out.print("<hr>");
			
			//4. storage 폴더에 저장된 파일의 기타 정보 확인하기
			File file =mr.getFile(item);
			if(file.exists()){
				out.print("원본 파일명:"+ file.getName());
				out.print("<hr>");
				out.print("원본 파일명:"+ file.length()+"byte");
				out.print("<hr>");
				
			}else{
				out.print("파일 존재하지 않음");
			}
			
			
 	}catch(Exception e){
 		out.print(e);
 		out.print("<p>파일 업로드 실패</p>");
 		out.print("<a href='javascript:history.back();'>다시시도</a>");
 	}
 	
 	
 	
 	
 	
 	
%>

</body>
</html>
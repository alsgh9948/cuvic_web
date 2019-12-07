<!-- 게시글(이미지, 설명) DB insert -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="UTF-8"%>
<%@ page
   import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*"%>
<%@ page import="java.sql.*"%>

<%
   //이미지 업로드 및 폴더 저장
   request.setCharacterEncoding("UTF-8");
   String realFolder;
   String filename1 = "";
   int maxSize = 1024 * 1024 * 1024;
   String encType = "UTF-8";
   String folder_name = (String)session.getAttribute("nick_name")+"_"+(String)session.getAttribute("folder_name");
   String type = (String)session.getAttribute("type");
   realFolder ="C:/Users/seo/Desktop/cuvic_web/cuvic_web_site/WebContent/post/"+folder_name;	
   try {
	   	System.out.println("1");
	      MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType);
		   	System.out.println("2");
	      Enumeration files = multi.getFileNames();
	      while(files.hasMoreElements())
	      {
		      String file1 = (String) files.nextElement();
		      filename1 = multi.getFilesystemName(file1);
		      File file = new File( realFolder +"/"+ filename1 );
	      }
	      File[] file_list = new File(realFolder).listFiles();      
		  for (int i = 0; i < file_list.length; i++) {
			File file = new File(realFolder +"/"+file_list[i].getName());
			file.renameTo(new File(realFolder +"/"+file_list[i].getName().replace(" ","_")));
	  	  }
     }
   	  catch (Exception e) {
	      e.printStackTrace();
	  }
%>

<title>Insert title here</title>
</head>
<body>

</body>
</html>
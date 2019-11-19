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
   //DB 접속
   Connection conn = null;
   Statement stmt = null;
   String jdbc_driver = "com.mysql.jdbc.Driver";
   String jdbc_url = "jdbc:mysql://database-1.cojltuuvj7qw.ap-northeast-2.rds.amazonaws.com:3307/cuvic?useUnicode=true&characterEncoding=UTF-8";
	try {
      Class.forName(jdbc_driver);
      conn = DriverManager.getConnection(jdbc_url, "admin", "tkakrnl1");
      stmt = conn.createStatement();
   } catch (Exception e) {
      System.out.println(e);
   }

   //이미지 업로드 및 폴더 저장
   request.setCharacterEncoding("UTF-8");
   String realFolder;
   String filename1 = "";
   int maxSize = 1024 * 1024 * 6;
   String encType = "UTF-8";
   String savefile = "image";
   ServletContext scontext = getServletContext();
   realFolder ="C:/Users/seo/Desktop/cuvic_web/cuvic_web_site/WebContent/user_img";
   System.out.println(realFolder);
   try {
      
      MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType);
      String id = (String)multi.getParameter("user_id");
      String gender = (String)multi.getParameter("user_gender");
	  System.out.println(gender);
      Enumeration<?> files = multi.getFileNames();
      String file1 = (String) files.nextElement();
      filename1 = multi.getFilesystemName(file1);
      String fullpath = realFolder + filename1; //fullpath = 이미지 경로
      File file = new File( realFolder +"/"+ filename1 );
      File fileNew = new File( realFolder +"/"+ id+".jpg" );
      if( file.exists() ) file.renameTo( fileNew );
      if(filename1 != null)
      {
    	  stmt.executeUpdate("update user_list set img_name='"+id+".jpg' where id='"+id+"'");
      }
      else
      {
    	  if(gender.equals("m"))
	    	  stmt.executeUpdate("update user_list set img_name='man.png' where id='"+id+"'");
    	  else if(gender.equals("w"))
	    	  stmt.executeUpdate("update user_list set img_name='woman.png' where id='"+id+"'");  
      }
      pageContext.forward("main.jsp");
   } catch (Exception e) {
      e.printStackTrace();
   }
%>

<title>Insert title here</title>
</head>
<body>

</body>
</html>
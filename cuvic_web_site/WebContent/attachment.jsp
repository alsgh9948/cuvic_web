<!-- 게시글(이미지, 설명) DB insert -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="UTF-8"%>
<%@ page
   import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="db" class="cuvic_web_site.db_control" />
<% request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
 %>
<script>
<%
   //이미지 업로드 및 폴더 저장
   request.setCharacterEncoding("UTF-8");
   String realFolder;
   String filename1 = "";
   int maxSize = 1024 * 1024 * 1024;
   String encType = "UTF-8";
   String nick_name = (String)session.getAttribute("nick_name");
   String folder_name = (String)session.getAttribute("folder_name");
   String contents_list[] = new String[2];
   folder_name = nick_name+"_"+folder_name;   
   realFolder ="C:/Users/seo/Desktop/cuvic_web/cuvic_web_site/WebContent/post/"+folder_name;	
   String type="";
   try {
	      MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	      contents_list[0] = multi.getParameter("title");
	      contents_list[1] = multi.getParameter("contents");
	      type = multi.getParameter("type");

	      db.insert_post(contents_list, nick_name, (String)session.getAttribute("folder_name"), type);
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
location.href="controller.jsp?&action=load_board&type=<%=type%>";
</script>
<title>Insert title here</title>
</head>
<body>

</body>
</html>
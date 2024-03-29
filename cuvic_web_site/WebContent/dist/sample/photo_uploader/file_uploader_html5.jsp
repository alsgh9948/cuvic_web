<%--------------------------------------------------------------------------------
	* 화면명 : Smart Editor 2.8 에디터 - 다중 파일 업로드 처리
	* 파일명 : /SE2/sample/photo_uploader/file_uploader_html5.jsp
--------------------------------------------------------------------------------%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.UUID"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="java.nio.file.Paths"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	// 로컬경로에 파일 저장하기 ============================================
	String sFileInfo = "";
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
	// 파일명 - 싱글파일업로드와 다르게 멀티파일업로드는 HEADER로 넘어옴 
	String name = request.getHeader("file-name");
	name = URLDecoder.decode(name, "utf-8");

	// 확장자
	String ext = name.substring(name.lastIndexOf(".")+1);
	String folder_name = (String)session.getAttribute("nick_name")+"_"+(String)session.getAttribute("folder_name");
    String board_type = (String)session.getAttribute("board_type");
    String type = (String)session.getAttribute("type");

	// 파일 기본경로
	String defaultPath="";
	if(board_type=="post")
		defaultPath = "C:\\Users\\seo\\Desktop\\cuvic_web\\cuvic_web_site\\WebContent\\post_board\\"+type+"\\"+folder_name+"\\img\\";
	else
		defaultPath = "C:\\Users\\seo\\Desktop\\cuvic_web\\cuvic_web_site\\WebContent\\picture_board\\"+folder_name+"\\";
	// 파일 기본경로 _ 상세경로
	String path = defaultPath + File.separator;

	File file = new File(path);
	if(!file.exists()) {
		file.mkdirs();
	}

	String realname = UUID.randomUUID().toString() + "." + ext;
	InputStream is = request.getInputStream();
	OutputStream os = new FileOutputStream(path + name);
	int numRead;

	// 파일쓰기
	byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
	while((numRead = is.read(b,0,b.length)) != -1) {
		os.write(b,0,numRead);
	}

	if(is != null) {
		is.close();
	}

	os.flush();
	os.close();
	// 파일 삭제
// 	File f1 = new File(path, realname);
// 	if (!f1.isDirectory()) {
// 		if(!f1.delete()) {
// 			System.out.println("File 삭제 오류!");
// 		}
// 	}

	if(board_type=="post")
		sFileInfo += "&bNewLine=true&sFileName="+ name+"&sFileURL="+"/cuvic_web_site/post_board/"+type+"/"+folder_name+"/img/"+name;
	else
		sFileInfo += "&bNewLine=true&sFileName="+ name+"&sFileURL="+"/cuvic_web_site/picture_board/"+folder_name+"/"+name;
	out.println(sFileInfo);	
	// ./로컬경로에 파일 저장하기 ============================================
%>
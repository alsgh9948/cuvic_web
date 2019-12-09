<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.ArrayList, java.io.File"%>
<% request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
 %>
<jsp:useBean id="db" class="cuvic_web_site.db_control" />
<jsp:useBean id="data_get_set" class="cuvic_web_site.data_get_set" />
<jsp:setProperty name="data_get_set" property="*" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<script type="text/javascript">
	<%
	  String action = request.getParameter("action");
	if(action.equals("sign_up"))
	{
		db.sign_up(data_get_set);
	}
	else if(action.equals("login"))
	{
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String[] nick_name = db.login(id, password);
  		if(nick_name[1] != null)
  		{
	   		%>
			alert("<%=nick_name[1] %>");
			<%
  		}
  		else
  		{
  			session.setAttribute("nick_name", nick_name[0]);
   		}			
  		pageContext.forward("main.jsp");
	}
	else if(action.equals("logout"))
	{
		session.invalidate();
		pageContext.forward("main.jsp");
	}
	else if(action.equals("IdCheck"))
	{
	 boolean check = db.IdCheck(request.getParameter("id"));
	 if(check)
	    {
	    %>
	       	alert("사용가능한 아이디입니다.");
	    <%
	 }
	  else if(!check)
	  {
	      session.setAttribute("check","false");
	     %>
	        	alert("이미 사용중인 아이디입니다.");
	 	  <%
	  }
	}
	else if(action.equals("load_info"))
	{
		String id = (String)session.getAttribute("id");
		String group = (String)request.getParameter("group");
	 	ArrayList<String[]> list = db.load_info(group);
	 	request.setAttribute("info_list", list);
     	pageContext.forward("member.jsp");
	}
	else if(action.equals("load_active_record"))
	{
		ArrayList<String[]> list = db.load_active_record();
		request.setAttribute("active_record_list", list);
		pageContext.forward("active_record.jsp");
	}
	else if(action.equals("insert_active_record"))
	{
	 	db.insert_active_record(data_get_set);
	}
	else if(action.equals("delete_active_record"))
	{
		String title = request.getParameter("list");
		db.delete_active_record(title);
		pageContext.forward("controller.jsp?&action=load_active_record");

	}
	else if(action.equals("load_picture_board"))
	{
		if((String)session.getAttribute("nick_name")==null)
		{
		%>
			alert("로그인후에 이용해주세요");
	        location.href="main.jsp";
		<%
		}
		else
		{	
			ArrayList<String[]> list = db.load_picture("*");
			request.setAttribute("picture_list", list);
			pageContext.forward("picture_board.jsp");
		}
	}
	else if(action.equals("load_board"))
	{
		String type=request.getParameter("type");
		ArrayList<String[]> list=null;
		String board_type = (String)session.getAttribute("type");
		
		if((String)session.getAttribute("nick_name")==null)
		{
		%>
			alert("로그인후에 이용해주세요");
	        location.href="main.jsp";
		<%
		}
		else
		{	
			if(type.equals("seminar"))			
				list = db.load_post("*", type, request.getParameter("year"));
			else
				list = db.load_post("*", type, "-");
			request.setAttribute("post_list", list);
			request.setAttribute("type", type);
			pageContext.forward("post_board.jsp");
		}
	}
	else if(action.equals("load_post_detail"))
	{
		if((String)session.getAttribute("nick_name")==null)
		{
		%>
			alert("로그인후에 이용해주세요");
	        location.href="main.jsp";
		<%
		}
		else
		{
			String target = (String)request.getParameter("cnt");
			String type=request.getParameter("type");
			String board_type = (String)session.getAttribute("type");
			String year = request.getParameter("year");
			ArrayList<String[]> list = null;
			if(type.equals("seminar"))		
				list = db.load_post(target, type,year);
			else
				list = db.load_post(target, type,"-");
			request.setAttribute("post_list", list);
			request.setAttribute("type",type);
			pageContext.forward("post_detail.jsp");

		}
	}
	else if(action.equals("load_seminar_board"))
	{
		String year=request.getParameter("year");
		pageContext.forward("seminar_board.jsp");
	}
	else if(action.equals("load_data_board"))
	{
		String Type=request.getParameter("type");
		pageContext.forward("data_board.jsp");
	}
	else if(action.equals("picture_upload"))
	{
		String nick_name = (String)session.getAttribute("nick_name");
		String folder_name = (String)session.getAttribute("folder_name");
		db.insert_picture(data_get_set,nick_name,folder_name);
		%>
		location.href="controller.jsp?&action=load_picture_board";<%
	}
	else if(action.equals("remove_folder"))
	{
		String today = (String)session.getAttribute("folder_name");
		String type = (String)session.getAttribute("type");
        File folder = new File("C:/Users/seo/Desktop/cuvic_web/cuvic_web_site/WebContent/"+type+"/"+(String)session.getAttribute("nick_name")+"_"+today);
       	if(folder.exists())
       	{        
       	File[] file_list = folder.listFiles();
		for (int i = 0; i < file_list.length; i++) {
			file_list[i].delete(); 
		}
			folder.delete();
		}	
    }
	else if(action.equals("load_picture_detail"))
	{
		if((String)session.getAttribute("nick_name")==null)
		{
		%>
			alert("로그인후에 이용해주세요");
	        location.href="main.jsp";
		<%
		}
		else
		{
			String target = (String)request.getParameter("cnt");
			ArrayList<String[]> list = db.load_picture(target);
			request.setAttribute("picture_list", list);
			pageContext.forward("picture_detail.jsp");
	}
   }
	%>
	</script>
<body>
</body>
</html>
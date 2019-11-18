<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.ArrayList"%>
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
	 	ArrayList<String[]> list = db.load_info();
	 	request.setAttribute("list", list);
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
		pageContext.forward("picture_board.jsp");
	}
	else if(action.equals("load_board"))
	{
		String type=request.getParameter("type");
		pageContext.forward("board.jsp");
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
	%>
	</script>
<body>
</body>
</html>
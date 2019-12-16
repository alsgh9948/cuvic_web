<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%><% request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:useBean id="db" class="cuvic_web_site.db_control" />

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link rel="stylesheet" type="text/css" href="css/main.css?version=2">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">


<style>
.mySlides {
	display: none
}

.w3-left, .w3-right, .w3-badge {
	cursor: pointer
}

.w3-badge {
	height: 13px;
	width: 13px;
	padding: 0;
}
</style>

<script>
	$(function() {
		$.datepicker.setDefaults({
		    dateFormat: 'yy-mm-dd' //Input Display Format 변경
		});

		$("#birthday").datepicker();
		$(".zeta-menu li").hover(function() {
			$('ul:first', this).show();
		}, function() {
			$('ul:first', this).hide();
		});
		$(".zeta-menu>li:has(ul)>a").each(function() {
			$(this).html($(this).html() + ' &or;');
		});
		$(".zeta-menu ul li:has(ul)").find("a:first").append(
				"<p style='float:right;margin:-3px'>&#9656;</p>");
	});
    $(document).ready(function(){
        <%
        ArrayList<String[]> lately_list = db.lately_post();
    	for(String[] post : lately_list)
    	{
  			String board = post[1].split("_")[0];
			if(board.equals("picture"))
			{
				%>
	    		$('#new_post').append("<a href=controller.jsp?action=load_picture_detail&cnt=<%=post[0]%>><div><%=post[2]%></div></a>");
	    		<%	
			}
			else
			{
				%>
	    		$('#new_post').append("<a href=controller.jsp?action=load_post_detail&cnt=<%=post[0]%>&type=<%=board%>><div><%=post[2]%></div></a>");
	    		<%
			}
  			
    	}
		String[] user_info = db.load_myinfo((String)session.getAttribute("id"));
		request.setAttribute("user_info", user_info);
    	%>
    	document.getElementById("name").value = "<%=user_info[0]%>";
    	if("<%=user_info[1]%>" == "m")
 	   		document.getElementsByName("gender")[0].checked = true;
    	else
 	   		document.getElementsByName("gender")[1].checked = true;
    	document.getElementById("phone").value = "<%=user_info[2]%>";
    	document.getElementById("Email").value = "<%=user_info[3]%>".split("@")[0];
    	document.getElementById("Addr").value = "<%=user_info[3]%>".split("@")[1];
    	document.getElementById("birthday").value = "<%=user_info[4]%>";
    	document.getElementsByName("work_place")[0].value = "<%=user_info[5]%>";
    	$("#now_img").append("<span style='margin-right:50px;float:right;text-align:center'><p>현재사진</p><img src='user_img/<%=user_info[6]%>' style='width:200px;'><span>");
    	document.getElementById("now_img_name").value = "<%=user_info[6]%>";
    	document.getElementById("comment").value = "<%=user_info[7]%>";
    	<%
    	for(String info : user_info)
    	{
    		%>$("#modify").append("<input type='hidden' name ='before_info' value='<%=info%>'>");<%	
    	}
    	%>
    });
    
    function check(type){
		if(type=="pw")
		{
	    	var pw1 = document.getElementById("password1");
			var pw2 = document.getElementById("password2");
			
			if(pw1.value == pw2.value){
				alert("비밀번호가 일치합니다.");
			}
			else{
				pw1.value="";
				pw2.value="";
				alert("비밀번호가 일치하지 않습니다.");
			}
		}
	}
   	var id_state=false,pw_state=false;
   	function pw_check(){
 		var password = document.getElementsByName("password")[0].value;
 		if(password.length < 5 || password.length > 15)
   		{
   			alert("비밀번호는 5 ~ 15 자리입니다");
   			return;
 		}
 		for(var i = 0 ; i < password.length ; i++){
 			if( (password[i] < 'A' || password[i] > 'Z') && (password[i] < 'a' || password[i] > 'z') && (password[i] < '0' || password[i] > '9') )
 			{	
 				alert("비밀번호는 알파벳과 숫자만 가능합니다.");
 				return;
 			}
 		}
 		pw_state=tre=true;
   	}
   	function SB(){
   		if(document.getElementById("comment").value.length > 100){
   			alert("100자까지 입력 가능합니다.");
   			return;
   		}
		if(document.getElementsByName("gender")[0].checked)
		{
			document.getElementsByName("user_gender")[0].value = "m";
		}
		else
		{
			document.getElementsByName("user_gender")[0].value = "w";
		}
		document.getElementById("email").value = document.getElementById("Email").value + "@" + document.getElementById("Addr").value;
		document.getElementById("default_img").value = document.getElementById("img_state").checked;
		document.getElementById("modify").submit();
   		document.getElementById("img").submit();
   	}
   	function direct_input()
   	{
   		document.getElementById("email_address").style.display="inline";
   	}

 </script>
<title>CUVIC</title>
</head>

<body>
	<div class="wrapper">
		<div id=user_info align="right">
			<a href="main.jsp"><img src="img/logo.png" width="300px;" style="display: block; margin: auto; padding-bottom: 20px;"></a>
		</div>
						<div style="position: relative; z-index: 2">
				<div class='zeta-menu-bar'>
					<ul class="zeta-menu">
						<li><a href="main.jsp">공지사항</a></li>
						<li><a href="introduce.jsp">동아리 소개</a>
							<ul>
								<li><a href="introduce.jsp">동아리 소개</a></li>
								<li><a href="controller.jsp?&action=load_active_record">주요활동ㆍ실적</a></li>
								<li><a href="controller.jsp?action=load_info&group=1">동아리 회원</a>
									<ul>
										<li><a href="controller.jsp?action=load_info&group=1">1~5기</a></li>
										<li><a href="controller.jsp?action=load_info&group=2">6~10기</a></li>
										<li><a href="controller.jsp?action=load_info&group=3">11~15기</a></li>
										<li><a href="controller.jsp?action=load_info&group=4">16~20기</a></li>
										<li><a href="controller.jsp?action=load_info&group=5">21기~</a></li>
									</ul></li>
							</ul></li>
						<li><a href="controller.jsp?&action=load_picture_board">사진첩</a></li>
						<li><a href="controller.jsp?&action=load_board&type=free">게시판</a>
							<ul>
								<li><a href="controller.jsp?&action=load_board&type=free">자유게시판</a></li>
								<li><a href="controller.jsp?&action=load_board&type=graduate">졸업생게시판</a></li>
								<li><a href="controller.jsp?&action=load_board&type=qa">Q&A</a></li>
								<li><a href="controller.jsp?&action=load_board&type=uggestions">건의사항</a></li>
							</ul></li>
						<li><a href="controller.jsp?&action=load_board&type=seminar&year=2019_1학년">세미나</a>
							<ul>
								<li><a href="controller.jsp?&action=load_board&type=seminar&year=2019_1학년">2019년</a>
								<ul>
									<li><a href="controller.jsp?&action=load_board&type=seminar&year=2019_1학년">1학년</a></li>
									<li><a href="controller.jsp?&action=load_board&type=seminar&year=2019_2학년">2학년</a></li>
								</ul></li>
							</ul></li>
						<li><a href="controller.jsp?&action=load_board&type=job">자료실</a>
							<ul>
								<li><a href="controller.jsp?&action=load_board&type=job">취업자료</a></li>
								<li><a href="controller.jsp?&action=load_board&type=exam">시험자료</a></li>
								<li><a href="controller.jsp?&action=load_board&type=assignment">과제공유</a></li>
								<li><a href="controller.jsp?&action=load_board&type=etc">기타</a></li>
							</ul></li>
					</ul>
				</div>
			</div>
			<div id="contents" style="height: 880px;">
				<form method="post" action="controller.jsp" id="modify"  target="if" >
					<input type="hidden" name="action" value="info_update">
					<input type="hidden" name="nick_name" id="nick_name" value="">
					<span>
						<span>비밀번호 : </span><input type="password" name="password" id="password1" placeholder="비밀번호" onchange="pw_check()">
						<span>비밀번호 확인 : </span><input type="password" placeholder="비밀번호 확인" id="password2" onchange="check('pw')"></span>
						<p>5~15자, 알파벳, 숫자 가능</p>
					</span>
					<p>이름</p>
					<input type="text" name="name" id="name" placeholder="이름"><br><br>
					<lable id="_gender" style="margin-left:30px;">남자</lable><input type="radio" name="gender" value="m" checked="checked">
					<lable style="margin-left:30px;">여자</lable><input type="radio" name="gender" value="w">
					<p>핸드폰 번호</p>
					<input id="phone" type="text"name="phone_num" placeholder="핸드폰 번호">
					<p>이메일</p>
					<input type="text" id="Email" placeholder="이메일">@
					<select id="Addr">
						<option value="hanmail.net">hanmail.net</option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option onclick="direct_input()">직접 입력</option>
					</select>
					<input type="hidden" id="email" name="email" value="">
					<input id="email_address" type="text" style="display:none">				
					<p>생년월일</p>
					<input type="text" id="birthday" name="birth">
					<p>근무지</p>
					<input type="text" name="work_place" placeholder="근무지"><br><br>
					<textarea cols="60" rows="5" name="comment" id="comment" style="resize:none;"></textarea>
					<hr style="border:1px solid black;"><br>
				</form>
							<div id="now_img" style="float:right;">
			</div>
			<form action="fileupload.jsp" method="post" enctype="Multipart/form-data" id="img">
				<input type="hidden" name="user_id" value="<%=(String)session.getAttribute("id")%>">
				<input type="hidden" name="user_gender" value="">
				<input type="hidden" name="now_img_name" id="now_img_name" value="">
				<input type="hidden" name="default_img" id="default_img" value="">
				<p>프로필 사진</p>
				<label>기본이미지로 변경</label><input type="checkbox" id="img_state">
				<input type="file" name="fileName1"  accept="image/*">
			</form>
					<input type="button" style="float: left; width:45%; margin-top:5px;" onclick="SB()" value="수정">
					<input type="button" onclick="location.href='main.jsp'" value="취소">
		</div>
	  		<iframe name="if" id="if" style="width: 0px;height: 0px;border: 0px;"></iframe>
	  		<div id="login_after" style="padding: 5px;">
				<form method="post" action="controller.jsp">
					<h1 style="display:inline-block; margin-top:30%;"><%=session.getAttribute("nick_name") %></h1>
					<input type="hidden" name="action" value="logout">
					<input type="submit" style="margin-left:10px; width:90px; height:69px;" value="Logout">
				</form>
	  		</div>
	  		<div id="birth">
	  			<p>이달의 생일</p>
	  		</div>
	  	    <div id="new_post" style="height:400px;">
	  			<p>최신글</p>
	  		</div>
	<div id="footer">
		<h1>뭐넣지</h1>
	</div>
	</div>
</body>
</html>



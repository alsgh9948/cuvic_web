<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat,java.io.*, java.util.*, java.io.*"%>

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

<link rel="stylesheet" type="text/css" href="css/main.css?version=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script type="text/javascript" src="dist/js/HuskyEZCreator.js" charset="utf-8"></script>

<style>
.mySlides {
	display: nonez
}

.w3-left, .w3-right, .w3-badge {
	cursor: pointer
}

.w3-badge {
	height: 13px;
	width: 13px;
	padding: 0
}
  #contents1{
  	margin:10px auto;
  	width: 70%;
  	border: solid 2px #e5e5e5;
  	min-height: 880px;
  	padding:5px 5px 5px 5px;
  	float:right;
  	}
  #contents1 img
  	{
  	width:100%;
  	}
</style>
	<%
String nick_name = (String)session.getAttribute("nick_name");
%>

<script>
	$(function() {
		$("input:text").keydown(function(evt) {
			if (evt.keyCode == 13) return false; 
			});
		 $("#title").on("change paste keyup", function() {
		    	if(document.getElementById("title").value.length > 100)
		    	{
		    		alert("제목은 100자까지 입력 가능합니다.");
		    		document.getElementById("title").value = document.getElementById("title").value.substring(0,100);
		    	}
		    });
		$(document).ready(function() {
			var nick_name = "<%= (String)session.getAttribute("nick_name") %>"
			if(nick_name != "null")
			{
	            document.getElementById("login_before").style.display="none";
	            document.getElementById("login_before").style.visibility="hidden";
	
	            document.getElementById("login_after").style.display="inline-block";
	            document.getElementById("login_after").style.visibility="visible";
	            
	            document.getElementById("user_info").style.display="inline-block";
	            document.getElementById("user_info").style.visibility="visible";
			}
		});
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
      $('.slider').bxSlider();
    });
    
    function upload()
	{
		document.getElementById("user_id").value = nick_name;
		document.getElementById("img").submit;
	}
</script>
<title>CUVIC</title>
</head>

<body onbeforeunload ="remove_dir()" onload="folder_check()">
	<iframe name="if" id="if" style="width: 0px;height: 0px;border: 0px;"></iframe>
	<form method="post" action="controller.jsp" target="if" id="remove_form">
		<input type="hidden" name="action" value="remove_folder"> 
		<input type="hidden" name="board_type" value="picture">
		<input type="hidden" name ="type" value="">
	</form>
	<div class="wrapper">
		<div align="right">
			<table id="user_info" style="visibility:hidden; display:none;">
				<tr>
					<td style="padding-right: 20px;"><p><%=nick_name %></p></td>
					<td><button onclick="location.href='controller.jsp?action=logout'">로그아웃</button></td>
				</tr>
			</table>
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
			<div id="contents1">
			<form action="controller.jsp" method="post" id="sb">
				<input type="hidden" name="action" id="action" value="picture_upload">
				<input type="hidden" name="target" id="target" value="">
				<textarea name="title" id="title" rows="1" cols="80" style="width:683px; resize:none;" placeholder="제목"> </textarea>
				<textarea name="contents" id="contents" rows="10" cols="80" style="both:clear; width:681px; height:412px; display:none;"> </textarea>
				<input type="button" style="float:right; margin:5px 3px 0 0;" id="btn" value="업로드" onclick="submitContents()">
			</form>
	  		</div>
			<div id="login_before" style="padding: 5px;">
				<h1>Login</h1>
				<form method="post" action="controller.jsp">
					<input type="hidden" name="action" value="login">
					<div style="float: left;">
						<input type="text" name="id" placeholder="아이디" style="margin-bottom: 17px;" size="15"><br>
						<input type="password" name="password" placeholder="비밀번호" size="15">
					</div>
					<button name="login" style="float: right; width:100px; height:69px;">Login</button>
					<input type="button" style="float: left; width:45%; margin-top:5px;" onclick="location.href='sign_up.jsp'" value="회원가입">
					<button style="width:45%; float:right; margin-top:5px;" onclick="window.open('main.jsp','아이디/비번찾기','width=430,height=500,location=no,status=no,scrollbars=yes');">회원정보 찾기</button>
				</form>
	  		</div>
	  		<div id="login_after" style="padding: 5px; visibility:hidden; display:none;">
				<form method="post" action="controller.jsp">
					<h1 style="display:inline-block; margin-top:30%;"><%=session.getAttribute("nick_name") %></h1>
					<input type="hidden" name="action" value="logout">
					<br>
					<input type="submit" value="로그아웃">
					<input type="button" value="정보수정" onclick="location.href='controller.jsp?action=info_modify'">
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
	<script type="text/javascript">
	
var oEditors = [];

// 추가 글꼴 목록
//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "contents",
	sSkinURI: "dist/SmartEditor2Skin.html",	
	htParams : {
		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
		fOnBeforeUnload : function(){
			//alert("완료!");
		}
	}, //boolean
	fOnAppLoad : function(){
		//예제 코드
		//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	},
	fCreator: "createSEditor2"
});

function pasteHTML() {
	var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
	oEditors.getById["contents"].exec("PASTE_HTML", [sHTML]);
}

function showHTML() {
	var sHTML = oEditors.getById["contents"].getIR();
	alert(sHTML);
}
var flag = false;
function folder_check()
{
	<%
	 String cnt = request.getParameter("cnt");
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
	%>
	if("<%=nick_name%>" == "null")
	{
    alert("로그인후에 이용해주세요");
    location.href="main.jsp";
	}
	var title = document.getElementById("title").value;
	var contents = document.getElementById("contents").value;
	if(title != " " || contents != " ")
	{
		if("<%=cnt%>" != "null")
		{
			alert("정상적인 접근이 아닙니다.");
			history.go(-1);
		}
		else
		{
			alert("뒤로가기로 넘어와서 새로고침 해야함");
			flag = true;
			location.reload();
		}
	}
	document.getElementById("title").value = "";
	contents = document.getElementById("contents").value="";
	<%
	if(cnt == null)
	{
		Calendar calendar = Calendar.getInstance();
	    java.util.Date date = calendar.getTime();
	    String today = (new SimpleDateFormat("yyyy년_MM월_dd일_HH시_mm분_ss초").format(date));
	    File folder = new File("C:/Users/seo/Desktop/cuvic_web/cuvic_web_site/WebContent/picture_board/"+(String)session.getAttribute("nick_name")+"_"+today);
		session.setAttribute("folder_name", today);
		session.setAttribute("board_type", "upload");
	    folder.mkdirs();
	}
	else
	{
		ArrayList<String[]> detail = db.load_picture(cnt);
		%>
	    document.getElementById("btn").value = "수정";
	    document.getElementById("target").value = "<%=cnt%>";
	    document.getElementById("action").value = "picture_modify";
	    document.getElementById("title").value = '<%=detail.get(0)[3]%>';
		document.getElementById("contents").value = '<%=detail.get(0)[4].replaceAll("(\r\n|\r|\n|\n\r)", "")%>';
		<%
	}
    %>
}
function remove_dir(){
	if(flag == false && "<%=cnt%>" == "null")
	{	
		document.getElementById("remove_form").submit();
	}
}
function submitContents(elClickedObj) {
	oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	var title = document.getElementById("title").value;
	var contents = document.getElementById("contents").value;
	if(title=="")
	{
		alert("제목을 입력하세요");
		location.href = "#title";
		return;
	}
	if(contents == ""  || contents == null || contents == '&nbsp;' || contents == '<p>&nbsp;</p>' || contents == " ")
	{
		alert("내용을 입력하세요");
		oEditors.getById["contents"].exec("FOCUS"); //포커싱
		return;
	}
	flag = true;
	document.getElementById("sb").submit();

	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("ir1").value를 이용해서 처리하면 됩니다.
	
	try {
		elClickedObj.form.submit();
	} catch(e) {}
}

function setDefaultFont() {
	var sDefaultFont = '궁서';
	var nFontSize = 24;
	oEditors.getById["contents"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>
</body>
</html>



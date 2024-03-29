package cuvic_web_site;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.io.File;

import cuvic_web_site.data_get_set;

public class db_control {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Statement st = null;
	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://database-1.cojltuuvj7qw.ap-northeast-2.rds.amazonaws.com:3306/cuvic?useUnicode=true&characterEncoding=UTF-8&openssl=true";
	String sql;
//	
	// 데이터베이스 연결
	void connect() {
		try {
			Class.forName("com.mysql.jdbc.Driver");

			conn = DriverManager.getConnection(jdbc_url, "admin", "tkakrnl1");
			st = conn.createStatement();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 데이터베이스 해제
	void disconnect() {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (st != null) {
			try {
				st.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public ArrayList<ArrayList<String[]>> load_main_page_post()
	{
		ArrayList<ArrayList<String[]>> post_list = new ArrayList<ArrayList<String[]>>();
		String table_list[] = {"notice_board","free_board","picture_board","etc_board"};
		connect();
		try {
			for(String table_name : table_list)
			{
				sql = "select * from "+table_name+" limit 8";
				rs = st.executeQuery(sql);
				ArrayList<String[]> list = new ArrayList<String[]>();
				while(rs.next()) {
					String[] term_list = new String[9];
					term_list[0] = rs.getString("cnt");
					term_list[1] = rs.getString("date");
					term_list[2] = rs.getString("writer_name");
					term_list[3] = rs.getString("title");
					term_list[4] = rs.getString("contents");
					term_list[5] = rs.getString("folder_name");
					File folder=null;
					if(table_name.equals("picture_board"))
					{
						folder = new File("C:/Users/seo/Desktop/cuvic_web/cuvic_web_site/WebContent/picture_board/"+term_list[5]);
						File[] file_list = folder.listFiles();
					    if(file_list.length == 0)
					    	term_list[6] = "-";
					    else term_list[6] = term_list[5]+"/"+file_list[0].getName();
					}
					else
						term_list[6] = "-";
			        term_list[7] = rs.getString("views");
			        list.add(term_list);
				}
				post_list.add(list);
				rs.close();
			}
			return post_list;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return null;
	}
	public ArrayList<String[]> lately_post()
	{
		ArrayList<String[]> post_list = new ArrayList<String[]>();
		connect();
		try {
			sql = "select *  from post_list order by date desc limit 8";
			rs = st.executeQuery(sql);
			while(rs.next()) {
				String[] term_list = new String[5];
				term_list[0] = rs.getString("cnt");
				term_list[1] = rs.getString("board_name");
				term_list[2] = rs.getString("title");
				term_list[3] = rs.getString("writer_name");
				term_list[4] = rs.getString("date");
				post_list.add(term_list);
			}
			rs.close();
			return post_list;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return null;
	}
	// 회원가입 처리 함수
	public boolean sign_up(data_get_set value) {
		connect();
		// 회원정보를 입력하는 쿼리문
		String img_path = value.getImg_path();
		if (value.getImg_path().equals("")) {
			if (value.getGender().equals("m"))
				img_path = "man.png";
			else
				img_path = "woman.png";
		}
		StringBuilder sb = new StringBuilder();
		String sql = sb.append("insert into user_list values('")
				.append(value.getId() + "','")
				.append(value.getPassword() + "','")
				.append(value.getName() + "','")
				.append(value.getGender() + "','")
				.append(value.getPhone_num() + "','")
				.append(value.getEmail() + "','")
				.append(value.getBirth() + "','")
				.append(value.getClub_num() + "','")
				.append(value.getNick_name() + "','")
				.append(value.getWork_place() + "','")
				.append(img_path + "','")
				.append(value.getComment() + "');").toString();
		try {
			st.executeUpdate(sql);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return true;
	}

	public String login(String id, String password) {
		connect();
		String nick_name = null;
		try {
			// 등록된 아이딘지 검사
			sql = "select password, nickname from user_list where id='" + id + "'";
			rs = st.executeQuery(sql);
			if (rs.next()) {
				if (rs.getString("password").equals(password)) {
					nick_name = rs.getString("nickname"); // 등록된 회원일 경우 null값을 리턴한다
				}
				else {
					return null;
				}
			} else {
				return null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
			return nick_name;
		}
	}
	public boolean IdCheck(String id) {
		//입력한 아이디가 이미 user 테이블에 있는지 검사
		sql = "select count(id) from user_list where id='"+id+"'";
		connect();
		try {
			rs = st.executeQuery(sql);
			rs.next();
			//아이디가 중복된다면 false 반환 아니면 true 반환
			if(rs.getInt("count(id)") == 1) {   
				rs.close();
				return false;
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return true;
	}
	public ArrayList<String[]> load_info(String group)
	{
		// 입력한 아이디가 이미 user 테이블에 있는지 검사
		int num = Integer.parseInt(group);
		sql = "select * from user_list where club_num between "+ (5*num-4) +" and "+ num*5 +" order by club_num, name";
		ArrayList<String[]> user_list = new ArrayList<String[]>();
		connect();
		try {
			rs = st.executeQuery(sql);
			while(rs.next()) {
				String[] term_list = new String[7];
				term_list[0] = rs.getString("img_name");
				term_list[1] = rs.getString("name");
				term_list[2] = rs.getString("club_num");
				term_list[3] = rs.getString("email");
				term_list[4] = rs.getString("work_place");
				term_list[5] = rs.getString("comment");
				user_list.add(term_list);
			}
			rs.close();
			return user_list;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return null;
	}
	public String[] load_myinfo(String id)
	{
		sql = "select * from user_list where id='"+id+"'";
		String[] user_info = new String[9];
		connect();
		try {
			rs = st.executeQuery(sql);
			while(rs.next()) {
				user_info[0] = rs.getString("name");
				user_info[1] = rs.getString("gender");
				user_info[2] = rs.getString("phone_num");
				user_info[3] = rs.getString("email");
				user_info[4] = rs.getString("birth");
				user_info[5] = rs.getString("work_place");
				user_info[6] = rs.getString("img_name");
				user_info[7] = rs.getString("comment");
				user_info[8] = rs.getString("password");
			}
			rs.close();
			return user_info;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return null;
	}
	public void info_update(data_get_set value, String[] before, String id) {
		connect();
		sql = "update user_list set";
		if(!value.getName().equals(before[0]))
			sql+=" name="+value.getName();
		if(!value.getGender().equals(before[1]))
			sql+=" gender="+value.getGender();
		if(!value.getPhone_num().equals(before[2]))
			sql+=" phone_num="+value.getPhone_num();
		if(!value.getEmail().equals(before[3]))
			sql+=" email="+value.getEmail();
		if(!value.getBirth().equals(before[4]))
			sql+=" birth="+value.getBirth();
		if(!value.getWork_place().equals(before[5]))
			sql+=" work_place="+value.getWork_place();
		if(!value.getComment().equals(before[7]))
			sql+=" comment="+value.getComment();
		if(value.getPassword() != null && !value.getPassword().equals(before[8]))
			sql+=" password="+value.getPassword();
		sql +=" id='"+id+"' where id='"+id+"'";
		try {
			st.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
	}
	public ArrayList<String[]> load_active_record()
	{
		// 입력한 아이디가 이미 user 테이블에 있는지 검사
		sql = "select * from active_record_list order by date";
		ArrayList<String[]> active_record_list = new ArrayList<String[]>();
		connect();
		try {
			rs = st.executeQuery(sql);
			while(rs.next()) {
				String[] term_list = new String[4];
				term_list[0] = rs.getString("title");
				term_list[1] = rs.getString("date");
				term_list[2] = rs.getString("member");
				term_list[3] = rs.getString("detail");
				active_record_list.add(term_list);
			}
			rs.close();
			return active_record_list;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return null;
	}
	public void insert_active_record(data_get_set value) {
		connect();
		StringBuilder sb = new StringBuilder();
		sql = sb.append("insert into active_record_list values('").
				append(value.getTitle() + "','")
				.append(value.getDate() + "','")
				.append(value.getMember() + "','")
				.append(value.getDetail() + "');")
				.toString();
		try {
			st.executeUpdate(sql);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
	}
	public void delete_active_record(String title) {
		connect();
		title = title.substring(0,title.length()-1);
		try {
			sql = "delete from active_record_list where title in ("+title+")";
			st.executeUpdate(sql);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
	}
	public void insert_picture(data_get_set value, String nick_name, String folder_name) {
		connect();
		StringBuilder sb = new StringBuilder();
		sql = sb.append("insert into picture_board(writer_name,title,contents,folder_name) values('").
				append(nick_name + "','")
				.append(value.getTitle() + "','")
				.append(value.getContents() + "','")
				.append(nick_name+"_"+folder_name+ "');")
				.toString();
		try {
			st.executeUpdate(sql);
			sql = "select * from picture_board order by date desc limit 1";
			rs = st.executeQuery(sql);
			String[] arr = new String[5];
			while(rs.next()) {
				arr[0] = rs.getString("cnt");
				arr[1] = "picture_board";
				arr[2] = rs.getString("title");
				arr[3] = rs.getString("writer_name");
				arr[4] = rs.getString("date");
			}
			rs.close();
			sb = new StringBuilder();
			sql = sb.append("insert into post_list values('").
					append(arr[0] + "','")
					.append(arr[1] + "','")
					.append(arr[2] + "','")
					.append(arr[3] + "','")	
					.append(arr[4]+ "');")
					.toString();
			st.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
	}
	public void modify_picture(data_get_set value, String cnt) {
		connect();
		StringBuilder sb = new StringBuilder();
		sql = sb.append("update picture_board set ")
				.append("title='" + value.getTitle() + "', ")
				.append("contents='" + value.getContents() + "' ")
				.append("where cnt="+cnt+";")
				.toString();
		try {
			st.executeUpdate(sql);
			st.executeUpdate("update post_list set title='"+value.getTitle()+"' where board_name='picture_board' and cnt="+cnt);
			rs = st.executeQuery("select folder_name from picture_board where cnt="+cnt);
			rs.next();
			String path = rs.getString("folder_name");
			File folder = new File("C:/Users/seo/Desktop/cuvic_web/cuvic_web_site/WebContent/picture_board/"+path);
			File[] file_list = folder.listFiles();
			if(file_list.length != 0)
	        {
				Map<String, Boolean> file_name = new HashMap<String, Boolean>();
				
				String[] contents_token = value.getContents().split("\"");
		        for(String token : contents_token)
		        {
		        	if(token.contains(path))
		        	{
		        		String[] name= token.split("/");
		        		file_name.put(name[name.length-1],true);		        	}
		        }
		        for(int i = 0 ; i < file_list.length ; i++)
		        {
		        	if(!file_name.containsKey(file_list[i].getName()))
		        	{
		        		file_list[i].delete();
		        	}
		        }
		        
	        }
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
	}
	public void delete_picture(data_get_set value, String cnt) {
		connect();
		try {
			st.executeUpdate("delete from picture_board where cnt="+cnt);
			st.executeUpdate("delete from post_list where board_name='picture_board' and cnt="+cnt);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
	}
	public ArrayList<String[]> load_picture(String target)
	{
		
		ArrayList<String[]> picture_list = new ArrayList<String[]>();
		connect();
		try {
			// 입력한 아이디가 이미 user 테이블에 있는지 검사
			if(target.equals("*"))
				sql = "select * from picture_board order by date desc";
			else
			{
				sql = "select * from picture_board where cnt="+target;
				st.executeUpdate("update picture_board set views=views+1 where cnt="+target);
			}
			rs = st.executeQuery(sql);
			while(rs.next()) {
				String[] term_list = new String[8];
				term_list[0] = rs.getString("cnt");
				term_list[1] = rs.getString("date");
				term_list[2] = rs.getString("writer_name");
				term_list[3] = rs.getString("title");
				term_list[4] = rs.getString("contents");
				term_list[5] = rs.getString("folder_name");
				File folder = new File("C:/Users/seo/Desktop/cuvic_web/cuvic_web_site/WebContent/picture_board/"+term_list[5]);
		        File[] file_list = folder.listFiles();
		        if(file_list.length == 0)
		        	term_list[6] = "-";
		        else term_list[6] = term_list[5]+"/"+file_list[0].getName();
		        term_list[7] = rs.getString("views");
				picture_list.add(term_list);
			}
			rs.close();
			return picture_list;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return null;
	}
	public void insert_post(String[] contents_list, String nick_name, String folder_name, String type, String year) {
		connect();
		StringBuilder sb = new StringBuilder();
		if(type.equals("seminar"))
			sql = sb.append("insert into "+type+"_board(writer_name,title,contents,folder_name,year) values('").
			append(nick_name + "','")
			.append(contents_list[0] + "','")
			.append(contents_list[1] + "','")
			.append(nick_name+"_"+folder_name+ "','")
			.append(year + "');")
			.toString();
		else
			sql = sb.append("insert into "+type+"_board(writer_name,title,contents,folder_name) values('").
				append(nick_name + "','")
				.append(contents_list[0] + "','")
				.append(contents_list[1] + "','")
				.append(nick_name+"_"+folder_name+ "');")
				.toString();
		try {
			st.executeUpdate(sql);
			sql = "select * from "+type+"_board order by date desc limit 1";
			rs = st.executeQuery(sql);
			String[] arr = new String[5];
			while(rs.next()) {
				arr[0] = rs.getString("cnt");
				arr[1] = type+"_board";
				arr[2] = rs.getString("title");
				arr[3] = rs.getString("writer_name");
				arr[4] = rs.getString("date");
			}
			rs.close();
			sb = new StringBuilder();
			sql = sb.append("insert into post_list values('").
					append(arr[0] + "','")
					.append(arr[1] + "','")
					.append(arr[2] + "','")
					.append(arr[3] + "','")	
					.append(arr[4]+ "');")
					.toString();
			st.executeUpdate(sql);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
	}
	public ArrayList<String[]> load_post(String target, String type, String year)
	{
		
		ArrayList<String[]> post_list = new ArrayList<String[]>();
		connect();
		try {
			// 입력한 아이디가 이미 user 테이블에 있는지 검사
			if(target.equals("*"))
			{
				if(!year.equals("-"))
					sql = "select * from "+type+"_board where year='"+year+"' order by cnt desc";
				else
					sql = "select * from "+type+"_board order by cnt desc";
			}
			else
			{
				sql = "select * from "+type+"_board where cnt="+target;
				st.executeUpdate("update "+type+"_board set views=views+1 where cnt="+target);
			}
			rs = st.executeQuery(sql);
			while(rs.next()) {
				String[] term_list = new String[9];
				term_list[0] = rs.getString("cnt");
				term_list[1] = rs.getString("date");
				term_list[2] = rs.getString("writer_name");
				term_list[3] = rs.getString("title");
				term_list[4] = rs.getString("contents");
				term_list[5] = rs.getString("folder_name");
				File folder = new File("C:/Users/seo/Desktop/cuvic_web/cuvic_web_site/WebContent/post_board/"+type+"/"+term_list[5]);
		        File[] file_list = folder.listFiles();
		       if(file_list.length == 0)
		        	term_list[6] = "-";
		        else term_list[6] = term_list[5]+"/"+file_list[0].getName();
		        term_list[7] = rs.getString("views");
		        post_list.add(term_list);
			}
			rs.close();
			return post_list;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return null;
	}
	public void modify_post(String[] contents_list, String cnt, String type) {
		connect();
		StringBuilder sb = new StringBuilder();
		sql = sb.append("update "+type+"_board set ")
				.append("title='" + contents_list[0] + "', ")
				.append("contents='" + contents_list[1] + "' ")
				.append("where cnt="+cnt+";")
				.toString();
		try {
			st.executeUpdate(sql);
			st.executeUpdate("update post_list set title='"+contents_list[0]+"' where board_name='"+type+"_board' and cnt="+cnt);
			rs = st.executeQuery("select folder_name from "+type+"_board where cnt="+cnt);
			rs.next();
			String path = rs.getString("folder_name");
			File folder = new File("C:/Users/seo/Desktop/cuvic_web/cuvic_web_site/WebContent/post_board/"+type+"/"+path+"/img");
			File[] file_list = folder.listFiles();
			if(folder.exists() && file_list.length != 0)
	        {
				Map<String, Boolean> file_name = new HashMap<String, Boolean>();
				
				String[] contents_token = contents_list[1].split("\"");
		        for(String token : contents_token)
		        {
		        	if(token.contains(path))
		        	{
		        		String[] name= token.split("/");
		        		file_name.put(name[name.length-1],true);		        	}
		        }
		        for(int i = 0 ; i < file_list.length ; i++)
		        {
		        	if(!file_name.containsKey(file_list[i].getName()))
		        	{
		        		file_list[i].delete();
		        	}
		        }
		        
	        }
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
	}
	public void delete_post(data_get_set value, String cnt, String type) {
		connect();
		try {
			st.executeUpdate("delete from "+type+"_board where cnt="+cnt);
			st.executeUpdate("delete from post_list where board_name='"+type+"_board' and cnt="+cnt);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
	}
}
package cuvic_web_site;

import java.sql.*;
import java.util.ArrayList;
import cuvic_web_site.data_get_set;

public class db_control {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Statement st = null;
	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://database-1.cojltuuvj7qw.ap-northeast-2.rds.amazonaws.com:3307/cuvic?useUnicode=true&characterEncoding=UTF-8";
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

	// 회원가입 처리 함수
	public boolean sign_up(data_get_set value) {
		connect();
		// 회원정보를 입력하는 쿼리문
		String img_path = value.getImg_path();
		if (value.getImg_path().equals("")) {
			if (value.getGender().equals("m"))
				img_path = "m";
			else
				img_path = "w";
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
				.append(value.getOpen_state() + "','")
				.append(value.getGender() + "','")
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

	public String[] login(String id, String password) {
		connect();
		String[] nick_name = new String[2];
		try {
			// 등록된 아이딘지 검사
			sql = "select password, nickname from user_list where id='" + id + "'";
			rs = st.executeQuery(sql);
			if (rs.next()) {
				if (rs.getString("password").equals(password)) {
					nick_name[0] = rs.getString("nickname"); // 등록된 회원일 경우 null값을 리턴한다
				}
				else {
					nick_name[1] = "비밀번호를 확인하세요";
				}
			} else {
				nick_name[1] = "아이디를 확인하세요";
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
	public ArrayList<String[]> load_info()
	{
		// 입력한 아이디가 이미 user 테이블에 있는지 검사
		sql = "select * from user_list order by club_num, name";
		ArrayList<String[]> user_list = new ArrayList<String[]>();
		connect();
		try {
			rs = st.executeQuery(sql);
			while(rs.next()) {
				String[] term_list = new String[7];
				term_list[0] = rs.getString("club_num");
				term_list[1] = rs.getString("name");
				term_list[2] = rs.getString("email");
				term_list[3] = rs.getString("work_place");
				term_list[4] = rs.getString("comment");
				term_list[5] = rs.getString("img_name");
				term_list[6] = rs.getString("open_state");
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
	public ArrayList<String[]> load_list()
	{
		// 입력한 아이디가 이미 user 테이블에 있는지 검사
		sql = "select * from user_list order by club_num, name";
		ArrayList<String[]> user_list = new ArrayList<String[]>();
		connect();
		try {
			rs = st.executeQuery(sql);
			while(rs.next()) {
				String[] term_list = new String[7];
				term_list[0] = rs.getString("club_num");
				term_list[1] = rs.getString("name");
				term_list[2] = rs.getString("email");
				term_list[3] = rs.getString("work_place");
				term_list[4] = rs.getString("comment");
				term_list[5] = rs.getString("img_name");
				term_list[6] = rs.getString("open_state");
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
}
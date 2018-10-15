<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@ page import = "java.sql.*" %>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	boolean isLogin=false;
	
	String request_id=request.getParameter("id");
	String request_pw=request.getParameter("pw");
	
	if(request_id!=null && request_pw!=null)
	{
		try{
			String url = "jdbc:mysql://localhost:3306/eventDB?characterEncoding=UTF-8&serverTimezone=UTC";
			String db_id="root";
			String db_pass="1234";
			
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, db_id,db_pass);
			
			String sql="select * from memberInfo";
			pstmt=conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				String user_id = rs.getString("id");
				String user_pw = rs.getString("pw");
				String user_name = rs.getString("name");

				if(user_id.contains(request_id) && user_pw.contains(request_pw))
				{
					session.setAttribute("s_Name", user_name);
					session.setAttribute("s_ID", user_pw);
					
					response.sendRedirect("index.jsp");//로그인성공		
					isLogin=true;					
				} 
			}
		}catch(Exception e){
			System.out.println("select 실패");
		}finally{
			if(pstmt!=null)
				try{pstmt.close(); } catch(SQLException sqle){}
			if(conn!=null)
				try{pstmt.close(); } catch(SQLException sqle){}
		
		}
	}

	if(isLogin==false)
	{%>
		<script>
			alert("로그인 실패");
			history.go(-1);//이전페이지로
		</script>
	<%}

%>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@ page import = "java.sql.*" %>
<html>
<head>
  <title>미림의 얼굴</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="HTML5 website template">
  <meta name="keywords" content="global, template, html, sass, jquery">
  <meta name="author" content="Bucky Maler">
  <link rel="stylesheet" href="assets/css/main.css">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <style>

  body{
    background-color: #fd999a;
    color:#3e4149;
  }
  .super h1{
    text-align: center;
    font-size: 5em;
  }
  .about--options a {
    border-color: #f15c5c;
  }

  .w3-third p{
    color:white;
  }
  .myCoupon{
  	 text-align: center;
  }
  .myCoupon h1{
  	padding-top:200px;
    font-size: 5em;
  }
  </style>
</head>
<body>

<div class="device-notification">
  <a class="device-notification--logo" href="#0">
            <img src="assets/img/daisy.png"  width="45px" height="45px">
    <p>미림의 얼굴</p>
  </a>
  <p class="device-notification--message">미림의 얼굴입니다.</p>
</div>

<div class="perspective effect-rotate-left">
  <div class="container"><div class="outer-nav--return"></div>
    <div id="viewport" class="l-viewport">
      <div class="l-wrapper">
        <header class="header">
          <a class="header--logo" href="#0">
            <img src="assets/img/daisy.png" width="45px" height="45px">
            <p>미림의 얼굴</p>
            <div style="position:absolute; right:10%;">
            	<%
					String checkName=null;
					String checkId=null;
					int checkHeart=0;
					
					checkName=(String)session.getAttribute("s_Name");
					checkId=(String)session.getAttribute("s_ID");
					
					
					if(checkId==null || checkId.equals(""))//이름없거나null이면
					{
						
						%>
						<button onclick="document.getElementById('id01').style.display='block'" class="w3-button w3-pale-red">Login</button>
						<button onclick="document.getElementById('id02').style.display='block'" class="w3-button w3-pale-red">Sign up</button>
					
					<%}
					else
					{
						Connection conn=null;
						PreparedStatement pstmt=null;
						ResultSet rs=null;
						
						
						try{
							String url = "jdbc:mysql://localhost:3306/eventDB?characterEncoding=UTF-8&serverTimezone=UTC";
							String db_id="root";
							String db_pass="1234";
							
							Class.forName("com.mysql.jdbc.Driver");
							conn=DriverManager.getConnection(url, db_id,db_pass);
							
							String sql="select * from memberInfo where name=?";
							pstmt=conn.prepareStatement(sql);
							pstmt.setString(1,checkName);
							rs = pstmt.executeQuery();
							
							while(rs.next()){
								String user_id = rs.getString("id");
								String user_pw = rs.getString("pw");
								String user_name = rs.getString("name");
								int user_heart=rs.getInt("heart");
								
								checkHeart=user_heart;
							}
						}catch(Exception e){
							System.out.println("select 실패");
						}finally{
							if(pstmt!=null)
								try{pstmt.close(); } catch(SQLException sqle){}
							if(conn!=null)
								try{pstmt.close(); } catch(SQLException sqle){}
						
						} 
						
						
						%>
						
						<div style="text-align:right;width:500px">
							<%=checkName %>님&nbsp;
											
						<%
							for(int i=0; i<checkHeart;i++)
							{
								%>
								<img src="like.png" width="30px" height="30px" style="margin-top:10px;">
								<%
							}
						%>
						<button onclick="location.href='Logout.jsp'" class="w3-button w3-pale-red">LogOut</button>
						
						</div>
						
				<% }%>
            </div>
            
          </a>
          <div class="header--nav-toggle">
            <span></span>
          </div>
        </header>
        <nav class="l-side-nav" >
          <ul class="side-nav">
            <li class="is-active"><span >Home</span></li>
            <li><span>About</span></li>
            <li><span>My Coupon</span></li>
            
            <li><span>Event</span></li>
          </ul>
        </nav>

 	 <form method="post" action="LoginCheck.jsp">
		<div id="id01" class="w3-modal w3-animate-opacity">
		    <div class="w3-modal-content w3-card-4">
		      <header class="w3-container w3-pale-red"> 
		        <span onclick="document.getElementById('id01').style.display='none'" 
		        class="w3-button w3-large w3-display-topright">&times;</span>
		        <h2>로그인</h2>
		      </header>
		      <div class="w3-container">
		          <label for="uname"><b>Id</b></label>
			      <input type="text" placeholder="Enter Id" name="id" required>
					<br>
			      <label for="psw"><b>Password</b></label>
			      <input type="password" placeholder="Enter Password" name="pw" required>
		     		<br>
		      </div>
		      <footer class="w3-container w3-pale-red">
		        <p><button onclick="document.getElementById('id01').style.display='none'" class="w3-button w3-white">로그인</button></p>
		      </footer>
		    </div>
		  </div>
		  </form>

		<form method="post" action="Signup.jsp">
		<div id="id02" class="w3-modal w3-animate-opacity">
		    <div class="w3-modal-content w3-card-4">
		      <header class="w3-container w3-pale-red"> 
		        <span onclick="document.getElementById('id02').style.display='none'" 
		        class="w3-button w3-large w3-display-topright">&times;</span>
		        <h2>회원가입</h2>
		      </header>
		      <div class="w3-container">
		          <label for="uname"><b>Id</b></label>
			      <input type="text" placeholder="Enter Id" name="id" required>
					<br>
			      <label for="psw"><b>Password</b></label>
			      <input type="password" placeholder="Enter Password" name="pw" required>
			      <br>
			       <label for="name"><b>Name</b></label>
			      <input type="text" placeholder="Enter Name" name="name" required>
		      	<br>
		      </div>
		      <footer class="w3-container w3-pale-red">
		        <p><button onclick="document.getElementById('id02').style.display='none'" class="w3-button w3-white">가입하기</button></p>
		      </footer>
		    </div>
		  </div>
		  </form>


        <ul class="l-main-content main-content">

          <li class="l-section section section--is-active">
            <div class="intro">
              <div class="intro--banner">
                <h1>모든<br>사람들의 <br>얼굴은 아름답다.</h1>
                <br>
                 <button class="cta">이벤트 참여하기
                  <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 150 118" style="enable-background:new 0 0 150 118;" xml:space="preserve">
                  <g transform="translate(0.000000,118.000000) scale(0.100000,-0.100000)">
                    <path d="M870,1167c-34-17-55-57-46-90c3-15,81-100,194-211l187-185l-565-1c-431,0-571-3-590-13c-55-28-64-94-18-137c21-20,33-20,597-20h575l-192-193C800,103,794,94,849,39c20-20,39-29,61-29c28,0,63,30,298,262c147,144,272,271,279,282c30,51,23,60-219,304C947,1180,926,1196,870,1167z"/>
                  </g>
                  </svg>
                  <span class="btn-background"  style="background-color:#f15c5c"></span>
                </button>
                <img src="assets/img/flower.png" alt="Welcome">
              </div>
               <div class="intro--options">
                <a href="#0">
                  <h3>주변사람들의 얼굴을 자세히 보자</h3>
                  <p>주변사람들에게 관심을 가지고, 자세히 관찰해 보자</p>
                </a>
                <a href="#0">
                  <h3>미림의 얼굴</h3>
                  <p>우리는 미림을 대표하는 미림의 얼굴들이다</p>
                </a>
                <a href="#0">
                  <h3>외모에 대한 자신감</h3>
                  <p>누구나 다 예쁘니 당당하게 살아가자</p>
                </a>
              </div>
            </div>
          </li>

         <li class="l-section section ">
            <div class="about">
              <div class="super" >
                <h1>최고의 혜택</h1>
                <br><br><br>
              </div>
              <div class="w3-row" style="text-align:center">
                <div class="w3-third w3-container " >
                  <strong><h3>01. 첫번째 혜택</h3></strong>
                  <img src="assets/img/coupon_1.png" width="95%" height="auto" >
                  <p >하트5개면 지급</p>
                </div>
                <div class="w3-third w3-container">
                  <strong><h3>02. 두번째 혜택</h3></strong>
                  <img src="assets/img/coupon_2.png" width="95%" height="auto">
                  <p>하트7개면 지급</p>
                </div>
                <div class="w3-third w3-container">
                  <strong><h3>03. 세번째 혜택</h3></strong>
                  <img src="assets/img/coupon_3.png" width="95%" height="auto">
                  <p>하트10개면 지급</p>
                </div>
              </div>
            </div>
          </li>

 		<li class="l-section section ">
            <div class="coupon">
              <div class="myCoupon" >
                <h1>나의 쿠폰함</h1>
                <h3>나의 현재 하트 갯수는 <%=checkHeart%>개입니다.</h3>
                <br><br><br>
              </div>
              <div class="w3-row" style="text-align:center">
                <div class="w3-third w3-container " >
                  
                  <%
                  	if(checkHeart>=5)
                  	{
                  		%>
                  		 <img src="assets/img/coupon_1.png" width="95%" height="auto" >
                  		<%
                  	}
                  %>
                  
                </div>
                <div class="w3-third w3-container">
                 <%
                  	if(checkHeart>=7)
                  	{
                  		%>
                 		 <img src="assets/img/coupon_2.png" width="95%" height="auto">
                  		<%
                  	}
                  %>
                
                </div>
                <div class="w3-third w3-container">
                   <%
                  	if(checkHeart>=10)
                  	{
                  		%>
                 		 <img src="assets/img/coupon_3.png" width="95%" height="auto">
                  		<%
                  	}
                  %>
                </div>
              </div>
            </div>
          </li>


          <li class="l-section section">
            <div class="work">
              <h2>진행중인 이벤트</h2>
              <div class="work--lockup">
                <ul class="slider">
                  <li class="slider--item slider--item-left">
                    <a href="#0" onclick="window.open('friend_event.jsp','3학년 5반','﻿left=200,top=50,width=620,height=790,location=no,status=no,scrollbars=yes');">
                      <div class="slider--item-image">
                        <img src="assets/img/eye.jpg" alt="Victory">
                      </div>
                      <p class="slider--item-title">3학년 5반</p>
                      <p class="slider--item-description">3학년 5반 학생들의 얼굴을 맞혀보세요!</p>
                    </a>
                  </li>
                  <li class="slider--item slider--item-center">
                    <a href="#0" onclick="window.open('teacher_event.jsp','미림선생님','﻿left=200,top=50,width=620,height=790,location=no,status=no,scrollbars=yes');">
                      <div class="slider--item-image">
                        <img src="assets/img/work-metiew-smith.jpg">
                      </div>
                      <p class="slider--item-title">선생님</p>
                      <p class="slider--item-description">미림의 선생님 얼굴을 맞혀보세요!</p>
                    </a>
                  </li>
                  <li class="slider--item slider--item-right">
                    <a href="#0" onclick="window.open('entertainer_event.jsp','연예인','﻿left=200,top=50,width=620,height=790,location=no,status=no,scrollbars=yes');">
                      <div class="slider--item-image">
                        <img src="assets/img/mic.jpg" >
                      </div>
                      <p class="slider--item-title">연예인</p>
                      <p class="slider--item-description">미림 학생들이 좋아하는 연예인 얼굴을 맞혀보세요!</p>
                    </a>
                  </li>
                </ul>
                <div class="slider--prev">
                  <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                  viewBox="0 0 150 118" style="enable-background:new 0 0 150 118;" xml:space="preserve">
                  <g transform="translate(0.000000,118.000000) scale(0.100000,-0.100000)">
                    <path d="M561,1169C525,1155,10,640,3,612c-3-13,1-36,8-52c8-15,134-145,281-289C527,41,562,10,590,10c22,0,41,9,61,29
                    c55,55,49,64-163,278L296,510h575c564,0,576,0,597,20c46,43,37,109-18,137c-19,10-159,13-590,13l-565,1l182,180
                    c101,99,187,188,193,199c16,30,12,57-12,84C631,1174,595,1183,561,1169z"/>
                  </g>
                  </svg>
                </div>
                <div class="slider--next">
                  <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 150 118" style="enable-background:new 0 0 150 118;" xml:space="preserve">
                  <g transform="translate(0.000000,118.000000) scale(0.100000,-0.100000)">
                    <path d="M870,1167c-34-17-55-57-46-90c3-15,81-100,194-211l187-185l-565-1c-431,0-571-3-590-13c-55-28-64-94-18-137c21-20,33-20,597-20h575l-192-193C800,103,794,94,849,39c20-20,39-29,61-29c28,0,63,30,298,262c147,144,272,271,279,282c30,51,23,60-219,304C947,1180,926,1196,870,1167z"/>
                  </g>
                  </svg>
                </div>
              </div>
            </div>
          </li>



        </ul>
      </div>
    </div>
  </div>
  <ul class="outer-nav">
    <li class="is-active">Home</li>
    <li>About</li>
     <li>My Coupon</li>
    <li>Event</li>

  </ul>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="assets/js/vendor/jquery-2.2.4.min.js"><\/script>')</script>
<script src="assets/js/functions-min.js"></script>
</body>

</html>
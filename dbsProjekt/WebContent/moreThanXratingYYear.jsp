<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
<%@ include file="/css/bootstrap.css" %>
<%@ include file="/css/bootstrap-theme.css" %>
<%@ include file="/css/style.css" %>
</style>

<title>moreThanxRatingYYearJSP</title>
</head>

<body>
	<%
		/* needed imports */
	%>
	<%@ page language="java"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.sql.Connection"%>
	<%@ page import="dbs.*"%>
	<%@ page import="java.sql.ResultSet"%>
	<%@ page import="javax.sql.*;"%>

	<%
		java.sql.Connection conn = null;
		java.sql.Statement st = null;
		Class.forName("org.postgresql.Driver");
		//			String url = "jdbc:postgresql://localhost:5432/imdb?&user=postgres&password=***REMOVED***";
		String url = "jdbc:postgresql://localhost:5432/movies?&user=postgres&password=***REMOVED***";
		conn = java.sql.DriverManager.getConnection(url);

		MyDBSAPIImplementation test = new MyDBSAPIImplementation(conn);
		int rating = Integer.parseInt(request.getParameter("ratingX"));
		int year = Integer.parseInt(request.getParameter("yearY"));

		st = conn.createStatement();
		ResultSet rs = test.morethanXratingYyear(rating, year);
	%>
	<div class="container">
		<div class="jumbotron">
			<p>All Movies with a rating higher than X in year Y</p>

			<div class="row">
				<div class="col-sm-12 center-block">
					<table>
						<%
							while (rs.next()) {
						%>
						<tr>
							<td><%=rs.getString(1) + "&nbsp;"%></td>
							<td><%=rs.getString(2)%></td>
						</tr>
						<%
							}
						%>
					</table>
					<%
						rs.close();
						st.close();
						conn.close();
					%>
				</div>
			</div>
			<!-- end of row -->
		</div>
		<!-- end of jumbotron -->
	</div>
</body>

</html>
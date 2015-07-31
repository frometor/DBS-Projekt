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

<title>movies from actor</title>

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
		
		/* add your databasename, db-username and db-password here*/
		String url = "jdbc:postgresql://localhost:5432/databasename?&user=username&password=password";
		
		conn = java.sql.DriverManager.getConnection(url);
		
		MyDBSAPIImplementation test = new MyDBSAPIImplementation(conn);

		String act_name = request.getParameter("act_name").toString();

		ResultSet rs = test.moviesFromActor(act_name);
	%>

	<div class="container">
		<div class="jumbotron">
			<p>All Movies from actor</p>

			<div class="row">
				<div class="col-sm-12 center-block">
					<table>
						<%
			while (rs.next()) {
		%>
						<tr>
							<td><%= rs.getString(1) %></td>
						</tr>
						<%
			}
		%>

					</table>
					<%
		rs.close();
		conn.close();
	%>

				</div>
				<!-- end of row -->
			</div>
			<!-- end of jumbotron -->
		</div>
	</div>

</body>

</html>
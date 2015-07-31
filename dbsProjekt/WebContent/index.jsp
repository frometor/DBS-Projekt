<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<style type="text/css"> <!-- used to style the Webpage-->
<%@ include file="/css/bootstrap.css" %>
<%@ include file="/css/bootstrap-theme.css" %>
<%@ include file="/css/style.css" %>
</style>

<title>DBS API</title>
</head>
<body>
	<%@ page language="java"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.sql.Connection"%>
	<!-- the self developed API -->
	<%@ page import="dbs.*"%>
	<%@ page import="java.sql.ResultSet"%>
	<%@ page import="javax.sql.*;"%>

	<!-- Html forms wrapped with bootstrap container and row classes -->
	<div class="container">
		<div class="jumbotron">
			<h1>MYDBS GUI</h1>

			<p>Ask me anything</p>
		</div>
		<div class="row">
			<div class="col-sm-4">
				<h3>All Movies from an actor</h3>
				<form action="moviesFromActor.jsp" method="POST">
					<p>
						Actor: <input type="text" name="act_name">
					</p>
					<p>
						<input type="submit" value="Submit" />
					</p>
				</form>
			</div>

			<div class="col-sm-4">
				<h3>actors from Director</h3>
				<p>
				<form action="actors_From_Director.jsp" method="POST">
					<p>
						<input type="text" name="reg_nameX">
					</p>
					<p>
						<input type="submit" value="Submit" />
					</p>
				</form>
			</div>

			<div class="col-sm-4">
				<h3>top Movies until X</h3>
				<form action="topXMovies.jsp" method="POST">
					<p>
						<input type="text" name="untilX">
					</p>
					<p>
						<input type="submit" value="Submit" />
					</p>
				</form>
			</div>
		</div>
		<!-- End of Row -->

		<div class="row">
			<div class="col-sm-4">
				<h3>directors with most movies/ year</h3>
				<p>
				<form action="mostMovies.jsp" method="POST">
					<p>
						<input type="text" name="yearX">
					</p>
					<p>
						<input type="submit" value="Submit" />
					</p>
				</form>
			</div>

			<div class="col-sm-4">
				<h3>debut Year and Movie of actor</h3>
				<form action="yearDebutActor.jsp" method="POST">
					<p>
						<input type="text" name="act_name">
					</p>
					<p>
						<input type="submit" value="Submit" />
					</p>
				</form>
			</div>


			<div class="col-sm-4">
				<h3>Top 20 Movies</h3>
				<form action="top20Movies.jsp" method="POST">
					<p>
						<input type="submit" value="Submit" />
					</p>
				</form>
			</div>
		</div>
		<!-- End of Row -->

		<div class="row">
			<div class="col-sm-6">
				<h3>Movies with rating higher than X in Year Y:</h3>
				<form action="moreThanXratingYYear.jsp" method="POST">
					<p>
						Rating X: <input type="text" name="ratingX">
					</p>
					<p>
						Year Y: <input type="text" name="yearY">
					<p>
						<input type="submit" value="Submit" />
					</p>
				</form>
			</div>

			<div class="col-sm-6">
				<h3>Actors only with Movies worse than X rating</h3>
				<form action="worseThanX.jsp" method="POST">
					<p>
						Rating X: <input type="text" name="ratingX">
					</p>
					<p>
						<input type="submit" value="Submit" />
					</p>
				</form>
			</div>

		</div>
		<!-- End of Row -->

		<div class="row">
			<div class="col-sm-6">
				<h3>last 3 movies of a director</h3>
				<form action="last3MoviesDirector.jsp" method="POST">
					<p>
						director: <input type="text" name="reg_name">
					</p>
					<p>
						<input type="submit" value="Submit" />
					</p>
				</form>
			</div>


			<div class="col-sm-6">
				<h3>The first three actors of a movie</h3>
				<form action="first3Actors.jsp" method="POST">
					<p>
						Movie Name: <input type="text" name="mov_name">
					</p>
					<p>
						<input type="submit" value="Submit" />
					</p>
				</form>
			</div>
		</div>
		<!-- End of Row -->

	</div>
	<!-- End of Container -->

</body>
</html>
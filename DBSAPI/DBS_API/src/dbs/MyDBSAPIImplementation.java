package dbs;

import java.sql.*;

public class MyDBSAPIImplementation implements myDBSAPI {

	private Connection conn = null;
	private Statement st = null;

	public MyDBSAPIImplementation(Connection conn) {
		this.conn = conn;
	}

	@Override
	public ResultSet moviesFromActor(String actor) {
		ResultSet ausgabe_rs = null;

		try {
			st = conn.createStatement();

			ausgabe_rs = st.executeQuery(
					"Select mov_name from movies where mov_id in (Select mov_id from acts where act_id = (Select act_id from actor where act_name = '"+actor+"'));");

		} catch (SQLException se) {
			se.printStackTrace();
		}
		return ausgabe_rs;
	}

	@Override
	public ResultSet topXMovie(int x) {
		ResultSet ausgabe_rs = null;

		try {
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM movies WHERE movies.rating IS NOT NULL ORDER BY rating DESC LIMIT ? ");
			ps.setInt(1, x);
			ausgabe_rs = ps.executeQuery();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ausgabe_rs;
	}

	@Override
	public ResultSet yearAndMovieDebutActor(String actor) {
		ResultSet ausgabe_rs = null;

		try {

			PreparedStatement ps = conn.prepareStatement(
					"Select mov_name, year from movies where mov_id in (Select mov_id from acts where act_id =(Select act_id from actor where act_name = ?)) order by year asc limit 1");
			ps.setString(1, actor);
			ausgabe_rs = ps.executeQuery();

		} catch (SQLException se) {
			se.printStackTrace();
		}
		return ausgabe_rs;
	}

	@Override
	public ResultSet mostMoviesYear(int year) {
		ResultSet ausgabe_rs = null;

		try {
			Statement ps = conn.createStatement();

			ps.execute(
					"CREATE OR REPLACE VIEW mov_per_year AS select reg_id, count(reg_id) from directs where mov_id in (Select mov_id from movies where year ="
							+ year + ") GROUP by reg_id order By 2 desc limit 10;");
			ausgabe_rs = ps.executeQuery(
					"SELECT regisseur.reg_name, mov_per_year.count from regisseur INNER JOIN mov_per_year ON regisseur.reg_id=mov_per_year.reg_id;");

		} catch (SQLException se) {
			// Handle errors for JDBC
			se.printStackTrace();
		}
		return ausgabe_rs;

	}

	@Override
	public ResultSet morethanXratingYyear(int x, int y) {
		ResultSet ausgabe_rs = null;

		try {
			PreparedStatement ps = conn.prepareStatement(
					"Select mov_name,rating, year from movies where year=? AND rating >? order by rating desc;");
			ps.setInt(2, x);
			ps.setInt(1, y);

			ausgabe_rs = ps.executeQuery();

		} catch (SQLException se) {
			// Handle errors for JDBC
			se.printStackTrace();
		}
		return ausgabe_rs;
	}

	@Override
	public ResultSet actorsFromDirector(String director) {
		ResultSet ausgabe_rs = null;

		try {
			Statement ps = conn.createStatement();

			ps.execute(
					"Create or Replace view acts_from_reg AS Select act_id, count(act_id) from acts where mov_id in (Select mov_id from directs where reg_id = (Select reg_id from regisseur where reg_name ='"
							+ director + "')) group by act_id order by count(act_id) desc;");
			ausgabe_rs = ps.executeQuery(
					"Select actor.act_name, acts_from_reg.count from actor INNER JOIN acts_from_reg ON actor.act_id=acts_from_reg.act_id;");

		} catch (SQLException se) {
			// Handle errors for JDBC
			se.printStackTrace();
		}
		return ausgabe_rs;

	}
	

	@Override
	public ResultSet worseThanX(int x) {
		ResultSet ausgabe_rs = null;

		try {

			PreparedStatement ps = conn.prepareStatement(
					"Select Distinct act_name from actor where act_id in (Select act_id from acts where mov_id in (Select mov_id from movies where rating < ?)) ORDER BY act_name ASC");
			ps.setInt(1, x);
			ausgabe_rs = ps.executeQuery();

		} catch (SQLException se) {
			se.printStackTrace();
		}
		return ausgabe_rs;
	}

	@Override
	public ResultSet first3Actors(String movie) {
		ResultSet ausgabe_rs = null;

		try {

			PreparedStatement ps = conn.prepareStatement(
					"Select act_name from actor where act_id in (Select act_id from acts where mov_id in (Select mov_id from movies where mov_name = ?));");
			ps.setString(1, movie);
			ausgabe_rs = ps.executeQuery();

		} catch (SQLException se) {
			se.printStackTrace();
		}
		return ausgabe_rs;
	}

	@Override
	public ResultSet last3MoviesDirector(String director) {
		ResultSet ausgabe_rs = null;

		try {

			PreparedStatement ps = conn.prepareStatement(
					"Select rating, mov_name, year from movies where mov_id in (Select mov_id from directs where reg_id = (Select reg_id from regisseur where reg_name = ?))GROUP BY rating, year, mov_name ORDER BY year desc LIMIT 3;");
			ps.setString(1, director);
			ausgabe_rs = ps.executeQuery();

		} catch (SQLException se) {
			se.printStackTrace();
		}
		return ausgabe_rs;
	}

	
}

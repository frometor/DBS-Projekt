package dbs;
import java.sql.ResultSet;


public interface myDBSAPI {
	

	/**
	 * @return all movies from an actor
	 */
	public ResultSet moviesFromActor(String actor);
	

	/**
	 * @param x int, highest place 
	 * @return all movies from top 1 to x
	 */
	public ResultSet topXMovie(int x);
	
	/**
	 * @param x int rating
	 * @param y int year
	 * @return all movies with more rating x in year y
	 */
	public ResultSet morethanXratingYyear(int x, int y);
	
	/**
	 * @param actor String
	 * @return the debut movie of one actor
	 */
	public ResultSet yearAndMovieDebutActor(String actor);
	
	/**
	 * @param year int 
	 * @return all movies of the year
	 */
	public ResultSet mostMoviesYear(int year);
	
	/**
	 * @param director String
	 * @return all actors and #appearances in movies from director  
	 */
	public ResultSet actorsFromDirector (String director);

	/**
	 * @param rating Integer
	 * @return All actors who act in Movies worse than x  
	 */
	public ResultSet worseThanX (int x);

	/**
	 * @param movie String
	 * @return first three actors of a Movie  
	 */
	public ResultSet first3Actors (String movie);

	/**
	 * @param director String
	 * @return rating of last three movies from an director  
	 */
	public ResultSet last3MoviesDirector (String director);

	
	
}

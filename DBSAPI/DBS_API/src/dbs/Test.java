package dbs;
import java.sql.*;

public class Test {

	static Connection conn = null;

	private static String treiber = "jdbc:postgresql";
	private static String server = "localhost:5432/databasename?";
	private static String user = "user";
	private static String password = "password";

	public static void main(String[] args) {
		String url = treiber + "://" + server + "&user=" + user + "&password="
				+ password;

		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
		
		try {
			conn = DriverManager.getConnection(url);
		} catch (SQLException e1) {
			e1.printStackTrace();
		}

		MyDBSAPIImplementation test = new MyDBSAPIImplementation(conn);
		ResultSet rs = null;

		try {
			rs = test.yearAndMovieDebutActor("Brad Pitt");
			while (rs.next()) {
				System.out.print(rs.getString(1)+" ");
				System.out.print(rs.getString(2));
				System.out.println(rs.getString(3));
				

			}
		} catch (SQLException e) {

		}
		
	try {
		conn.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	}
}

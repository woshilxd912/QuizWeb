package xuandong;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

public class QuizSummary {
	private int takeNum;
	
	private String quizID;
	private String userID;
	private String maxScore;
	private String minScore;
	private String meanScore;
	
	private ArrayList<Performance> badPerformers;
	private ArrayList<Performance> goodPerformers;
	private ArrayList<Performance> userPerformance;
	private ArrayList<Performance> highestPerformers;
	private ArrayList<Performance> highestPerformersLastDay;

	public static final int TOP_NUM = 10;

	
	/**
	 * Simple constructor, get the statistics about this quiz
	 * @param quizID
	 * @param userID
	 */
	public QuizSummary(String quizID, String userID) {
		this.quizID = quizID;
		this.userID = userID;
		highestPerformers = new ArrayList<Performance>();
		highestPerformersLastDay = new ArrayList<Performance>();
		goodPerformers = new ArrayList<Performance>();
		badPerformers = new ArrayList<Performance>();
		userPerformance = new ArrayList<Performance>();
		try {
			DBConnection database = new DBConnection();
			Statement stmt = database.getStmt();
			String sql = "SELECT COUNT(UserID), AVG(Score), MAX(Score), MIN(Score) FROM QuizRecord WHERE QuizID = \"" + this.quizID + "\" GROUP BY QuizID;";
			ResultSet res = stmt.executeQuery(sql);
			if (res.next()) {
				takeNum = res.getInt(1);
				meanScore = String.format("%.2f", res.getDouble(2)) + "%";
				maxScore = String.format("%.2f", res.getDouble(3)) + "%";
				minScore = String.format("%.2f", res.getDouble(4)) + "%";
			} else {
				takeNum = 0;
				meanScore = "Untaken";
				maxScore = "Untaken";
				minScore = "Untaken";
			}
			database.getCon().close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * Get the performance of this user ordered by date
	 * @return a Performance Object, it's easy to read
	 */
	public ArrayList<Performance> getUserPerformanceByDate() {
		try {
			DBConnection database = new DBConnection();
			Statement stmt = database.getStmt();
			String sql = "SELECT QuizID, UserID, StartTime, Duration, Score FROM QuizRecord WHERE QuizID = \"" + this.quizID + "\" AND UserID = \"" + this.userID.replace("\"", "\"\"") + "\" ORDER BY StartTime DESC;";
			ResultSet res = stmt.executeQuery(sql);
			if (res != null) {
				while (res.next()) {
					String curQuizID = res.getString(1);
					String curUserID = res.getString(2);
					String curStartTime = res.getString(3);
					String curDuration = res.getString(4);
					double curScore = Double.parseDouble(res.getString(5));
					Performance perf = new Performance(curQuizID, curUserID, curStartTime, curDuration, curScore);
					userPerformance.add(perf);
				}
			}
			database.getCon().close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return userPerformance;
	}
	
	
	/**
	 * Get the performance of this user ordered by score
	 * @return a Performance Object, it's easy to read
	 */
	public ArrayList<Performance> getUserPerformanceByScore() {
		ArrayList<Performance> perfByScore = new ArrayList<Performance>();
		try {
			DBConnection database = new DBConnection();
			Statement stmt = database.getStmt();
			String sql = "SELECT QuizID, UserID, StartTime, Duration, Score FROM QuizRecord WHERE QuizID = \"" + this.quizID + "\" AND UserID = \"" + this.userID + "\" ORDER BY Score DESC;";
			ResultSet res = stmt.executeQuery(sql);
			if (res != null) {
				while (res.next()) {
					String curQuizID = res.getString(1);
					String curUserID = res.getString(2);
					String curStartTime = res.getString(3);
					String curDuration = res.getString(4);
					double curScore = Double.parseDouble(res.getString(5));
					Performance perf = new Performance(curQuizID, curUserID, curStartTime, curDuration, curScore);
					perfByScore.add(perf);
				}
			}
			database.getCon().close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return perfByScore;
	}
	
	
	/**
	 * Get the performance of this user ordered by duration
	 * @return a Performance Object, it's easy to read
	 */
	public ArrayList<Performance> getUserPerformanceByDuration() {
		ArrayList<Performance> perfByScore = new ArrayList<Performance>();
		try {
			DBConnection database = new DBConnection();
			Statement stmt = database.getStmt();
			String sql = "SELECT QuizID, UserID, StartTime, Duration, Score FROM QuizRecord WHERE QuizID = \"" + this.quizID + "\" AND UserID = \"" + this.userID + "\" ORDER BY Duration ASC;";
			ResultSet res = stmt.executeQuery(sql);
			if (res != null) {
				while (res.next()) {
					String curQuizID = res.getString(1);
					String curUserID = res.getString(2);
					String curStartTime = res.getString(3);
					String curDuration = res.getString(4);
					double curScore = Double.parseDouble(res.getString(5));
					Performance perf = new Performance(curQuizID, curUserID, curStartTime, curDuration, curScore);
					perfByScore.add(perf);
				}
			}
			database.getCon().close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return perfByScore;
	}
	
	
	/**
	 * Get the top 10 performance of this quiz 
	 * @return a Performance Object, it's easy to read
	 */
	public ArrayList<Performance> getHighestPerformers() {
		try {
			DBConnection database = new DBConnection();
			Statement stmt = database.getStmt();
			String sql = "SELECT QuizID, UserID, StartTime, Duration, Score FROM QuizRecord WHERE QuizID = \"" + this.quizID + "\" ORDER BY Score DESC, Duration ASC, StartTime ASC LIMIT " + TOP_NUM + " ;";
			ResultSet res = stmt.executeQuery(sql);
			if (res != null) {
				while (res.next()) {
					String curQuizID = res.getString(1);
					String curUserID = res.getString(2);
					String curStartTime = res.getString(3).substring(0, res.getString(3).length() - 2);
					String curDuration = res.getString(4);
					double curScore = Double.parseDouble(res.getString(5));
					Performance perf = new Performance(curQuizID, curUserID, curStartTime, curDuration, curScore);
					highestPerformers.add(perf);
				}
			}
			database.getCon().close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return highestPerformers;
	}
	
	
	/**
	 * Get the top 10 performance of this quiz during the last 24 hours
	 * @return a Performance Object, it's easy to read
	 */
	public ArrayList<Performance> getHighestPerformersLastDay() {
		try {
			DBConnection database = new DBConnection();
			Statement stmt = database.getStmt();
			String curTime = Quiz.df.format((new Date()).getTime());
			String sql = "SELECT QuizID, UserID, StartTime, Duration, Score FROM QuizRecord WHERE QuizID = \"" + this.quizID + "\" AND TIMESTAMPDIFF(SECOND, EndTime, \"" + curTime + "\") <= 86400 ORDER BY Score DESC, Duration ASC, StartTime ASC LIMIT " + TOP_NUM + " ;";
			ResultSet res = stmt.executeQuery(sql);
			if (res != null) {
				while (res.next()) {
					String curQuizID = res.getString(1);
					String curUserID = res.getString(2);
					String curStartTime = res.getString(3).substring(0, res.getString(3).length() - 2);
					String curDuration = res.getString(4);
					double curScore = Double.parseDouble(res.getString(5));
					Performance perf = new Performance(curQuizID, curUserID, curStartTime, curDuration, curScore);
					highestPerformersLastDay.add(perf);
				}
			}
			database.getCon().close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return highestPerformersLastDay;
	}
	
	
	/**
	 * Get the top 10 good performers who scored over 80% of this quiz
	 * @return a Performance Object, it's easy to read
	 */
	public ArrayList<Performance> getGoodPerformers() {
		try {
			DBConnection database = new DBConnection();
			Statement stmt = database.getStmt();
			String sql = "SELECT QuizID, UserID, StartTime, Duration, Score FROM QuizRecord WHERE QuizID = \"" + this.quizID + "\" AND Score >= 80 ORDER BY EndTime DESC, Score DESC LIMIT " + TOP_NUM + ";";
			ResultSet res = stmt.executeQuery(sql);
			if (res != null) {
				while (res.next()) {
					String curQuizID = res.getString(1);
					String curUserID = res.getString(2);
					String curStartTime = res.getString(3).substring(0, res.getString(3).length() - 2);
					String curDuration = res.getString(4);
					double curScore = Double.parseDouble(res.getString(5));
					Performance perf = new Performance(curQuizID, curUserID, curStartTime, curDuration, curScore);
					goodPerformers.add(perf);
				}
			}
			database.getCon().close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return goodPerformers;
	}
	
	
	/**
	 * Get the top 10 bad performers who scored bellow 40% of this quiz
	 * @return Performance Object, it's easy to read
	 */
	public ArrayList<Performance> getBadPerformers() {
		try {
			DBConnection database = new DBConnection();
			Statement stmt = database.getStmt();
			String sql = "SELECT QuizID, UserID, StartTime, Duration, Score FROM QuizRecord WHERE QuizID = \"" + this.quizID + "\" AND Score <= 40 ORDER BY EndTime DESC, Score ASC LIMIT " + TOP_NUM + " ;";
			ResultSet res = stmt.executeQuery(sql);
			if (res != null) {
				while (res.next()) {
					String curQuizID = res.getString(1);
					String curUserID = res.getString(2);
					String curStartTime = res.getString(3).substring(0, res.getString(3).length() - 2);
					String curDuration = res.getString(4);
					double curScore = Double.parseDouble(res.getString(5));
					Performance perf = new Performance(curQuizID, curUserID, curStartTime, curDuration, curScore);
					badPerformers.add(perf);
				}
			}
			database.getCon().close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return badPerformers;
	}
	
	
	/**
	 * @return the number of the quiz been taken
	 */
	public String getTakeNum() {
		return String.valueOf(takeNum);
	}
	
	
	/**
	 * @return the average score of all users
	 */
	public String getMeanScore() {
		return meanScore;
	}
	
	
	/**
	 * @return the maximum score of all users
	 */
	public String getMaxScore() {
		return maxScore;
	}
	
	
	/**
	 * @return the minimum score of all users
	 */
	public String getMinScore() {
		return minScore;
	}
	
}

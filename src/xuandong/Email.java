package xuandong;

import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

public class Email {
	String senderID;
	String receiverID;
	String content;
	String link;
	String subject;
	String time;
	boolean read;
	
	/**
	 * Simple Constructor
	 */
	public Email() {
	}
	
	/**
	 * Set the senderID
	 * @param sender
	 */
	public void setSender(String sender) {
		senderID = sender;
	}
	
	/**
	 * Set the receiverID
	 * @param receiver
	 */
	public void setReceiver(String receiver) {
		receiverID = receiver;
	}
	
	/**
	 * Set the content
	 * @param content
	 */
	public void setContent(String content) {
		this.content = content;
	}
	
	/**
	 * Set the link
	 * @param link
	 */
	public void setLink(String link) {
		this.link = link;
	}
	
	/**
	 * Set the subject
	 * @param subject
	 */
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	/**
	 * Set the time of this email
	 * @param time
	 */
	public void setTime(String time) {
		this.time = Quiz.df.format(new Date().getTime());
	}
	
	/**
	 * Set whether or not this email has been read
	 * @param value TRUE for already read, FALSE if not
	 */
	public void setRead(boolean value) {
		this.read = value;
	}
	
	/**
	 * Delete an email from the databse
	 */
	public void deleteEmail() {
		DBConnection database = new DBConnection();
		Statement stmt = database.getStmt();
		try {
			String sql = "DELETE FROM Emails WHERE SenderID = \"" + this.senderID + "\" AND ReceiverID = \"" + this.receiverID + "\" AND Time = \"" + this.time + "\";";
			stmt.executeUpdate(sql);
			database.getCon().close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Insert this email into database
	 * Notice that we only insert an new email into database when it is being sent by someone
	 */
	public void insertToDatabse() {
		DBConnection database = new DBConnection();
		Statement stmt = database.getStmt();
		try {
			String sql = "INSERT INTO Emails(SenderID, ReceiverID, Time, Subject, Content, Link, IsRead)" + " VALUES(\"" + this.senderID + "\",\"" + this.receiverID + "\",\"" + this.time
				+ "\",\"" + this.subject + "\",\"" + this.content + "\",\"" + this.link + "\"," + this.read + ");";
			stmt.executeUpdate(sql);
			database.getCon().close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Update the isRead Attribute in the database for this email
	 */
	public void updateDatabase() {
		DBConnection database = new DBConnection();
		Statement stmt = database.getStmt();
		try {
			String sql = "UPDATE Emails SET IsRead = " + this.read + ";";
			stmt.executeUpdate(sql);
			database.getCon().close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
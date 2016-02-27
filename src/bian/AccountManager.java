package bian;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

public class AccountManager {
	private Statement stmt;
	private ResultSet rs;
	private MessageDigest md;
	
	
	AccountManager(Statement stmt) throws SQLException {
		this.stmt = stmt;
		rs = stmt.executeQuery("SELECT * FROM users");
	}
	
	
	/**
	 * Check before creating account and login, if this account exist.
	 * @param id
	 * @return if the account exist.
	 */
	public boolean accountExist(String id) {
		try {
			rs = stmt.executeQuery("SELECT * FROM users WHERE id = " + "\"" + id + "\";");
			if (rs.next()) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	
	/**
	 * Create account.
	 * @param String id.
	 * @param String password.
	 */
	public void createAccount(String id, String password) {
		password = hashSHAPassword(password);
		try {
			stmt.executeUpdate("INSERT INTO users(id, password) VALUES(\"" + id + "\",\"" + password + "\");");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Check if password and id are matched. Used to login.
	 * @param String id.
	 * @param String password.
	 */
	public boolean idPasswordMatch(String id, String password) {
		password = hashSHAPassword(password);
		try {
			rs = stmt.executeQuery("SELECT * FROM users WHERE id = \"" + id + "\";");
			String right_password = rs.getString("password");
			if (right_password == password) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	/**
	 * Change password for an id.
	 * @param String id.
	 * @param String password.
	 */
	public void changePassword(String id, String ps_new) {
		String password = hashSHAPassword(ps_new);
		try {
			stmt.executeUpdate("UPDATE users SET password = \"" + password 
					+ "\" WHERE id = \"" + id + "\";");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Delete account.
	 * @param String id.
	 */
	public void removeAccount(String id) {
		try {
			stmt.executeUpdate("DELETE FROM user WHERE id = \"" + id + "\";");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	

	/*
	 Given a plain text string, produces a SHA coded password.
	*/
	private String hashSHAPassword(String pw) {
		byte[] byte_pw = pw.getBytes();
		try {
			md = MessageDigest.getInstance("SHA");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		md.reset();
		md.update(byte_pw);
		byte[] result = md.digest();
		return hexToString(result);
	}
	
	/*
	 Given a byte[] array, produces a hex String,
	 such as "234a6f". with 2 chars for each byte in the array.
	 (provided code)
	*/
	public static String hexToString(byte[] bytes) {
		StringBuffer buff = new StringBuffer();
		for (int i=0; i<bytes.length; i++) {
			int val = bytes[i];
			val = val & 0xff;  // remove higher bits, sign
			if (val<16) buff.append('0'); // leading 0
			buff.append(Integer.toString(val, 16));
		}
		return buff.toString();
	}

}
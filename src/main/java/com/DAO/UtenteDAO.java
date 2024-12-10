package com.DAO;

import com.connection.ConnectionDB;
import com.entities.Utente;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UtenteDAO {
	static ConnectionDB connessione = new ConnectionDB();

	public static void registraUtente(String username, String email, String password) {
		String sql = "INSERT INTO Utenti (username, email, password ) VALUES (?,?,?)";

		try (Connection conn = connessione.connessioneDB()) {
			if (conn != null) {
				PreparedStatement preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setString(1, username);
				preparedStatement.setString(2, email);
				preparedStatement.setString(3, password);
				preparedStatement.executeUpdate();
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public static Utente findUtente(String username, String email) {
		Utente utente = null;
		String sql = "SELECT * FROM Utenti WHERE username = ? AND email = ?";
		try (Connection conn = connessione.connessioneDB()) {
			if (conn != null) {
				PreparedStatement preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setString(1, username);
				preparedStatement.setString(2, email);
				ResultSet rs = preparedStatement.executeQuery();
				while (rs.next()) {
					utente = new Utente();
					utente.setIdUtente(rs.getInt("id"));
					utente.setUsername(rs.getString("username"));
					utente.setEmail(rs.getString("email"));
					utente.setPassword(rs.getString("password"));
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return utente;
	}

	public static Utente getUtenteByCredentials(String email, String password) {
		Utente utente = null;
		String sql = "SELECT * FROM Utenti WHERE email = ? AND password = ?";
		try (Connection conn = connessione.connessioneDB()) {
			if (conn != null) {
				PreparedStatement preparedStatement = conn.prepareStatement(sql);

				preparedStatement.setString(1, email);
				preparedStatement.setString(2, password);
				ResultSet rs = preparedStatement.executeQuery();
				while (rs.next()) {
					utente = new Utente();
					utente.setIdUtente(rs.getInt("id"));
					utente.setUsername(rs.getString("username"));
					utente.setEmail(rs.getString("email"));
					utente.setPassword(rs.getString("password"));
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return utente;
	}

	public static Utente findUtenteByEmail(String email) {
		Utente utente = null;
		String sql = "SELECT * FROM Utenti WHERE email = ?";
		try (Connection conn = connessione.connessioneDB()) {
			if (conn != null) {
				PreparedStatement preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setString(1, email);
				ResultSet rs = preparedStatement.executeQuery();
				while (rs.next()) {
					utente = new Utente();
					utente.setIdUtente(rs.getInt("id"));
					utente.setUsername(rs.getString("username"));
					utente.setEmail(rs.getString("email"));
					utente.setPassword(rs.getString("password"));
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return utente;
	}

	public static List<Utente> getAllUtenti() {
		List<Utente> utenti = new ArrayList<>();
		String sql = "SELECT * FROM Utenti";
		try (Connection conn = connessione.connessioneDB()) {
			if (conn != null) {
				PreparedStatement preparedStatement = conn.prepareStatement(sql);
				ResultSet rs = preparedStatement.executeQuery();
				while (rs.next()) {
					Utente utente = new Utente();
					utente.setIdUtente(rs.getInt("id"));
					utente.setUsername(rs.getString("username"));
					utente.setEmail(rs.getString("email"));
					utente.setPassword(rs.getString("password"));
					utenti.add(utente);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return utenti;
	}
}

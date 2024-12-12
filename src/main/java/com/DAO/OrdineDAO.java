package com.DAO;

import com.connection.ConnectionDB;
import com.entities.Ordine;
import com.entities.Prodotto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class OrdineDAO {
	static ConnectionDB connessione = new ConnectionDB();

	public static void aggiungiOrdine(Ordine ordine) {
		String sql = "INSERT INTO Ordine (id_utente, totale_ordine) VALUES (?,?)";
		try (Connection conn = connessione.connessioneDB()) {
			if (conn != null) {
				PreparedStatement preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setInt(1, ordine.getIdUtente());
				preparedStatement.setDouble(2, ordine.getTotaleOrdine());
				preparedStatement.executeUpdate();
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public static int getIdOrdine(int idUtente) {
		Ordine ordine = new Ordine();
		String sql = "SELECT id FROM ordine WHERE id_utente = ?";
		try (Connection conn = connessione.connessioneDB()) {
			if (conn != null) {
				PreparedStatement preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setInt(1, idUtente);
				ResultSet rs = preparedStatement.executeQuery();
				while (rs.next()) {
					ordine.setIdOrdine(rs.getInt("id"));
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return ordine.getIdOrdine();
	}

	public static void aggiungiDettagliOrdine(int idOrdine, int idProdotto, int quantita) {
		String sql = "INSERT INTO dettagli_ordine (id_ordine, id_prodotto, quantita) VALUES (?,?,?)";
		try (Connection conn = connessione.connessioneDB()) {
			if (conn != null) {
				PreparedStatement preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setInt(1, idOrdine);
				preparedStatement.setInt(2, idProdotto);
				preparedStatement.setInt(3, quantita);
				preparedStatement.executeUpdate();
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}

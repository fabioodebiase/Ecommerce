package com.DAO;

import com.connection.ConnectionDB;
import com.entities.Ordine;
import com.entities.Prodotto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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

	public static ArrayList<Ordine> getAllOrdini() {
		ArrayList<Ordine> ordini = new ArrayList<>();
		String sql = "SELECT ordine.id, utenti.username, ordine.totale_ordine FROM ordine INNER JOIN utenti ON utenti.id = ordine.id_utente";
		try (Connection conn = connessione.connessioneDB()) {
			if (conn != null) {
				PreparedStatement preparedStatement = conn.prepareStatement(sql);

				ResultSet rs = preparedStatement.executeQuery();
				while (rs.next()) {
					Ordine ordine = new Ordine();
					ordine.setIdOrdine(rs.getInt("ordine.id"));
					ordine.setUsername(rs.getString("utenti.username"));
					ordine.setTotaleOrdine(rs.getInt("ordine.totale_ordine"));
					ordini.add(ordine);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return ordini;
	}

	public static ArrayList<Ordine> getDettagliOrdineById(int idOrdine) {
		ArrayList<Ordine> ordini = new ArrayList<>();
		String sql = "SELECT prodotti.nome_prodotto AS nome_prodotto, prodotti.image_path AS image_path, " +
				"prodotti.prezzo AS prezzo, dettagli_ordine.quantita AS quantita, ordine.id AS id_ordine " +
				"FROM utenti " +
				"INNER JOIN ordine ON utenti.id = ordine.id_utente " +
				"INNER JOIN dettagli_ordine ON ordine.id = dettagli_ordine.id_ordine " +
				"INNER JOIN prodotti ON dettagli_ordine.id_prodotto = prodotti.id " +
				"WHERE ordine.id = ?";
		try (Connection conn = connessione.connessioneDB()) {
			if (conn != null) {
				PreparedStatement preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setInt(1, idOrdine);
				ResultSet rs = preparedStatement.executeQuery();
				while (rs.next()) {
					Ordine ordine = new Ordine();
					ordine.setNomeProdotto(rs.getString("nome_prodotto"));
					ordine.setImagePath(rs.getString("image_path"));
					ordine.setPrezzo(rs.getDouble("prezzo"));
					ordine.setQuantita(rs.getInt("quantita"));
					ordine.setIdOrdine(rs.getInt("id_ordine"));
					ordini.add(ordine);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return ordini;
	}
}

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

	public static void aggiungiDettagliOrdine(Ordine newOrdine) {
		String sql = "INSERT INTO dettagli_ordine (id_ordine, id_prodotto, quantita,nome_prodotto,prezzo,image_path) VALUES (?,?,?,?,?,?)";
		try (Connection conn = connessione.connessioneDB()) {
			if (conn != null) {
				PreparedStatement preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setInt(1, newOrdine.getIdOrdine());
				preparedStatement.setInt(2, newOrdine.getIdProdotto());
				preparedStatement.setInt(3, newOrdine.getQuantita());
				preparedStatement.setString(4, newOrdine.getNomeProdotto());
				preparedStatement.setDouble(5,newOrdine.getPrezzo());
				preparedStatement.setString(6,newOrdine.getImagePath());
				preparedStatement.executeUpdate();
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public static void aggiungiStoricoOrdini() {
		String sql = "INSERT INTO storico_ordini (id_ordine, username, nome_prodotto, prezzo, quantita, image_path, id_utente, totale) " +
				"SELECT ordine.id, utenti.username, dettagli_ordine.nome_prodotto, dettagli_ordine.prezzo, dettagli_ordine.quantita, dettagli_ordine.image_path, utenti.id, ordine.totale_ordine " +
				"FROM utenti " +
				"INNER JOIN ordine ON utenti.id = ordine.id_utente " +
				"INNER JOIN dettagli_ordine ON ordine.id = dettagli_ordine.id_ordine";
		try (Connection conn = connessione.connessioneDB();
			 PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
			if (conn != null) {
				preparedStatement.executeUpdate();
			}
		} catch (SQLException e) {
			System.out.println(e);
			throw new RuntimeException("Errore durante l'inserimento di tutti gli ordini nello storico", e);
		}
	}

	public static ArrayList<Ordine> getStoricoOrdini() {
		ArrayList<Ordine> ordini = new ArrayList<>();
		String sql = "SELECT DISTINCT id_ordine, username, totale FROM storico_ordini ORDER BY id_ordine;";
		try (Connection conn = connessione.connessioneDB()) {
			if (conn != null) {
				PreparedStatement preparedStatement = conn.prepareStatement(sql);

				ResultSet rs = preparedStatement.executeQuery();
				while (rs.next()) {
					Ordine ordine = new Ordine();
					ordine.setIdOrdine(rs.getInt("id_ordine"));
					ordine.setUsername(rs.getString("username"));
					ordine.setTotaleOrdine(rs.getInt("totale"));
					ordini.add(ordine);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return ordini;
	}

	public static ArrayList<Ordine> getDettagliStoricoOrdineByIdOrdine(int idOrdine) {
		ArrayList<Ordine> ordini = new ArrayList<>();
		String sql = "SELECT DISTINCT id_ordine, nome_prodotto, prezzo, quantita, image_path FROM storico_ordini WHERE id_ordine = ?";
		try (Connection conn = connessione.connessioneDB()) {
			if (conn != null) {
				PreparedStatement preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setInt(1, idOrdine);
				ResultSet rs = preparedStatement.executeQuery();
				while (rs.next()) {
					Ordine ordine = new Ordine();
					ordine.setIdOrdine(rs.getInt("id_ordine"));
					ordine.setNomeProdotto(rs.getString("nome_prodotto"));
					ordine.setPrezzo(rs.getDouble("prezzo"));
					ordine.setQuantita(rs.getInt("quantita"));
					ordine.setImagePath(rs.getString("image_path"));

					ordini.add(ordine);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return ordini;
	}

	public static ArrayList<Ordine> getStoricoOrdiniByIdUtente(int idUtente) {
		ArrayList<Ordine> ordini = new ArrayList<>();
		String sql = "SELECT DISTINCT id_ordine, totale FROM storico_ordini WHERE id_utente = ? ORDER BY id_ordine;";
		try (Connection conn = connessione.connessioneDB()) {
			if (conn != null) {
				PreparedStatement preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setInt(1,idUtente);
				ResultSet rs = preparedStatement.executeQuery();
				while (rs.next()) {
					Ordine ordine = new Ordine();
					ordine.setIdOrdine(rs.getInt("id_ordine"));
					ordine.setTotaleOrdine(rs.getInt("totale"));
					ordini.add(ordine);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return ordini;
	}

	public static ArrayList<Ordine> getDettagliStoricoOrdineByIdOrdineAndIdUtente(int idOrdine,int idUtente) {
		ArrayList<Ordine> ordini = new ArrayList<>();
		String sql = "SELECT DISTINCT id_ordine, nome_prodotto, prezzo, quantita, image_path FROM storico_ordini WHERE id_ordine = ? AND id_utente = ?";
		try (Connection conn = connessione.connessioneDB()) {
			if (conn != null) {
				PreparedStatement preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setInt(1, idOrdine);
				preparedStatement.setInt(2, idUtente);
				ResultSet rs = preparedStatement.executeQuery();
				while (rs.next()) {
					Ordine ordine = new Ordine();
					ordine.setIdOrdine(rs.getInt("id_ordine"));
					ordine.setNomeProdotto(rs.getString("nome_prodotto"));
					ordine.setPrezzo(rs.getDouble("prezzo"));
					ordine.setQuantita(rs.getInt("quantita"));
					ordine.setImagePath(rs.getString("image_path"));

					ordini.add(ordine);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return ordini;
	}

}



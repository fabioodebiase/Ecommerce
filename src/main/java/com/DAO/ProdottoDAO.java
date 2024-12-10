package com.DAO;

import com.connection.ConnectionDB;
import com.entities.Prodotto;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProdottoDAO {
	static ConnectionDB connessione = new ConnectionDB();

	public static void aggiungiProdotto(Prodotto prodotto) {
		String sql = "INSERT INTO Prodotti (nome_prodotto, prezzo, quantita_disponibile, image_path ) VALUES (?,?,?,?)";
		try (Connection conn = connessione.connessioneDB()) {
			if (conn != null) {
				PreparedStatement preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setString(1, prodotto.getNomeProdotto());
				preparedStatement.setDouble(2, prodotto.getPrezzo());
				preparedStatement.setInt(3, prodotto.getQuantitaDisponibile());
				preparedStatement.setString(4, prodotto.getImagePath());
				preparedStatement.executeUpdate();
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public static List<Prodotto> getAllProdotti() {
		String sql = "SELECT * FROM Prodotti";
		List<Prodotto> listaProdotti = new ArrayList<>();
		try (Connection conn = connessione.connessioneDB()) {
			if (conn != null) {
				Statement statement = conn.createStatement();
				ResultSet rs = statement.executeQuery(sql);
				while (rs.next()) {
					Prodotto prodotto = new Prodotto();
					prodotto.setIdProdotto(rs.getInt("id"));
					prodotto.setNomeProdotto(rs.getString("nome_prodotto"));
					prodotto.setPrezzo(rs.getDouble("prezzo"));
					prodotto.setQuantitaDisponibile(rs.getInt("quantita_disponibile"));
					prodotto.setImagePath(rs.getString("image_path"));
					listaProdotti.add(prodotto);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return listaProdotti;
	}

	public static Prodotto getProdottoById(int id) {
		Prodotto prodotto = new Prodotto();
		String sql = "SELECT * FROM Prodotti WHERE id = ?";
		try (Connection conn = connessione.connessioneDB()) {
			if (conn != null) {
				PreparedStatement preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setInt(1, id);
				ResultSet rs = preparedStatement.executeQuery();
				while (rs.next()) {
					prodotto.setIdProdotto(rs.getInt("id"));
					prodotto.setNomeProdotto(rs.getString("nome_prodotto"));
					prodotto.setPrezzo(rs.getDouble("prezzo"));
					prodotto.setQuantitaDisponibile(rs.getInt("quantita_disponibile"));
					prodotto.setImagePath(rs.getString("image_path"));
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return prodotto;
	}
}



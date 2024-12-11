package com.entities;

public class Prodotto {
	private int idProdotto;
	private String nomeProdotto;
	private double prezzo;
	private int quantitaDisponibile;
	private String imagePath;
	private int quantitaSel;

	public Prodotto() {

	}

	public int getIdProdotto() {
		return idProdotto;
	}

	public void setIdProdotto(int idProdotto) {
		this.idProdotto = idProdotto;
	}

	public String getNomeProdotto() {
		return nomeProdotto;
	}

	public void setNomeProdotto(String nomeProdotto) {
		this.nomeProdotto = nomeProdotto;
	}

	public double getPrezzo() {
		return prezzo;
	}

	public void setPrezzo(double prezzo) {
		this.prezzo = prezzo;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public int getQuantitaDisponibile() {
		return quantitaDisponibile;
	}

	public void setQuantitaDisponibile(int quantitaDisponibile) {
		this.quantitaDisponibile = quantitaDisponibile;
	}

	public int getQuantitaSel() {
		return quantitaSel;
	}

	public void setQuantitaSel(int quantitaSel) {
		this.quantitaSel = quantitaSel;
	}
}

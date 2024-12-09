package com.entities;

public class Prodotto {
    private int idProdotto;
    private String nomeProdotto;
    private double prezzo;
    private int quantitaProdotto;
    private String imagePath;
    private int idUtente;
    private int idOrdine;

    public void Prodotto(){

    }

    public int getIdUtente() {
        return idUtente;
    }

    public void setIdUtente(int idUtente) {
        this.idUtente = idUtente;
    }

    public int getIdOrdine() {
        return idOrdine;
    }

    public void setIdOrdine(int idOrdine) {
        this.idOrdine = idOrdine;
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

    public int getQuantitaProdotto() {
        return quantitaProdotto;
    }

    public void setQuantitaProdotto(int quantitaProdotto) {
        this.quantitaProdotto = quantitaProdotto;
    }
}

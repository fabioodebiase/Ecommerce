<%@ page import="com.entities.Utente" %>
<%@ page import="com.entities.Prodotto" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>Carrello</title>
    <link rel="stylesheet" href="carrello.css">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            let plus = document.querySelectorAll(".plus");
            let minus = document.querySelectorAll(".minus");
            let quantitaProdottoBox = document.querySelectorAll(".quantitaIn");
            let quantitaMax = document.querySelectorAll(".quantitaMax");
            let prezzo = document.querySelectorAll(".product-price");
            let totale = document.getElementById("totale");

            // Funzione per aggiornare il totale
            function aggiornaTotale() {
                let calcoloTotale = 0;
                quantitaProdottoBox.forEach((input, index) => {
                    let currentValue = parseInt(input.value, 10) || 0;
                    let prezzoUnitario = parseFloat(prezzo[index].textContent.split(":")[1]); // Estrae il prezzo
                    calcoloTotale += currentValue * prezzoUnitario;

                });
                totale.textContent = calcoloTotale.toFixed(2); // Mostra il totale con due decimali

                // Aggiorna il campo hidden con il valore del totale
                document.querySelector("input[name='totale']").value = calcoloTotale.toFixed(2);
            }

            // Event listener per i pulsanti "plus"
            plus.forEach((button, index) => {
                button.addEventListener("click", function () {
                    let inputBox = quantitaProdottoBox[index];
                    let max = parseInt(quantitaMax[index].value, 10);
                    let currentValue = parseInt(inputBox.value, 10) || 0;

                    if (currentValue < max) {
                        inputBox.value = currentValue + 1;
                    }

                    aggiornaTotale();
                });
            });

            // Event listener per i pulsanti "minus"
            minus.forEach((button, index) => {
                button.addEventListener("click", function () {
                    let inputBox = quantitaProdottoBox[index];
                    let currentValue = parseInt(inputBox.value, 10) || 0;

                    if (currentValue > 1) {
                        inputBox.value = currentValue - 1;
                    }

                    aggiornaTotale();
                });
            });

            // Inizializza il totale all'avvio
            aggiornaTotale();
        });
    </script>
</head>
<body>
    <main>
        <div class="title-cart">
            <h1>Il tuo carrello</h1>
        </div>
        <%
        Utente utente = (Utente) session.getAttribute("user");
        int totale = 0;
        String emptyCart = "";
        String errore = (String) request.getAttribute("errore");
        List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");

        %>
            <div class="list-order">
                <form action="Ordine" method="POST">
                    <% if (carrello != null && !carrello.isEmpty()) { %>
                    <% for (Prodotto prodotto : carrello) {
                    %>
                    <div class = "product-container">
                        <img src="<%= request.getContextPath() %>/<%= prodotto.getImagePath() %>"
                             alt="<%= prodotto.getNomeProdotto() %>" width="200">
                        <div class="productDetails-container">
                            <div class="product-info">
                                <span class="product-name"><%= prodotto.getNomeProdotto() %></span>
                                <span class="product-price"> Prezzo: <%= prodotto.getPrezzo() %></span>
                            </div>
                            <div class = "quantity-container">

                                <div class = "quantityIn-container">
                                    <button type="button" class="minus">-</button>
                                    <input type="number" name="quantitaSel_<%=prodotto.getIdProdotto()%>" class="quantitaIn" min="1" max="<%= prodotto.getQuantitaDisponibile() %>" value="<%= prodotto.getQuantitaSel() %>" required readonly>
                                    <button type="button" class="plus">+</button>
                                </div>
                                <a class = "deleteProduct" href="EliminaProdottoInCarrello?idProdotto=<%= prodotto.getIdProdotto() %>">
                                    Rimuovi
                                </a>
                            </div>
                        </div>
                        <input type="hidden" name="quantitaDisp" value="<%= prodotto.getQuantitaDisponibile() %>" class="quantitaMax">
                        <input type="hidden" name="idProdotto" value="<%= prodotto.getIdProdotto() %>">

                    </div>


                </div>
                    <% } %>
                    <% } else {
                        emptyCart = "Il carrello e' vuoto."; %>
                    <p class="empty-cart"><%= emptyCart %></p>
                    <% } %>
                    <% if (carrello != null && !carrello.isEmpty()) { %>
                    <p class="total">Totale: <span id="totale" name="totale"><%= totale %></span></p>
                    <input type="hidden" name="totale" value="<%=totale%>">
                    <input type="submit" value="Procedi all'ordine" id="submitForm" class="botton-order">
                    <% } %>
                </form>
            <% if (errore != null){
            %>
            <p style = "color:red">Errore in ordine: <%=errore%></p>
            <% } %>
            <% if (utente != null && utente.getUsername().equals("admin")) { %>
            <a href="adminHome.jsp">Vai alla home</a>
            <% } else { %>
            <a href="home.jsp" class="botton-home">Vai alla home</a>
            <% } %>
    </main>
</body>
</html>
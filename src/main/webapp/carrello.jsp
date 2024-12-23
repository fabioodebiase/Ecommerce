<%@ page import="com.entities.Utente" %>
<%@ page import="com.entities.Prodotto" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>Carrello</title>
    <link rel="stylesheet" href="css/carrello.css">
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
                    console.log(calcoloTotale)
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
                    <img src="<%= request.getContextPath() %>/<%= prodotto.getImagePath() %>"
                         alt="<%= prodotto.getNomeProdotto() %>" width="200">
                    <div class="products">
                        <div class="product-info">
                            <p class="product-name">Prodotto: <%= prodotto.getNomeProdotto() %></p>
                            <p class="product-price"> Prezzo: <%= prodotto.getPrezzo() %></p>
                        </div>

                    </div>
                    <div>
                        <button type="button" class="plus">+</button>
                        <input type="number" name="quantitaSel_<%=prodotto.getIdProdotto()%>" class="quantitaIn" min="1" max="<%= prodotto.getQuantitaDisponibile() %>" value="<%= prodotto.getQuantitaSel() %>" required>
                        <button type="button" class="minus">-</button>


                        <input type="hidden" name="quantitaDisp" value="<%= prodotto.getQuantitaDisponibile() %>" class="quantitaMax">
                        <input type="hidden" name="idProdotto" value="<%= prodotto.getIdProdotto() %>">
                        <a href="EliminaProdottoInCarrello?idProdotto=<%= prodotto.getIdProdotto() %>">
                            <button type="button">Rimuovi</button>
                        </a>
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
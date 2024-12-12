<%@ page import="com.entities.Utente" %>
<%@ page import="com.entities.Prodotto" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>Carrello</title>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            let plus = document.querySelectorAll(".plus");
            let minus = document.querySelectorAll(".minus");
            let quantitaProdottoBox = document.querySelectorAll(".quantitaIn");
            let quantitaMax = document.querySelectorAll(".quantitaMax");
            let prezzo = document.querySelectorAll(".prezzo");
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
<%
Utente utente = (Utente) session.getAttribute("user");
int totale = 0;
List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
    %>
    <form action="Ordine" method="POST">
        <% if (carrello != null && !carrello.isEmpty()) { %>
        <% for (int i = 0; i < carrello.size(); i++) {
        Prodotto prodotto = carrello.get(i);
        %>
        <div>
            <p>Prodotto: <%= prodotto.getNomeProdotto() %></p>
            <p class="prezzo"> Prezzo: <%= prodotto.getPrezzo() %></p>
            <img src="<%= request.getContextPath() %>/<%= prodotto.getImagePath() %>"
                 alt="<%= prodotto.getNomeProdotto() %>" width="200">
        </div>
        <div>
            <button type="button" class="plus">+</button>
            <input type="number" name="quantitaProdotto" class="quantitaIn"
                   min="1" max="<%= prodotto.getQuantitaDisponibile() %>" value="<%= prodotto.getQuantitaSel() %>" required>
            <button type="button" class="minus">-</button>

            <input type="hidden" name="quantitaDisp" value="<%= prodotto.getQuantitaDisponibile() %>" class="quantitaMax">

            <a href="EliminaProdottoInCarrello?idProdotto=<%= prodotto.getIdProdotto() %>">
                <button type="button">Rimuovi</button>
            </a>
        </div>
        <% } %>
        <% } else { %>
        <p>Il carrello è vuoto.</p>
        <% } %>
        <p>Totale: <span id="totale" name="totale"><%= totale %></span></p>
        <input type="hidden" name="totale" value="<%=totale%>">
        <input type="submit" value="Procedi all'ordine" id="submitForm">
    </form>

    <% if (utente != null && utente.getUsername().equals("admin")) { %>
    <a href="adminHome.jsp">Vai alla home</a>
    <% } else { %>
    <a href="home.jsp">Vai alla home</a>
    <% } %>
</body>
</html>
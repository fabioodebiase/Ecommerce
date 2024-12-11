<%@ page import="com.entities.Utente" %>
<%@ page import="com.entities.Prodotto" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>Carrello</title>
</head>
<body>
<%
Utente utente = (Utente) session.getAttribute("user");
int totale = 0;
List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
    %>
    <form action="Ordine" method="POST">
        <% if (carrello != null && !carrello.isEmpty()) { %>
        <% for (Prodotto prodotto : carrello) { %>
        <div>
            <p>Prodotto: <%= prodotto.getNomeProdotto() %></p>
            <p>Prezzo: <%= prodotto.getPrezzo() %></p>
            <img src="<%= request.getContextPath() %>/<%= prodotto.getImagePath() %>"
                 alt="<%= prodotto.getNomeProdotto() %>" width="200">
        </div>
        <div>
            <a href="EliminaProdottoInCarrello?idProdotto=<%= prodotto.getIdProdotto() %>">
                <button type="button">Rimuovi</button>
            </a>

            <label for="quantitaProdotto">Quantita':</label>
            <input type="number" name="quantitaProdotto" id="quantitaProdotto"
                   min="1" value="<%= prodotto.getQuantitaSel() %>" required>
            <input type="hidden" name="quantitaDisp"
                   value="<%= prodotto.getQuantitaDisponibile() %>" id="quantitaDisp">
            <p id="errorMsg" style="color: red; display: none;">Selezionare una quantità valida!</p>
        </div>
        <% } %>
        <% } else { %>
        <p>Il carrello è vuoto.</p>
        <% } %>
        <p>Totale: <%= totale %></p>
        <input type="submit" value="Procedi all'ordine" id="submitForm">
    </form>
    <% if (utente != null && utente.getUsername().equals("admin")) { %>
    <a href="adminHome.jsp">Vai alla home</a>
    <% } else { %>
    <a href="home.jsp">Vai alla home</a>
    <% } %>

    <script>
        // Ottieni riferimenti agli elementi HTML
        const quantitaDisp = document.getElementById("quantitaDisp");
        const quantitaSel = document.getElementById("quantitaProdotto");
        const errorMsg = document.getElementById("errorMsg");
        const submit = document.getElementById("submitForm");

        // Aggiungi un listener all'input per controllare il valore
        quantitaSel.addEventListener("input", () => {
            // Ottieni il valore selezionato dall'utente
            const selectedValue = parseInt(quantitaSel.value, 10);
            const maxQuantita = parseInt(quantitaDisp.value, 10);

            // Controlla se la quantità è valida
            if (selectedValue > maxQuantita || selectedValue < 1 || isNaN(selectedValue)) {
                errorMsg.style.display = "block";
                submit.disabled = true;
            } else {
                errorMsg.style.display = "none";
                submit.disabled = false;
            }
        });
    </script>
</body>
</html>
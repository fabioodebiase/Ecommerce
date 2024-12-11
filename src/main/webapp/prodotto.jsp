<%@ page import="com.entities.Utente" %>
<%@ page import="com.entities.Prodotto" %>
<%@ page import="com.DAO.ProdottoDAO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <title>Shop</title>
</head>
<body>
<%
Utente user = (Utente) session.getAttribute("user");
Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
%>
<form action = "Carrello" method = "POST">
    <p><%=prodotto.getNomeProdotto()%></p>
    <p>Prezzo: <%=prodotto.getPrezzo()%></p>
    <p id = "quantitaDisp">Quantita' disponibili: <%=prodotto.getQuantitaDisponibile()%></p>

    <label for="quantitaProdotto"> Quantita':</label>
    <input type = "number" name = "quantitaProdotto" id = "quantitaProdotto" min = "1" required>

    <img src="<%=request.getContextPath()%>/<%= prodotto.getImagePath()%>" width="200">
    <p id="errorMsg" style="color: red; display: none;">Selezionare una quantita' valida!</p>

    <!--input hidden per passare parametri alla servlet del carrello -->
    <input type = "hidden" name = "idProdotto" value = "<%=prodotto.getIdProdotto()%>">
    <input type = "submit" value = "Aggiungi al carrello" id = "submitForm">
</form>
<script>
    // Ottieni riferimenti agli elementi HTML
    const quantitaDisp = document.getElementById("quantitaDisp");
    const quantitaSel = document.getElementById("quantitaProdotto");
    const errorMsg = document.getElementById("errorMsg");
    const submit = document.getElementById("submitForm");
    // Estrai il numero massimo di quantità disponibili
    const maxQuantita = parseInt(quantitaDisp.textContent.replace("Quantita' disponibili: ", ""), 10);

    // Aggiungi un listener all'input per controllare il valore
    quantitaSel.addEventListener("input", () => {
        // Ottieni il valore selezionato dall'utente
        const selectedValue = parseInt(quantitaSel.value, 10);

        // Controlla se la quantità è valida
        if (selectedValue > maxQuantita || selectedValue < 1 || isNaN(selectedValue)) {
            // Mostra il messaggio di errore
            errorMsg.style.display = "block";
            submit.disabled = true
        } else {
            // Nascondi il messaggio di errore
            errorMsg.style.display = "none";
            submit.disabled = false;
        }
    });
</script>
</body>
</html>
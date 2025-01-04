<%@ page import="com.DAO.OrdineDAO" %>
<%@ page import="com.entities.Ordine" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.entities.Utente" %>
<html>
<head>
    <title>Ordini</title>
</head>
<body>
<main>
    <div class="title-ordini">
        <h1>Lista Ordini</h1>
        <link rel="stylesheet" href="ordini.css">
    </div>
    <%
    Utente user = (Utente) session.getAttribute("user");
    ArrayList<Ordine> ordini = OrdineDAO.getStoricoOrdiniByIdUtente(user.getIdUtente());
    %>
    <div class="container">
        <% if (ordini == null || ordini.isEmpty()) { %>
        <div class="no-ordini">
            <h2>Non hai effettuato ordini al momento</h2>
        </div>
        <% } else {
        ArrayList<Ordine> dettagliOrdini = null;
        for (Ordine ordine : ordini) {
        dettagliOrdini = OrdineDAO.getDettagliStoricoOrdineByIdOrdineAndIdUtente(ordine.getIdOrdine(), user.getIdUtente());
        %>
        <div class="container-ordini">
            <div class="head-prodotti">
                <span>Id Ordine: <%= ordine.getIdOrdine() %></span>
                <span>Totale Ordine: <%= ordine.getTotaleOrdine() %></span>
            </div>
            <% for (Ordine ordineDettagli : dettagliOrdini) { %>
            <div class="details-ordine">
                <img class="image-prodotto" src="<%=request.getContextPath()%>/<%= ordineDettagli.getImagePath()%>">
                <div class="details-container">
                    <span><%= ordineDettagli.getNomeProdotto() %></span>
                    <span class="prezzo">Prezzo: <%= ordineDettagli.getPrezzo() %></span>
                    <span class="quantita">Quantità selezionata: <%= ordineDettagli.getQuantita() %></span>
                </div>
            </div>
            <% } %>
        </div>
        <%
        }
        } %>
    </div>
</main>
</body>
</html>
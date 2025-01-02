<%@ page import="com.DAO.OrdineDAO" %>
<%@ page import="com.entities.Ordine" %>
<%@ page import="java.util.ArrayList" %>

<html>
<head>
    <title>Ordini</title>
</head>
<body>
<main>
    <div class="title-ordini">
        <h1>Lista Ordini</h1>
        <link rel="stylesheet" href="ordiniAdmin.css">
    </div>
    <%
    ArrayList<Ordine> ordini = OrdineDAO.getAllOrdini();
    ArrayList<Ordine> dettagliOrdini = null;
        %>
        <div class = "container">
            <% for (Ordine ordine : ordini) {
            dettagliOrdini = OrdineDAO.getDettagliOrdineById(ordine.getIdOrdine()); %>
            <div class = "container-ordini">
                <div class = "head-prodotti">
                    <span>Id Ordine: <%= ordine.getIdOrdine() %></span>
                    <span>Ordine effettuato da: <%= ordine.getUsername() %></span>
                    <span>Totale Ordine: <%= ordine.getTotaleOrdine() %></span>
                </div>


                <% for (Ordine ordineDettagli : dettagliOrdini) { %>
                <div class = "details-ordine">
                    <img class = "image-prodotto" src = "<%=request.getContextPath()%>/<%= ordineDettagli.getImagePath()%>">
                    <div class = "details-container">
                        <span><%=ordineDettagli.getNomeProdotto() %></span>
                        <span class = "prezzo">Prezzo:<%=ordineDettagli.getPrezzo()%></span>
                        <span class = "quantita">Quantita' selezionata: <%=ordineDettagli.getQuantita()%></span>
                    </div>

                </div>


                <% } %>
            </div>
                <% } %>


        </div>
</main>
</body>
</html>
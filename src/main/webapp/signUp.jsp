<html>
<head>Registrazione</head>
<body>
<h1>Registrazione</h1>

<form action = "SignUp" method = "POST">
    <label for="username"> Username</label>
    <input type = "text" name = "username" id = "username">

    <label for="email"> Email</label>
    <input type = "email" name = "email" id = "email">


    <label for="password"> Password</label>
    <input type = "password" name = "password" id = "password">

    <input type = "submit" value = "Registrati">

    <%
    if (request.getAttribute("errore") != null){
    %>
    <p style = "color:red">Errore: <%= request.getAttribute("errore") %></p>
    <% } %>
</form>

</body>
</html>
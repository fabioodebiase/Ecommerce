<html>
<head>
    <title>Registrazione</title>
    <link rel="stylesheet" href="css/signUp.css">
</head>
<body>

<main>
    <h1>Registrazione</h1>
    <div class="container">
        <form action="SignUp" method="POST">
            <label for="username"> Username</label>
            <input type="text" name="username" id="username">
            <label for="email"> Email</label>
            <input type="email" name="email" id="email">
            <label for="password"> Password</label>
            <input type="password" name="password" id="password">
            <input type="submit" value="Registrati">
        </form>
        <%
        if (request.getAttribute("errore") != null){
        %>
        <p style="color:red">Errore: <%= request.getAttribute("errore") %></p>
        <% } %>
    </div>
</main>
</body>
</html>
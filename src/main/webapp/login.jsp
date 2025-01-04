<!DOCTYPE html>
<html lang="it">
<head>
    <title>Login</title>
    <link rel="stylesheet" href="login.css">
</head>
<body>
<div class = "container">
    <span class = "title">Accedi</span>
        <form action = "Login" method = "POST">
            <div class="container-login">
                <div class = "container-input">
                    <span class = "title-input"><label for = "email"> Email</label></span>
                    <input type = "email" class = "input" name = "email" id = "email">
                </div>
            <div class = "container-input">
                <span class = "title-input"><label for = "password"> Password</label></span>
                <input type = "password" class = "input" name = "password" id = "password">

            </div>
                <div class = "submit-container">
                    <input type = "submit" class = "submit" value = "Accedi">
                </div>
                <span>Non sei ancora registrato?
                    <a href="signUp.jsp">Clicca qui per registrarti</a>
                </span>
            </div>
        <%
        if (request.getAttribute("errore") != null) { %>
        <span class = "error" > <%= request.getAttribute("errore") %> </span>
        <% } %>
        </form>


</div>
</body>
</html>
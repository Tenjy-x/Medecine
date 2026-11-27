<%@ page contentType="text/html;charset=UTF-8" import="Model.Patient" %>
<%
    String ctx = request.getContextPath();
    Patient p = (Patient) request.getAttribute("patient");
    String sexe = "M".equals(p.getSexe()) ? "Masculin" : "F".equals(p.getSexe()) ? "Féminin" : "—";
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title></title>
</head>
<body>
<header><a href="<%= ctx %>/patients">🏥 Gestion des patients</a></header>
<main>
    <div class="carte">
        <h1><%= (p.getNomComplet()) %></h1>
        <img src = "<%= p.qrcodedir() %>">
        <dl>
            <dt>N° patient</dt><dd><%= p.getId() %></dd>
            <dt>Nom</dt><dd><%= (p.getNom()) %></dd>
            <dt>Prénom</dt><dd><%= (p.getPrenom()) %></dd>
            <dt>Date de naissance</dt><dd><%= p.getDateNaissance() %></dd>
            <dt>Sexe</dt><dd><%= sexe %></dd>
            <dt>Téléphone</dt><dd><%= p.getTelephone() == null ? "—" : (p.getTelephone()) %></dd>
            <dt>Email</dt><dd><%= p.getEmail() == null ? "—" : (p.getEmail()) %></dd>
            <dt>Adresse</dt><dd><%= p.getAdresse() == null ? "—" : (p.getAdresse()) %></dd>
        </dl>
        <div class="actions">
            <a class="btn btn-primaire" href="<%= ctx %>/patients/modifier?id=<%= p.getId() %>">Modifier</a>
            <a class="btn" href="<%= ctx %>/patients">Retour à la liste</a>
        </div>
    </div>
</main>
</body>
</html>

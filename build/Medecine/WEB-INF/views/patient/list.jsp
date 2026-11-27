<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" import="java.util.List, Model.Patient" %>
<%
    // Attribut envoyé par PatientController.liste() : mv.setAttribute("patients", patients)
    List<Patient> patients = (List<Patient>) request.getAttribute("patients");
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gestion des patients</title>
    <link rel="stylesheet" href="<%= ctx %>/assets/css/app.css">
</head>
<body>
<div class="carte">
    <div class="entete">
        <div>
            <h1>Liste des patients</h1>
            <p class="sous-titre">Consultez et gérez les dossiers des patients.</p>
        </div>
        <a class="btn btn-primaire" href="<%= ctx %>/patients/create">+ Nouveau patient</a>

    </div>

    <% if (patients == null || patients.isEmpty()) { %>
        <div class="vide">Aucun patient enregistré.</div>
    <% } else { %>
        <div class="table-conteneur">
        <table>
            <thead>
            <tr>
                <th>#</th><th>Nom</th><th>Prénom</th><th>Date de naissance</th><th>Sexe</th>
                <th>Téléphone</th><th>Email</th><th>Adresse</th><th></th>
            </tr>
            </thead>
            <tbody>
            <% for (Patient p : patients) { %>
            <tr>
                <td><%= p.getId() %></td>
                <td><%= p.getNom() %></td>
                <td><%= p.getPrenom() %></td>
                <td><%= p.getDateNaissance() %></td>
                <td><%= p.getSexe() != null ? p.getSexe() : "---" %></td>
                <td><%= p.getTelephone() != null ? p.getTelephone() : "---" %></td>
                <td><%= p.getEmail() != null ? p.getEmail() : "---" %></td>
                <td><%= p.getAdresse() != null ? p.getAdresse() : "---" %></td>
                <td>
                    <div class="actions">
                        <a class="btn" href="<%= ctx %>/patients/<%= p.getId()%>">Voir</a>
                        <a class="btn" href="<%= ctx %>/patients/update?id=<%= p.getId() %>">Modifier</a>
                        <form method="post" action="<%= ctx %>/patients/delete"
                              onsubmit="return confirm('Supprimer ce patient ?');">
                            <input type="hidden" name="id" value="<%= p.getId() %>">
                            <button class="btn btn-danger" type="submit">Supprimer</button>
                        </form>
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        </div>
        <div class="total"><%= patients.size() %> patient(s)</div>
    <% } %>
</div>
</body>
</html>

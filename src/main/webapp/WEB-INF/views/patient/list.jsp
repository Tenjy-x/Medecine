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
    <title>Patients</title>
    <style>
        body  { font-family: Arial, sans-serif; background: #f4f6f8; margin: 0; padding: 24px; color: #222; }
        .carte { max-width: 1000px; margin: 0 auto; background: #fff; border-radius: 8px;
                 padding: 24px; box-shadow: 0 1px 4px rgba(0,0,0,.08); }
        h1    { margin-top: 0; font-size: 22px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { text-align: left; padding: 10px 8px; border-bottom: 1px solid #e5e7eb; }
        th    { background: #f9fafb; font-size: 13px; text-transform: uppercase; color: #555; }
        tr:hover td { background: #f9fafb; }
        .vide { padding: 24px; text-align: center; color: #777; }
        .total { margin-top: 12px; color: #555; font-size: 14px; }
        .entete { display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px; }
        .entete h1 { margin: 0; }
        .btn  { display: inline-block; padding: 6px 12px; border: 1px solid #d1d5db; border-radius: 6px;
                background: #fff; color: #222; text-decoration: none; font-size: 14px; cursor: pointer; }
        .btn-primaire { background: #2563eb; border-color: #2563eb; color: #fff; }
        .btn-danger   { background: #dc2626; border-color: #dc2626; color: #fff; }
        .actions { display: flex; gap: 6px; }
        .actions form { margin: 0; }
    </style>
</head>
<body>
<div class="carte">
    <div class="entete">
        <h1>Liste des patients</h1>
        <a class="btn btn-primaire" href="<%= ctx %>/patients/create">+ Nouveau patient</a>

    </div>

    <% if (patients == null || patients.isEmpty()) { %>
        <div class="vide">Aucun patient enregistré.</div>
    <% } else { %>
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
        <div class="total"><%= patients.size() %> patient(s)</div>
    <% } %>
</div>
</body>
</html>

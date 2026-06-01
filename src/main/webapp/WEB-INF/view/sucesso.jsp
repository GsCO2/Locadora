<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>Locadora - Locação Confirmada</title>
<link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>

	<div class="menu-container"
		style="max-width: 500px; text-align: center;">
		<h1>LOCAÇÃO CONFIRMADA</h1>
		<p>SUA LOCAÇÃO FOI REGISTRADA COM SUCESSO</p>

		<hr
			style="border: 0; border-top: 1px solid rgba(255, 255, 255, 0.1); margin: 25px 0;">

		<div style="display: grid; grid-template-columns: 1fr; gap: 15px;">
			<a href="<c:url value='/relatorioLocacao?idLocacao=${idLocacao}'/>"
				class="btn-menu"> DESCRIÇÃO DA LOCAÇÃO </a> <a
				href="<c:url value='/'/>" class="btn-menu"
				style="background: rgba(255, 255, 255, 0.05);"> VOLTAR AO INÍCIO
			</a>
		</div>
	</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>Locadora - Clientes</title>
<link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>

	<div class="menu-container" style="max-width: 950px;">
		<h1>CLIENTES</h1>
		<p>LISTAGEM DE CLIENTES CADASTRADOS</p>

		<hr
			style="border: 0; border-top: 1px solid rgba(255, 255, 255, 0.1); margin-bottom: 25px;">

		<c:if test="${not empty clientes}">
			<div
				style="background: rgba(0, 0, 0, 0.2); border-radius: 10px; padding: 10px;">
				<table
					style="width: 100%; color: white; border-collapse: collapse; font-size: 0.85rem;">
					<thead>
						<tr style="border-bottom: 2px solid rgba(255, 255, 255, 0.1);">
							<th style="padding: 12px; text-align: left;">CPF</th>
							<th style="padding: 12px; text-align: left;">NOME</th>
							<th style="padding: 12px; text-align: left;">CNH</th>
							<th style="padding: 12px; text-align: left;">DATA NASC.</th>
							<th style="padding: 12px; text-align: left;">ENDEREÇO</th>
							<th style="padding: 12px; text-align: left;">CIDADE</th>
							<th style="padding: 12px; text-align: left;">HISTÓRICO</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="l" items="${clientes}">
							<tr style="border-bottom: 1px solid rgba(255, 255, 255, 0.05);">
								<td style="padding: 10px; font-weight: 600;">${l.cpf}</td>
								<td style="padding: 10px;">${l.nome}</td>
								<td style="padding: 10px;">${l.numeroHabilitacao}</td>
								<td style="padding: 10px;">${l.dataNascimento}</td>
								<td style="padding: 10px;">${l.logradouro},${l.numero},
									${l.cep}</td>
								<td style="padding: 10px;">${l.cidade}</td>
								<td style="padding: 10px;"><a
									href="<c:url value='/historicoLocatario?cpf=${l.cpf}'/>"
									class="btn-menu"
									style="padding: 5px 12px; font-size: 0.75rem; height: auto;">
										HISTÓRICO </a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>

		<div style="margin-top: 30px; text-align: left;">
			<a href="<c:url value='/gestao'/>"
				style="color: rgba(255, 255, 255, 0.4); text-decoration: none; font-size: 0.8rem;">←
				VOLTAR AO MENU</a>
		</div>
	</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>Locadora - Locações</title>
<link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>

	<div class="menu-container" style="max-width: 1000px;">
		<h1>LOCAÇÕES</h1>
		<p>LISTAGEM DE LOCAÇÕES REGISTRADAS</p>

		<form action="<c:url value='/locacoes'/>" method="get"
			style="text-align: left; margin-bottom: 20px;">
			<div
				style="display: grid; grid-template-columns: 2fr 1fr; gap: 15px; align-items: end;">
				<div>
					<label style="color: white; font-size: 0.8rem; font-weight: 600;">FILTRAR
						POR STATUS:</label> <select name="status"
						style="margin-top: 5px; width: 100%;">
						<option value="">TODAS</option>
						<option value="ATIVO"
							${statusSelecionado == 'ATIVO' ? 'selected' : ''}>ATIVO</option>
						<option value="CONCLUIDO"
							${statusSelecionado == 'CONCLUIDO' ? 'selected' : ''}>CONCLUÍDAS</option>
					</select>
				</div>
				<div>
					<button type="submit" class="btn-menu"
						style="width: 100%; height: 48px; background: rgba(255, 255, 255, 0.1);">
						FILTRAR</button>
				</div>
			</div>
		</form>

		<hr
			style="border: 0; border-top: 1px solid rgba(255, 255, 255, 0.1); margin-bottom: 20px;">

		<c:if test="${not empty locacoes}">
			<div
				style="background: rgba(0, 0, 0, 0.2); border-radius: 10px; padding: 10px;">
				<table
					style="width: 100%; color: white; border-collapse: collapse; font-size: 0.85rem;">
					<thead>
						<tr style="border-bottom: 2px solid rgba(255, 255, 255, 0.1);">
							<th style="padding: 12px; text-align: left;">CLIENTE</th>
							<th style="padding: 12px; text-align: left;">VEÍCULO</th>
							<th style="padding: 12px; text-align: left;">RETIRADA</th>
							<th style="padding: 12px; text-align: left;">DIAS</th>
							<th style="padding: 12px; text-align: left;">STATUS</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="l" items="${locacoes}">
							<tr style="border-bottom: 1px solid rgba(255, 255, 255, 0.05);">
								<td style="padding: 10px;"><span style="font-weight: 600;">${l.nome}</span><br>
									<span
									style="color: rgba(255, 255, 255, 0.5); font-size: 0.75rem;">${l.cpf}</span>
								</td>
								<td style="padding: 10px;"><span style="font-weight: 600;">${l.marca}
										${l.modelo}</span><br> <span
									style="color: rgba(255, 255, 255, 0.5); font-size: 0.75rem;">${l.placa}</span>
								</td>
								<td style="padding: 10px;">${l.dataRetirada}</td>
								<td style="padding: 10px;">${l.qtdDias}</td>
								<td style="padding: 10px;"><span
									style="background: rgba(255, 255, 255, 0.1); padding: 3px 8px; border-radius: 4px; font-size: 0.75rem;">
										${l.statusAluguel} </span></td>
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
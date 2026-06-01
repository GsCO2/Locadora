<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>Locadora - Veículos Disponíveis</title>
<link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>

	<div class="menu-container" style="max-width: 950px;">
		<h1>VEÍCULOS DISPONÍVEIS</h1>
		<p>CONFIRA NOSSOS CARROS DISPONÍVEIS PARA LOCAÇÃO</p>

		<form action="<c:url value='/carrosdisponiveis'/>" method="get"
			style="text-align: left; margin-bottom: 20px;">
			<div
				style="display: grid; grid-template-columns: 2fr 1fr; gap: 15px; align-items: end;">
				<div>
					<label style="color: white; font-size: 0.8rem; font-weight: 600;">FILTRAR
						POR CATEGORIA:</label> <select name="idCategoria"
						style="margin-top: 5px; width: 100%;">
						<option value="">TODAS AS CATEGORIAS</option>
						<c:forEach var="cat" items="${categorias}">
							<option value="${cat.codigo}"
								${idCategoriaSelecionada == cat.codigo ? 'selected' : ''}>
								${cat.nome}</option>
						</c:forEach>
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

		<c:if test="${not empty carros}">
			<div
				style="margin-top: 10px; background: rgba(0, 0, 0, 0.2); border-radius: 10px; padding: 10px;">
				<table
					style="width: 100%; color: white; border-collapse: collapse; font-size: 0.85rem;">
					<thead>
						<tr style="border-bottom: 2px solid rgba(255, 255, 255, 0.1);">
							<th style="padding: 12px; text-align: left;">MARCA</th>
							<th style="padding: 12px; text-align: left;">MODELO</th>
							<th style="padding: 12px; text-align: left;">ANO</th>
							<th style="padding: 12px; text-align: left;">CATEGORIA</th>
							<th style="padding: 12px; text-align: left;">COMBUSTÍVEL</th>
							<th style="padding: 12px; text-align: left;">CÂMBIO</th>
							<th style="padding: 12px; text-align: left;">DIÁRIA</th>
							<th style="padding: 12px; text-align: left;">AÇÃO</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="v" items="${carros}">
							<tr style="border-bottom: 1px solid rgba(255, 255, 255, 0.05);">
								<td style="padding: 10px; font-weight: 600;">${v.marca}</td>
								<td style="padding: 10px;">${v.modelo}</td>
								<td style="padding: 10px;">${v.ano}</td>
								<td style="padding: 10px;"><span
									style="background: rgba(255, 255, 255, 0.1); padding: 3px 8px; border-radius: 4px; font-size: 0.75rem;">
										${v.categoria} </span></td>
								<td style="padding: 10px;">${v.combustivel}</td>
								<td style="padding: 10px;">${v.cambio}</td>
								<td style="padding: 10px; font-weight: 600;">R$ ${v.diaria}</td>
								<td style="padding: 10px;">
									<form action="<c:url value='/aluguel'/>" method="post">
										<input type="hidden" name="placa" value="${v.placa}">
										<button type="submit" class="btn-menu"
											style="padding: 5px 12px; font-size: 0.75rem; height: auto;">
											ALUGAR</button>
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>

		<div style="margin-top: 30px; text-align: left;">
			<a href="<c:url value='/'/>"
				style="color: rgba(255, 255, 255, 0.4); text-decoration: none; font-size: 0.8rem;">←
				VOLTAR AO MENU</a>
		</div>
	</div>

</body>
</html>
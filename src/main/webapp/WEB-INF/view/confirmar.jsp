<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>Locadora - Confirmar Locação</title>
<link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>

	<div class="menu-container" style="max-width: 700px;">
		<h1>CONFIRMAR LOCAÇÃO</h1>
		<p>REVISE OS DADOS ANTES DE CONFIRMAR</p>

		<hr
			style="border: 0; border-top: 1px solid rgba(255, 255, 255, 0.1); margin-bottom: 25px;">

		<%-- Resumo --%>
		<div
			style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 25px;">
			<div
				style="background: rgba(0, 0, 0, 0.2); border-radius: 10px; padding: 15px;">
				<p
					style="color: rgba(255, 255, 255, 0.5); font-size: 0.75rem; margin-bottom: 8px;">CLIENTE</p>
				<p style="color: white; font-weight: 600; margin-bottom: 4px;">${locatario.nome}</p>
				<p style="color: rgba(255, 255, 255, 0.6); font-size: 0.85rem;">CPF:
					${locatario.cpf}</p>
			</div>
			<div
				style="background: rgba(0, 0, 0, 0.2); border-radius: 10px; padding: 15px;">
				<p
					style="color: rgba(255, 255, 255, 0.5); font-size: 0.75rem; margin-bottom: 8px;">VEÍCULO</p>
				<p style="color: white; font-weight: 600; margin-bottom: 4px;">${carro.marca}
					${carro.modelo}</p>
				<p style="color: rgba(255, 255, 255, 0.6); font-size: 0.85rem;">Categoria:
					${carro.categoria.nome}</p>
				<p style="color: rgba(255, 255, 255, 0.6); font-size: 0.85rem;">Diária:
					R$ ${carro.categoria.valor}</p>
			</div>
		</div>

		<form action="<c:url value='/aluguel/finalizar'/>" method="post"
			style="text-align: left;">
			<input type="hidden" name="placa" value="${carro.placa}"> <input
				type="hidden" name="cpf" value="${locatario.cpf}">

			<div
				style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 25px;">
				<div>
					<label style="color: white; font-size: 0.8rem; font-weight: 600;">DATA
						DE RETIRADA:</label> <input type="date" name="dataRetirada" required
						style="width: 100%; margin-top: 5px;">
				</div>
				<div>
					<label style="color: white; font-size: 0.8rem; font-weight: 600;">PERÍODO
						(DIAS):</label> <input type="number" name="qtdDias" min="1" value="1"
						required style="width: 100%; margin-top: 5px;">
				</div>
			</div>

			<c:if test="${not empty erro}">
				<div
					style="color: #ff7675; background: rgba(231, 76, 60, 0.2); padding: 10px; border-radius: 5px; margin-bottom: 15px;">
					${erro}</div>
			</c:if>

			<c:if test="${not empty saida}">
				<div
					style="color: #fff; background: rgba(46, 204, 113, 0.2); padding: 10px; border-radius: 5px; margin-bottom: 15px;">
					${saida}</div>
			</c:if>

			<button type="submit" class="btn-menu"
				style="width: 100%; height: 48px;">CONFIRMAR LOCAÇÃO</button>
		</form>

		<div style="margin-top: 30px; text-align: left;">
			<a href="<c:url value='/carrosdisponiveis'/>"
				style="color: rgba(255, 255, 255, 0.4); text-decoration: none; font-size: 0.8rem;">←
				VOLTAR</a>
		</div>
	</div>

</body>
</html>
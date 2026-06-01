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

	<div class="menu-container" style="max-width: 850px;">
		<h1>REGISTRO</h1>
		<p>REALIZE SEU REGISTRO PARA CONTINUAR COM A LOCAÇÃO</p>

		<form action="<c:url value='/locatario'/>" method="post"
			style="text-align: left;">
			<input type="hidden" name="placa" value="${placa}">

			<div
				style="display: grid; grid-template-columns: 1fr 2fr; gap: 15px; margin-bottom: 15px;">
				<div>
					<label style="color: white; font-size: 0.8rem; font-weight: 600;">CPF
						(ID):</label> <input type="text" name="cpf" value="${cpf}"
						placeholder="Apenas números" maxlength="11" pattern="[0-9]{11}"
						oninput="this.value=this.value.replace(/[^0-9]/g,'')" required
						style="width: 100%; margin-top: 5px;">
				</div>

				<div>
					<label style="color: white; font-size: 0.8rem; font-weight: 600;">NOME
						COMPLETO:</label> <input type="text" name="nome" value="${locatario.nome}"
						placeholder="Nome do Cliente" required
						style="width: 100%; margin-top: 5px;">
				</div>
			</div>

			<div
				style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 15px;">
				<div>
					<label style="color: white; font-size: 0.8rem; font-weight: 600;">Nº
						HABILITAÇÃO (CNH):</label> <input type="text" name="numeroHabilitacao"
						value="${locatario.numeroHabilitacao}" maxlength="11"
						pattern="[0-9]{11}" placeholder="Apenas números"
						oninput="this.value=this.value.replace(/[^0-9]/g,'')" required
						style="width: 100%; margin-top: 5px;">
				</div>

				<div>
					<label style="color: white; font-size: 0.8rem; font-weight: 600;">DATA
						DE NASCIMENTO:</label> <input type="date" name="dataNascimento"
						value="${locatario.dataNascimento}" required
						style="width: 100%; margin-top: 5px;">
				</div>
			</div>

			<hr
				style="border: 0; border-top: 1px solid rgba(255, 255, 255, 0.1); margin: 20px 0;">

			<div
				style="display: grid; grid-template-columns: 2fr 1fr; gap: 15px; margin-bottom: 15px;">
				<div>
					<label style="color: white; font-size: 0.8rem; font-weight: 600;">LOGRADOURO:</label>
					<input type="text" name="logradouro"
						value="${locatario.logradouro}" required
						style="width: 100%; margin-top: 5px;">
				</div>

				<div>
					<label style="color: white; font-size: 0.8rem; font-weight: 600;">NÚMERO:</label>
					<input type="text" name="numero"
						value="${locatario.numero != 0 ? locatario.numero : ''}"
						pattern="[0-9]+" inputmode="numeric"
						oninput="this.value=this.value.replace(/[^0-9]/g,'')" required
						style="width: 100%; margin-top: 5px;">
				</div>
			</div>

			<div
				style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 30px;">
				<div>
					<label style="color: white; font-size: 0.8rem; font-weight: 600;">CEP:</label>
					<input type="text" name="cep" value="${locatario.cep}"
						maxlength="8" pattern="[0-9]{8}" placeholder="Apenas números"
						oninput="this.value=this.value.replace(/[^0-9]/g,'')" required
						style="width: 100%; margin-top: 5px;">
				</div>

				<div>
					<label style="color: white; font-size: 0.8rem; font-weight: 600;">CIDADE:</label>
					<input type="text" name="cidade" value="${locatario.cidade}"
						required style="width: 100%; margin-top: 5px;">
				</div>
			</div>

			<div
				style="display: flex; justify-content: center; margin-bottom: 20px;">
				<button type="submit" name="acao" value="Continuar" class="btn-menu"
					style="width: 250px; height: 45px;">CONTINUAR</button>
			</div>

		</form>

		<c:if test="${not empty erro}">
			<div
				style="color: #ff7675; background: rgba(231, 76, 60, 0.2); padding: 10px; border-radius: 5px; margin-bottom: 15px;">
				${erro}</div>
		</c:if>

		<div style="margin-top: 30px; text-align: left;">
			<a href="<c:url value='/aluguel'/>"
				style="color: rgba(255, 255, 255, 0.4); text-decoration: none; font-size: 0.8rem;">
				← VOLTAR </a>
		</div>

	</div>

</body>
</html>
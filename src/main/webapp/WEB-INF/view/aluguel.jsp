<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>Locadora - Identificação do Cliente</title>
<link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>

    <div class="menu-container" style="max-width: 500px;">
        <h1>IDENTIFICAÇÃO</h1>
        <p>INFORME SEU CPF PARA CONTINUAR COM A LOCAÇÃO</p>

        <hr style="border: 0; border-top: 1px solid rgba(255,255,255,0.1); margin-bottom: 25px;">

        <form action="<c:url value='/aluguel'/>" method="post" style="text-align: left;">
            <input type="hidden" name="placa" value="${placa}">

            <div style="margin-bottom: 20px;">
                <label style="color: white; font-size: 0.8rem; font-weight: 600;">CPF:</label>
                <input type="text" name="cpf" value="${cpf}"
						placeholder="Apenas números" maxlength="11" pattern="[0-9]{11}"
						oninput="this.value=this.value.replace(/[^0-9]/g,'')" required
						style="width: 100%; margin-top: 5px;">
            </div>

            <c:if test="${not empty erro}">
                <div style="color: #ff7675; background: rgba(231, 76, 60, 0.2); padding: 10px; border-radius: 5px; margin-bottom: 15px;">
                    ${erro}
                </div>
            </c:if>

            <button type="submit" class="btn-menu" style="width: 100%; height: 48px;">
                CONTINUAR
            </button>
        </form>

        <div style="margin-top: 30px; text-align: left;">
            <a href="<c:url value='/carrosdisponiveis'/>"
                style="color: rgba(255,255,255,0.4); text-decoration: none; font-size: 0.8rem;">← VOLTAR</a>
        </div>
    </div>

</body>
</html>
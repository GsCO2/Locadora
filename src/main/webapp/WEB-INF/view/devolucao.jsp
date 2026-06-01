<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Devolução - Locadora</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>

    <div class="menu-container">
        <h1>DEVOLUÇÃO</h1>
        <p>TELA DE DEVOLUCAO E VISTORIA DO VEICULO</p>

        <form action="devolucao" method="post" style="text-align: left;">
            <div style="margin-bottom: 20px;">
                <label style="color: white; font-weight: 600;">VEÍCULOS ALUGADOS:</label>
                <select name="placa_selecionada" required style="margin-top:5px;">
                    <option value="">Selecione um carro</option>
                    <c:forEach var="a" items="${alugueisAtivos}">
                        <option value="${a.carro.placa}" style="color: black;">
                            ${a.carro.placa} - ${a.carro.modelo} (Cliente: ${a.locatario.nome})
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div style="margin-bottom: 20px;">
                <label style="color: white; font-weight: 600;">LITROS FALTANTES:</label>
                <input type="number" name="litrosFaltantes" value="0" min="0" step="1" style="margin-top:5px;">
            </div>

            <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 25px;">
                <input type="checkbox" name="enviarOficina" id="oficina" style="width: 20px; height: 20px; accent-color: #2ecc71;">
                <label for="oficina" style="color: white; font-weight: 600; cursor: pointer;">ENVIAR PARA REPARO</label>
            </div>

            <button type="submit" name="acao" value="Finalizar" class="btn-menu" style="width: 100%; background: #343a40;">
                CALCULAR TOTAL
            </button>
        </form>

        <c:if test="${not empty saida}"><div style="color: #2ecc71; margin-top: 15px; font-weight: bold;">${saida}</div></c:if>
        <c:if test="${not empty erro}"><div style="color: #ff7675; margin-top: 15px; font-weight: bold;">${erro}</div></c:if>

        <div style="margin-top: 30px; text-align: left;">
            <a href="<c:url value='/gestao'/>" style="color: #adb5bd; text-decoration: none; font-size: 0.8rem;">← VOLTAR AO MENU</a>
        </div>
    </div>

</body>
</html>
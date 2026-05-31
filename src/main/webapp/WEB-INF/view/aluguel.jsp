<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Aluguel | Locadora Elite</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body style="color: white;">
    <div class="menu-container" style="max-width: 900px;">
        <h1>REGISTRAR LOCAÇÃO</h1>
        <p>GESTÃO DE CONTRATOS ATIVOS</p>

        <form action="aluguel" method="post" style="text-align: left;">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px;">
                <div>
                    <label style="font-weight: 600; font-size: 0.8rem;">CARRO DISPONÍVEL:</label>
                    <select name="placa_carro" required style="margin-top: 5px;">
                        <option value="">Selecione o veículo...</option>
                        <c:forEach var="car" items="${carrosDisponiveis}">
                            <option value="${car.placa}" style="color: black;">${car.placa} - ${car.modelo}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label style="font-weight: 600; font-size: 0.8rem;">CPF DO CLIENTE:</label>
                    <div style="display: flex; gap: 10px; margin-top: 5px;">
                        <input type="text" name="cpf_locatario" value="${locatarioEncontrado.cpf}" placeholder="Apenas números" required style="flex: 1; margin: 0;">
                        <button type="submit" name="acao" value="Verificar Cliente" class="btn-menu" style="width: 100px; height: 48px; background: #343a40; font-size: 0.7rem; padding: 0;">VERIFICAR</button>
                    </div>
                    <c:if test="${not empty locatarioEncontrado}">
                        <p style="color: #2ecc71; margin-top: 5px; font-size: 0.8rem; font-weight: bold;">✓ ${locatarioEncontrado.nome}</p>
                    </c:if>
                </div>
            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 15px; margin-bottom: 25px;">
                <div>
                    <label style="font-weight: 600; font-size: 0.8rem;">DATA RETIRADA:</label>
                    <input type="date" name="data_retirada" required style="margin-top: 5px;">
                </div>
                <div>
                    <label style="font-weight: 600; font-size: 0.8rem;">PERÍODO (DIAS):</label>
                    <input type="number" name="qtd_dias" min="1" value="1" style="margin-top: 5px;">
                </div>
                <div style="display: flex; align-items: center; padding-top: 25px;">
                    <input type="checkbox" name="tanque_cheio" checked style="width:20px; height:20px; accent-color: #2ecc71;">
                    <label style="margin-left:10px; font-weight: 600; font-size: 0.8rem;">TANQUE CHEIO</label>
                </div>
            </div>

            <button type="submit" name="acao" value="Confirmar Aluguel" class="btn-menu" style="width: 100%; background: #343a40; border-color: #495057;">CONFIRMAR LOCAÇÃO</button>
        </form>

        <c:if test="${not empty saida}"><p style="color: #2ecc71; font-weight: bold; margin-top: 15px;">${saida}</p></c:if>
        <c:if test="${not empty erro}"><p style="color: #ff7675; font-weight: bold; margin-top: 15px;">${erro}</p></c:if>

        <h3 style="margin-top: 40px; border-bottom: 1px solid #495057; padding-bottom: 5px; font-size: 0.9rem;">LOCAÇÕES REGISTRADAS</h3>
        <div style="overflow-x: auto; margin-top: 10px;">
            <table>
                <thead>
                    <tr>
                        <th>DATA</th>
                        <th>PLACA</th>
                        <th>CLIENTE</th>
                        <th>AÇÃO</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="a" items="${alugueis}">
                        <tr>
                            <td style="padding: 10px;">${a.dataRetirada}</td>
                            <td>${a.carro.placa}</td>
                            <td>${a.locatario.nome}</td>
                            <td style="text-align: center;">
                                <form action="aluguel" method="post" onsubmit="return confirm('Excluir esta locação?');">
                                    <input type="hidden" name="id_aluguel" value="${a.id}">
                                    <button type="submit" name="acao" value="Excluir" style="background: #ff7675; color: white; border: none; padding: 5px 12px; border-radius: 4px; cursor: pointer; font-size: 0.7rem; font-weight: bold;">EXCLUIR</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div style="margin-top: 30px; text-align: left;"><a href="<c:url value='/'/>" style="color: #adb5bd; text-decoration: none; font-size: 0.8rem;">← VOLTAR AO MENU</a></div>
    </div>
</body>
</html>
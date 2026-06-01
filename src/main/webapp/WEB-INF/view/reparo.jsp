<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Oficina | Locadora Elite</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>

    <div class="menu-container" style="max-width: 900px;">
        <h1>OFICINA E REPAROS</h1>
        <p>GESTÃO DE MANUTENÇÃO</p>

        <form action="reparo" method="post" style="text-align: left;">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px;">
                <div>
                    <label style="color: white; font-weight: 600;">VEÍCULO:</label>
                    <select name="placa_carro" required style="margin-top:5px;">
                        <option value="">Selecione o veículo</option>
                        <c:forEach var="car" items="${carrosOficina}">
                            <option value="${car.placa}" style="color: black;">${car.placa} - ${car.modelo}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label style="color: white; font-weight: 600;">VALOR DO REPARO (R$):</label>
                    <input type="text" name="valor_reparo" placeholder="Ex: 250.00" required style="margin-top:5px;">
                </div>
            </div>

            <div style="display: grid; grid-template-columns: 1fr 2fr; gap: 20px; margin-bottom: 25px;">
                <div>
                    <label style="color: white; font-weight: 600;">PRAZO (DIAS):</label>
                    <input type="number" name="prazo_dias" value="1" min="1" required style="margin-top:5px;">
                </div>
                <div>
                    <label style="color: white; font-weight: 600;">DESCRIÇÃO:</label>
                    <input type="text" name="descricao" placeholder="Ex: Troca de pneus" required style="margin-top:5px;">
                </div>
            </div>

            <button type="submit" name="acao" value="Registrar Reparo" class="btn-menu" style="width: 100%; background: #343a40;">
                CONFIRMAR ENTRADA NA OFICINA
            </button>
        </form>

        <c:if test="${not empty saida}"><div style="color: #2ecc71; margin: 10px 0;">${saida}</div></c:if>
        <c:if test="${not empty erro}"><div style="color: #ff7675; margin: 10px 0;">${erro}</div></c:if>

        <h3 style="color: white; margin-top: 40px; font-size: 0.9rem; border-bottom: 1px solid #495057; padding-bottom: 5px;">VEÍCULOS EM MANUTENÇÃO</h3>
        <div style="overflow-x: auto; margin-top: 10px;">
            <table>
                <thead>
                    <tr>
                        <th>CARRO</th>
                        <th>ENTRADA</th>
                        <th>PRAZO</th>
                        <th>DESCRIÇÃO</th>
                        <th>VALOR</th>
                        <th>AÇÃO</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="r" items="${reparos}">
                        <tr>
                            <td>${r.carro.placa} - ${r.carro.modelo}</td>
                            <td>${r.dataEntrada}</td>
                            <td>${r.prazoDias} dias</td>
                            <td>${r.descricao}</td>
                            <td>R$ ${r.valorReparo}</td>
                            <td style="text-align: center;">
                                <form action="reparo" method="post" style="margin: 0;">
                                    <input type="hidden" name="id_reparo" value="${r.id}">
                                    <button type="submit" name="acao" value="Finalizar" 
                                            style="background: #2ecc71; color: #000; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer; font-weight: bold; font-size: 0.7rem;">
                                        CONCLUIR
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div style="margin-top: 30px; text-align: left;">
            <a href="<c:url value='/gestao'/>" style="color: #adb5bd; text-decoration: none; font-size: 0.8rem;">← VOLTAR AO MENU</a>
        </div>
    </div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Oficina | Locadora</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>

    <div class="menu-container" style="max-width: 900px;">
        <h1>OFICINA E REPAROS</h1>
        <p>GESTÃO DE MANUTENÇÃO</p>

        <form action="<c:url value='/reparo'/>" method="post" style="text-align: left;">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px;">
                <div>
                    <label style="color: white; font-size: 0.8rem; font-weight: 600;">VEÍCULO:</label>
                    <select name="placa_carro" required style="margin-top: 5px;">
                        <option value="">Selecione o veículo</option>
                        <c:forEach var="car" items="${carrosOficina}">
                            <option value="${car.placa}">${car.placa} - ${car.modelo}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label style="color: white; font-size: 0.8rem; font-weight: 600;">VALOR DO REPARO (R$):</label>
                    <input type="text" name="valor_reparo" placeholder="Ex: 250.00" required style="margin-top: 5px;">
                </div>
            </div>

            <div style="display: grid; grid-template-columns: 1fr 2fr; gap: 20px; margin-bottom: 25px;">
                <div>
                    <label style="color: white; font-size: 0.8rem; font-weight: 600;">PRAZO (DIAS):</label>
                    <input type="number" name="prazo_dias" value="1" min="1" required style="margin-top: 5px;">
                </div>
                <div>
                    <label style="color: white; font-size: 0.8rem; font-weight: 600;">DESCRIÇÃO:</label>
                    <input type="text" name="descricao" placeholder="Ex: Troca de pneus" required style="margin-top: 5px;">
                </div>
            </div>

            <button type="submit" name="acao" value="Registrar Reparo" class="btn-menu" style="width: 100%;">
                CONFIRMAR ENTRADA NA OFICINA
            </button>
        </form>

        <c:if test="${not empty saida}">
            <div style="color: #fff; background: rgba(46, 204, 113, 0.2); padding: 10px; border-radius: 5px; margin-top: 15px;">
                ${saida}
            </div>
        </c:if>
        <c:if test="${not empty erro}">
            <div style="color: #ff7675; background: rgba(231, 76, 60, 0.2); padding: 10px; border-radius: 5px; margin-top: 15px;">
                ${erro}
            </div>
        </c:if>

        <hr style="border: 0; border-top: 1px solid rgba(255,255,255,0.1); margin: 25px 0;">

        <div style="display: grid; grid-template-columns: 2fr 1fr; align-items: center; margin-bottom: 15px;">
            <p style="color: white; font-size: 0.9rem; font-weight: 600; margin: 0;">VEÍCULOS EM MANUTENÇÃO</p>
            <a href="<c:url value='/relatorioReparos'/>" class="btn-menu"
                style="text-align: center; font-size: 0.75rem; height: auto; padding: 8px 12px;">
                RELATÓRIO DE REPAROS
            </a>
        </div>

        <c:if test="${not empty reparos}">
            <div style="background: rgba(0,0,0,0.2); border-radius: 10px; padding: 10px;">
                <table style="width: 100%; color: white; border-collapse: collapse; font-size: 0.85rem;">
                    <thead>
                        <tr style="border-bottom: 2px solid rgba(255,255,255,0.1);">
                            <th style="padding: 12px; text-align: left;">CARRO</th>
                            <th style="padding: 12px; text-align: left;">ENTRADA</th>
                            <th style="padding: 12px; text-align: left;">PRAZO</th>
                            <th style="padding: 12px; text-align: left;">DESCRIÇÃO</th>
                            <th style="padding: 12px; text-align: left;">VALOR</th>
                            <th style="padding: 12px; text-align: left;">AÇÃO</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${reparos}">
                            <tr style="border-bottom: 1px solid rgba(255,255,255,0.05);">
                                <td style="padding: 10px; font-weight: 600;">${r.carro.placa} - ${r.carro.modelo}</td>
                                <td style="padding: 10px;">${r.dataEntrada}</td>
                                <td style="padding: 10px;">${r.prazoDias} dias</td>
                                <td style="padding: 10px;">${r.descricao}</td>
                                <td style="padding: 10px;">R$ ${r.valorReparo}</td>
                                <td style="padding: 10px;">
                                    <form action="<c:url value='/reparo'/>" method="post" style="margin: 0;">
                                        <input type="hidden" name="id_reparo" value="${r.id}">
                                        <button type="submit" name="acao" value="Finalizar" class="btn-menu"
                                            style="padding: 5px 12px; font-size: 0.75rem; height: auto;">
                                            CONCLUIR
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        <div style="margin-top: 30px; text-align: left;">
            <a href="<c:url value='/gestao'/>"
                style="color: rgba(255,255,255,0.4); text-decoration: none; font-size: 0.8rem;">← VOLTAR AO MENU</a>
        </div>
    </div>

</body>
</html>
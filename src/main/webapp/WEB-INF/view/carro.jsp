<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Locadora - Veiculos</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>

    <div class="menu-container" style="max-width: 950px;"> <h1>VEÍCULOS</h1>
        <p>TELA DE GERENCIAMENTO DE VEÍCULOS</p>

        <form action="<c:url value='/carro'/>" method="post" style="text-align: left;">
            
			<div style="display: grid; grid-template-columns: 2fr 1fr; gap: 20px; margin-bottom: 20px;">
			    <div>
			        <label style="color: white; font-size: 0.8rem; font-weight: 600;">PLACA (ID):</label>
			        <div style="display: flex; gap: 10px; margin-top: 5px;">
			            <input type="text" name="placa" placeholder="ABC1D23" value="${carro.placa}" style="flex: 1; margin: 0;">
			            <button type="submit" name="acao" value="Buscar" class="btn-menu" 
			                    style="width: 100px; padding: 0; height: 48px; background: rgba(255,255,255,0.1);">BUSCAR</button>
			        </div>
			    </div>
			
			    <div>
			        <label style="color: white; font-size: 0.8rem; font-weight: 600;">STATUS:</label>
			        <select name="status" style="margin-top: 5px; width: 100%;">
			            <option value="DISPONIVEL" ${carro.status == 'DISPONIVEL' ? 'selected' : ''}>DISPONÍVEL</option>
			            <option value="ALUGADO" ${carro.status == 'ALUGADO' ? 'selected' : ''}>ALUGADO</option>
			            <option value="REPARO" ${carro.status == 'REPARO' ? 'selected' : ''}>EM REPARO</option>
			        </select>
			    </div>
			</div>

            <hr style="border: 0; border-top: 1px solid rgba(255,255,255,0.1); margin-bottom: 20px;">

            <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 15px; margin-bottom: 20px;">
                <div>
                    <label style="color: white; font-size: 0.8rem; font-weight: 600;">MARCA:</label>
                    <input type="text" name="marca" value="${carro.marca}" placeholder="Ex: VW, Ford" style="width: 100%; margin-top: 5px;">
                </div>
                <div>
                    <label style="color: white; font-size: 0.8rem; font-weight: 600;">MODELO:</label>
                    <input type="text" name="modelo" value="${carro.modelo}" placeholder="Ex: Gol, Ka" style="width: 100%; margin-top: 5px;">
                </div>
                <div>
                    <label style="color: white; font-size: 0.8rem; font-weight: 600;">COR:</label>
                    <input type="text" name="cor" value="${carro.cor}" placeholder="Ex: Preto" style="width: 100%; margin-top: 5px;">
                </div>
            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 20px;">
                <div>
                    <label style="color: white; font-size: 0.8rem; font-weight: 600;">ANO DE FABRICAÇÃO:</label>
                    <input type="number" name="ano" value="${carro.ano}" placeholder="2024" style="width: 100%; margin-top: 5px;">
                </div>
                <div>
                    <label style="color: white; font-size: 0.8rem; font-weight: 600;">QUILOMETRAGEM (KM):</label>
                    <input type="number" name="quilometragem" value="${carro.quilometragem}" placeholder="0" style="width: 100%; margin-top: 5px;">
                </div>
            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 15px; margin-bottom: 30px;">
                <div>
                    <label style="color: white; font-size: 0.8rem; font-weight: 600;">CATEGORIA:</label>
                    <select name="id_categoria" style="margin-top: 5px;">
                        <c:forEach var="cat" items="${listaCategorias}">
                            <option value="${cat.codigo}" ${carro.categoria.codigo == cat.codigo ? 'selected' : ''}>${cat.nome}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label style="color: white; font-size: 0.8rem; font-weight: 600;">CÂMBIO:</label>
                    <select name="id_cambio" style="margin-top: 5px;">
                        <c:forEach var="cam" items="${listaCambios}">
                            <option value="${cam.id}" ${carro.tipoCambio.id == cam.id ? 'selected' : ''}>${cam.descricao}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label style="color: white; font-size: 0.8rem; font-weight: 600;">COMBUSTÍVEL:</label>
                    <select name="id_combustivel" style="margin-top: 5px;">
                        <c:forEach var="com" items="${listaCombustiveis}">
                            <option value="${com.id}" ${carro.tipoCombustivel.id == com.id ? 'selected' : ''}>${com.nome}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; margin-bottom: 20px;">
                <button type="submit" name="acao" value="Inserir" class="btn-menu" style="border-color: rgba(255,255,255,0.3);">INSERIR</button>
                <button type="submit" name="acao" value="Atualizar" class="btn-menu" style="border-color: rgba(255,255,255,0.3);">ATUALIZAR</button>
                <button type="submit" name="acao" value="Excluir" class="btn-menu" style="border-color: rgba(255,255,255,0.3);">EXCLUIR</button>
                <button type="submit" name="acao" value="Listar" class="btn-menu" style="border-color: rgba(255,255,255,0.3);">LISTAR</button>
            </div>
        </form>

        <c:if test="${not empty saida}">
            <div style="color: #fff; background: rgba(46, 204, 113, 0.2); padding: 10px; border-radius: 5px; margin-bottom: 10px;">${saida}</div>
        </c:if>
        <c:if test="${not empty erro}">
            <div style="color: #ff7675; background: rgba(231, 76, 60, 0.2); padding: 10px; border-radius: 5px; margin-bottom: 10px;">${erro}</div>
        </c:if>

        <c:if test="${not empty carros}">
            <div style="margin-top: 25px; background: rgba(0,0,0,0.2); border-radius: 10px; padding: 10px;">
                <table style="width: 100%; color: white; border-collapse: collapse; font-size: 0.85rem;">
                    <thead>
                        <tr style="border-bottom: 2px solid rgba(255,255,255,0.1);">
                            <th style="padding: 12px; text-align: left;">PLACA</th>
                            <th style="padding: 12px; text-align: left;">MARCA/MODELO</th>
                            <th style="padding: 12px; text-align: left;">STATUS</th>
                            <th style="padding: 12px; text-align: left;">CATEGORIA</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="v" items="${carros}">
                            <tr style="border-bottom: 1px solid rgba(255,255,255,0.05);">
                                <td style="padding: 10px; font-weight: 600;">${v.placa}</td>
                                <td style="padding: 10px;">${v.marca} ${v.modelo}</td>
                                <td style="padding: 10px;">
                                    <span style="background: rgba(255,255,255,0.1); padding: 3px 8px; border-radius: 4px; font-size: 0.75rem;">
                                        ${v.status}
                                    </span>
                                </td>
                                <td style="padding: 10px;">${v.categoria.nome}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        <div style="margin-top: 30px; text-align: left;">
            <a href="<c:url value='/'/>" style="color: rgba(255,255,255,0.4); text-decoration: none; font-size: 0.8rem;">← VOLTAR AO MENU</a>
        </div>
    </div>

</body>
</html>
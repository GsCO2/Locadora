<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Categorias</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>

    <div class="menu-container" style="max-width: 700px;">
        <h1>CATEGORIAS</h1>
        <p>TELA DE GERENCIMENTO DE CATEGORIA</p>

        <form action="<c:url value='/categoria'/>" method="post" style="text-align: left;">

            <label style="color: white; font-size: 0.8rem; font-weight: 600;">CÓDIGO (ID):</label>
            <div style="display: flex; gap: 10px; margin-bottom: 20px; margin-top: 5px;">
                <input type="number" name="codigo" placeholder="Insira o ID para buscar" value="${categoria.codigo > 0 ? categoria.codigo : ''}" style="flex: 1; margin: 0;">
                <button type="submit" name="acao" value="Buscar" class="btn-menu" style="width: 120px; padding: 12px; margin: 0; background: rgba(255,255,255,0.1); border-color: rgba(255,255,255,0.3);">BUSCAR</button>
            </div>

            <label style="color: white; font-size: 0.8rem; font-weight: 600;">NOME DA CATEGORIA:</label>
            <input type="text" name="nome" value="${categoria.nome}" placeholder="Insira o nome da Categoria" style="width: 100%; margin-top: 5px; margin-bottom: 20px;">

            <label style="color: white; font-size: 0.8rem; font-weight: 600;">VALOR DA DIÁRIA (R$):</label>
            <input type="number" step="0.01" name="valor" value="${categoria.valor}" placeholder="0.00" style="width: 100%; margin-top: 5px; margin-bottom: 30px;">

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 20px;">
                <button type="submit" name="acao" value="Inserir" class="btn-menu" style="background: rgba(255,255,255,0.05); border-color: rgba(255,255,255,0.3);">INSERIR</button>
                <button type="submit" name="acao" value="Atualizar" class="btn-menu" style="background: rgba(255,255,255,0.05); border-color: rgba(255,255,255,0.3);">ATUALIZAR</button>
                <button type="submit" name="acao" value="Excluir" class="btn-menu" style="background: rgba(255,255,255,0.05); border-color: rgba(255,255,255,0.3);">EXCLUIR</button>
                <button type="submit" name="acao" value="Listar" class="btn-menu" style="background: rgba(255,255,255,0.05); border-color: rgba(255,255,255,0.3);">LISTAR</button>
            </div>
        </form>

        <c:if test="${not empty saida}">
            <div style="margin-bottom: 15px; color: #fff; background: rgba(46, 204, 113, 0.2); padding: 10px; border-radius: 5px; font-size: 0.9rem;">${saida}</div>
        </c:if>
        <c:if test="${not empty erro}">
            <div style="margin-bottom: 15px; background: rgba(231, 76, 60, 0.2); padding: 10px; border-radius: 5px; color: #ff7675; font-size: 0.9rem;">${erro}</div>
        </c:if>

        <c:if test="${not empty categorias}">
            <div style="margin-top: 25px;">
                <table style="width: 100%; color: white; border-collapse: collapse; background: rgba(0,0,0,0.2); font-size: 0.9rem;">
                    <thead>
                        <tr style="border-bottom: 2px solid rgba(255,255,255,0.1); background: rgba(255,255,255,0.05);">
                            <th style="padding: 12px; text-align: left;">ID</th>
                            <th style="padding: 12px; text-align: left;">NOME</th>
                            <th style="padding: 12px; text-align: left;">VALOR (R$)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${categorias}">
                            <tr style="border-bottom: 1px solid rgba(255, 255, 255, 0.05);">
                                <td style="padding: 10px;">${c.codigo}</td>
                                <td>${c.nome}</td>
                                <td>${c.valor}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        <div style="margin-top: 30px; text-align: left;">
            <a href="<c:url value='/gestao'/>" style="color: rgba(255,255,255,0.5); text-decoration: none; font-size: 0.8rem;">← VOLTAR AO MENU</a>
        </div>
    </div>

</body>
</html>
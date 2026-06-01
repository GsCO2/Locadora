<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Locadora FTZL-FG | Gestão</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">

    <style>
        .img-ref-left, .img-ref-right {
            position: absolute !important;
            width: 240px !important;
            height: 140px !important;
            object-fit: cover;
            border-radius: 12px;
            border: 1px solid rgba(255, 255, 255, 0.4);
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            z-index: 1;
        }

        #img5 { top: 30px !important; left: 40px !important; }
        #img6 { top: 30px !important; right: 40px !important; }
        #img3 { top: 50% !important; left: 40px !important; transform: translateY(-50%) !important; }
        #img4 { top: 50% !important; right: 40px !important; transform: translateY(-50%) !important; }
        #img1 { bottom: 30px !important; left: 40px !important; }
        #img2 { bottom: 30px !important; right: 40px !important; }
        
        .menu-container {
            z-index: 10;
            position: relative;
        }

        .grid-botoes {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-top: 20px;
        }
    </style>
</head>

<body>

    <div class="menu-container">
        <h1>LOCADORA FTZL-FG</h1>
        <p>A MELHOR PLATAFORMA DE GESTÃO E LOCAÇÃO AUTOMOTIVA</p>

        <div class="grid-botoes">
            <a href="<c:url value='/categoria'/>" class="btn-menu">GERENCIAR CATEGORIAS</a>
            <a href="<c:url value='/usuarios'/>" class="btn-menu">GERENCIAR CLIENTES</a>
            <a href="<c:url value='/carro'/>" class="btn-menu">GERENCIAR CARROS</a>
            <a href="<c:url value='/locacoes'/>" class="btn-menu">GERENCIAR LOCAÇÕES</a>
            
            <a href="<c:url value='/devolucao'/>" class="btn-menu">REGISTRAR DEVOLUÇÃO</a>
            <a href="<c:url value='/reparo'/>" class="btn-menu">OFICINA DE REPAROS</a>
        </div>
    </div>

    <img id="img5" src="<c:url value='/imgs/img5.jpg'/>" class="img-ref-left">
    <img id="img6" src="<c:url value='/imgs/img6.jpg'/>" class="img-ref-right">
    
    <img id="img3" src="<c:url value='/imgs/img3.jpg'/>" class="img-ref-left">
    <img id="img4" src="<c:url value='/imgs/img4.jpg'/>" class="img-ref-right">
    
    <img id="img1" src="<c:url value='/imgs/img1.jpg'/>" class="img-ref-left">
    <img id="img2" src="<c:url value='/imgs/img2.jpg'/>" class="img-ref-right">

</body>
</html>
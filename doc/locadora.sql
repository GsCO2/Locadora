CREATE DATABASE locadora;
GO
USE locadora;
GO

CREATE TABLE tipo_combustivel (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(20) NOT NULL,
    valor_litro_extra DECIMAL(10,2) NOT NULL
);

CREATE TABLE tipo_cambio (
    id INT IDENTITY(1,1) PRIMARY KEY,
    descricao VARCHAR(20) NOT NULL
);

CREATE TABLE categoria (
    codigo INT IDENTITY(1,1) PRIMARY KEY,
    nome   VARCHAR(30) NOT NULL,
    valor  DECIMAL(10,2) NOT NULL
);

CREATE TABLE locatario (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    num_habilitacao VARCHAR(20),
    data_nascimento DATE,
    logradouro VARCHAR(100),
    numero INT,
    cep VARCHAR(8),
    cidade VARCHAR(50)
);

CREATE TABLE carro (
    placa VARCHAR(7) PRIMARY KEY,
    marca VARCHAR(30) NOT NULL,
    modelo VARCHAR(30) NOT NULL,
    cor VARCHAR(20) NOT NULL,
    ano INT NOT NULL,
    quilometragem INT NOT NULL,
    status_veiculo VARCHAR(20) DEFAULT 'DISPONIVEL', 
    id_categoria   INT NOT NULL,
    id_cambio      INT NOT NULL,
    id_combustivel INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria(codigo),
    FOREIGN KEY (id_cambio) REFERENCES tipo_cambio(id),
    FOREIGN KEY (id_combustivel) REFERENCES tipo_combustivel(id)
);

CREATE TABLE aluguel (
    id INT IDENTITY(1,1) PRIMARY KEY,
    placa_carro VARCHAR(7) NOT NULL,
    cpf_locatario VARCHAR(11),
    data_retirada DATE NOT NULL,
    qtd_dias INT NOT NULL,
    status_aluguel VARCHAR(20) DEFAULT 'ATIVO', 
    tanque_cheio BIT DEFAULT 1, 
    litros_faltantes DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (placa_carro) REFERENCES carro(placa),
    FOREIGN KEY (cpf_locatario) REFERENCES locatario(cpf)
);

CREATE TABLE reparo (
    id INT IDENTITY(1,1) PRIMARY KEY,
    placa_carro VARCHAR(7) NOT NULL,
    data_entrada DATE NOT NULL,
    prazo_dias INT NOT NULL,
    descricao VARCHAR(255),
    valor_reparo DECIMAL(10,2),
    FOREIGN KEY (placa_carro) REFERENCES carro(placa)
);
GO

INSERT INTO tipo_cambio (descricao) VALUES ('Manual'), ('Automático');
GO
INSERT INTO tipo_combustivel (nome, valor_litro_extra)
VALUES ('Gasolina', 7.00), ('Álcool', 5.50);
INSERT INTO categoria (nome, valor) 
VALUES ('Econômico', 120.00), ('SUV', 250.00), ('Luxo', 450.00);
GO
INSERT INTO carro (placa, marca, modelo, cor, ano, quilometragem, status_veiculo, id_categoria, id_cambio, id_combustivel)
VALUES 
('ABC1234', 'Volkswagen', 'Polo', 'Preto', 2024, 5000, 'DISPONÍVEL', 1, 2, 1);
GO
INSERT INTO carro (placa, marca, modelo, cor, ano, quilometragem, status_veiculo, id_categoria, id_cambio, id_combustivel)
VALUES 
('XYZ9999', 'Jeep', 'Compass', 'Branco', 2025, 1200, 'DISPONÍVEL', 2, 2, 1);

INSERT INTO carro (placa, marca, modelo, cor, ano, quilometragem, status_veiculo, id_categoria, id_cambio, id_combustivel)
VALUES 
('XYZ9919', 'Jeep', 'Compass', 'Branco', 2025, 1200, 'INDISPONÍVEL', 2, 2, 1);
GO
SELECT * FROM CARRO
GO
SELECT * FROM CATEGORIA
GO
CREATE FUNCTION fn_carroDisp()
RETURNS @tabela TABLE(
	placa VARCHAR(7),
	categoria VARCHAR(30),
	marca VARCHAR(30),
	modelo VARCHAR(30),
	ano INT,
	combustivel VARCHAR(20),
	cambio VARCHAR(20),
	diaria DECIMAL(10,2)
)
AS
BEGIN
	DECLARE @placa VARCHAR(7),
		@categoria VARCHAR(30),
		@marca VARCHAR(30),
		@modelo VARCHAR(30),
		@ano INT,
		@combustivel VARCHAR(20),
		@cambio VARCHAR(20),
		@diaria DECIMAL(10,2)
	DECLARE C cursor
		FOR SELECT car.placa, cat.nome, car.marca, car.modelo, car.ano, com.nome, cam.descricao,
			cat.valor 
		FROM categoria cat, carro car, tipo_combustivel com, tipo_cambio cam
		WHERE cat.codigo = car.id_categoria
		AND car.id_combustivel = com.id
		AND car.id_cambio = cam.id
		AND car.status_veiculo = 'DISPONIVEL'
	OPEN C
	FETCH NEXT FROM c INTO @placa, @categoria, @marca, @modelo, @ano, @combustivel, @cambio,
		@diaria
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		INSERT INTO @tabela VALUES(@placa, @categoria, @marca, @modelo, @ano, @combustivel, @cambio,
			@diaria)
		FETCH NEXT FROM c INTO @placa, @categoria, @marca, @modelo, @ano, @combustivel, @cambio,
			@diaria
	END
		CLOSE C 
		DEALLOCATE C
		RETURN
END
GO
CREATE FUNCTION fn_carroDispComFiltro(@codigoFiltro int)
RETURNS @tabela TABLE(
	placa VARCHAR(7),
	categoria VARCHAR(30),
	marca VARCHAR(30),
	modelo VARCHAR(30),
	ano INT,
	combustivel VARCHAR(20),
	cambio VARCHAR(20),
	diaria DECIMAL(10,2)
)
AS
BEGIN
	DECLARE @placa VARCHAR(7),
		@categoria VARCHAR(30),
		@marca VARCHAR(30),
		@modelo VARCHAR(30),
		@ano INT,
		@combustivel VARCHAR(20),
		@cambio VARCHAR(20),
		@diaria DECIMAL(10,2)
	DECLARE C cursor
		FOR SELECT car.placa, cat.nome, car.marca, car.modelo, car.ano, com.nome, cam.descricao,
			cat.valor 
		FROM categoria cat, carro car, tipo_combustivel com, tipo_cambio cam
		WHERE cat.codigo = car.id_categoria
		AND car.id_combustivel = com.id
		AND car.id_cambio = cam.id
		AND car.status_veiculo = 'DISPONIVEL'
		AND cat.codigo = @codigoFiltro
	OPEN C
	FETCH NEXT FROM c INTO @placa, @categoria, @marca, @modelo, @ano, @combustivel, @cambio,
		@diaria
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		INSERT INTO @tabela VALUES(@placa, @categoria, @marca, @modelo, @ano, @combustivel, @cambio,
			@diaria)
		FETCH NEXT FROM c INTO @placa, @categoria, @marca, @modelo, @ano, @combustivel, @cambio,
			@diaria
	END
		CLOSE C 
		DEALLOCATE C
		RETURN
END
DELETE FROM ALUGUEL
SELECT * FROM ALUGUEL
SELECT car.placa, car.marca, car.modelo, car.cor, car.ano, loc.nome, loc.cpf, alg.qtd_dias
FROM carro car, locatario loc, aluguel alg
WHERE car.placa = alg.placa_carro
AND alg.cpf_locatario = loc.cpf
AND alg.id = 6



SELECT * FROM locatario

SELECT * FROM aluguel
SELECT car.placa, car.marca, car.modelo, cat.nome, 
						CONVERT(VARCHAR(10), alg.data_retirada, 103) as dataRetirada,  alg.qtd_dias,
						CAST((alg.qtd_dias * cat.valor) + (alg.litros_faltantes * cmb.valor_litro_extra)
						AS DECIMAL(10,2)) AS valFinal
FROM locatario loc, carro car, categoria cat, aluguel alg, tipo_combustivel cmb
WHERE loc.cpf = alg.cpf_locatario
AND alg.placa_carro = car.placa
and car.id_combustivel = cmb.id
AND car.id_categoria = cat.codigo
AND loc.cpf = '60656584050'

SELECT car.placa, car.marca, car.modelo, car.cor, car.ano, 
	CONVERT(VARCHAR(10), rep.data_entrada, 103) as dataEntrada, CAST(rep.prazo_dias as VARCHAR(5)) + ' dias' as prazoReparo, rep.descricao, rep.valor_reparo
FROM carro car, reparo rep
WHERE car.placa = rep.placa_carro
AND car.status_veiculo = 'INDISPONIVEL'

SELECT * FROM carro
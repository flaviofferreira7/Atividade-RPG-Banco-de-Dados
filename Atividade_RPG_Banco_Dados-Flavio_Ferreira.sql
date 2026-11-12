-- ============================================================
-- PROJETO: CRÔNICAS DE ELDORIA
-- SISTEMA: RPG
-- SOFTWARE: MYSQL WORKBENCH
-- ALUNO: Flávio Fonseca Ferreira
-- OBJETIVO:
-- Criar um banco de dados para armazenar jogadores,
-- personagens, classes e habilidades de um jogo RPG.
-- ============================================================


-- ============================================================
-- ETAPA 1: CRIACAO DO BANCO DE DADOS
-- ============================================================

-- Cria o banco de dados caso ele ainda nao exista.
CREATE DATABASE cronicas_eldoria;

-- Seleciona o banco de dados que sera utilizado.
USE cronicas_eldoria;


-- ============================================================
-- ETAPA 2: CRIACAO DA TABELA USUARIOS
-- ============================================================

-- Armazena os jogadores cadastrados no sistema.
-- UsuarioId: chave primaria (PK).
-- Nome: nome do jogador.
-- Email: endereco de email do jogador.
-- Senha: campo destinado a senha protegida.

CREATE TABLE Usuarios (
    UsuarioId INT AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Senha VARCHAR(255) NOT NULL
);

-- Adiciona o campo Nome à tabela Usuarios.
ALTER TABLE Usuarios
ADD Nome VARCHAR(100) NOT NULL;

-- Cadastro dos tres jogadores.
INSERT INTO USUARIOS (UsuarioId, Nome, Email, Senha)
VALUES
(1, 'Flavio', 'flavio@example.com', 'senha_flavio_123'),
(2, 'Hevelin', 'hevelin@example.com', 'senha_hevelin_123'),
(3, 'Senai', 'senai@example.com', 'senha_senai_123');

-- Visualiza todos os jogadores.
SELECT * FROM Usuarios;

-- ============================================================
-- ETAPA 3: CRIACAO DA TABELA CLASSES
-- ============================================================

-- Armazena as classes disponiveis no jogo.
-- ClasseId: chave primaria (PK).
-- Nome: nome da classe.
-- Descricao: descricao das caracteristicas da classe.

CREATE TABLE Classes (
    ClasseId INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao VARCHAR(500)
);

-- Cadastro das Classes.
INSERT INTO Classes (Nome, Descricao)
VALUES
('Guerreiro', 'Especialista em combate fisico, espadas e defesa.'),
('Mago Arcano', 'Mestre em feiticos e poderes elementais.'),
('Arqueiro', 'Especialista em ataques a distancia e precisao.'),
('Assassino', 'Especialista em furtividade e ataques surpresa.'),
('Paladino', 'Guerreiro sagrado com poderes de cura e protecao.'),
('Druida', 'Controla a natureza, animais e elementos naturais.'),
('Barbaro', 'Guerreiro de forca extraordinaria e resistencia.'),
('Necromante', 'Manipula energias sombrias e invoca mortos-vivos.');

-- Visualiza todas as classes.
SELECT * FROM Classes;

-- ============================================================
-- ETAPA 4: CRIACAO DA TABELA PERSONAGENS
-- ============================================================

-- Armazena os personagens criados pelos jogadores.
--
-- PersonagemId: chave primaria (PK).
-- UsuarioId: chave estrangeira (FK) que referencia USUARIOS.
-- ClasseId: chave estrangeira (FK) que referencia CLASSES.
--
-- Cada personagem pertence a um unico usuario
-- e possui uma unica classe.

CREATE TABLE Personagens (

    PersonagemId INT AUTO_INCREMENT PRIMARY KEY,
    NomePersonagem VARCHAR(100) NOT NULL,
    UsuarioId INT NOT NULL,
    ClasseId INT NOT NULL,

    -- Relacionamento entre Personagens e Usuarios.
    CONSTRAINT FK_Personagens_Usuarios
    FOREIGN KEY (UsuarioId)
    REFERENCES Usuarios (UsuarioId),

    -- Relacionamento entre Personagens e Classes.
    CONSTRAINT FK_Personagens_Classes
    FOREIGN KEY (ClasseId)
    REFERENCES Classes (ClasseId)

);

-- Cadastro dos Personagens
-- 
-- Cada personagem possui um UsuarioId e um ClasseId.
--
-- IDs dos Usuarios:
-- 1 = Flavio
-- 2 = Hevelin
-- 3 = Senai
--
-- IDs das Classes:
-- 1 = Guerreiro
-- 2 = Mago Arcano
-- 3 = Arqueiro
-- 4 = Assassino
-- 5 = Paladino
-- 6 = Druida
-- 7 = Barbaro
-- 8 = Necromante

INSERT INTO Personagens
(NomePersonagem, UsuarioId, ClasseId)
VALUES

-- Personagens do Flavio
('Kael Draven', 1, 1),
('Lyra Moonfall', 1, 2),
('Thorian Blackthorn', 1, 5),
('Nymera Valeris', 1, 3),
('Darius Nightshade', 1, 4),

-- Personagens da Hevelin
('Seraphina Dawnfire', 2, 5),
('Elowen Frostwind', 2, 6),
('Vaelora Silvermoon', 2, 6),
('Isolde Ravenheart', 2, 8),
('Aelira Starwind', 2, 2),

-- Personagens do SENAI
('Ragnar Ironfist', 3, 7),
('Drakar Bloodfang', 3, 1),
('Zephyr Windwalker', 3, 4),
('Eldrin Stormveil', 3, 2),
('Arthen Goldshield', 3, 5);

-- Visualiza todos os Personagens.
SELECT * FROM Personagens;

-- ============================================================
-- ETAPA 5: CRIACAO DA TABELA HABILIDADES
-- ============================================================

-- Armazena as habilidades disponiveis no jogo.
-- HabilidadeId: chave primaria (PK).
-- Nome: nome da habilidade.

CREATE TABLE Habilidades (

    HabilidadeId INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);

-- Cadastro das Habilidades
-- ------------------------------------------------------------

INSERT INTO Habilidades (Nome)
VALUES
('Golpe Devastador'),
('Escudo Arcano'),
('Chama do Dragao'),
('Flecha Fantasma'),
('Cura Divina'),
('Lamina Sombria'),
('Tempestade Eletrica'),
('Furia Berserker'),
('Prisao de Gelo'),
('Invocacao Espectral'),
('Passos das Sombras'),
('Explosao Arcana'),
('Barreira Sagrada'),
('Raizes Aprisionadoras'),
('Precisao Mortal'),
('Terremoto'),
('Veneno Mortal'),
('Ressurreicao'),
('Lanca de Luz'),
('Metamorfose Selvagem'),
('Corte Relampago'),
('Maldicao Ancestral'),
('Chuva de Meteoros'),
('Pacto Demoniaco');

-- Visualiza todas as Habilidades.
SELECT * FROM Habilidades;


-- ============================================================
-- ETAPA 6: Criação da tabela Classes_Habilidades
-- ============================================================

-- Esta tabela resolve o relacionamento muitos para muitos.
--
-- Uma classe pode possuir varias habilidades.
-- Uma habilidade pode pertencer a varias classes.
--
-- ClasseId: PK e FK.
-- HabilidadeId: PK e FK.
--
-- A chave primária composta impede que a mesma
-- habilidade seja associada duas vezes a mesma classe.

CREATE TABLE Classes_Habilidades (

    ClasseId INT NOT NULL,
    HabilidadeId INT NOT NULL,

    -- Chave primaria composta.
    PRIMARY KEY (ClasseId, HabilidadeId),

    -- Chave estrangeira que referencia CLASSES.
    -- Cria uma restricao de chave estrangeira.
    -- FK_CH_CLASSES e o nome dado a essa restricao.
    -- Ela conecta ClasseId desta tabela com ClasseId
    -- da tabela CLASSES.
    CONSTRAINT FK_CH_Classes
    FOREIGN KEY (ClasseId)
    REFERENCES Classes (ClasseId)
    ON DELETE CASCADE, -- ON DELETE CASCADE:Se uma classe for excluida da tabela Classes, suas associacoes nesta tabela também serao excluidas.

    -- Chave estrangeira que referencia HABILIDADES.
    -- Cria outra restricao de chave estrangeira.
    -- FK_CH_HABILIDADES e o nome dado a essa restricao.
    -- Ela conecta HabilidadeId desta tabela com
    -- HabilidadeId da tabela HABILIDADES.
    CONSTRAINT FK_CH_Habilidades
    FOREIGN KEY (HabilidadeId)
    REFERENCES Habilidades (HabilidadeId)
    ON DELETE CASCADE -- ON DELETE CASCADE: Se uma habilidade for excluida da tabela HABILIDADES, suas associacoes nesta tabela tambem serao excluidas.
);

-- ASSOCIACÃO ENTRE CLASSES E HABILIDADES
-- ------------------------------------------------------------

-- Relaciona cada classe com suas habilidades. Foi relacionado de forma aleatória
-- Os números representam os IDs das classes e habilidades.

INSERT INTO Classes_Habilidades
(ClasseId, HabilidadeId)
VALUES

-- GUERREIRO (Id 1)
(1, 1),
(1, 2),
(1, 16),

-- MAGO ARCANO (Id 2)
(2, 3),
(2, 7),
(2, 9),
(2, 12),
(2, 23),

-- ARQUEIRO (Id 3)
(3, 4),
(3, 15),
(3, 21),

-- ASSASSINO (Id 4)
(4, 6),
(4, 11),
(4, 17),
(4, 21),

-- PALADINO (Id 5)
(5, 5),
(5, 13),
(5, 18),
(5, 19),

-- DRUIDA (Id 6)
(6, 5),
(6, 14),
(6, 20),

-- BARBARO (Id 7)
(7, 1),
(7, 8),
(7, 16),

-- NECROMANTE (Id 8)
(8, 10),
(8, 22),
(8, 24);

-- Visualiza as associacoes entre Classes e Habilidades.
SELECT * FROM Classes_Habilidades;

-- ============================================================
-- ETAPA 9: CONSULTAS COM INNER JOIN (Foi feito uma pesquisa sobre esse comando usado para combinar dados de duas ou mais tabelas, 
-- retornando apenas as linhas que possuem correspondência (dados em comum) em ambas as tabelas)
-- ============================================================

-- Exibe o nome dos jogadores e seus personagens,
-- incluindo a classe de cada personagem.

SELECT
    U.Nome AS Jogador,
    P.NomePersonagem AS Personagem,
    C.Nome AS Classe

FROM Personagens P

INNER JOIN Usuarios U
    ON P.UsuarioId = U.UsuarioId

INNER JOIN Classes C
    ON P.ClasseId = C.ClasseId;


-- Exibe todas as classes e suas respectivas habilidades.

SELECT
    C.Nome AS Classe,
    H.Nome AS Habilidade

FROM Classes_Habilidades CH

INNER JOIN Classes C
    ON CH.ClasseId = C.ClasseId

INNER JOIN Habilidades H
    ON CH.HabilidadeId = H.HabilidadeId

ORDER BY C.Nome, H.Nome;

-- CONSULTANDO PERSONAGENS DO JOGADOR FLAVIO
-- =====================================================

-- SELECT: seleciona os campos que desejamos visualizar.
SELECT
    P.PersonagemId,
    P.NomePersonagem,
    U.Nome AS Jogador

-- FROM: define a tabela principal da consulta.
FROM Personagens P

-- INNER JOIN: relaciona PERSONAGENS com USUARIOS.
-- A ligacao acontece por meio do UsuarioId.
INNER JOIN Usuarios U
    ON P.UsuarioId = U.UsuarioId

-- WHERE: filtra os resultados.
-- Retorna somente os personagens do jogador Flavio.
WHERE U.Nome = 'Flavio';


-- Caso se deseje atualizar, adicionar ou excluir alguma tabela ou atributo, 
-- deverão ser usado os comandos UPDATE, ADD ou DELETE.

-- ============================================================
-- FIM DO PROJETO CRÔNICAS DE ELDORIA
-- ============================================================


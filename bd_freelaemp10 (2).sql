-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 30/09/2024 às 20:02
-- Versão do servidor: 10.4.28-MariaDB
-- Versão do PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `bd_freelaemp10`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_contratos`
--

CREATE TABLE `tb_contratos` (
  `Contrato_ID` int(8) NOT NULL,
  `Projeto_ID` int(8) NOT NULL,
  `Status` varchar(100) NOT NULL,
  `ValorTotal` decimal(8,0) NOT NULL,
  `Periodo` int(8) NOT NULL,
  `usuarios` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_feedback`
--

CREATE TABLE `tb_feedback` (
  `Feedback_ID` int(8) NOT NULL,
  `Contrato_ID` int(8) NOT NULL,
  `usuarios` int(8) NOT NULL,
  `mensagem` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_garantia`
--

CREATE TABLE `tb_garantia` (
  `Garantia_ID` int(8) NOT NULL,
  `TermosGarantia` text NOT NULL,
  `InicioGarantia` int(6) NOT NULL,
  `FimGarantia` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_pagamento`
--

CREATE TABLE `tb_pagamento` (
  `ID_Pagamento` int(8) NOT NULL,
  `Contrato_ID` int(8) NOT NULL,
  `Valor` decimal(8,0) NOT NULL,
  `MetodoPagamento` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_perfildetalhes`
--

CREATE TABLE `tb_perfildetalhes` (
  `Perfil_ID` int(8) NOT NULL,
  `NumeroTelefone` int(14) NOT NULL,
  `Endereço` varchar(200) NOT NULL,
  `MidiasSociais` varchar(200) NOT NULL,
  `usuarios` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_periodo`
--

CREATE TABLE `tb_periodo` (
  `Periodo` int(8) NOT NULL,
  `Data_Inicio` int(6) NOT NULL,
  `Data_Fim` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_profissoes`
--

CREATE TABLE `tb_profissoes` (
  `Posicao_ID` int(8) NOT NULL,
  `ID_ProjetosAnteriores` int(8) NOT NULL,
  `usuarios` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_suporte`
--

CREATE TABLE `tb_suporte` (
  `Suporte_ID` int(8) NOT NULL,
  `Garantia_ID` int(8) NOT NULL,
  `SuporteContato` varchar(200) NOT NULL,
  `SuporteHorarioFuncionamento` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usuarios`
--

CREATE TABLE `tb_usuarios` (
  `usuarios` int(8) NOT NULL,
  `TipoUsuario` varchar(100) NOT NULL,
  `Nome` varchar(100) NOT NULL,
  `senha` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Acionadores `tb_usuarios`
--
DELIMITER $$
CREATE TRIGGER `before_insert_tb_usuarios` BEFORE INSERT ON `tb_usuarios` FOR EACH ROW BEGIN
    DECLARE max_even_id INT DEFAULT 0;
    DECLARE max_odd_id INT DEFAULT 0;
    
    -- Get the current max even and odd IDs
    SELECT IFNULL(MAX(usuarios), 0) INTO max_even_id 
    FROM tb_usuarios 
    WHERE usuarios % 2 = 0;

    SELECT IFNULL(MAX(usuarios), 0) INTO max_odd_id 
    FROM tb_usuarios 
    WHERE usuarios % 2 != 0;
    
    -- Assign a new ID based on the 'tipousuario' column
    IF NEW.tipousuario = 'empregador' THEN
        -- Assign an even ID for 'empregador'
        SET NEW.usuarios = max_even_id + 2;
    ELSEIF NEW.tipousuario = 'freelancer' THEN
        -- Assign an odd ID for 'freelancer'
        SET NEW.usuarios = max_odd_id + 2;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_vagasanteriores`
--

CREATE TABLE `tb_vagasanteriores` (
  `ID_ProjetosAnteriores` int(8) NOT NULL,
  `Posicao` varchar(100) NOT NULL,
  `Periodo` int(8) NOT NULL,
  `Projeto_ID` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_vagasinscritas`
--

CREATE TABLE `tb_vagasinscritas` (
  `VagasInscritas_ID` int(8) NOT NULL,
  `Posicao_ID` varchar(100) NOT NULL,
  `usuarios` int(8) NOT NULL,
  `Projeto_ID` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_vagaspostadas`
--

CREATE TABLE `tb_vagaspostadas` (
  `Descricao` varchar(200) NOT NULL,
  `Posicao_ID` int(8) NOT NULL,
  `Projeto_ID` int(8) NOT NULL,
  `usuarios` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `tb_contratos`
--
ALTER TABLE `tb_contratos`
  ADD PRIMARY KEY (`Contrato_ID`),
  ADD KEY `usuarios` (`usuarios`),
  ADD KEY `Projeto_ID` (`Projeto_ID`),
  ADD KEY `Periodo` (`Periodo`);

--
-- Índices de tabela `tb_feedback`
--
ALTER TABLE `tb_feedback`
  ADD PRIMARY KEY (`Feedback_ID`),
  ADD KEY `Contrato_ID` (`Contrato_ID`),
  ADD KEY `usuarios` (`usuarios`);

--
-- Índices de tabela `tb_garantia`
--
ALTER TABLE `tb_garantia`
  ADD PRIMARY KEY (`Garantia_ID`);

--
-- Índices de tabela `tb_pagamento`
--
ALTER TABLE `tb_pagamento`
  ADD PRIMARY KEY (`ID_Pagamento`),
  ADD KEY `Contrato_ID` (`Contrato_ID`);

--
-- Índices de tabela `tb_perfildetalhes`
--
ALTER TABLE `tb_perfildetalhes`
  ADD PRIMARY KEY (`Perfil_ID`),
  ADD KEY `usuarios` (`usuarios`);

--
-- Índices de tabela `tb_periodo`
--
ALTER TABLE `tb_periodo`
  ADD PRIMARY KEY (`Periodo`),
  ADD KEY `Data_Início` (`Data_Inicio`,`Data_Fim`);

--
-- Índices de tabela `tb_profissoes`
--
ALTER TABLE `tb_profissoes`
  ADD PRIMARY KEY (`Posicao_ID`),
  ADD KEY `Posição` (`ID_ProjetosAnteriores`),
  ADD KEY `TipoUsuário` (`usuarios`);

--
-- Índices de tabela `tb_suporte`
--
ALTER TABLE `tb_suporte`
  ADD PRIMARY KEY (`Suporte_ID`),
  ADD KEY `Garantia_ID` (`Garantia_ID`);

--
-- Índices de tabela `tb_usuarios`
--
ALTER TABLE `tb_usuarios`
  ADD PRIMARY KEY (`usuarios`);

--
-- Índices de tabela `tb_vagasanteriores`
--
ALTER TABLE `tb_vagasanteriores`
  ADD PRIMARY KEY (`ID_ProjetosAnteriores`),
  ADD KEY `Posição` (`Posicao`,`Periodo`),
  ADD KEY `Projeto_ID` (`Projeto_ID`);

--
-- Índices de tabela `tb_vagasinscritas`
--
ALTER TABLE `tb_vagasinscritas`
  ADD PRIMARY KEY (`VagasInscritas_ID`),
  ADD KEY `Posição` (`Posicao_ID`),
  ADD KEY `usuarios` (`usuarios`),
  ADD KEY `Projeto_ID` (`Projeto_ID`);

--
-- Índices de tabela `tb_vagaspostadas`
--
ALTER TABLE `tb_vagaspostadas`
  ADD PRIMARY KEY (`Projeto_ID`),
  ADD KEY `Posição` (`Posicao_ID`),
  ADD KEY `usuarios` (`usuarios`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `tb_pagamento`
--
ALTER TABLE `tb_pagamento`
  MODIFY `ID_Pagamento` int(8) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_profissoes`
--
ALTER TABLE `tb_profissoes`
  MODIFY `Posicao_ID` int(8) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_vagasanteriores`
--
ALTER TABLE `tb_vagasanteriores`
  MODIFY `ID_ProjetosAnteriores` int(8) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_vagasinscritas`
--
ALTER TABLE `tb_vagasinscritas`
  MODIFY `VagasInscritas_ID` int(8) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `tb_contratos`
--
ALTER TABLE `tb_contratos`
  ADD CONSTRAINT `klhcjgfhxg` FOREIGN KEY (`Contrato_ID`) REFERENCES `tb_pagamento` (`Contrato_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `yfhkgtj` FOREIGN KEY (`Contrato_ID`) REFERENCES `tb_feedback` (`Contrato_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `tb_garantia`
--
ALTER TABLE `tb_garantia`
  ADD CONSTRAINT `Garantia-Suporte` FOREIGN KEY (`Garantia_ID`) REFERENCES `tb_suporte` (`Garantia_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `tb_periodo`
--
ALTER TABLE `tb_periodo`
  ADD CONSTRAINT `jdjdghjgj` FOREIGN KEY (`Periodo`) REFERENCES `tb_contratos` (`Periodo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `tb_usuarios`
--
ALTER TABLE `tb_usuarios`
  ADD CONSTRAINT `hkfyktj` FOREIGN KEY (`usuarios`) REFERENCES `tb_profissoes` (`usuarios`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lyfyhxfhf` FOREIGN KEY (`usuarios`) REFERENCES `tb_contratos` (`usuarios`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mjdtyghytfh` FOREIGN KEY (`usuarios`) REFERENCES `tb_perfildetalhes` (`usuarios`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tktyftzhfdg` FOREIGN KEY (`usuarios`) REFERENCES `tb_feedback` (`usuarios`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `tb_vagaspostadas`
--
ALTER TABLE `tb_vagaspostadas`
  ADD CONSTRAINT `Projeto-Contrato` FOREIGN KEY (`Projeto_ID`) REFERENCES `tb_contratos` (`Projeto_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `thsxrjstyus` FOREIGN KEY (`Projeto_ID`) REFERENCES `tb_vagasinscritas` (`Projeto_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ytjiyukdstth` FOREIGN KEY (`Projeto_ID`) REFERENCES `tb_vagasanteriores` (`Projeto_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

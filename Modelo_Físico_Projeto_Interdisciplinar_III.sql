CREATE DATABASE uber_logistico;

USE uber_logistico;

CREATE TABLE prestadores  -- PRESTADORES.
(
	id INT NOT NULL AUTO_INCREMENT, -- A função de "Auto_increment" é ao mesmo tempo "not null".
    nome VARCHAR(80) NOT NULL,
    cpf_cnpj CHAR(11) NOT NULL,
    email VARCHAR(80) NOT NULL,
    senha VARCHAR(32) NOT NULL,
    data_da_incricao DATETIME NOT NULL,
    descricao VARCHAR(250) NOT NULL,
        
    PRIMARY KEY (id),
    
    INDEX (nome),
	INDEX (data_da_inscricao),
    INDEX (email), -- Busca por email? Por que buscar email na prática?
    INDEX (cpf_cnpj)
    
);

CREATE TABLE clientes -- CLIENTES.
(
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    cpf_cnpj CHAR(11) NOT NULL,
    email VARCHAR(80) NOT NULL,
    senha VARCHAR(32) NOT NULL,
    data_da_incricao DATETIME NOT NULL,
    descricao VARCHAR(250) NOT NULL,
    
    
    PRIMARY KEY (id),
    
    INDEX (nome),
	INDEX (data_da_inscricao),
    INDEX (email), -- Busca por email? Por que buscar email na prática?
    INDEX (cpf_cnpj)
    
);

CREATE TABLE categorias -- CATEGORIAS.
(
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    descricao VARCHAR(250) NOT NULL,
    
    PRIMARY KEY (id),
    
    UNIQUE INDEX (nome) -- A junção de ambos já faz tranSforma em "Index" para buscas?
                        -- Devo colocar "unique" nesse atributo?
);

CREATE TABLE transportes_transbordo -- TIPO DE MODAIS OU TRANSBORDO.
(
	id INT NOT NULL AUTO_INCREMENT, -- Nesta tabela há a opção de registro de transporte ou tranbordo, 
    transporte BOOLEAN NULL,        -- e, também o tipo de modal (podendo ter mais de um por prestador). 
    transbordo BOOLEAN NULL, -- Esta variável está correta?
    tipo_modal VARCHAR(40) NULL,
    descricao VARCHAR(250) NOT NULL,
    
    PRIMARY KEY (id),
    
    INDEX (nome), 
    INDEX (transporte),
    INDEX (transbordo), --Na prática esses Index estão corretos?
    INDEX (tipo_modal),

    FOREIGN KEY (categoria_id) REFERENCES categorias (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (prestadores_id) REFERENCES prestadores (id) ON DELETE RESTRICT ON UPDATE RESTRICT

);

CREATE TABLE avaliacoes -- AVALIAÇÕES.
(
	id INT NOT NULL AUTO_INCREMENT,
    nota INT NOT NULL,
    comentario VARCHAR(250) NOT NULL,
    
    PRIMARY KEY (id),
    
    INDEX (nota), 
    
    FOREIGN KEY (clientes_id) REFERENCES clientes (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (prestadores_id) REFERENCES prestadores (id) ON DELETE RESTRICT ON UPDATE RESTRICT

);

CREATE TABLE ordens_servicos -- ORDENS DE SERVIÇOS -- Devo colocar acentuações?
(
	id INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(250) NOT NULL,   -- Devo colocar acentuações?
    data_de_inicio DATETIME NOT NULL,  -- Como fica as datas e horários comparado com
    data_de_termino DATETIME NOT NULL, -- modelo conceitual e lógico?
    status_os VARCHAR(20) NOT NULL, -- Pode colocar "status" assim?

    PRIMARY KEY (id),
    
    INDEX (data_de_inicio),
    INDEX (data_de_termino),
    INDEX (status_os),

    FOREIGN KEY (clientes_id) REFERENCES clientes (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (transportes_transbordo_id) REFERENCES transportes_transbordo (id) ON DELETE RESTRICT ON UPDATE RESTRICT
    -- Deve ter uma "foreign key" da tabela prestadores?

);

CREATE TABLE formas_pagamentos -- FORMAS DE PAGAMENTOS.
(
	id INT NOT NULL AUTO_INCREMENT, -- OBS: Essa tabela vai ter mais de uma forma de pagamento ao mesmo tempo.
    dinheiro FLOAT NULL,
    credito FLOAT NULL, -- Esse tipo de váriavel está correta? Ou boolean?
    debito FLOAT NULL,  -- Quando "null" é permitido, devo colocar?
    pix FLOAT NULL, 
    
    PRIMARY KEY (id),
    
    INDEX (dinheiro),
    INDEX (credito),
    INDEX (debito),
    INDEX (pix),

    FOREIGN KEY (ordens_servicos) REFERENCES ordens_servicos (id) ON DELETE RESTRICT ON UPDATE RESTRICT

);

CREATE TABLE telefones -- TELEFONES.
(
	id INT NOT NULL AUTO_INCREMENT,
    ddd CHAR(3) NOT NULL,
    telefone CHAR(9) NULL, -- Esse tipo de váriavel está correta?
    
    PRIMARY KEY (id),
    
    INDEX (telefone),
    INDEX (ddd), -- Devo colocar como "index"?

    FOREIGN KEY (prestadores_id) REFERENCES prestadores (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (clientes_id) REFERENCES clientes (id) ON DELETE RESTRICT ON UPDATE RESTRICT

);

CREATE TABLE enderecos -- ENDEREÇOS.
(
	id INT NOT NULL AUTO_INCREMENT,
    lougradouro VARCHAR(80) NOT NULL,
    bairro VARCHAR(11) NOT NULL,
    municipio VARCHAR(80) NOT NULL,
    uf CHAR(2) NOT NULL,
    cep CHAR(8) NOT NULL,
    complemento VARCHAR(40) NULL,
    
    PRIMARY KEY (id),
    
    INDEX (lougradouro),
	INDEX (bairro),
    INDEX (municipio),
    INDEX (uf),
    INDEX (cep),

    FOREIGN KEY (prestadores_id) REFERENCES prestadores (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (clientes_id) REFERENCES clientes (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    
);



use wk;

drop table if exists cliente;

create table cliente(
codigo int not null primary key AUTO_INCREMENT,
nome varchar(50) not null,
cidade varchar(40),
uf char(2)
);

insert into cliente (nome, cidade, uf) values('Fulano', 'Curitiba', 'PR');
insert into cliente (nome, cidade, uf) values('Beltrano', 'Araucaria', 'PR');
insert into cliente (nome, cidade, uf) values('Sicrano', 'Curitiba', 'PR');
insert into cliente (nome, cidade, uf) values('Cliente 4', 'Curitiba', 'PR');
insert into cliente (nome, cidade, uf) values('Cliente 5', 'Curitiba', 'PR');
insert into cliente (nome, cidade, uf) values('Cliente 6', 'Curitiba', 'PR');
insert into cliente (nome, cidade, uf) values('Cliente 7', 'Curitiba', 'PR');
insert into cliente (nome, cidade, uf) values('Cliente 8', 'Curitiba', 'PR');
insert into cliente (nome, cidade, uf) values('Cliente 9', 'Curitiba', 'PR');
insert into cliente (nome, cidade, uf) values('Cliente 10', 'Curitiba', 'PR');
insert into cliente (nome, cidade, uf) values('Cliente 11', 'Curitiba', 'PR');
insert into cliente (nome, cidade, uf) values('Cliente 12', 'Curitiba', 'PR');
insert into cliente (nome, cidade, uf) values('Cliente 13', 'Curitiba', 'PR');
insert into cliente (nome, cidade, uf) values('Cliente 14', 'Curitiba', 'PR');
insert into cliente (nome, cidade, uf) values('Cliente 15', 'Curitiba', 'PR');
insert into cliente (nome, cidade, uf) values('Cliente 16', 'Curitiba', 'PR');
insert into cliente (nome, cidade, uf) values('Cliente 17', 'Curitiba', 'PR');
insert into cliente (nome, cidade, uf) values('Cliente 18', 'Curitiba', 'PR');
insert into cliente (nome, cidade, uf) values('Cliente 19', 'Curitiba', 'PR');
insert into cliente (nome, cidade, uf) values('Cliente 20', 'Curitiba', 'PR');

commit;

drop table if exists produto;

create table produto(
codigo int not null primary key AUTO_INCREMENT,
descricao varchar(50) not null,
preco numeric(15,2) not null
);

insert into produto (descricao, preco) values('Café', 4.50);
insert into produto (descricao, preco) values('Leite', 3.50);
insert into produto (descricao, preco) values('Pão', 9.90);
insert into produto (descricao, preco) values('Misto', 5.00);
insert into produto (descricao, preco) values('Produto 5', 5.00);
insert into produto (descricao, preco) values('Produto 6', 5.00);
insert into produto (descricao, preco) values('Produto 7', 5.00);
insert into produto (descricao, preco) values('Produto 8', 5.00);
insert into produto (descricao, preco) values('Produto 9', 5.00);
insert into produto (descricao, preco) values('Produto 10', 5.00);
insert into produto (descricao, preco) values('Produto 11', 5.00);
insert into produto (descricao, preco) values('Produto 12', 5.00);
insert into produto (descricao, preco) values('Produto 13', 5.00);
insert into produto (descricao, preco) values('Produto 14', 5.00);
insert into produto (descricao, preco) values('Produto 15', 5.00);
insert into produto (descricao, preco) values('Produto 16', 5.00);
insert into produto (descricao, preco) values('Produto 17', 5.00);
insert into produto (descricao, preco) values('Produto 18', 5.00);
insert into produto (descricao, preco) values('Produto 19', 5.00);
insert into produto (descricao, preco) values('Produto 20', 5.00);

drop table if exists pedido;

create table pedido(
codigo int not null primary key,
idcliente int not null,
emissao date not null,
total numeric(15,2) not null,
FOREIGN KEY (idcliente) REFERENCES cliente(codigo)
);

drop table if exists pedido_item;

create table pedido_item(
codigo int not null,
idpedido int not null,
idproduto int not null,
quantidade numeric(15,2) not null,
preco numeric(15,2) not null,
total numeric(15,2) not null,
FOREIGN KEY (idpedido) REFERENCES pedido(codigo),
FOREIGN KEY (idproduto) REFERENCES produto(codigo)
);

commit;

drop table if exists sequencial;

create table sequencial(
tabela varchar(50) not null,
codigo int not null
);

insert into sequencial values('pedido', 1);
insert into sequencial values('pedido_item', 1);

commit;
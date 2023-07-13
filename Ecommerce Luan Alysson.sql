create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table clients (
			idClient int auto_increment primary key,
            Fname varchar(10),
            Minit char(3),
            Lname varchar(20),
            CPF char(11) not null,
            Address varchar(30),
            constraint unique_cpf_client unique (CPF)
);
-- criar produto
create table product (
			idProduct int auto_increment primary key,
            Pname varchar(10),
            classification_kids bool,
            category enum ('Eletronico','Vestimenta', 'Alimentos', 'Móveis') not null,
            avaliação float default 0,
            size varchar(10)
);
-- criar pagamento
create table payments(
			idclient int,
			id_payment int,
			typePayment enum('Boleto', 'Cartão', 'Dois Cartões'),
            limitAvaible float,
			primary key(idClient, id_payment)
);
-- criar pedido
create table orders (
			idOrder int auto_increment primary key,
            idOrderClient int, 
            orderStatus enum('Cancelado', 'Confirmado', 'Em Processamento') default 'Em Processamento',
            orderDescription varchar(255),
            sendValue float default 10,
            paymentCash boolean default false,
            constraint fk_ordes_cliente foreign key (idOrderClient) references clients(idClient)
);
-- criar estoque
create table productStorage (
			idProdStorage int auto_increment primary key,
            storageLocation varchar(255),
            quantity int default 0
);
-- criar fornecedor
create table supplier (
			idSupplier int auto_increment primary key,
            socialName varchar(255) not null,
            CNPJ char(15) not null,
            contact varchar(11) not null, 
            constraint unique_supplier unique (CNPJ)
);
-- criar tabela vendedor
create table seller (
			idSeller int auto_increment primary key,
            socialName varchar(255) not null,
            AbsName varchar(255),
            CNPJ char(15),
            CPF char(9),
            location varchar (255),
            contact varchar(11) not null, 
            constraint unique_cnpj_seller unique (CNPJ),
            constraint unique_cpf_seller unique (CPF)
);
-- cria vendedor dos produtos 
create table productSeller(
			idPseller int, 
            idPproduct int, 
            prodQuantity int default 1,
            primary key (idPseller, idPproduct),
            constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
            constraint fk_product_product foreign key (idPproduct) references product (idProduct)
);
-- cria ordem dos pedidos
create table productOrder(
			idPoproduct int, 
            idPOorder int, 
            PoQuantity int default 1,
            poStatus enum ('Disponível', 'Sem Estoque') default 'Disponível',
            primary key (idPOproduct, idPOorder),
            constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
            constraint fk_productorder_product foreign key (idPOorder) references orders (idOrder)
);
-- cria localização dos pedidos
create table storageLocation (
			idLproduct int, 
            idLstorage int, 
            location varchar(255) not null,
            primary key (idLproduct, idLstorage),
			constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
            constraint fk_storage_location_storage foreign key (idLstorage) references productStorage (idProdStorage)
);
-- criar cadeia de suprimentos 
create table productSupplier (
			idPsSupplier int, 
            idPsProduct int, 
            quantity int not null,
            primary key (idPsSupplier, idPsProduct),
			constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(IdSupplier),
            constraint fk_product_supplier_product foreign key (IdPsProduct) references product (IdProduct)
);

show tables;
desc productSupplier;
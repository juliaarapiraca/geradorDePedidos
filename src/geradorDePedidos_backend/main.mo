import Buffer "mo:base/Buffer";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Bool "mo:base/Bool";


actor GeradorDePedidos {

  type Pedido = {
    id: Nat;
    id_cliente: Nat;
    cliente: Text;
    descricao: Text;
    };

    type Cliente = {
    id: Nat;
    nome: Text;
    endereco: Text;
    whatsapp: Text;
    qtd_pedidos: Nat;
    };

    var id_pedido: Nat = 0;
    var pedidos: Buffer.Buffer<Pedido> = Buffer.Buffer<Pedido>();

    var id_cliente: Nat = 0;
    var clientes: Buffer.Buffer<Cliente> = Buffer.Buffer<Cliente>();

    /* ########## CLIENTES ########## */

    public func add_cliente( nomeCliente: Text, enderecoCliente: Text, whatsappCliente: Text, n_pedidos: Nat): async(){
        id_cliente += 1;

        let novoCliente: Cliente = {
            id = id_cliente;
            nome = nomeCliente;
            endereco = enderecoCliente;
            whatsapp = whatsappCliente;
            qtd_pedidos = n_pedidos;   
        };

        clientes.add(novoCliente);
    };

    public func excluir_cliente(id_excluir: Nat): async(){
        func localiza_excluir(i: Nat, x: Cliente): Bool {
            return x.id != id_excluir
        };

        clientes.filterEntries(localiza_excluir);
    };

    public func alterar_cliente (id_cl: Nat, nomeCliente: Text, enderecoCliente: Text, whatsappCliente: Text, n_pedidos: Nat): async(){
        let alterarCliente: Cliente = {
            id = id_cl;
            nome = nomeCliente;
            endereco = enderecoCliente;
            whatsapp = whatsappCliente;
            qtd_pedidos = n_pedidos;
        };

        func localiza_index(x: Cliente, y: Cliente): Bool {
            return x.id == y.id;
        };

        let index: ?Nat = Buffer.indexOf(alterarCliente, clientes, localiza_index);

        switch(index){
            case(null){
                
            };
            
            case(?i){
                clientes.put(i, alterarCliente);
            };
        };
    };

    public func get_clientes(): async [Cliente]{
        return Buffer.toArray(clientes);
    };

    /* ######### PEDIDOS ######### */

    public func add_pedido (id_ped: Nat, id_cl: Nat, clienteNome: Text, pedido: Text): async (){
        id_pedido += 1;

        let ped: Pedidos = {
            id = id_ped;
            id_cliente = id_cl;
            cliente = clienteNome;
            descricao = pedido;
        };

        pedidos.add(ped);   
    };

    public func excluir_pedido(id_excluir: Nat): async(){
        func localiza_excluir(i: Nat, x: Pedido): Bool{
            return x.id != id_excluir;
        };

        pedidos.filterEntries(localiza_excluir);
    };

    public func alterar_pedido(id_ped: Nat, id_cl: Nat, clienteNome: Text, pedido: Text): async(){
        let ped: Pedidos = {id = id_ped;
            id_cliente = id_cl;
            cliente = clienteNome;
            descricao = pedido;
            };

        func localiza_index(x: Pedido, y: Pedidos): Bool {
            return x.id == y.id;
        };

        let index: ?Nat = Buffer.indexOf(ped, pedidos, localiza_index);

        switch(index){
            case(null){
                
            };

            case(?i){
                pedidos.put(i, ped);
            };
        };
    };

    public func get_pedidos(id_order: Nat): async[Pedido]{
        var arrayPedidos = Buffer.toArray<Pedido>(pedidos);

        return Array.filter<Pedido>(arrayPedidos, func(x: Pedido){x.id_pedido == id_order});
    };

};

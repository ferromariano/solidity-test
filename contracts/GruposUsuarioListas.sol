pragma solidity >=0.8.1 <0.9.0;



/* 
 * @title Usuario
 * @type schema
 */
contract Usuario {

    // variable contante pero no se como se define
    enum util_estados { VACIO, NEW, VALIDADO, DISABLED, ERROR }
    

    address identificador;
    string apodo;
    util_estados estado;
    
    
    constructor(address _identificador, string memory _apodo) {
        estado = util_estados.VACIO;
        apodo = _apodo;
    }

    function hidrateByWallet(address _identificador) public returns(bool) {
        identificador = _identificador;

    }

    function getIdentificador() public view  returns( address ) {
        return identificador;
    }

    function getApodo() public view returns( string memory) {
        return apodo;
    }

}

/* 
 * @title grupo
 * @type schema
 */
contract Grupo {

    string apodo;
    address identificador;
    GrupoUsuarios_OneToMany GrupoUsuarios;
    
    constructor(string memory _apodo) public {
        apodo = _apodo;
        
        identificador = staticGenerateAddress();

        GrupoUsuarios = new GrupoUsuarios_OneToMany( this );
    }

    function addUsuario( Usuario _usuario ) public returns(bool) {
        GrupoUsuarios.push(_usuario);
        return true;
    }

    function staticGenerateAddress() public view returns(address) {
        // descubrir como generar una adress random
        return address(this);
    }

}


contract GrupoUsuarios_OneToMany {

    struct OneToMany {
        Grupo _grupo;
        //string memory to;
        mapping( address => Usuario ) _many;
    }

    OneToMany relation;

    constructor( Grupo _grupo ) public {
        relation._grupo = _grupo;
    }

    function push( Usuario _usuario ) public {
        relation._many[ _usuario.getIdentificador() ] = _usuario;
    }

    function remove( Usuario _usuario ) public {
        delete relation._many[ _usuario.getIdentificador() ];
    }

    function length() public view returns (uint) {
        // hayq ue hacer la function
        return 0; // relation.length;
    }
}

/*
 * @title MatrisType(key => Usuario)
 * helper de estructura de datos del tipo matris/ventor 
 * @type dataMatrixEscrcture
 */
contract MatrisUsuario{
    

}


/*
 * @title TESTv1
 * @type app
 */
contract myTestv1{

    Grupo grupo;

    constructor() public {
        // aca deveria ejecutar el contrato
        
    }

}


pragma solidity >=0.8.1 <0.9.0;

import "hardhat/console.sol";

/* 
 * @title Usuario
 * @type schema
 */
contract schema_usuario {
    address _id;
    string _toString;

    enum util_estados { VACIO, NEW, VALIDADO, DISABLED, ERROR }
    util_estados estado;

    function getIdentificador() public view  returns( address ) {
        return _id;
    }

    function getApodo() public view returns( string memory) {
        return _toString;
    }


}

contract schema_grupo {
    address _id;
    string _toString;

    enum util_estados { VACIO, NEW, VALIDADO, DISABLED, ERROR }
    util_estados estado = util_estados.NEW;

    function getIdentificador() public view  returns( address ) {
        return _id;
    }

    function getApodo() public view returns( string memory) {
        return _toString;
    }

}


/* 
 * @title Usuario
 * @type instance
 */
contract Usuario is schema_usuario {

    function hidrateByWallet(address _identificador) public returns(bool) {
        _id = _identificador;

    }
}

/* 
 * @title grupo
 * @type schema
 */
contract Grupo is schema_grupo {

    string apodo;
    address identificador;
    GrupoUsuarios_OneToMany GrupoUsuarios;
    
    constructor(string memory _apodo) public {
        _id = staticGenerateAddress();
        _toString = _apodo;

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


//    function getUsuarios() public view returns( string memory) {
//       return GrupoUsuarios.all();
//    }



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
contract Aa_myTestv1{

    Grupo grupo;

    Usuario usrCurrent;

    constructor() public {
    }

    function test() public {
        initGrupo();
        generateUser();
    }

    function initGrupo() private returns(bool)  {
        grupo = new Grupo("uno");
        return true;
    }

    function generateUser() private returns(bool) {
        usrCurrent = new Usuario();
        usrCurrent.hidrateByWallet(msg.sender);
        grupo.addUsuario(usrCurrent);
        return true;
    }

    function getGrupoAddresss() public view returns(address) {
        return grupo.getIdentificador();
    }

    function getGrupoApodo() public view returns(string memory) {
        return grupo.getApodo();
    }


}


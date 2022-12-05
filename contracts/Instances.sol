pragma solidity <=0.8.1;

import "contracts/Schemas.sol";
/* 
 * @title Usuario
 * @type instance
 */
contract Usuario is schema_usuario {

    function hidrateByWallet(address _identificador) public returns(bool) {
        _id = _identificador;

    }
}


contract GrupoRelation is schema_grupo {
    GrupoUsuarios_OneToMany GrupoUsuarios;

    function addUsuario( Usuario _usuario ) public returns(bool) {
        GrupoUsuarios.push(_usuario);
        return true;
    }

}

/* 
 * @title grupo
 * @type schema
 */
contract Grupo is GrupoRelation {

    constructor(string memory _apodo) public {
        apodo = _apodo;
        
        identificador = staticGenerateAddress();

        GrupoUsuarios = new GrupoUsuarios_OneToMany( this );
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
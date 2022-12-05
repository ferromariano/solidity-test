pragma solidity <=0.8.1;

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


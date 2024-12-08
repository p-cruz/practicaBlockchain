// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract PrestamoPortatiles{
    address public owner;

    enum Estado {Disponible, Prestado}

    struct Portatil{
        string modeloPortatil;
        Estado estadoPortatil;
        address prestadoA;
    }

    mapping (uint256 => Portatil) public portatiles;

    event portatilPrestado (uint256 id, address prestadoA);
    event portatilDevuelto (uint256 id);
    event portatilEliminado (uint256 id);

    constructor () {
        owner = msg.sender; //la persona que está desplegando el smart contract en la blockchain
        portatiles[0] = Portatil("Lenovo TIC01", Estado.Disponible, address(0));
        portatiles[1] = Portatil("HP TIC02", Estado.Disponible, address(0));
        portatiles[2] = Portatil("Lenovo TIC03", Estado.Disponible, address(0));
        portatiles[3] = Portatil("TTL TIC04", Estado.Disponible, address(0));
        portatiles[4] = Portatil("TTLTIC05", Estado.Disponible, address(0));
    }

    function prestarPortatil (uint256 id) public{
        require (portatiles[id].estadoPortatil == Estado.Disponible, unicode"El portátil no está disponible para préstamo");
        portatiles[id].estadoPortatil = Estado.Prestado;
        portatiles[id].prestadoA = msg.sender;
        emit portatilPrestado(id, msg.sender);
    }

    function devolverPortatil (uint256 id) public{
        //comprobación de que el portátil está prestado
        require (portatiles[id].estadoPortatil == Estado.Prestado, unicode"El portátil no está prestado, no se puede devolver");
        //Indicar que únicamente el profesor/a que ha cogido el portátil, el que lo devuelva
        require (portatiles[id].prestadoA == msg.sender, unicode"Solo el usuario que cogió el portátil, lo puede devolver");
        portatiles[id].estadoPortatil = Estado.Disponible;
        portatiles[id].prestadoA = address(0);
        emit portatilDevuelto(id);
    }

    function consultarEstadoPortatil (uint256 id) public view returns (Estado){
        return portatiles[id].estadoPortatil;
    }

    //modifier establece una condición previa a la ejecución de una función
    modifier soloOwner(){
        require (msg.sender == owner, unicode"Solo el propietario del smart contract puede realizar esta acción de añadir portatil");
        //esta línea es sustituida por el cuerpo de la función que incorpora este modifier
        _; 
    }

    function agregarPortatil(uint256 id, string memory modelo) public soloOwner{
        require(bytes(portatiles[id].modeloPortatil).length == 0, unicode"El ID ya está en uso");
        portatiles[id] = Portatil(modelo, Estado.Disponible, address(0));
    }

    function eliminarPortatil(uint256 id) public soloOwner{
        require(bytes(portatiles[id].modeloPortatil).length != 0, unicode"El portátil no existe o ya fue eliminado");
        delete portatiles[id];
        emit portatilEliminado(id);
    }
}
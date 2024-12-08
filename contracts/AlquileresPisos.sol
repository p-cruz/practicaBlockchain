// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract AlquileresPisos {
    address public owner;

    enum Estado {Disponible, Alquilado}

    // Estructura para almacenar información de un piso
    struct Piso {
        string direccion;
        Estado estado;
        address inquilino;
    }

    mapping(uint256 => Piso) public pisos;

    event PisoAlquilado(uint256 id, address inquilino);
    event PisoDevuelto(uint256 id, address inquilino);

    constructor() {
        owner = msg.sender;
        pisos[0] = Piso("Avda America 45", Estado.Disponible, address(0));
        pisos[1] = Piso("Atocha, 87, 4B", Estado.Disponible, address(0));
        pisos[2] = Piso("C/ Luna, 98 7A", Estado.Disponible, address(0));
    }

    modifier soloOwner() {
        require(msg.sender == owner, "Solo el propietario puede realizar esta accion.");
        _;
    }

    function alquilarPiso(uint256 id) public {
        require(pisos[id].estado == Estado.Disponible, "El piso no esta disponible para alquilar.");
        pisos[id].estado = Estado.Alquilado;
        pisos[id].inquilino = msg.sender;

        emit PisoAlquilado(id, msg.sender);
    }

    function devolverPiso(uint256 id) public {
        require(pisos[id].estado == Estado.Alquilado, "El piso no esta alquilado.");
        require(pisos[id].inquilino == msg.sender, "Solo el inquilino actual puede devolver el piso.");

        pisos[id].estado = Estado.Disponible;
        pisos[id].inquilino = address(0);

        emit PisoDevuelto(id, msg.sender);
    }

    function consultarPiso(uint256 id) public view returns (string memory, Estado, address) {
        return (pisos[id].direccion, pisos[id].estado, pisos[id].inquilino);
    }
}

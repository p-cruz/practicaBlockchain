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
}
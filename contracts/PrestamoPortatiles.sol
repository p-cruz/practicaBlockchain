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

    constructor () {
        owner = msg.sender; //la persona que está desplegando el smart contract en la blockchain
        portatiles[0] = Portatil("Lenovo TIC01", Estado.Disponible, address(0));
        portatiles[1] = Portatil("HP TIC02", Estado.Disponible, address(0));
        portatiles[2] = Portatil("Lenovo TIC03", Estado.Disponible, address(0));
        portatiles[3] = Portatil("TTL TIC04", Estado.Disponible, address(0));
        portatiles[4] = Portatil("TTLTIC05", Estado.Disponible, address(0));
    }
}
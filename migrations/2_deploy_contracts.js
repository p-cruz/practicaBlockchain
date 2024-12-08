const PrestamoPortatiles = artifacts.require("PrestamoPortatiles");
const AlquileresPisos = artifacts.require("AlquileresPisos");

module.exports = function(deployer){
    deployer.deploy(PrestamoPortatiles);
};
module.exports = function(deployer){
    deployer.deploy(AlquileresPisos);
};
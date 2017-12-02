pragma solidity ^0.4.15;

contract ReportingContract {

    address[] public validators =
        [0xb40fd7dfdd4e4abd79472c76f5515e23f463f90b,
         0xb4f321c2aa960770f3a0192533ae1a6558ff4912];

    mapping(address => uint) indices;

    address public disliked;

    function ReportingContract() {
        for (uint i = 0; i < validators.length; i++) {
            indices[validators[i]] = i;
        }
    }

    // Called on every block to update node validator list.
    function getValidators() constant returns (address[]) {
        return validators;
    }
    // Expand the list of validators.
    function addValidator(address validator) {
        validators.push(validator);
    }
    // Remove a validator from the list.
    function reportMalicious(address validator) {
        validators[indices[validator]] = validators[validators.length-1];
        delete indices[validator];
        delete validators[validators.length-1];
        validators.length--;
    }
    function reportBenign(address validator) {
        disliked = validator;
    }
}
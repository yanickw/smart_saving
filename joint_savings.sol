pragma solidity ^0.5.0;

// Create JointSavings contract
contract JointSavings {

    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    //function named withdraw that will accept two arguments: `uint` variable named `amount` and `payable address` named `recipient`
    function withdraw(uint amount, address payable recipient) public {
        //require statement that checks if the `recipient` is equal to either `accountOne` or `accountTwo`.
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");

        //require` statement that checks if the `balance` is sufficient to accomplish the withdraw operation. If there are insufficient funds, the text `Insufficient funds!` is returned.
        require(address(this).balance >= amount, "Insufficient funds!");

        // `if` statement to check if the `lastToWithdraw` is not equal to `recipient` then set it to the current value of `recipient`.
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        // Calling the `transfer` function of the `recipient` and pass it the `amount` to transfer as an argument.
        recipient.transfer(amount);

        // Setting  `lastWithdrawAmount` equal to `amount`
        lastWithdrawAmount = amount;

        // Calling the `contractBalance` variable and seting it equal to the balance of the contract to reflect the new balance of the contract.
        contractBalance = address(this).balance;
    }

    // `public payable` function named `deposit`.
    function deposit() public payable {

        // Calling the `contractBalance` variable and setting it equal to the balance of the contract.
        contractBalance = address(this).balance;
    }

    // `public` function named `setAccounts` that receive two `address payable` arguments named `account1` and `account2`.
    function setAccounts(address payable account1, address payable account2) public{

        // Setting values of `accountOne` and `accountTwo` to `account1` and `account2`.
        accountOne = account1;
        accountTwo = account2;
    }

    // Adding the default fallback function so that the contract is able to store Ether sent from outside the deposit function.
    function() external payable {}
}

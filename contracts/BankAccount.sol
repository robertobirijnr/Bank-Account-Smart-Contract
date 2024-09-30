pragma solidity ^0.8.27;

contract BankAccount {
    event Deposit(
        address indexed user,
        uint indexed accoundId,
        uint value,
        uint timestamp
    );

    event WithdrawRequested(
        address indexed user,
        uint indexed accountId,
        uint indexed withdrawId,
        uint amount,
        uint timestamp
    );

    event Withdraw(uint indexed withdrawId, uint timestamp);
    event AccountCreated(address[] owners, uint indexed id, uint timestamp);

    struct WithdrawRequest {
        address user;
        uint amount;
        uint approvals;
        mapping(address => bool) ownersApproved;
        bool approved;
    }

    struct Account {
        address[] owners;
        uint balance;
        mapping(uint => WithdrawRequest) WithdrawRequests;
    }

    mapping(uint => Account) accounts;
    mapping(address => uint[]) userAccounts;

    uint nextAccountId;
    uint nextWithdrawId;

    // helper functions
    modifier accountOwner(uint accountId){
        bool isOwner;
        // loop through all the accounts
        for(uint idx; idx < accounts[accountId].owners.length; idx++){
            if(accounts[accountId].owners[idx] == msg.sender){
                isOwner = true;
                break;
            }
        }
        require(isOwner, "you are not an owner of this account");
        _;
    }

    modifier validOwners(address[] calldata owners){
        require(owners.length + 1 <=4, "maximum of 4 owners per account");
        for(uint i; i < owners.length; i++){
            for(uint j = i + 1; j < owners.length; j++){
                if(owners[i] == owners[j]){
                    revert("no duplicate owners");
                }
            }
        }
        _;
    }

    function deposit(uint accountId) external payable accountOwner(accountId){
        accounts[accountId].balance += msg.value;
    }

    function createAccount(address[] calldata otherOners) external  validOwners(otherOwners){
        // create an array of all owners
        address[] memory owners = new address[](otherOwners.length + 1);
        owners[otherOwners.length] = msg.sender;

        uint id = nextAccountId;

        // check if each user has a maximun number of accounts
        for(uint idx; idx < owners.length; idx++){
            if(idx < owners.length - 1){
                owners[idx] = otherOwners[idx];
            }

            if(userAccounts[owners[idx]].length > 2){
                revert("each user can have a mx of 3 accounts");
            }
            userAccounts[owners[idx]].push(id);
        }

        accounts[id].owners = owners;
        nextAccountId++;
        emit AccountCreated(owners, id, block.timestamp)
    }

    function requestWithdrawl(uint accountId, uint amount) external{

    }

    function approveWithdrawl(uint accountId, uint witthdrawId) external {
        
    }

    function withdraw(uint accountId, uint withdrawId) external {
        
    }

    function getBalance(uint accountId) public view returns (uint) {
        
    }
 
    function getOwners(uint accountId) public view returns (address[] memory) {
        
    }

    function getapprovals(uint accountId, uint withdrawId) public view returns (uint) {
        
    }

    function getAccounts() public view returns {
        
    }
}

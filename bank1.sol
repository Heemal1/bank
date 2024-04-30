<!DOCTYPE html>
<html lang="en">
<head>
    <title>Blockchain Bank</title>
    <!-- Load jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <!-- Load Web3.js -->
    <script src="https://cdn.jsdelivr.net/npm/web3/dist/web3.min.js"></script>
    <!-- CSS for styling -->
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <div class="bank-image">
            <img src="https://cdn.corporatefinanceinstitute.com/assets/banking-fundamentals-1024x734.jpeg" alt="Bank" />
        </div>
        <h1>Blockchain Bank</h1>
        <div class="form-group">
            <label for="amount">Amount:</label>
            <input type="text" id="amount" placeholder="Enter amount">
        </div>
        <p>Balance: <span id="balance"></span></p>
        <div class="buttons">
            <button id="deposit">Deposit</button>
            <button id="withdraw">Withdraw</button>
        </div>
    </div>

    <!-- Script with Web3.js logic -->
    <script>
        $(document).ready(function() {
            if (typeof web3 !== 'undefined') {
                // Initialize Web3 with the current provider
                web3 = new Web3(web3.currentProvider);
                
                // Request access to MetaMask accounts
                web3.eth.requestAccounts();

                // Contract ABI and address
                var address = "//address";
                var abi =//abi;
                
                // Create contract instance
                var contract = new web3.eth.Contract(abi, address);
                
                // Function to update the balance
                function updateBalance() {
                    contract.methods.getBalance().call()
                        .then(function(bal) {
                            $('#balance').text(bal);
                        })
                        .catch(function(error) {
                            console.error("Error fetching balance:", error);
                        });
                }
                
                updateBalance(); // Update balance on page load
                
                $('#deposit').click(function() {
                    var amount = parseInt($('#amount').val());
                    if (isNaN(amount) || amount <= 0) {
                        alert("Please enter a valid positive amount.");
                        return;
                    }
                    web3.eth.getAccounts()
                        .then(function(accounts) {
                            return contract.methods.deposit(amount).send({ from: accounts[0] });
                        })
                        .then(function(tx) {
                            console.log("Deposit successful:", tx);
                            updateBalance(); // Refresh balance after deposit
                        })
                        .catch(function(error) {
                            console.error("Error during deposit:", error);
                        });
                });
                
                $('#withdraw').click(function() {
                    var amount = parseInt($('#amount').val());
                    if (isNaN(amount) || amount <= 0) {
                        alert("Please enter a valid positive amount.");
                        return;
                    }
                    web3.eth.getAccounts()
                        .then(function(accounts) {
                            return contract.methods.withdraw(amount).send({ from: accounts[0] });
                        })
                        .then(function(tx) {
                            console.log("Withdraw successful:", tx);
                            updateBalance(); // Refresh balance after withdraw
                        })
                        .catch(function(error) {
                            console.error("Error during withdraw:", error);
                        });
                });
                
            } else {
                console.error("Web3 not found. Please ensure MetaMask or another provider is installed.");
            }
        );
    </script>
</body>
</html>



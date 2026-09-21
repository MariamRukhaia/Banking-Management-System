
-- SignUp
DELIMITER $$
CREATE OR REPLACE PROCEDURE signUp(IN input_username VARCHAR(250), IN input_password VARCHAR(250))
BEGIN
    DECLARE new_user_id INT;
    DECLARE new_account_id INT;

    INSERT INTO User (username, password) VALUES (input_username, input_password);
    SET new_user_id = LAST_INSERT_ID();

    INSERT INTO Account (user_id, balance) VALUES (new_user_id, 0);
    SET new_account_id = LAST_INSERT_ID();

    INSERT INTO User_Accounts (user_id, account_id) VALUES (new_user_id, new_account_id);
END$$
DELIMITER ;


-- View Transactions
DELIMITER $$
CREATE OR REPLACE PROCEDURE view_transactions(IN user_id INT)
BEGIN
    SELECT 
        transaction.type,
        transaction.sender_id,
        sender.username AS sender_name,
        transaction.sender_account_id,
        transaction.receiver_id,
        receiver.username AS receiver_name,
        transaction.receiver_account_id,
        transaction.amount,
        transaction.timestamp
    FROM transaction 
    LEFT JOIN user sender ON transaction.sender_id = sender.user_id
    LEFT JOIN user receiver ON transaction.receiver_id = receiver.user_id
    WHERE transaction.sender_id = user_id OR transaction.receiver_id = user_id
    ORDER BY transaction.timestamp DESC;
END$$
DELIMITER ;


-- Deposit
DELIMITER $$
CREATE OR REPLACE PROCEDURE deposit(IN acc_id INT, IN amount DECIMAL(10,2))
BEGIN
    UPDATE account SET balance = balance + amount WHERE account_id = acc_id;
END$$
DELIMITER ;


-- Withdraw
DELIMITER $$
CREATE OR REPLACE PROCEDURE withdraw(IN acc_id INT, IN amount DECIMAL(10,2))
BEGIN
    UPDATE account SET balance = balance - amount WHERE account_id = acc_id;
END$$
DELIMITER ;


-- Get_accounts
DELIMITER $$
CREATE OR REPLACE PROCEDURE get_accounts(IN input_user_id INT)
BEGIN
    SELECT 
        account.account_id, 
        account.balance, 
        GROUP_CONCAT(u.username SEPARATOR ', ') AS shared_with
    FROM account 
    JOIN user_accounts ua1 ON account.account_id = ua1.account_id
    LEFT JOIN user_accounts ua2 ON account.account_id = ua2.account_id AND ua1.user_id != ua2.user_id
    LEFT JOIN user u ON ua2.user_id = u.user_id
    WHERE ua1.user_id = input_user_id
    GROUP BY account.account_id;
END $$
DELIMITER ;

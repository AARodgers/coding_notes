-- Manage MySQL user accounts and roles using the phpMyAdmin graphical user interface (GUI) tool
-- Control access to MySQL databases and their objects
-- Secure your data by adding an extra layer of security using data encryption

-- Secure data using encryption
-- learn how to secure your data by adding an extra layer of security using data encryption
-- Certain parts of your database may contain sensitive information that should not be stored in plain text.
--AES (Advanced Encryption Standard) algorithm
----implement encryption and decryption of a column in the customerorders database
----AES is a symmetric encryption where the same key is used to encrypt and decrypt the data.
----The AES standard permits various key lengths. By default, a key length of 128 bits is used.
----Key lengths of 196 or 256 bits can be used. The key length is a trade-off between performance and security.

--In MySQL CLI:
-- First, you will need to hash your passphrase (consider your passphrase is My secret passphrase) with
-- a specific hash length (consider your hash length is 512) using a hash function
-- (here you will use the hash function from SHA-2 family).
-- It is good practice to hash the passphrase you use since storing the passphrase in plaintext is a
-- significant security vulnerability. Use the following command in the terminal to use the SHA2
-- algorithm to hash your passphrase and assign it to the variable key_str:

SET @key_str = SHA2('My secret passphrase', 512);

-- Now, let's take a look at the customerorders database. First, you will connect to the database by entering the following command in the CLI:

USE customerorders;

-- Next, let's take a quick look at the customers table in our database with the following command.

SELECT * FROM customers LIMIT 5;

-- For demonstration purposes, suppose that the last column in the table, labelled addressLine1,
-- contains sensitive data; storing such sensitive data in plain text is an enormous security concern,
-- so let's go ahead and encrypt that column.

-- To encrypt the addressLine1 column, you will first convert the data in the column into binary byte
-- strings of length 255 by entering the following command into the CLI.
-- Do this line in the SQL tab of phpMyAdmin(press Go to execute):
ALTER TABLE customers MODIFY COLUMN addressLine1 varbinary(255);

-- Now, to encrypt the addressLine1 column, execute the following command using the AES
--encryption standard and our hashed passphrase.

UPDATE customers SET addressLine1  = AES_ENCRYPT(addressLine1 , @key_str);

-- see if the column was successfully encrypted by taking another look at the customers table
SELECT * FROM customers LIMIT 5;

--we should still have a way to access the encrypted data when needed. To do this,
--we use the AES_DECRYPT command, and since AES is symmetric, we use the same key for both encryption
--and decryption. In our case, recall that the key was a passphrase, which was hashed and stored in the
--variable key_str. Suppose we need to access the sensitive data in that column. We can do so by entering
--the following command in the CLI:
SELECT cast(AES_DECRYPT(addressLine1 , @key_str) as char(255)) FROM customers;



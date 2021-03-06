Production Enviroment: http://secure-online-banking.herokuapp.com/

Preconfigured admin
--------------------------------------------------------------------------------------------------------------------------------
A super admin is provided with the following credentials

    Email: admin@ncsu.edu
    Password: admin
	
Before Sign-in:
--------------------------------------------------------------------------------------------------------------------------------
1. Login with the admin/user's email id
2. Signup to create a new user email.

After Sign-in:
--------------------------------------------------------------------------------------------------------------------------------
ADMIN

* Home: 
It is the landing page for the admin.
* List of Transactions: 
This displays the list of user transactions. The admin can see the transactions of various users and their accounts. The transaction statuses can be observed. Wherever the transaction is pending, the admin can either cancel the transaction or approve it.
* User List:
The user list is displayed to the admin. The user search bar can be used by the admin to search for a user. The email-id needs to be entered in order to search for the user. Here, the admin can delete a particular user if there is no pending transaction on any of his accounts.
* Accounts List:
The accounts list is displayed to the admin. Here, the admin can delete a particular account if there is no pending transaction on the accounts. By entering the user's email id directly, the admin can create an account for him/her.
* New Account Request:
The admin can see the list of account creation requests by the users. The admin can either approve or reject the account creation requests. 
* Admin Details:
Here, the admin can see the list of other admins. The delete button remains on for the admin who isn't pre-configured. The admin has the privilege to add or delete another admin. The "ADD NEW ADMIN" option helps you to create new admins.
* Edit my profile:
Here, the admin can change his account password.
* Logout


USER

* Home: 
Its the landing page for the user. The user can request a new account from this page. He can view his accounts and its balance in the drop down box. The list of transactions can be viewed on the same page.
* Make a Transfer:
The user can initiate various types of transactions here. The options provided are : Transfer, Deposit and Withdraw. Deposit and Withdrawal (above 1000) requires admin permissions. Transfers can be made to other users added as beneficiaries. 
* Search User:
This allows a user to search for other users by email and know their details to add them as beneficiaries. One needs to type the email id in the search bar.
* Manage Beneficiaries:
Manage beneficiaries allows us to add beneficiaries in order to initiate transfers. A user can add other users as beneficiaries. Also, the user can see the his own beneficiary list on the same page.
* Settings:
Here, the user can change his account password.
* Logout

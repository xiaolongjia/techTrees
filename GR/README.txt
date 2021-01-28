
DESCRIPTION

1) Development environment

-----------------------
| Software  | version |
-----------------------
| Mac OS X  |  10.15.5|
| nginx     |  1.19.6 |
| fcgi      |  2.4.2  |
| fcgiwrap  |  1.1.0  |
| spawn-fcgi|  1.6.4  |
| perl      |  5.32.1 |
-----------------------

2) Directory tree
  .
  |
  |-- assets
  |    |
  |    |-- common.js     # common js features like cookie verification, clean form etc.
  |    |
  |    |-- common.css    # common css format.
  |
  |-- bin
  |    |
  |    |-- process.fcgi  # main process program of FCGI.
  |
  |-- data
  |    |
  |    |-- orders.txt    # all orders information.
  |    |
  |    |-- password.txt  # all users information.
  |
  |-- favicon.ico        # icon image.
  |
  |-- libs
  |    |
  |    |-- Users.pm      # perl package to provide some re-used functions for back-end tasks.
  |
  |-- login.html         # authentication page.
  |
  |-- orders.html        # welcome page.
  |
  |-- tools
  |    |
  |    |changePassword.pl  # a command-line utility for setting the password for a particular user.
  |    |
  |    |getOrder.pl        # to query orders information with specified user.
  |    |
  |    |writeOrder.pl      # to write an order information into server storage.
  |
  |-- ut
  |    |
  |    |-- ut_login.pl            # unit test to login process.
  |    |
  |    |-- ut_showUserOrders.pl   # unit test to query order.
  |    |
  |    |-- ut_submitOrder.pl      # unit test to submit order.

  6 directories, 15 files. 

3) Pending feature due to limited time

3.1 The web application security need to be improved (SQL injection, Cross-site scripting).

3.2 The password management need to be improved. 

3.3 The server storage is better to use database instead of using flat text files.


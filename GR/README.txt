
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

3) How to run this package?

3.1 Run commond: spawn-fcgi -n -a [IP] -p [Port] -f /usr/local/var/www/process.fcgi &

[IP] and [PORT] should be consistent with the field 'fastcgi_pass' of /usr/local/etc/nginx/nginx.conf. For example: 

location ~ \.fcgi$ {
           root           /usr/local/var/www;
           fastcgi_pass   127.0.0.1:9900;
           fastcgi_index  index.fcgi;
           include        /usr/local/etc/nginx/fastcgi_params;
           fastcgi_param  SCRIPT_FILENAME  /usr/local/var/www$fastcgi_script_name;
}

In this case, please run: spawn-fcgi -n -a 127.0.0.1 -p 9900 -f /usr/local/var/www/process.fcgi &

3.2 Lunch the login page:  http://127.0.0.1:9999/login.html

127.0.0.1 is the local host. 

9999 is the port listening by nginx (be consistent with nginx.conf).

4) Pending features due to limited time

4.1 The web application security need to be improved (SQL injection, Cross-site scripting).

4.2 The password management need to be improved. 

4.3 The server storage is better to use database instead of using flat text files.

4.4 The frontend business process logic (FCGI actions) should be optimized folowing OO.


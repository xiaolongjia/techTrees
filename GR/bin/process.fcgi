#!/usr/local/bin/perl -T

use strict;
use warnings;
use CGI::Fast;

use lib "../libs";
use Users;

while (my $cgi = CGI::Fast->new) {
	my $action = $cgi->param("action");
	if ($action) {
		my $username = $cgi->param("username");
		my $userObj = Users->new( userId => $username);
		my $json = '';
		if ($action eq 'login') {
			my $password = $cgi->param("password");
			my $storedPasswd = $userObj->getPassword();
			my $passwordToVerified = crypt($password, Users->SALT); 
			if ($storedPasswd eq $passwordToVerified) {
				my $cookie = $cgi->cookie(-name=>'userID', -value=>"$username", -expires=>'+5m', -path=>'/');
				$json .= qq{{"success" : "login is successful", "user" : "$username"}}; 
				print $cgi->header(-cookie=>$cookie, -type => "application/json", -charset => "utf-8");
				print $json;
			} else {
				$json .= qq{{"error" : "username or password is wrong"}};
				print $cgi->header(-type => "application/json", -charset => "utf-8");
				print $json;
			}
		} elsif ($action eq 'orderQuery') {
			my $orderData = $userObj->getOrders();
			if (scalar @$orderData > 0) {
				$json .= '[';
				for (@$orderData) {
					my $currData = $_;
					$json .= qq{{"ID":"$currData->[0]", "userName":"$currData->[1]", "Date":"$currData->[2]", "Item":"$currData->[3]", "Price":"$currData->[4]"},};
				}
				chop($json);
				$json .= ']';
			} else { 
				$json .= qq{{"error":"null order!"}};
			}
			# return JSON string
			print $cgi->header(-type => "application/json", -charset => "utf-8");
			print $json;
		} elsif ($action eq 'submit') {
			my $product = $cgi->param("product");
			my $price = $cgi->param("price");
			my $return = $userObj->writeOrder($product, $price);
			$json .= ($return==0)? qq{{"Failed" : "Cancelled"}} : qq{{"success":"submitted", "product":"$product", "price":"$price","ID":"$username" }};
			# return JSON string
			print $cgi->header(-type => "application/json", -charset => "utf-8");
			print $json;
		} else {
			next;
		}
	}
}

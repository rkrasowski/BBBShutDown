#!/usr/bin/perl 
use strict;
use warnings;

################################# shutDDeamon.pl ################################
#										#
#	If 12V goes away, nicely shut down BBB 					#
#	by Robert J. Krasowski							#
#	24 January, 2014							#
#										#
#################################################################################

print "\nShut Down Deamon is working ......\n\n";

# Assign  PIN P8_15 as  GPIO to check for 12V

`echo 47 > /sys/class/gpio/export`;


while(1)
	{
		my $value = `cat /sys/class/gpio/gpio47/value`;
		if ($value == 0)
			{
				print "Shutting down the system ......\n";
				`sudo shutdown -h now`;
				select(undef,undef,undef,0.5);
				exit();

			}
		select(undef,undef,undef,0.5);
	}


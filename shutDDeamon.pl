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

my $numRecheck = 10;

print "\nShut Down Deamon is working ......\n\n";

# Assign  PIN P8_15 as  GPIO to check for 12V

`echo 47 > /sys/class/gpio/export`;


while(1)
	{
		START:
		my $value = `cat /sys/class/gpio/gpio47/value`;
		if ($value == 0)
			{
				print "Lack of power noted, will recheck it ......\n";
				# Recheck again 
				
				for(my $i = 1; $i <= $numRecheck; $i++)			
					{	
						$value = `cat /sys/class/gpio/gpio47/value`;
						if ($value == 1)
							{
								print "Power is back up, startt from the begining\n";
								goto START;
							}	
						select(undef,undef,undef,0.2);			
						print "Rechecking $i\n";
					}
				print "Lack of power CONFIRMED, will shut down.....\n";
				#`sudo shutdown -h now`;
				select(undef,undef,undef,0.5);
                                exit();
			}
		select(undef,undef,undef,0.5);
	}


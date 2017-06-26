#!/usr/bin/expect -f

# See http://stackoverflow.com/questions/19403360/how-to-use-expect-to-copy-a-public-key-to-a-host

set timeout 9
set username [lindex $argv 0]
set hostname [lindex $argv 1]
set password [lindex $argv 2]


spawn scp -q ./cleaner.sh $username@$hostname:

expect {
    timeout { send_user "\nFailed to get password prompt\n"; exit 1 }

    "*re you sure you want to continue connecting" {
        send "yes\r"
        exp_continue
    }
    "*ssword" { 
        send "$password\r"
        exp_continue
    }
}


spawn ssh -q -o StrictHostKeyChecking=no $username@$hostname /bin/bash ./cleaner.sh
 
expect {
    timeout { send_user "\nFailed to get password prompt\n"; exit 1 }
    eof { send_user "\nSSH failure for $hostname\n"; exit 1 }

    "*re you sure you want to continue connecting" {
        send "yes\r"
        exp_continue
    }
    "*ssword" { send "$password\r"; exp_continue }
}

    #eof { send_user "\nSSH failure for $hostname\n"; exit 1 }

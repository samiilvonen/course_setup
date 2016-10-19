#!/usr/bin/expect -f

set timeout 9
set hostname [lindex $argv 0]

spawn ssh-copy-id $hostname 

expect {
    timeout { send_user "\nFailed to get password prompt\n"; exit 1 }
    eof { send_user "\nSSH failure for $hostname\n"; exit 1 }

    "*re you sure you want to continue connecting" {
        send "yes\r"
        exp_continue    
    }
    "*assword*" {
        send "paaswordi\r"
        interact
        exit 0
    }
}




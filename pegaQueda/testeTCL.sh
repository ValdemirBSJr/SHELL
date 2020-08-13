#!/usr/bin/expect -f

puts "Hello world"
log_user 0
spawn ping -c 2 -i 3 -W 1 127.0.0.2

expect {
        " 0%" {puts "I'M FULLY ALIVE MATEE"}
        " 100%" {puts "NOT A SAUSAGE"}
        }

puts "done"

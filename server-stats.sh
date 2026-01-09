#!/bin/bash

echo "============== SERVER PERFORMANCE STATS ==============="
echo ""

cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "Total CPU Usage: $cpu%"

mem_total=$(free -m | awk 'NR==2 {print $2}')
mem_used=$(free -m | awk 'NR==2 {print $3}')
mem_free=$(free -m | awk 'NR==2 {print $4}')
mem_percent=$(( 100 * mem_used / mem_total ))

echo "Memory Usage: Total: ${mem_total}MB, Used: ${mem_used}MB, Free: ${mem_free}MB, Usage: ${mem_percent}%"


df -h --total | awk 'END{print "Disk Usage: Used " $3 ", Free " $4 ", Usage: " $5}'

echo "Top 5 processes by CPU:"
ps aux --sort=-%cpu | head -n 6

echo "Top 5 processes by Memory:"
ps aux --sort=-%mem | head -n 6

echo "OS Version:"
grep PRETTY_NAME /etc/os-release

echo "Uptime:"
uptime -p

echo "Load Average:"
uptime | awk -F'load average:' '{print $2}'

echo "Logged in Users:"
who

echo "Last 5 Failed Login Attempts:"
sudo lastb -n 5

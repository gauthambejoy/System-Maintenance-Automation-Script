#!/bin/bash
exec > /home/gauthambejoy/bash-project/debug_cron.log 2>&1

#Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'  

# Create logs folder if it doesn't exist
mkdir -p logs
mkdir -p backups

# Delete logs older than 7 days
find logs/ -type f -name "*.log" -mtime  +7 -exec rm {} \;

#Create a log file with current date and time
TIMESTAMP=$(date +%F-%H_%M_%S)
LOGFILE="/home/gauthambejoy/bash-project/logs/sys_report_$(date +%F_%H-%M-%S).log"
BACKUP_FILE="/home/gauthambejoy/bash-project/backups/backup_file_$(date +%F_%H-%M-%S).tar.gz"
#Write system info to log
{
	echo -e "${BLUE}===== System Report for $(date) ======${NC}"
	echo ""

	echo -e "${YELLOW}>> Disk Usage:${NC}"
	df -h
	echo""

	echo -e "${YELLOW}>>Memory Usage:${NC}"
	free -h
	echo ""

	echo -e "${YELLOW}>>System Uptime:${NC}"
	uptime
	echo ""

	echo -e "${YELLOW}>>Available System Updates:${NC}"
	apt update -qq > /dev/null
	apt list --upgradable 2>/dev/null
	echo ""

	echo -e "${GREEN}Backing up ~/bash-project folder...${NC}"
	tar -czf "$BACKUP_FILE" ~/bash-project 2>/dev/null
	echo -e "${GREEN}Backup saved to $BACKUP_FILE${NC}"
	echo ""


} >> "$LOGFILE" 2>&1

echo -e  "${BLUE}System report saved to $LOGFILE${NC}"
EMAIL="gauthambejoypriv@gmail.com"
SUBJECT="System Report - $TIMESTAMP"
{
	echo "Subject: $SUBJECT"
	echo "To: $EMAIL"
	echo "From: $EMAIL"
	echo ""
	cat "$LOGFILE"
} | msmtp "$EMAIL"

# System Maintenance & Resource Report Script

A simple Bash script that automates system resource monitoring and log management on Linux.

## Features

- Generates system usage reports (CPU, Memory, Disk)
- Organizes logs and backups automatically
- Can be scheduled via `cron`
- Redirects cron debug info to a log file
- Sends reports via email using `msmtp`

## Files

| File             | Description                             |
|------------------|-----------------------------------------|
| `sys_report.sh`  | Main script to generate and manage reports |
| `logs/`          | Contains generated reports and logs     |
| `backups/`       | Optional backups of older logs          |
| `debug_cron.log` | Cron job debug output                   |

## Usage

1. **Make the script executable**:
   ```bash
   chmod +x sys_report.sh
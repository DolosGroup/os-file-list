# OS-File-List
This project is a repository of default files on various distributions of Linux. Effectively, we went to each provider (AWS/Azure/DigitalOcean), created every Linux virtual machine and pulled a listing of every world readable file.

We also created a basic user account on each instance and listed readable files from that perspective.

## Why?
File listings can be extremely useful in web application testing. A couple use cases:
 - List of files that should exist via LFI/Directory Traversal
 - Different files and their locations can help fingerprint the distribution
 - Bypass WAFs by not using common files (e.g. /etc/passwd)

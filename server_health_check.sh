#!/bin/bash

# Output File
OUT="server_report_$(date +%F).txt"
echo "🧾 Server Health Report - Generated on $(date)" > $OUT
echo "===========================================" >> $OUT

echo -e "\n🖥️ System Info:" >> $OUT
hostnamectl >> $OUT
uname -a >> $OUT

echo -e "\n📦 Package Manager & Patches:" >> $OUT
if command -v apt &>/dev/null; then
  echo "Using apt (Debian/Ubuntu)" >> $OUT
  apt update -y > /dev/null
  apt list --upgradable | grep -i security >> $OUT
elif command -v yum &>/dev/null; then
  echo "Using yum (RHEL/CentOS)" >> $OUT
  yum check-update --security >> $OUT
else
  echo "Package manager not detected." >> $OUT
fi

echo -e "\n🧱 Open Ports:" >> $OUT
ss -tuln | grep LISTEN >> $OUT

echo -e "\n🔐 SSH Configuration:" >> $OUT
grep -E 'PermitRootLogin|PasswordAuthentication' /etc/ssh/sshd_config >> $OUT

echo -e "\n🩹 Uptime / Load Average:" >> $OUT
uptime >> $OUT

echo -e "\n💾 Memory Usage:" >> $OUT
free -h >> $OUT

echo -e "\n💽 Disk Usage:" >> $OUT
df -hT | grep -v tmpfs >> $OUT

echo -e "\n📈 Top Memory-consuming Processes:" >> $OUT
ps aux --sort=-%mem | head -n 6 >> $OUT

echo -e "\n🚀 Running Services:" >> $OUT
systemctl list-units --type=service --state=running >> $OUT

echo -e "\n✅ End of Report" >> $OUT
echo -e "\nReport saved to: $OUT"

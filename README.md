Here’s a **README.md** file you can use for your project. It includes details about the script and the cron job setup.  

---

# **Automated Jenkins Log Backup to AWS S3**

This project provides a Bash script to automate the backup of Jenkins logs to an AWS S3 bucket. It also includes instructions for scheduling the script using **cron jobs**, ensuring regular backups.

## **Features**
- Automates the process of identifying and uploading Jenkins logs to an S3 bucket.
- Filters logs based on the last modification date (current day).
- Organizes logs in S3 using job name and build number.
- Can be scheduled to run automatically using cron jobs.

---

## **Pre-Requisites**
1. **Jenkins Installation:** Ensure Jenkins is installed and running on your machine.
2. **AWS CLI:** The script uses the AWS CLI for uploading files to S3. Install and configure it:
   ```bash
   sudo apt install awscli
   aws configure
   ```
   Provide your AWS credentials and region during configuration.
3. **Permissions:** The IAM user or role associated with the AWS CLI must have the following S3 permissions:
   - `s3:PutObject`
   - `s3:GetObject`
   - `s3:ListBucket`

---

## **Script Overview**
### **`backup_logs.sh`**
The script:
1. Checks if Jenkins and AWS CLI are installed.
2. Iterates through all Jenkins job directories.
3. Filters log files modified on the current day.
4. Uploads the logs to the specified S3 bucket in the format:
   ```
   s3://<bucket_name>/<job_name>/<build_number>.log
   ```

---

## **How to Use**
### **1. Clone the Repository**
```bash
git clone https://github.com/vootlasaicharan/jenkins-log-backup-s3.git
cd jenkins-log-backup-s3
```

### **2. Configure the Script**
- Update the `JENKINS_HOME` variable in the script with your Jenkins installation directory (default: `/var/lib/jenkins`).
- Replace the `BUCKET_NAME` variable with your S3 bucket name.

### **3. Make the Script Executable**
```bash
chmod +x backup_logs.sh
```

### **4. Test the Script**
Run the script manually to ensure it works:
```bash
./backup_logs.sh
```

---

## **Automating with Cron Jobs**
### **1. Open Crontab**
```bash
crontab -e
```

### **2. Add a Cron Job**
Choose a schedule and add the following line to run the script. For example:
- **Run daily at midnight**:
  ```bash
  0 0 * * * /path/to/backup_logs.sh >> /path/to/backup_logs.log 2>&1
  ```

- **Run every hour**:
  ```bash
  0 * * * * /path/to/backup_logs.sh >> /path/to/backup_logs.log 2>&1
  ```

### **3. Verify Cron Job**
List your cron jobs to confirm:
```bash
crontab -l
```

---

## **Project Structure**
```
jenkins-log-backup-s3/
├── backup_logs.sh   # The main script for Jenkins log backup
├── README.md        # Documentation
```

---

## **Future Enhancements**
- Add email notifications for backup status.
- Extend support for logs older than one day.
- Add integration with monitoring tools for error alerts.

---

## **Contributions**
Contributions are welcome! Feel free to open issues or submit pull requests to improve the script.

---

Let me know if you want to include any additional sections or information! 😊

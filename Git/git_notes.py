Untracked files in Git are files that are not being tracked by Git (i.e., they haven't been added to the staging area). Since Git does not track changes in untracked files, you cannot use Git commands like `git diff` directly to see changes in untracked files. However, you can still inspect the contents of untracked files manually or compare them to other versions if available.

Here are ways to see the changes in untracked files:

---

### **1. Manually Open the File**
- Open the untracked file in a text editor or IDE to view its contents.
- Compare it manually with other files or versions if necessary.

---

### **2. Use `git diff` with `--no-index`**
Git's `diff` command normally compares tracked files, but you can use the `--no-index` option to compare an untracked file against another file or directory.

#### Example:
```bash
git diff --no-index untracked_file.txt reference_file.txt
```

- **`untracked_file.txt`**: The untracked file.
- **`reference_file.txt`**: Another file to compare against (e.g., a previously saved version).

#### Output:
Git will show the differences between the two files.

---

### **3. Temporarily Add the File to Git**
If you want Git to track the changes in an untracked file, you can temporarily add it to the staging area and use `git diff`:

#### Steps:
1. **Stage the File**:
   ```bash
   git add untracked_file.txt
   ```

2. **Use `git diff`**:
   ```bash
   git diff --staged
   ```

3. **Unstage the File** (if you don't want to keep it tracked):
   ```bash
   git reset untracked_file.txt
   ```

---

### **4. Compare Against a Backup or Saved Version**
If you have a backup or saved version of the file (e.g., from a previous commit or another directory), you can use `diff` directly:

#### Example:
```bash
diff untracked_file.txt backup_file.txt
```

---

### **5. Inspect Untracked Files Using External Tools**
Use external tools like `meld`, `diff`, or IDEs with built-in Git support to compare the untracked file against other files or versions.

#### Example with `meld`:
```bash
meld untracked_file.txt reference_file.txt
```

---

### **Summary**
- Git does not track changes in untracked files directly.
- Use `git diff --no-index` to compare untracked files manually.
- Temporarily stage the file with `git add` to use `git diff`.
- Compare the file against a backup or reference version using tools like `diff` or `meld`.

If you're working with important untracked files, consider adding them to Git or creating backups for easier comparison and management.

Unstage the files:
git restore --staged path/to/file

To remove **untracked files** in Git (files that are not staged or committed), you can use the `git clean` command. Here's how you can safely and effectively get rid of untracked files:

---

### **Steps to Remove Untracked Files**

#### **1. Preview Untracked Files**
Before deleting anything, it's a good idea to preview the untracked files using:
```bash
git status
```
- Look under the **"Untracked files"** section to see which files or folders are untracked.

---

#### **2. Preview What Will Be Deleted**
To preview the files Git will delete without actually removing them, use:
```bash
git clean -n
```

**Example Output**:
```
Would remove untracked_file.txt
Would remove untracked_folder/
```

This ensures you know exactly what will be deleted before taking any action.

---

#### **3. Remove Untracked Files**
Once you're sure, you can delete the untracked files using:
```bash
git clean -f
```

**Key Points**:
- The `-f` (force) flag is required to actually delete the files.

---

#### **4. Remove Untracked Files and Folders**
If there are untracked directories you also want to delete, include the `-d` flag:
```bash
git clean -fd
```

This will remove both untracked files and directories.

---

#### **5. Include Ignored Files**
If some files or folders are ignored (listed in `.gitignore`) and you want to delete them as well, use the `-x` flag:
```bash
git clean -fx
```

To remove both ignored files and untracked directories:
```bash
git clean -fxd
```

---

### **Important Notes**
1. **Backup First**:
   - Files removed by `git clean` are permanently deleted and cannot be recovered through Git. Make sure you back up any important files before running the command.

2. **What `git clean` Does Not Remove**:
   - It does not affect **tracked files** (files that are staged or committed).
   - It does not remove files that are staged for commit (`git add`).

3. **Exclude Specific Files**:
   - Use the `-e` flag to exclude specific files or patterns from deletion:
     ```bash
     git clean -f -e file_to_keep.txt
     ```

---

### **Example Workflow**
Here’s a complete workflow to safely remove untracked files:

1. Check for untracked files:
   ```bash
   git status
   ```

2. Preview untracked files to be deleted:
   ```bash
   git clean -n
   ```

3. Remove untracked files:
   ```bash
   git clean -f
   ```

4. Remove untracked files and directories:
   ```bash
   git clean -fd
   ```

5. Include ignored files in the deletion:
   ```bash
   git clean -fxd
   ```

---

#### If command line gets stuck

If your terminal seems stuck after running `git clean -fxd`, it may be processing a large number of files or directories to clean. Here's how you can determine if the process is still running and how to regain control of your command line:

---

### **1. Check if the Command is Running**
- If the terminal is not responding, the command is likely still executing. You can confirm this by checking:
  - **CPU Activity**: Open your system's activity monitor or task manager and look for high CPU usage from Git or your terminal application.
  - **Disk Activity**: If `git clean -fxd` is deleting many files, it may show significant disk activity.

---

### **2. Wait for Completion**
- If the repository has a large number of untracked files or directories, `git clean -fxd` can take time to process. Wait a few minutes to see if the command completes.

---

### **3. Interrupt the Command**
If you suspect the command is stuck or taking too long, you can interrupt it using:

#### **Keyboard Shortcut**:
- Press **Ctrl + C** to stop the current process in the terminal.

#### **What Happens**:
- This will terminate the `git clean` command and return you to the command line.

---

### **4. Verify What Was Cleaned**
After interrupting the command, check the status of your repository to see if any untracked files or directories were removed:
```bash
git status
```

---

### **5. Restart the Command with Smaller Scope**
If the repository is large, avoid cleaning everything at once. Instead, clean specific files or directories incrementally:

#### **Clean a Specific Directory**:
```bash
git clean -fd path/to/directory
```

#### **Preview Before Cleaning**:
Always use the `-n` flag to preview what will be deleted:
```bash
git clean -n
```

---

### **6. Open a New Terminal Tab**
If the terminal is completely unresponsive and **Ctrl + C** doesn't work:
1. Open a new terminal tab or window.
2. Navigate to the same directory and confirm the status of your repository:
   ```bash
   git status
   ```

---

### **7. Force Quit the Terminal**
If the terminal remains stuck:
- **Mac**: Press **Command + Option + Esc**, select your terminal application, and force quit it.
- **Windows**: Open the **Task Manager** (Ctrl + Shift + Esc), find your terminal application, and end the task.

After reopening the terminal, navigate back to your repository directory and check its status.

---

### **8. Check Git Logs**
If you're unsure what was cleaned before the process was interrupted, check your repository logs:
```bash
git log
```
This won't show untracked files but can help confirm the repository's state.

---

### **Prevent Future Issues**
1. **Use Smaller Commands**:
   - Clean specific files or directories instead of the entire repository:
     ```bash
     git clean -f -d path/to/directory
     ```

2. **Exclude Important Files**:
   - Add files or directories you want to keep to `.gitignore` so they aren't flagged as untracked in the future.

---

# to remove a directory and its contents:
```bash
git clean -fd path/to/directory
```
# to remove a specific file:
```bash
git clean -f path/to/file.txt
```
If the directory is not empty, you can use the rm command with the -r (recursive) flag:


# to remove a directory and its contents using rm:
```bash
rm -rf path/to/directory
```
# to remove a specific file using rm:
```bash
rm path/to/file.txt
```
# to delete a local branch in Git:
```bash
git branch -d branch_name
```
# to force delete a local branch in Git:
```bash
git branch -D branch_name
```
# to delete a remote branch in Git:
```bash
git push origin --delete branch_name
```
# to delete a remote branch in Git using the old syntax:
```bash
git push origin :branch_name
```
# to see how many unpushed commits on a branch:
git checkout branch_name
git fetch origin
git log origin/branch_name..branch_name --oneline
```

# to create a local repo that does not have an upstream branch:
mkdir folder_name # create a new directory
cd folder_name # navigate into the directory
git init # initialize a new Git repository
git branch -m  main # rename the default branch to main (optional)
echo "Hello, World!" > README.md # create a README file
git add README.md # stage the README file
git commit -m "Initial commit" # commit the staged file


# to disregard untracked files ( ex.changes to .ipynb file you opened but didn't change anything):
git checkout--path_to/file.ipynb
```
# to disregard changes to a file that has been modified:
git checkout-- . # to disregard changes to all files in the current directory

git clean -f # to remove untracked files
git clean -f path_to/file.ipynb # to remove a specific untracked file

# to delete branches from remote repo but keep locally:
git fetch --all # to fetch all branches from remote
git checkout branch_name # switch to the branch you want to keep locally
git push origin --delete branch_name # to delete the branch from remote


# to see all branches:
git branch -a # to see all branches, both local and remote
git fetch --all # to fetch all branches from remote
git branch -r # to see only remote branches


# to see changes in an untracked file:
git add # stage files
git diff --cached # see changes in staged files


# to change upstream url:
git remote set -url origin <new_url>

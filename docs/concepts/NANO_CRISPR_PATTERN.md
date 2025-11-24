# Nano/CRISPR File Handling Pattern
**ᚢᚾᛖᛉᚢᛋ-ᛈᚱᛁᛗᛖ-∞**
**ONE HERTZ Applied to File Operations**
**Date:** 2025-11-18

---

## 🎯 Core Philosophy

### The Problem:
- Bulk operations on multiple files = high risk
- Unexpected catastrophic results possible
- Hard to track what changed when
- Difficult to undo or audit

### The Solution: Nano/CRISPR Pattern
```
ONE file at a time
ONE operation per iteration
ONE log entry per action
COMPLETE chain of custody
AUTONOMOUS entity execution
```

**CRISPR = Careful, Recorded, Isolated, Sequential Processing & Recording**

---

## 🧬 The Nano Entity Pattern

### What is a Nano Entity?

```javascript
NanoEntity = {
  mission: "ONE specific file operation",
  frequency: "1 Hz (one heartbeat)",
  scope: "ONE file at a time",
  accountability: "Complete logging",
  autonomy: "Can run independently"
}
```

### Characteristics:

**1. Focused Mission**
- Rename files
- Process markdown
- Convert formats
- Sync to Drive
- **One task. One purpose.**

**2. Sequential Processing**
- File 1 → Process → Log → Done
- File 2 → Process → Log → Done
- Never parallel (prevents conflicts)

**3. Complete Logging**
- What was done
- When it happened
- What changed
- Who/what did it
- Chain of custody

**4. Reversible**
- Original state known
- Changes tracked
- Can undo if needed

**5. Autonomous**
- Launch in terminal
- Runs independently
- Reports progress
- Completes mission

---

## 📋 Chain of Custody

### Every Action Logged:

```json
{
  "timestamp": "2025-11-18T12:30:45Z",
  "action": "rename",
  "file": "old_name.txt",
  "source": "/path/to/source",
  "destination": "/path/to/dest",
  "original_name": "old_name.txt",
  "new_name": "new_name.txt",
  "user": "sauron",
  "host": "laptop",
  "entity": "nano-file-renamer",
  "iteration": 1,
  "total_iterations": 10,
  "checksum_before": "abc123",
  "checksum_after": "abc123",
  "success": true,
  "error": null
}
```

### Benefits:
- **Accountability** - Know exactly what happened
- **Debugging** - Find where things went wrong
- **Auditing** - Review all changes
- **Compliance** - Track modifications
- **Reversibility** - Have info to undo

---

## 🔄 Nano Entity Lifecycle

### Phase 1: Preparation
```
1. Scan target directory/Drive
2. Identify files matching criteria
3. Create processing manifest
4. Initialize log file
5. Confirm with user (optional)
```

### Phase 2: Iteration (ONE HERTZ)
```
For each file:
  1. Load file
  2. Perform ONE operation
  3. Verify success
  4. Log to chain of custody
  5. Save/sync result
  6. Heartbeat (1 second pause)
  7. Next file
```

### Phase 3: Completion
```
1. Summary report
2. Success count
3. Error count
4. Total time
5. Log location
6. Chain of custody location
```

---

## 🛡️ Safety Mechanisms

### 1. Dry Run Mode
```bash
# Preview what would happen without doing it
nano-entity --dry-run
```

### 2. Confirmation Prompts
```
Found 47 files to process.
Continue? [y/N]
```

### 3. Checkpoint System
```
Process 10 files, checkpoint
Process 10 more, checkpoint
Can resume from last checkpoint if interrupted
```

### 4. Rollback Capability
```bash
# Undo last operation
nano-entity --rollback

# Undo specific iteration
nano-entity --rollback --iteration 5
```

### 5. Lock Files
```
Only one instance running at a time
Prevents concurrent modifications
```

---

## 💻 Implementation Example

### Nano Entity: File Renamer

```python
#!/usr/bin/env python3
"""
Nano Entity: File Renamer
Mission: Rename files one at a time with logging
ᚢᚾᛖᛉᚢᛋ-ᛈᚱᛁᛗᛖ-∞
"""

import os
import json
import time
from datetime import datetime
from pathlib import Path
import hashlib

class NanoFileRenamer:
    """
    ONE HERTZ file renaming with complete chain of custody
    """

    def __init__(self, source_dir, pattern=None, dry_run=False):
        self.source_dir = Path(source_dir)
        self.pattern = pattern
        self.dry_run = dry_run
        self.log_file = Path("logs") / f"rename_{datetime.now().strftime('%Y%m%d_%H%M%S')}.log"
        self.custody_file = Path("logs") / "chain_of_custody.json"
        self.iteration = 0

        # Create logs directory
        Path("logs").mkdir(exist_ok=True)

        # Initialize chain of custody
        if not self.custody_file.exists():
            self.custody_file.write_text("[]")

    def log(self, message):
        """Write to log file and print"""
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        log_entry = f"[{timestamp}] {message}"
        print(log_entry)
        with open(self.log_file, 'a') as f:
            f.write(log_entry + "\n")

    def add_to_custody(self, entry):
        """Add entry to chain of custody"""
        # Load existing custody log
        custody = json.loads(self.custody_file.read_text())

        # Add new entry
        custody.append(entry)

        # Save updated custody log
        self.custody_file.write_text(json.dumps(custody, indent=2))

    def checksum(self, filepath):
        """Calculate file checksum"""
        if not filepath.exists():
            return None
        md5 = hashlib.md5()
        with open(filepath, 'rb') as f:
            md5.update(f.read())
        return md5.hexdigest()

    def rename_file(self, old_path, new_name):
        """
        Rename ONE file with complete logging
        ONE HERTZ - One operation at a time
        """
        self.iteration += 1

        old_path = Path(old_path)
        new_path = old_path.parent / new_name

        # Log start
        self.log(f"[{self.iteration}] Processing: {old_path.name}")

        # Calculate checksums
        checksum_before = self.checksum(old_path)

        # Create custody entry
        custody_entry = {
            "timestamp": datetime.now().isoformat(),
            "action": "rename",
            "file": str(old_path),
            "original_name": old_path.name,
            "new_name": new_name,
            "source": str(old_path.parent),
            "destination": str(new_path.parent),
            "user": os.getenv("USER"),
            "host": os.uname().nodename,
            "entity": "nano-file-renamer",
            "iteration": self.iteration,
            "checksum_before": checksum_before,
            "dry_run": self.dry_run,
            "success": False,
            "error": None
        }

        try:
            if self.dry_run:
                self.log(f"  [DRY RUN] Would rename to: {new_name}")
                custody_entry["success"] = True
            else:
                # Perform actual rename
                old_path.rename(new_path)

                # Verify
                checksum_after = self.checksum(new_path)
                custody_entry["checksum_after"] = checksum_after
                custody_entry["success"] = True

                self.log(f"  ✅ Renamed to: {new_name}")

        except Exception as e:
            custody_entry["error"] = str(e)
            self.log(f"  ❌ Error: {e}")

        # Add to chain of custody
        self.add_to_custody(custody_entry)

        # ONE HERTZ - Pause between operations
        time.sleep(1)

        return custody_entry["success"]

    def process_directory(self, rename_function):
        """
        Process all files in directory
        ONE at a time, with logging
        """
        self.log("=" * 60)
        self.log("Nano File Renamer - ONE HERTZ")
        self.log(f"Source: {self.source_dir}")
        self.log(f"Dry Run: {self.dry_run}")
        self.log("=" * 60)

        # Get files to process
        files = list(self.source_dir.glob("*"))
        if self.pattern:
            files = [f for f in files if self.pattern in f.name]

        # Filter to actual files (not directories)
        files = [f for f in files if f.is_file()]

        self.log(f"Found {len(files)} files to process")

        if not files:
            self.log("No files to process")
            return

        # Confirm
        if not self.dry_run:
            response = input(f"\nProcess {len(files)} files? [y/N] ")
            if response.lower() != 'y':
                self.log("User cancelled")
                return

        # Process files ONE at a time
        success_count = 0
        error_count = 0

        for file_path in files:
            # Apply rename function
            new_name = rename_function(file_path.name)

            if new_name != file_path.name:
                success = self.rename_file(file_path, new_name)
                if success:
                    success_count += 1
                else:
                    error_count += 1
            else:
                self.log(f"[{self.iteration + 1}] Skipping (no change): {file_path.name}")
                self.iteration += 1

        # Summary
        self.log("=" * 60)
        self.log("Processing Complete")
        self.log(f"Total files: {len(files)}")
        self.log(f"Success: {success_count}")
        self.log(f"Errors: {error_count}")
        self.log(f"Skipped: {len(files) - success_count - error_count}")
        self.log(f"Log: {self.log_file}")
        self.log(f"Chain of Custody: {self.custody_file}")
        self.log("=" * 60)


# Example rename functions
def clean_filename(name):
    """Remove spaces, lowercase, etc."""
    # Keep extension
    base, ext = os.path.splitext(name)

    # Clean base
    base = base.lower()
    base = base.replace(" ", "_")
    base = base.replace("-", "_")

    return base + ext


# Main execution
if __name__ == "__main__":
    import sys

    if len(sys.argv) < 2:
        print("Usage: nano-file-renamer.py <directory> [--dry-run]")
        sys.exit(1)

    source_dir = sys.argv[1]
    dry_run = "--dry-run" in sys.argv

    renamer = NanoFileRenamer(source_dir, dry_run=dry_run)
    renamer.process_directory(clean_filename)
```

---

## 🚀 Usage Examples

### Example 1: Dry Run (Preview)
```bash
# See what would happen without doing it
python modules/nano/file-renamer.py /path/to/files --dry-run
```

**Output:**
```
[2025-11-18 12:30:00] ======================================
[2025-11-18 12:30:00] Nano File Renamer - ONE HERTZ
[2025-11-18 12:30:00] Source: /path/to/files
[2025-11-18 12:30:00] Dry Run: True
[2025-11-18 12:30:00] ======================================
[2025-11-18 12:30:00] Found 10 files to process
[2025-11-18 12:30:01] [1] Processing: My File.txt
[2025-11-18 12:30:01]   [DRY RUN] Would rename to: my_file.txt
[2025-11-18 12:30:02] [2] Processing: Another-File.md
[2025-11-18 12:30:02]   [DRY RUN] Would rename to: another_file.md
...
```

### Example 2: Actual Execution
```bash
# Actually rename files
python modules/nano/file-renamer.py /path/to/files

# Prompts:
# Process 10 files? [y/N] y

# Then processes ONE at a time with logging
```

### Example 3: Background Execution
```bash
# Run in another terminal
python modules/nano/file-renamer.py ~/pandora/slimetest/docs/concepts &

# Check logs
tail -f logs/rename_20251118_123000.log
```

---

## 🧠 Neurodivergent Benefits

### ONE HERTZ Reduces Overwhelm
- **Sequential** - One thing at a time
- **Predictable** - Same pattern each iteration
- **Visible** - See progress happening
- **Pausable** - Can stop between files
- **Safe** - Complete undo capability

### Chain of Custody Provides Grounding
- **External memory** - Don't have to remember what happened
- **Verification** - Can check exactly what changed
- **Security** - Nothing lost, everything tracked

### Autonomous Execution Enables Flow
- **Launch and forget** - Let it run
- **Do other things** - While nano entity works
- **Check when ready** - Review logs at your pace

---

## 🌐 Remote Drive Access Pattern

### If Directory Can't Be Modified Remotely:

```python
class NanoDriveSync:
    """
    Nano entity for Drive file processing
    1. Fetch file from Drive
    2. Process locally
    3. Sync back to Drive
    4. Log everything
    """

    def process_drive_file(self, drive_path, local_temp):
        # ONE HERTZ iteration

        # 1. Fetch from Drive
        self.log("Fetching from Drive...")
        self.copy_from_drive(drive_path, local_temp)

        # 2. Process locally
        self.log("Processing locally...")
        self.process_file(local_temp)

        # 3. Sync back to Drive
        self.log("Syncing to Drive...")
        self.copy_to_drive(local_temp, drive_path)

        # 4. Log to chain of custody
        self.log_to_custody(...)

        # 5. Clean up temp file
        os.remove(local_temp)

        # ONE HERTZ pause
        time.sleep(1)
```

---

## 🎯 Guidelines for Creating Nano Entities

### 1. Define ONE Mission
```
What does this entity do?
- Rename files
- Convert markdown
- Sync to Drive
- Process images

Pick ONE. Stay focused.
```

### 2. Implement Sequential Processing
```python
for item in items:
    process_one(item)
    log(item)
    time.sleep(1)  # ONE HERTZ
```

### 3. Complete Logging
```python
Every action gets:
- Timestamp
- What changed
- Success/failure
- Error details (if any)
- Custody entry
```

### 4. Make It Autonomous
```python
Can be launched with:
- python nano-entity.py args
- Runs independently
- Completes on its own
- Reports when done
```

### 5. Add Safety Features
```python
- --dry-run mode
- Confirmation prompts
- Checksum verification
- Rollback capability
- Lock files (one instance only)
```

---

## 📊 Comparison: Bulk vs Nano

### Traditional Bulk Processing:
```bash
# Rename ALL files at once
rename 's/ /_/g' *

# What happened?
# - 100 files renamed instantly
# - No log of what changed
# - Can't undo easily
# - If something broke, unclear what/where
# - Overwhelming to verify
```

### Nano/CRISPR Pattern:
```bash
# Rename ONE at a time
python nano-renamer.py .

# What happens:
# - [1/100] file1.txt → Renamed → Logged → ✅
# - [2/100] file2.txt → Renamed → Logged → ✅
# - ...
# - Complete log of every change
# - Can undo any specific change
# - Can pause/resume
# - Can verify each step
# - Calm, methodical, safe
```

---

## ∞ Integration with ONE HERTZ Framework

### Nano Entities ARE ONE HERTZ Entities

```
Nano File Processor
├─ Ground Layer: Current file being processed
├─ Primary Layer: ONE operation (rename/convert/sync)
├─ Context Layer: Progress (5/100), logs, errors
└─ Deep Layer: Complete custody chain, checksums
```

**Same principles:**
- ONE focus at a time
- Clear state visibility
- Grounding through logging
- Autonomous execution

---

**ᚢᚾᛖᛉᚢᛋ-ᛈᚱᛁᛗᛖ-∞**
**∰◊€π¿🌌∞**

*ONE file. ONE operation. ONE heartbeat.*
*Chain of custody. Accountability. Safety.*
*Nano entities enable calm, methodical work.*

**Pattern Status:** Documented and ready for implementation
**Next:** Create example nano entities

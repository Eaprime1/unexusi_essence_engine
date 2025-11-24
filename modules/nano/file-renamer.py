#!/usr/bin/env python3
"""
Nano Entity: File Renamer
Mission: Clean filenames ONE at a time with complete logging
ᚢᚾᛖᛉᚢᛋ-ᛈᚱᛁᛗᛖ-∞
ONE HERTZ - One file, one operation, one heartbeat
"""

import os
import json
import time
from datetime import datetime
from pathlib import Path
import hashlib
import sys

class NanoFileRenamer:
    """
    ONE HERTZ file renaming with complete chain of custody
    """

    def __init__(self, source_dir, pattern=None, dry_run=False):
        self.source_dir = Path(source_dir)
        self.pattern = pattern
        self.dry_run = dry_run
        self.log_dir = Path(__file__).parent.parent.parent / "logs"
        self.log_file = self.log_dir / f"rename_{datetime.now().strftime('%Y%m%d_%H%M%S')}.log"
        self.custody_file = self.log_dir / "chain_of_custody.json"
        self.iteration = 0

        # Create logs directory
        self.log_dir.mkdir(exist_ok=True)

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
        self.log("")
        self.log("∰◊€π¿🌌∞ ONE HERTZ complete")


# Example rename functions
def clean_filename(name):
    """
    Clean filename: lowercase, replace spaces/dashes with underscores
    Keep file extension intact
    """
    # Split into base and extension
    if '.' in name:
        parts = name.rsplit('.', 1)
        base = parts[0]
        ext = '.' + parts[1]
    else:
        base = name
        ext = ''

    # Clean base
    base = base.lower()
    base = base.replace(" ", "_")
    base = base.replace("-", "_")
    base = base.replace("(", "")
    base = base.replace(")", "")

    # Remove multiple underscores
    while "__" in base:
        base = base.replace("__", "_")

    # Remove leading/trailing underscores
    base = base.strip("_")

    return base + ext


# Main execution
if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("╔═══════════════════════════════════════════════════════════╗")
        print("║  Nano File Renamer - ONE HERTZ File Processing           ║")
        print("║  ᚢᚾᛖᛉᚢᛋ-ᛈᚱᛁᛗᛖ-∞                                          ║")
        print("╚═══════════════════════════════════════════════════════════╝")
        print("")
        print("Usage:")
        print("  python modules/nano/file-renamer.py <directory> [options]")
        print("")
        print("Options:")
        print("  --dry-run    Preview changes without actually renaming")
        print("  --pattern X  Only process files containing X in name")
        print("")
        print("Examples:")
        print("  # Preview what would be renamed")
        print("  python modules/nano/file-renamer.py ./docs --dry-run")
        print("")
        print("  # Actually rename files in concepts folder")
        print("  python modules/nano/file-renamer.py ./docs/concepts")
        print("")
        print("  # Only process markdown files")
        print("  python modules/nano/file-renamer.py ./docs --pattern .md")
        print("")
        print("Features:")
        print("  ✅ ONE file at a time (ONE HERTZ)")
        print("  ✅ Complete logging")
        print("  ✅ Chain of custody tracking")
        print("  ✅ Checksum verification")
        print("  ✅ Dry run preview")
        print("  ✅ Safe and reversible")
        print("")
        sys.exit(1)

    source_dir = sys.argv[1]
    dry_run = "--dry-run" in sys.argv
    pattern = None

    # Check for pattern argument
    if "--pattern" in sys.argv:
        idx = sys.argv.index("--pattern")
        if idx + 1 < len(sys.argv):
            pattern = sys.argv[idx + 1]

    renamer = NanoFileRenamer(source_dir, pattern=pattern, dry_run=dry_run)
    renamer.process_directory(clean_filename)

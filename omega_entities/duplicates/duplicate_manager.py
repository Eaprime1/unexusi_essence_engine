#!/usr/bin/env python3
# ∰◊€π¿🌌∞ Duplicate Manager Entity
# ONE MISSION: Intelligent duplicate file detection with gaming interface

import os
import hashlib
import json
from pathlib import Path
from collections import defaultdict
import argparse

class DuplicateManagerEntity:
    def __init__(self):
        self.name = "DuplicateManagerEntity"
        self.mission = "Intelligent duplicate detection with gaming interface"
        self.report_dir = Path.home() / "universe_logs" / "duplicate_reports"
        self.report_dir.mkdir(parents=True, exist_ok=True)
        
    def calculate_file_hash(self, filepath):
        """Calculate MD5 hash of file for duplicate detection"""
        hash_md5 = hashlib.md5()
        try:
            with open(filepath, "rb") as f:
                for chunk in iter(lambda: f.read(4096), b""):
                    hash_md5.update(chunk)
            return hash_md5.hexdigest()
        except Exception as e:
            print(f"Error hashing {filepath}: {e}")
            return None
    
    def scan_directory(self, directory):
        """Scan directory for files and group by hash"""
        print(f"🔍 Scanning directory: {directory}")
        file_hashes = defaultdict(list)
        
        for root, dirs, files in os.walk(directory):
            for file in files:
                filepath = Path(root) / file
                file_hash = self.calculate_file_hash(filepath)
                if file_hash:
                    file_info = {
                        'path': str(filepath),
                        'size': filepath.stat().st_size,
                        'modified': filepath.stat().st_mtime
                    }
                    file_hashes[file_hash].append(file_info)
        
        return file_hashes
    
    def find_duplicates(self, file_hashes):
        """Identify duplicate files"""
        duplicates = {}
        for file_hash, files in file_hashes.items():
            if len(files) > 1:
                duplicates[file_hash] = files
        return duplicates
    
    def gaming_interface(self, duplicates):
        """Gaming-style interface for duplicate management"""
        print("\n🎮 DUPLICATE MANAGEMENT GAME INTERFACE")
        print("=====================================")
        print("Choose your character approach:")
        print("1. 🗡️  Warrior (Aggressive deletion)")
        print("2. 🧙‍♂️  Sage (Careful analysis)")
        print("3. 🕵️  Detective (Detailed investigation)")
        print("4. 🏃‍♂️  Scout (Quick overview)")
        
        choice = input("\nSelect character (1-4): ").strip()
        
        characters = {
            '1': {'name': 'Warrior', 'emoji': '🗡️', 'style': 'aggressive'},
            '2': {'name': 'Sage', 'emoji': '🧙‍♂️', 'style': 'analytical'},
            '3': {'name': 'Detective', 'emoji': '🕵️', 'style': 'detailed'},
            '4': {'name': 'Scout', 'emoji': '🏃‍♂️', 'style': 'overview'}
        }
        
        character = characters.get(choice, characters['2'])
        print(f"\n{character['emoji']} You chose {character['name']}!")
        
        return character
    
    def generate_report(self, directory, duplicates, character):
        """Generate duplicate analysis report"""
        report_file = self.report_dir / f"duplicate_scan_{Path(directory).name}_{character['name'].lower()}.json"
        
        report = {
            'scan_info': {
                'directory': directory,
                'character': character,
                'timestamp': str(Path().resolve()),
                'total_duplicate_groups': len(duplicates)
            },
            'duplicates': duplicates,
            'summary': {
                'total_files_with_duplicates': sum(len(files) for files in duplicates.values()),
                'wasted_space_bytes': sum(sum(f['size'] for f in files[1:]) for files in duplicates.values())
            }
        }
        
        with open(report_file, 'w') as f:
            json.dump(report, f, indent=2)
        
        print(f"📋 {character['emoji']} Report saved: {report_file}")
        return report_file
    
    def execute_mission(self, directory):
        """Main execution function"""
        print(f"🚀 {self.name} Mission Started")
        print(f"📁 Target: {directory}")
        
        # Scan for files
        file_hashes = self.scan_directory(directory)
        
        # Find duplicates
        duplicates = self.find_duplicates(file_hashes)
        
        if not duplicates:
            print("🎉 No duplicates found! Directory is clean.")
            return
        
        print(f"\n⚠️  Found {len(duplicates)} groups of duplicate files")
        
        # Gaming interface
        character = self.gaming_interface(duplicates)
        
        # Generate report
        report_file = self.generate_report(directory, duplicates, character)
        
        print(f"\n✅ {character['emoji']} {self.name} Mission Complete!")
        print(f"📊 Analysis style: {character['name']}")
        
        return report_file

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Duplicate Manager Entity")
    parser.add_argument("directory", help="Directory to scan for duplicates")
    args = parser.parse_args()
    
    manager = DuplicateManagerEntity()
    manager.execute_mission(args.directory)

from pathlib import Path
check_dir = Path("sagemath/check/odd-orbit-selection")
if not check_dir.is_dir():
    check_dir = Path(".")
check_paths = sorted(check_dir.resolve().glob("check_*.sage"))
assert len(check_paths) == 13
for check_path in check_paths:
    __file__ = str(check_path)
    load(__file__)
print("odd-orbit-selection: 13 files; RESULT: PASS")

from pathlib import Path

check_dir = Path(__file__).resolve().parent
check_paths = sorted(check_dir.glob("check_*.sage"))
assert len(check_paths) == 31
for check_path in check_paths:
    __file__ = str(check_path)
    load(__file__)
assert len(sop_results) == 30
print("RESULT: PASS (30 rows; " + str(sum(sop_results.values())) + " exact checks; 31 files)")

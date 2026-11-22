from pathlib import Path

check_dir = Path(__file__).resolve().parent
check_paths = sorted(check_dir.glob("check_*.sage"))
assert len(check_paths) == 33
for check_path in check_paths:
    __file__ = str(check_path)
    load(__file__)
assert len(irs_results) == 32
print("RESULT: PASS (32 rows; " + str(sum(irs_results.values())) + " exact checks; 33 files)")

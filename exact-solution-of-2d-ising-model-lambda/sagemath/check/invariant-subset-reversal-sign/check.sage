from pathlib import Path

check_dir = Path(__file__).resolve().parent
check_paths = sorted(check_dir.glob("check_*.sage"))
assert len(check_paths) == 32
for check_path in check_paths:
    __file__ = str(check_path)
    load(__file__)
assert len(irs_results) == 31
print("RESULT: PASS (31 rows; " + str(sum(irs_results.values())) + " exact checks; 32 files)")

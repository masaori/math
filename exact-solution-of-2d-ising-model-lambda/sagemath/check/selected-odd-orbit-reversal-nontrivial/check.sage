from pathlib import Path
check_dir = Path("sagemath/check/selected-odd-orbit-reversal-nontrivial")
if not check_dir.is_dir():
    check_dir = Path(".")
check_paths = sorted(check_dir.resolve().glob("check_*.sage"))
assert len(check_paths) == 47
for check_path in check_paths:
    __file__ = str(check_path)
    load(__file__)
assert len(sfn_results) == 46
print("RESULT: PASS (46 rows; " + str(sum(sfn_results.values())) + " exact checks; 47 files)")

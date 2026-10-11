from pathlib import Path
_check_dir = Path("sagemath/check/finite-permutation-orbit-invariant")
if not _check_dir.is_dir():
    _check_dir = Path(".")
check_paths = sorted(_check_dir.resolve().glob("check_*.sage"))
assert len(check_paths) == 20
for check_path in check_paths:
    __file__ = str(check_path.resolve())
    load(__file__)
print("finite-permutation-orbit-invariant: 20 files; RESULT: PASS")

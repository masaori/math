# 軌道の定義と、本文の各計算行を一括検算する。
from pathlib import Path

_check_dir = Path("sagemath/check/invariant-subset-reversal-orbit")
if not _check_dir.is_dir():
    _check_dir = Path(".")
check_paths = sorted(_check_dir.resolve().glob("check_*.sage"))
assert len(check_paths) == 26
for check_path in check_paths:
    __file__ = str(check_path.resolve())
    load(__file__)
print("invariant-subset-reversal-orbit: 26 files; RESULT: PASS")

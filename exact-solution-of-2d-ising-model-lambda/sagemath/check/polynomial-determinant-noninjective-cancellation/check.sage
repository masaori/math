# 対象ラベル: claim_polynomial_determinant_noninjective_cancellation
# 本文の全行と構造条件を同じ有限入力で検査する。
import os
import sys
from pathlib import Path

_nic_directory = Path(os.path.abspath(__file__)).parent
if not (_nic_directory / "_prelude.sage").is_file():
    _nic_directory = Path(os.path.abspath(sys.argv[0])).parent
for _nic_check_path in sorted(_nic_directory.glob("check_*.sage")):
    __file__ = str(_nic_check_path.resolve())
    load(__file__)
print("INPUT_COUNTS:", _nic_stats)
print("CHECK_FILES:", len(list(_nic_directory.glob("check_*.sage"))))
print("RESULT: PASS integrated noninjective cancellation checks")

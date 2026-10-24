# 対象ラベル: claim_qbar_polynomial_square_root_unique
from pathlib import Path
import sys

# Sage CLI は __file__ を入力ファイルへ設定しないため argv へ戻る。
source_file = Path(__file__) if "__file__" in globals() else Path(sys.argv[0])
if source_file.suffix != ".sage" or not source_file.exists():
    source_file = Path(sys.argv[0])
from sage.repl.preparse import preparse

check_directory = source_file.resolve().parent
check_files = sorted(check_directory.glob("check_*.sage"))
assert len(check_files) == 18
for check_file in check_files:
    namespace = {"__file__": str(check_file)}
    exec("from sage.all import *", namespace)
    exec(compile(preparse(check_file.read_text()), str(check_file), "exec"), namespace)
print("RESULT: PASS all 18 independent checks")

# 対象ラベル: claim_qbar_polynomial_square_root_unique
# 式ペア: zero[0] = (S+T)[0]
# 帰属: S,T は QQbar[x]、定数係数は QQbar。
from pathlib import Path
import sys

# Sage CLI は __file__ を入力ファイルへ設定しないため argv へ戻る。
source_file = Path(__file__) if "__file__" in globals() else Path(sys.argv[0])
if source_file.suffix != ".sage" or not source_file.exists():
    source_file = Path(sys.argv[0])
load(str(source_file.resolve().with_name("_prelude.sage")))

check_pairs("substitute_zero_sum", zero_sum_pairs,
    lambda S,T: zero[0],
    lambda S,T: (S+T)[0], 8)

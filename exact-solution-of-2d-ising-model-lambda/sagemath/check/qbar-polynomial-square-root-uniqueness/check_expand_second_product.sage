# 対象ラベル: claim_qbar_polynomial_square_root_unique
# 式ペア: (S*S+S*T)-T*(S+T) = (S*S+S*T)-(T*S+T*T)
# 帰属: S,T は QQbar[x]、定数係数は QQbar。
from pathlib import Path
import sys

# Sage CLI は __file__ を入力ファイルへ設定しないため argv へ戻る。
source_file = Path(__file__) if "__file__" in globals() else Path(sys.argv[0])
if source_file.suffix != ".sage" or not source_file.exists():
    source_file = Path(sys.argv[0])
load(str(source_file.resolve().with_name("_prelude.sage")))

check_pairs("expand_second_product", general_pairs,
    lambda S,T: (S*S+S*T)-T*(S+T),
    lambda S,T: (S*S+S*T)-(T*S+T*T), 64)

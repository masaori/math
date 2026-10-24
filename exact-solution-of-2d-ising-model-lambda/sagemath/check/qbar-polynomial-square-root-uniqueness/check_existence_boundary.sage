# 対象ラベル: claim_qbar_polynomial_square_root_unique
# 一意性は存在を含意しない。補足例 D=1+x、帰属 QQbar[x]。
from pathlib import Path
import sys

# Sage CLI は __file__ を入力ファイルへ設定しないため argv へ戻る。
source_file = Path(__file__) if "__file__" in globals() else Path(sys.argv[0])
if source_file.suffix != ".sage" or not source_file.exists():
    source_file = Path(sys.argv[0])
load(str(source_file.resolve().with_name("_prelude.sage")))

D = R(1)+x
assert D[0] == scalar_one
assert D.degree() == 1
assert not D.is_square()
print("RESULT: PASS existence_boundary (1+x has no polynomial square root)")

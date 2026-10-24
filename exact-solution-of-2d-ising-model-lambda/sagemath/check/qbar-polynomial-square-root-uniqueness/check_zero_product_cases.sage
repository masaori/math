# 対象ラベル: claim_qbar_polynomial_square_root_unique
# 零積性の分岐と定数項の矛盾の検算。帰属: QQbar[x], QQbar。
from pathlib import Path
import sys

# Sage CLI は __file__ を入力ファイルへ設定しないため argv へ戻る。
source_file = Path(__file__) if "__file__" in globals() else Path(sys.argv[0])
if source_file.suffix != ".sage" or not source_file.exists():
    source_file = Path(sys.argv[0])
load(str(source_file.resolve().with_name("_prelude.sage")))

same = opposite = rejected = 0
for S, T in equal_square_pairs:
    assert (S-T)*(S+T) == zero
    assert S-T == zero or S+T == zero
    if S-T == zero:
        same += 1
        assert S == T and T[0] == scalar_one
    else:
        opposite += 1
        assert S+T == zero
        assert T[0] == -scalar_one
        assert T[0] != scalar_one
        rejected += 1
assert (same, opposite, rejected) == (8, 8, 8)
# 和=0と両方の定数項が1という仮定は両立不能。
# 0=2を満たす標本は作らず、矛盾を生む二つの値が異なることを検査する。
for S, T in general_pairs:
    assert (S+T)[0] == scalar_two
    assert zero[0] == scalar_zero
    assert scalar_two != scalar_zero
    assert S+T != zero
print("RESULT: PASS zero_product_cases (8 equal, 8 opposite rejected; 64 nonzero sums)")

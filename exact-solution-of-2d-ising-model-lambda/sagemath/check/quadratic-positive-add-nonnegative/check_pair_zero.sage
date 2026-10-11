# 対象ラベル: claim_quadratic_positive_add_nonnegative
# 対象: 「正錐の非負係数条件どうしの和」の証明。
# 本文の行: (a,b)=(0,0)
# 検算する局所条件: 各成分が零である一組
# 背理法の全仮定を同時に満たす事例とは数えない。
# 帰属: QQ / QQbar の厳密計算。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

checked = 0
for a, b in product((QQ.zero(),), repeat=2):
    assert a == 0 and b == 0
    assert (a, b) == (0, 0), (a, b)
    checked += 1
assert checked == 1, checked
print(f"RESULT: PASS (pair_zero: {checked} 件)")

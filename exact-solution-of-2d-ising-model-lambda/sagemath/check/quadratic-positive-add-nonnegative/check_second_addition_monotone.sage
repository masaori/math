# 対象ラベル: claim_quadratic_positive_add_nonnegative
# 対象: 「正錐の非負係数条件どうしの和」の証明。
# 本文の行: b+0\le b+b'
# 検算する局所条件: 対象係数は符号付き標本、他方の加数は非負標本
# 背理法の全仮定を同時に満たす事例とは数えない。
# 帰属: QQ / QQbar の厳密計算。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

checked = 0
for b, bp in product(qpn_samples, qpn_nonnegative):
    assert b + 0 <= b + bp, (b, bp)
    checked += 1
assert checked == 276, checked
print(f"RESULT: PASS (second_addition_monotone: {checked} 件)")

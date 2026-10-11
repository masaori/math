# 対象ラベル: claim_quadratic_positive_add_nonnegative
# 対象: 「正錐の非負係数条件どうしの和」の証明。
# 本文の行: 0\le a+a'
# 検算する局所条件: 二つの加数を非負標本から独立に取る
# 背理法の全仮定を同時に満たす事例とは数えない。
# 帰属: QQ / QQbar の厳密計算。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

checked = 0
for a, ap in product(qpn_nonnegative, repeat=2):
    assert 0 <= a + ap, (a, ap)
    checked += 1
assert checked == 144, checked
print(f"RESULT: PASS (first_sum_nonnegative: {checked} 件)")

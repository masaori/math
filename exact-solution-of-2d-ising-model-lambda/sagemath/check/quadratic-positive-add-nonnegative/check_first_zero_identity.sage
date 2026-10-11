# 対象ラベル: claim_quadratic_positive_add_nonnegative
# 対象: 「正錐の非負係数条件どうしの和」の証明。
# 本文の行: a=a+0
# 検算する局所条件: 対象係数を符号付き標本から取る
# 背理法の全仮定を同時に満たす事例とは数えない。
# 帰属: QQ / QQbar の厳密計算。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

checked = 0
for a in qpn_samples:
    assert a == a + 0, a
    checked += 1
assert checked == 23, checked
print(f"RESULT: PASS (first_zero_identity: {checked} 件)")

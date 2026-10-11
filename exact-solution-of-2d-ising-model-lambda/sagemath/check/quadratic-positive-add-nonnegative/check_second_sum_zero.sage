# 対象ラベル: claim_quadratic_positive_add_nonnegative
# 対象: 「正錐の非負係数条件どうしの和」の証明。
# 本文の行: b+b'=0
# 検算する局所条件: 対象係数を符号付き標本から取り、他方をその加法逆元とする
# 背理法の全仮定を同時に満たす事例とは数えない。
# 帰属: QQ / QQbar の厳密計算。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

checked = 0
for b in qpn_samples:
    bp = -b
    assert b + bp == 0, (b, bp)
    checked += 1
assert checked == 23, checked
print(f"RESULT: PASS (second_sum_zero: {checked} 件)")

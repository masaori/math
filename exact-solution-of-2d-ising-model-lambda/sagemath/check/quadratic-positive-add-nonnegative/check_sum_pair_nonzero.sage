# 対象ラベル: claim_quadratic_positive_add_nonnegative
# 対象: 「正錐の非負係数条件どうしの和」の証明。
# 本文の行: (a+a',b+b')\ne(0,0)
# 検算する局所条件: 四係数を非負標本から取り、両入力組を非零とする
# 背理法の全仮定を同時に満たす事例とは数えない。
# 帰属: QQ / QQbar の厳密計算。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

checked = 0
for a, b, ap, bp in qpn_valid_cases():
    assert (a + ap, b + bp) != (0, 0), (a, b, ap, bp)
    checked += 1
assert checked == 20449, checked
print(f"RESULT: PASS (sum_pair_nonzero: {checked} 件)")

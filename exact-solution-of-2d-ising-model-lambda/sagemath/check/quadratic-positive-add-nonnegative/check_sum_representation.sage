# 対象ラベル: claim_quadratic_positive_add_nonnegative
# 対象: 「正錐の非負係数条件どうしの和」の証明。
# 本文の行: \mathrm{rep}_s(\xi+\eta)=(a+a',b+b')
# 検算する局所条件: 非負標本の四係数・両入力組非零・s の両根
# 背理法の全仮定を同時に満たす事例とは数えない。
# 帰属: QQ / QQbar の厳密計算。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

checked = 0
for s, a, b, ap, bp, xi, eta in qpn_algebraic_cases():
    actual = qpn_rep(xi + eta, s)
    expected = (a + ap, b + bp)
    assert actual == expected, (s, a, b, ap, bp, actual)
    checked += 1
assert checked == 40898, checked
print(f"RESULT: PASS (sum_representation: {checked} 件)")

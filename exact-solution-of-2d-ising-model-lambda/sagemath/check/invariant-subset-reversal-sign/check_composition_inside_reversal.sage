# 対象ラベル: claim_invariant_subset_reversal_sign
# 内側の反転の定義
# 式ペア: \sigma^{-1}(i)=\tau(i)
# 帰属: 有限集合と真偽値。添字は整数。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row, i in irs_points(True):
    sigma, inverse, subset = row["sigma"], row["inverse"], row["subset"]
    p, q, tau = row["p"], row["q"], row["tau"]
    expr1 = inverse[i]
    expr2 = tau[i]
    assert expr1 == expr2, (row, i, expr1, expr2)
    count += 1
irs_record("composition_inside_reversal", count)

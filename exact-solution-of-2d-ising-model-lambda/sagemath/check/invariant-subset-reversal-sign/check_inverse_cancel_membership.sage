# 対象ラベル: claim_invariant_subset_reversal_sign
# 順逆の相殺による所属の同値
# 式ペア: \sigma(\sigma^{-1}(i))\in C \Longleftrightarrow i\in C
# 帰属: 有限集合と真偽値。添字は整数。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row, i in irs_points(None):
    sigma, inverse, subset = row["sigma"], row["inverse"], row["subset"]
    p, q, tau = row["p"], row["q"], row["tau"]
    expr1 = sigma[inverse[i]] in subset
    expr2 = i in subset
    assert expr1 == expr2, (row, i, expr1, expr2)
    count += 1
irs_record("inverse_cancel_membership", count)

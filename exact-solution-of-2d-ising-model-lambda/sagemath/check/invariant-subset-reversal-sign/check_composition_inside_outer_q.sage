# 対象ラベル: claim_invariant_subset_reversal_sign
# 内側の合成で外側の q を展開
# 式ペア: q(i)=\sigma^{-1}(i)
# 帰属: 有限集合と真偽値。添字は整数。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row, i in irs_points(True):
    sigma, inverse, subset = row["sigma"], row["inverse"], row["subset"]
    p, q, tau = row["p"], row["q"], row["tau"]
    expr1 = q[i]
    expr2 = inverse[i]
    assert expr1 == expr2, (row, i, expr1, expr2)
    count += 1
irs_record("composition_inside_outer_q", count)

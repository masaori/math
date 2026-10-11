# 対象ラベル: claim_invariant_subset_reversal_sign
# 外側の合成を点で評価
# 式ペア: (q\circ(q\circ\sigma))(i)=q(q(\sigma(i)))
# 帰属: 有限集合と真偽値。添字は整数。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row, i in irs_points(False):
    sigma, inverse, subset = row["sigma"], row["inverse"], row["subset"]
    p, q, tau = row["p"], row["q"], row["tau"]
    expr1 = row["q_q_sigma"][i]
    expr2 = q[q[sigma[i]]]
    assert expr1 == expr2, (row, i, expr1, expr2)
    count += 1
irs_record("composition_outside_definition", count)

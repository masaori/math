# 対象ラベル: claim_invariant_subset_reversal_sign
# 内側の逆順合成で q の定義
# 式ペア: p(q(i))=p(\sigma^{-1}(i))
# 帰属: 有限集合と真偽値。添字は整数。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row, i in irs_points(True):
    sigma, inverse, subset = row["sigma"], row["inverse"], row["subset"]
    p, q, tau = row["p"], row["q"], row["tau"]
    expr1 = p[q[i]]
    expr2 = p[inverse[i]]
    assert expr1 == expr2, (row, i, expr1, expr2)
    count += 1
irs_record("pq_inside_q", count)

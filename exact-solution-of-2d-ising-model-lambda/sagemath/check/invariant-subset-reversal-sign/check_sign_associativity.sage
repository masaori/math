# 対象ラベル: claim_invariant_subset_reversal_sign
# 整数の積の結合則
# 式ペア: \mathrm{sgn}(q)(\mathrm{sgn}(q)\mathrm{sgn}(\sigma))=(\mathrm{sgn}(q)\mathrm{sgn}(q))\mathrm{sgn}(\sigma)
# 帰属: ZZ。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in irs_rows:
    sigma, rank, subset = row["sigma"], row["rank"], row["subset"]
    p, q, tau = row["p"], row["q"], row["tau"]
    expr1 = irs_sign(q, rank) * (irs_sign(q, rank) * irs_sign(sigma, rank))
    expr2 = (irs_sign(q, rank) * irs_sign(q, rank)) * irs_sign(sigma, rank)
    assert expr1 == expr2, (row, expr1, expr2)
    count += 1
irs_record("sign_associativity", count)

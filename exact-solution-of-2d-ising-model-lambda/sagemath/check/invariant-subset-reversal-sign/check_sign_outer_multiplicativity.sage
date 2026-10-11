# 対象ラベル: claim_invariant_subset_reversal_sign
# 外側の合成に符号の乗法性
# 式ペア: \mathrm{sgn}(q\circ(q\circ\sigma))=\mathrm{sgn}(q)\mathrm{sgn}(q\circ\sigma)
# 帰属: ZZ。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in irs_rows:
    sigma, rank, subset = row["sigma"], row["rank"], row["subset"]
    p, q, tau = row["p"], row["q"], row["tau"]
    expr1 = irs_sign(row["q_q_sigma"], rank)
    expr2 = irs_sign(q, rank) * irs_sign(row["q_sigma"], rank)
    assert expr1 == expr2, (row, expr1, expr2)
    count += 1
irs_record("sign_outer_multiplicativity", count)

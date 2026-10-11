# 対象ラベル: claim_invariant_subset_reversal_sign
# 反転の合成表示を符号に代入
# 式ペア: \mathrm{sgn}(\tau)=\mathrm{sgn}(q\circ(q\circ\sigma))
# 帰属: ZZ。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in irs_rows:
    sigma, rank, subset = row["sigma"], row["rank"], row["subset"]
    p, q, tau = row["p"], row["q"], row["tau"]
    expr1 = irs_sign(tau, rank)
    expr2 = irs_sign(row["q_q_sigma"], rank)
    assert expr1 == expr2, (row, expr1, expr2)
    count += 1
irs_record("sign_composition_identity", count)

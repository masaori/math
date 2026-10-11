# 対象ラベル: claim_invariant_subset_reversal_sign
# 符号が正負の一に属する
# 式ペア: \mathrm{sgn}(q)\in\{-1,1\}
# 帰属: ZZ。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in irs_rows:
    sigma, rank, subset = row["sigma"], row["rank"], row["subset"]
    p, q, tau = row["p"], row["q"], row["tau"]
    expr1 = irs_sign(q, rank) in (ZZ(-1), ZZ(1))
    expr2 = True
    assert expr1 == expr2, (row, expr1, expr2)
    count += 1
irs_record("sign_values", count)

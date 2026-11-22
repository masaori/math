# 対象ラベル: claim_invariant_subset_reversal_sign
# 式ペア: \mathrm{sgn}(q)\cdot\mathrm{sgn}(q)=\mathrm{sgn}(q)^2
# 帰属: ZZ。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in irs_rows:
    q, rank = row["q"], row["rank"]
    expr1 = irs_sign(q, rank) * irs_sign(q, rank)
    expr2 = irs_sign(q, rank) ** ZZ(2)
    assert expr1 == expr2, (row, expr1, expr2)
    count += 1
irs_record("sign_square_definition", count)

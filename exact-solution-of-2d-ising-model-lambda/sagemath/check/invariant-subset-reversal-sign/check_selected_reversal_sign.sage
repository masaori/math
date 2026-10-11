# 対象ラベル: claim_invariant_subset_reversal_sign
# 選んだ奇数軌道での符号保存
# 式ペア: \mathrm{sgn}(\rho_{\operatorname{OddOrb}(\sigma)}(\sigma))=\mathrm{sgn}(\sigma)
# 帰属: ZZ。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in irs_odd_rows:
    sigma, rank, subset = row["sigma"], row["rank"], row["subset"]
    expr1 = irs_sign(irs_reverse(sigma, subset), rank)
    expr2 = irs_sign(sigma, rank)
    assert expr1 == expr2, (row, expr1, expr2)
    count += 1
irs_record("selected_reversal_sign", count)

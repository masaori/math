# 対象ラベル: claim_invariant_subset_reversal_sign
# 選んだ奇数軌道の反転の定義
# 式ペア: \mathrm{sgn}(R_{\mathrm{odd}}(\sigma))=\mathrm{sgn}(\rho_{\operatorname{OddOrb}(\sigma)}(\sigma))
# 帰属: ZZ。浮動小数点は使わない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in irs_odd_rows:
    sigma, rank, subset = row["sigma"], row["rank"], row["subset"]
    expr1 = irs_sign(irs_selected_reversal(sigma, rank), rank)
    expr2 = irs_sign(irs_reverse(sigma, subset), rank)
    assert expr1 == expr2, (row, expr1, expr2)
    count += 1
irs_record("selected_reversal_definition", count)

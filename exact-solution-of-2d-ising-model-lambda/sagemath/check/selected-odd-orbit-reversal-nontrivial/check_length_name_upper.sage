# 対象ラベル: claim_selected_odd_orbit_reversal_nontrivial
# 個数による長さの定義の再使用
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

count = 0
for row in sfn_two_rows:
    sigma, inverse = row["sigma"], row["inverse"]
    a, b, ell = row["a"], row["b"], row["ell"]
    assert ell == len(row["subset"])
    count += 1
sfn_record("length_name_upper", count)

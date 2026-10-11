# 対象ラベル: claim_rational_square_lt_implies_lt
# 帰属: QQ の厳密計算。浮動小数点を使わない。
# 本文末尾で使う全順序性: not (q<=p) iff p<q。
# これは背理法の同時仮定を使わない順序の性質として検算する。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

checked = 0
for p in samples:
    for q in samples:
        assert (not (q <= p)) == (p < q), (p, q)
        checked += 1
assert checked == 20736
print(f"RESULT: PASS (全順序: {checked} 同値)")

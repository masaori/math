# 対象ラベル: claim_rational_square_lt_implies_lt
# 帰属: QQ の厳密計算。浮動小数点を使わない。
# 本文末尾で使う順序の非反射性: not (p*p < p*p)。
# これは背理法の同時仮定を使わない順序の性質として検算する。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

checked = 0
for p in samples:
    assert not (p * p < p * p), p
    checked += 1
assert checked == 144
print(f"RESULT: PASS (狭義順序の非反射性: {checked} 否定)")

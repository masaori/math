# 対象ラベル: claim_rational_square_lt_implies_lt
# 帰属: QQ の厳密計算。浮動小数点を使わない。
# 本文の行: q*q <= p*q（第一の鎖、右乗法の単調性）。
# 0<=p, 0<=q, q<=p の下でこの一行を検算する。平方の狭義不等式は仮定しない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

checked = 0
for p in samples:
    for q in samples:
        if q <= p:
            assert q * q <= p * q, (p, q)
            checked += 1
assert checked == 10440
print(f"RESULT: PASS (右乗法: {checked} 不等式)")

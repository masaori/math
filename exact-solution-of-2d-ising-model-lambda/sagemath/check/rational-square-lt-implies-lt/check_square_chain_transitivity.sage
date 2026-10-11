# 対象ラベル: claim_rational_square_lt_implies_lt
# 帰属: QQ の厳密計算。浮動小数点を使わない。
# 本文の行: q*q <= p*p（第二の鎖、第一の鎖に推移律を使う）。
# 0<=p, 0<=q, q<=p だけから従う広義不等式として検算する。
# 平方の狭義不等式と同時に成立する数値事例の検算ではない。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

checked = 0
for p in samples:
    for q in samples:
        if q <= p:
            assert q * q <= p * p, (p, q)
            checked += 1
assert checked == 10440
print(f"RESULT: PASS (第一の鎖の推移律: {checked} 不等式)")

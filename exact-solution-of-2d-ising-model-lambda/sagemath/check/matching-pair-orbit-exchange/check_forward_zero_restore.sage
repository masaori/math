# 対象ラベル: claim_matching_pair_orbit_exchange
# 本文の行: tau[i] = iterate(q,0,tau[i])
# 帰属: 有限番号集合と自然数、厳密計算。
from pathlib import Path
_dir = Path(__file__).resolve().parent
load(str(_dir / '_prelude.sage'))
count = 0
for tau, upsilon, p, q, i in ROWS:
    for n in range(MAX_EXPONENT + 1):
        assert tau[i] == iterate(q,0,tau[i])
        count += 1
print("RESULT: PASS forward_zero_restore", count)

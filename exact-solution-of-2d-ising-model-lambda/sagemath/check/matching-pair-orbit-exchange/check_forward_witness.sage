# 対象ラベル: claim_matching_pair_orbit_exchange
# 本文の行: tau[iterate(p,n,i)] = tau[j]
# 帰属: 有限番号集合と自然数、厳密計算。
from pathlib import Path
_dir = Path(__file__).resolve().parent
load(str(_dir / '_prelude.sage'))
count = 0
for tau, upsilon, p, q, i in ROWS:
    for n in range(MAX_EXPONENT + 1):
        j = iterate(p,n,i)
        assert tau[iterate(p,n,i)] == tau[j]
        count += 1
print("RESULT: PASS forward_witness", count)

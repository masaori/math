# 対象ラベル: claim_matching_pair_orbit_exchange
# 本文の行: iterate(p,n,tau[tau[upsilon[i]]]) = iterate(p,n,upsilon[i])
# 帰属: 有限番号集合と自然数、厳密計算。
from pathlib import Path
_dir = Path(__file__).resolve().parent
load(str(_dir / '_prelude.sage'))
count = 0
for tau, upsilon, p, q, i in ROWS:
    for n in range(MAX_EXPONENT + 1):
        assert iterate(p,n,tau[tau[upsilon[i]]]) == iterate(p,n,upsilon[i])
        count += 1
print("RESULT: PASS backward_step_cancel", count)

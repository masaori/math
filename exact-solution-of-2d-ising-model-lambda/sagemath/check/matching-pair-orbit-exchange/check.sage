from pathlib import Path
_dir = Path(__file__).resolve().parent
load(str(_dir / '_prelude.sage'))
for tau, upsilon, p, q in CASES:
    for i in range(len(tau)):
        left = orbit(p,i)
        right = orbit(p,tau[i])
        assert {tau[j] for j in left} == right
        assert {tau[j] for j in right} == left
        assert all(tau[tau[j]] == j for j in left | right)
        assert not left & right
print('RESULT: PASS 236 ordered pairs, 1388 basepoints; empty and shared pairs included')

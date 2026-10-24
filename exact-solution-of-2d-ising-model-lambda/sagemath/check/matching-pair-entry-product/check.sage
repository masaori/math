# 対象ラベル: claim_matching_pair_entry_product
# 帰属: QQ[x] と有限集合。丸めを使わない。
from pathlib import Path

_root = next(d for d in (Path.cwd(), *Path.cwd().parents)
             if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage').is_file())
load(str(_root / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage'))

R = PolynomialRing(QQ, 'x')
x = R.gen()

def finite_product(values):
    result = R.one()
    for value in values:
        result *= value
    return result

seen = set()
for tau, upsilon, p, q, i in ROWS:
    key = (tau, upsilon)
    if key in seen:
        continue
    seen.add(key)
    n = len(tau)
    C = color(tau, p)
    sigma = tuple(successor(tau, upsilon, C, j) for j in range(n))
    A = lambda j, k: R((j + 1) * (k + 2)) + R(j + k + 1) * x + x**2
    all_entries = finite_product(A(j, sigma[j]) for j in range(n))
    split_entries = finite_product(A(j, sigma[j]) for j in range(n) if j in C) * finite_product(A(j, sigma[j]) for j in range(n) if j not in C)
    first_replaced = finite_product(A(j, tau[j]) for j in range(n) if j in C) * finite_product(A(j, sigma[j]) for j in range(n) if j not in C)
    both_replaced = finite_product(A(j, tau[j]) for j in range(n) if j in C) * finite_product(A(j, upsilon[j]) for j in range(n) if j not in C)
    assert all_entries == split_entries == first_replaced == both_replaced

# 空集合には相手写像も成分列も一意で、三つの積は空積である。
assert finite_product([]) == R.one()
print('RESULT: PASS', len(seen), 'matching pairs and the empty index set')

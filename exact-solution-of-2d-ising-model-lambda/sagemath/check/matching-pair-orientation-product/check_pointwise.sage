# 対象ラベル: claim_matching_pair_orientation_product
# 各対の向きによる成分の等号を QQ[x] で検算する。
from pathlib import Path

root = next(d for d in (Path.cwd(), *Path.cwd().parents)
            if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage').is_file())
load(str(root / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage'))

R = PolynomialRing(QQ, 'x')
x = R.gen()

def entry(i, j):
    if i == j:
        return R.zero()
    a, b = sorted((i, j))
    upper = R((a + 1) * (b + 2)) + R(a + b + 1) * x + x**2
    return upper if i < j else -upper

seen = set()
checked = 0
for tau, upsilon, p, q, i in ROWS:
    key = (tau, upsilon)
    if key in seen:
        continue
    seen.add(key)
    C = color(tau, p)
    for mate, selected in ((tau, C), (upsilon, set(range(len(tau))) - C)):
        for j in selected:
            a, b = sorted((j, mate[j]))
            sign = R.one() if j < mate[j] else -R.one()
            assert entry(j, mate[j]) == sign * entry(a, b)
            checked += 1

print('RESULT: PASS pointwise', checked, 'entries')

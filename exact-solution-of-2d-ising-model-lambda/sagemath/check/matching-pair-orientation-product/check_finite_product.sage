# 対象ラベル: claim_matching_pair_orientation_product
# 各色の端点から昇順対への再添字付けと有限積を QQ[x] で検算する。
from pathlib import Path

root = next(d for d in (Path.cwd(), *Path.cwd().parents)
            if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage').is_file())
load(str(root / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage'))

R = PolynomialRing(QQ, 'x')
x = R.gen()

def finite_product(values):
    result = R.one()
    for value in values:
        result *= value
    return result

def entry(i, j):
    if i == j:
        return R.zero()
    a, b = sorted((i, j))
    upper = R((a + 1) * (b + 2)) + R(a + b + 1) * x + x**2
    return upper if i < j else -upper

seen = set()
for tau, upsilon, p, q, i in ROWS:
    key = (tau, upsilon)
    if key in seen:
        continue
    seen.add(key)
    C = color(tau, p)
    for mate, selected in ((tau, C), (upsilon, set(range(len(tau))) - C)):
        oriented = {tuple(sorted((j, mate[j]))) for j in selected}
        all_pairs = {tuple(sorted((j, mate[j]))) for j in range(len(tau))}
        assert oriented == all_pairs
        assert len(oriented) == len(selected)
        left = finite_product(entry(j, mate[j]) for j in selected)
        expanded = finite_product((R.one() if j < mate[j] else -R.one()) *
                                  entry(*sorted((j, mate[j]))) for j in selected)
        separated = finite_product(R.one() if j < mate[j] else -R.one()
                                   for j in selected) * finite_product(
            entry(*sorted((j, mate[j]))) for j in selected)
        reindexed = finite_product(R.one() if j < mate[j] else -R.one()
                                   for j in selected) * finite_product(
            entry(*pair) for pair in oriented)
        assert left == expanded == separated == reindexed

assert finite_product([]) == R.one()
print('RESULT: PASS finite product', len(seen), 'matching pairs and empty index')

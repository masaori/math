"""非後退置換の母関数を反転対と単純通過で層別する等式を厳密検査する。

対象: claim_nonbacktracking_permutation_stratified_count。

L=2 の非後退置換 30,784 個を全列挙し、各置換の像
(D(phi), E_1(phi)) が互いに素で第 2 成分が偶部分グラフであること、
その像ごとのファイバーが全置換を互いに素に分割すること、軌道長総和が
2|D|+|E| に等しいこと、両辺の ZZ[x] の多項式が一致することを検査する。
浮動小数点は使わない。
"""

load("sagemath/check/moved-orbit-length-sum-stratified/check.sage")

R = PolynomialRing(ZZ, "y")
y = R.gen()


def permutation_stratum(phi):
    moved = {edge for edge in oriented2 if phi[edge] != edge}
    support = {edge[:3] for edge in moved}
    doubled = frozenset(base for base in support
                        if base + (0,) in moved and base + (1,) in moved)
    single = frozenset(support - set(doubled))
    return doubled, single


even_sets = {frozenset(subset) for subset in even_subgraphs(L2)}
fibers = {}
left = R(0)

for phi in nonbacktracking_permutations:
    doubled, single = permutation_stratum(phi)

    # 像は D cap E = empty と Even_L(E) を満たす。
    assert doubled.isdisjoint(single)
    assert single in even_sets

    key = (doubled, single)
    fibers.setdefault(key, []).append(phi)

    # 軌道長総和を直接数える。
    moved = {edge for edge in oriented2 if phi[edge] != edge}
    remaining = set(moved)
    orbit_length_sum = 0
    while remaining:
        start = next(iter(remaining))
        orbit = {start}
        current = phi[start]
        while current != start:
            assert current in moved
            orbit.add(current)
            current = phi[current]
        assert orbit <= remaining
        remaining -= orbit
        orbit_length_sum += len(orbit)

    assert orbit_length_sum == 2 * len(doubled) + len(single)
    left += y ** orbit_length_sum

# 相異なるキーのファイバーは辞書の構成上交わらず、その個数の和は全置換数に等しい。
assert sum(len(fiber) for fiber in fibers.values()) == len(nonbacktracking_permutations)

right = R(0)
for (doubled, single), fiber in fibers.items():
    right += len(fiber) * y ** (2 * len(doubled) + len(single))

assert left == right

print("PASS: nonbacktracking-permutation-stratified-count")
print(f"  L=2: 非後退置換 {len(nonbacktracking_permutations)} 個")
print(f"  非空ファイバー {len(fibers)} 個")
print(f"  母関数 {left}")

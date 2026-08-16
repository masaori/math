# 対象ラベル: claim_full_boundary_response_value_at_one
# 内箱 V_{L'}={(0,0,0)}、外箱 V_L={0,1}^3（8 点・12 辺）の自由境界の箱で、
# 辺変数を 1 に置かない境界応答多項式 R~_{L,L'} の全不定元を 1 に置いた値が 2^{#V_L} に等しいことを、
# 証明と同順（R~ は配位ごとの単項式の有限和 → 環準同型 ε_L は有限和・有限積を保つので各項が 1 → 項数は配位の個数 2^{#V_L}）
# で ZZ 上の厳密計算により確認する。
from itertools import product


def box_sites(sides):
    return list(product(*[range(side) for side in sides]))


def box_edges(sides):
    vertex_set = set(box_sites(sides))
    result = []
    for start in box_sites(sides):
        for direction in range(3):
            end = list(start)
            end[direction] += 1
            end = tuple(end)
            if end in vertex_set:
                result.append((start, end))
    return result


inner_sites = box_sites((1, 1, 1))
sites, edges = box_sites((2, 2, 2)), box_edges((2, 2, 2))
assert set(inner_sites) <= set(sites)
assert len(sites) == 8 and len(edges) == 12

ring = PolynomialRing(ZZ, ["x%s" % i for i in range(len(edges))])
index = {edge: i for i, edge in enumerate(edges)}


def broken_set(configuration):
    return frozenset(edge for edge in edges if configuration[edge[0]] != configuration[edge[1]])


def monomial_of(broken):
    monomial = ring.one()
    for edge in broken:
        monomial *= ring.gen(index[edge])
    return monomial


# R~_{L,L'} を配位の有限和として作り、同時に破れ辺集合ごとの配位の個数（自然数の係数）を数える
R_full = ring.zero()
count_by_broken = {}
for values in product([ZZ(-1), ZZ(1)], repeat=len(sites)):
    configuration = dict(zip(sites, values))
    broken = broken_set(configuration)
    R_full += monomial_of(broken)
    count_by_broken[broken] = count_by_broken.get(broken, 0) + 1
configuration_count = 0
for values in product([ZZ(-1), ZZ(1)], repeat=len(sites)):
    configuration_count += 1

# 全不定元を 1 に置く環準同型 ε_L
epsilon = ring.hom([ZZ(1)] * len(edges), ZZ)
for i in range(len(edges)):
    assert epsilon(ring.gen(i)) == 1

# 各配位の単項式 ∏_{e∈B(σ)} X_e の像は ∏ 1 = 1
for broken in count_by_broken:
    assert epsilon(monomial_of(broken)) == 1
# 環準同型は有限和を保つので、像は項数（配位の個数）に等しい
sum_of_images = sum(count_by_broken[broken] * epsilon(monomial_of(broken)) for broken in count_by_broken)
assert epsilon(R_full) == sum_of_images
assert sum_of_images == configuration_count
# 配位の個数は 2^{#V_L}
assert configuration_count == 2 ** len(sites)
assert epsilon(R_full) == 2 ** len(sites)

print("RESULT: PASS  #V_L=%d, #E_L=%d, epsilon(R~_{L,L'}) = %d = 2^%d" % (len(sites), len(edges), epsilon(R_full), len(sites)))

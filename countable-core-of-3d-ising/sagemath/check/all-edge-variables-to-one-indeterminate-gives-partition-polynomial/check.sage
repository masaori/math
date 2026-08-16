# 対象ラベル: claim_all_edge_variables_to_one_indeterminate_gives_partition_polynomial
# 多変数分配多項式 𝒵_L = Σ_σ Π_{e∈B(σ)} X_e の全辺変数を一つの不定元 X に置く環準同型 κ_L で
# Z_L(X) = Σ_m Ω_L(m) X^m が得られることを、L=1,2 で ZZ[X_e] と ZZ[X] の厳密計算で確認する。
# 帰属: 整係数多項式環だけを使う。実数・極限は使わない。
from itertools import product


def box_sites(box_side):
    return list(product(range(box_side), repeat=3))


def inner_edges(box_side):
    sites = set(box_sites(box_side))
    edges = []
    for start in sites:
        for direction in range(3):
            end = list(start)
            end[direction] += 1
            end = tuple(end)
            if end in sites:
                edges.append((start, end))
    return edges


def check_box(box_side):
    sites = box_sites(box_side)
    edges = inner_edges(box_side)
    names = ["X_%d" % i for i in range(len(edges))] or ["X_dummy"]
    multi_ring = PolynomialRing(ZZ, names)
    gens = multi_ring.gens()
    single_ring = PolynomialRing(ZZ, "X")
    X = single_ring.gen()
    # 段1: 𝒵_L の定義（配位ごとの破れ辺の単項式の和）
    multi_partition = multi_ring(0)
    # 段5: Z_L の定義（多重度 Ω_L(m) による）
    multiplicity = {}
    for spins in product([-1, 1], repeat=len(sites)):
        sigma = dict(zip(sites, spins))
        broken = [i for i, (u, v) in enumerate(edges) if sigma[u] != sigma[v]]
        monomial = multi_ring(1)
        for i in broken:
            monomial *= gens[i]
        multi_partition += monomial
        multiplicity[len(broken)] = multiplicity.get(len(broken), 0) + 1
    partition_polynomial = sum(c * X**m for m, c in multiplicity.items())
    # 段2-3: 全辺変数を X に置く環準同型 κ_L
    kappa = multi_ring.hom([X] * len(gens), single_ring)
    image = kappa(multi_partition)
    assert image == partition_polynomial, (box_side, image, partition_polynomial)
    # 段4: 像は Σ_σ X^{m_L(σ)} にも一致する
    assert image == sum(X**m for m, c in multiplicity.items() for _ in range(c))
    print("L=%d: kappa(Z_multi) = %s = Z_L(X)  PASS" % (box_side, image))


for L in [1, 2]:
    check_box(L)
print("ALL PASS")

# 対象ラベル: claim_coarse_graining_not_necessary_for_symmetrized_limit_quantity
# 対称化した列の項 (#V_L, σ_L(q)) が q と 1/q で一致し、かつ Z_L(q)^2/q^{#E_L} も QQ で一致する一方で、
# 粗視化の値 Z_L(q) と Z_L(1/q) は L≥2, q≠1 で異なることを、L=2 と有理点で厳密計算で確認する。
# 帰属: ZZ[X]、QQ、有限台の整数列（Λ）だけ。実数・極限・対数は使わない。
from itertools import product

integer_polynomial_ring = PolynomialRing(ZZ, "X")
X = integer_polynomial_ring.gen()


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


def partition_polynomial(box_side):
    sites = box_sites(box_side)
    edges = inner_edges(box_side)
    polynomial = integer_polynomial_ring.zero()
    for values in product([ZZ(1), ZZ(-1)], repeat=len(sites)):
        configuration = dict(zip(sites, values))
        broken_count = sum(ZZ(configuration[s] != configuration[e]) for s, e in edges)
        polynomial += X ** broken_count
    return polynomial


def prime_exponent_data(rational):
    # λ(a) = (v_p(a))_p を、現れる素数だけの辞書で表す（Λ の有限台の元）
    return {p: ZZ(e) for p, e in QQ(rational).factor()}


def add_data(a, b, coeff_a=1, coeff_b=1):
    keys = set(a) | set(b)
    out = {p: coeff_a * a.get(p, 0) + coeff_b * b.get(p, 0) for p in keys}
    return {p: e for p, e in out.items() if e != 0}


def sigma(box_side, polynomial, q):
    edge_count = len(inner_edges(box_side))
    return add_data(prime_exponent_data(polynomial(q)), prime_exponent_data(q), 2, -edge_count)


sample_points = [QQ(2), QQ(3), QQ(1) / 2, QQ(2) / 3, QQ(5) / 7, QQ(10)]
for box_side in [2]:
    polynomial = partition_polynomial(box_side)
    edge_count = len(inner_edges(box_side))
    site_count = len(box_sites(box_side))
    for q in sample_points:
        q_inverse = 1 / q
        # 粗視化の値は異なる（q≠1）
        assert polynomial(q) != polynomial(q_inverse), (box_side, q)
        # 対称化した列の項は一致する
        term_q = (site_count, sigma(box_side, polynomial, q))
        term_q_inverse = (site_count, sigma(box_side, polynomial, q_inverse))
        assert term_q == term_q_inverse, (box_side, q)
        # 対称化した量の底 Z_L(q)^2 / q^{#E_L} も QQ の元として一致する
        assert polynomial(q) ** 2 / q ** edge_count == polynomial(q_inverse) ** 2 / q_inverse ** edge_count, (box_side, q)
print("PASS: coarse graining Z_L(q) differs at q and 1/q, symmetrized terms coincide (L=2, 6 rational points)")

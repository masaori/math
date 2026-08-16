# 対象ラベル: claim_symmetrized_prime_exponent_data_is_reciprocal_invariant
# 対称化した素指数データ σ_L(q) := 2 λ(Z_L(q)) − #E_L λ(q) ∈ Λ が σ_L(1/q) = σ_L(q) を満たし、
# q≠1 では Z_L(q) ≠ Z_L(1/q) であることを、L=1,2 と有理点で QQ・素指数ベクトルの厳密計算で確認する。
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
for box_side in [1, 2]:
    polynomial = partition_polynomial(box_side)
    edge_count = len(inner_edges(box_side))
    for q in sample_points:
        # 第一の等式（相反多項式の代入）
        assert q ** edge_count * polynomial(1 / q) == polynomial(q)
        # 対称化データの不変性
        assert sigma(box_side, polynomial, q) == sigma(box_side, polynomial, 1 / q), (box_side, q)
        # L≥2（#E_L≥1）かつ q≠1 なら値は異なる。L=1 は #E_1=0、Z_1=2 で一致する（主張どおり）
        if box_side >= 2:
            assert polynomial(q) != polynomial(1 / q), (box_side, q)
        else:
            assert edge_count == 0 and polynomial(q) == polynomial(1 / q) == 2
    assert sigma(box_side, polynomial, QQ(1)) == sigma(box_side, polynomial, QQ(1))
    print("PASS L=%d, #E_L=%d, points=%d" % (box_side, edge_count, len(sample_points)))
print("ALL PASS")

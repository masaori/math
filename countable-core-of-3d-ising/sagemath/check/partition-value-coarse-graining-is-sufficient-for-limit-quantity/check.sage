# 対象ラベル: claim_partition_value_coarse_graining_is_sufficient_for_limit_quantity
# 粗視化 π_L(q) := ε_{L,q}(𝒵_L)（多変数分配多項式の全辺変数を q に置いた値）について、
# (1) π_L(q) が列 S_q の第 L 項 (#V_L, λ(Z_L(q))) から素指数データの復元 ∏ p^{e_p} で決定可能に定まる
#     （粗視化であること）、(2) 二つの有理点で π_L の値が一致すれば Z_L(q)=Z_L(q')（可算側の段）を
# L=1,2・有理点の対で QQ 上で確認する。極限量への移送の段は既存主張への帰着なので検査対象外。
# 帰属: ZZ[X]、QQ、有限台の整数列だけ。実数・極限・対数は使わない。
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


def prime_exponent_data(value):
    value = QQ(value)
    assert value > 0
    data = {}
    for prime, exponent in ZZ(value.numerator()).factor():
        data[prime] = ZZ(exponent)
    for prime, exponent in ZZ(value.denominator()).factor():
        data[prime] = data.get(prime, ZZ(0)) - ZZ(exponent)
    return {p: e for p, e in data.items() if e != 0}


def reconstruct_from_prime_exponent_data(data):
    value = QQ(1)
    for prime, exponent in data.items():
        value *= QQ(prime) ** ZZ(exponent)
    return value



def finite_box_sequence_entry(box_side, q):
    return (ZZ(len(box_sites(box_side))), prime_exponent_data(partition_polynomial(box_side)(QQ(q))))


def coarse_graining_value(box_side, q):
    # ε_{L,q}(𝒵_L) = Σ_σ Π_{e∈B(σ)} q（多変数分配多項式に全辺変数を q で代入した値）
    q = QQ(q)
    sites = box_sites(box_side)
    edges = inner_edges(box_side)
    total = QQ(0)
    for values in product([ZZ(1), ZZ(-1)], repeat=len(sites)):
        configuration = dict(zip(sites, values))
        term = QQ(1)
        for s, e in edges:
            if configuration[s] != configuration[e]:
                term *= q
        total += term
    return total


points = [QQ(2) / 3, QQ(4) / 6, QQ(5) / 7, QQ(3), QQ(1) / 2, QQ(6) / 2]
for box_side in [1, 2]:
    Z = partition_polynomial(box_side)
    for q in points:
        pi = coarse_graining_value(box_side, q)
        entry = finite_box_sequence_entry(box_side, q)
        # 段 1: π_L(q) = Z_L(q)（既存主張の再確認）
        assert pi == Z(q) and pi > 0
        # 段 2: π_L(q) は S_q の第 L 項から復元される（粗視化であること）
        assert reconstruct_from_prime_exponent_data(entry[1]) == pi
    for q in points:
        for q_prime in points:
            # 段 3: 粗視化の値の一致 ⇒ Z_L(q)=Z_L(q')（十分性の可算側の段）
            if coarse_graining_value(box_side, q) == coarse_graining_value(box_side, q_prime):
                assert Z(q) == Z(q_prime)
                assert finite_box_sequence_entry(box_side, q) == finite_box_sequence_entry(box_side, q_prime)
    print(f"L={box_side}: 有理点 {len(points)} 点 PASS")
print("ALL PASS")

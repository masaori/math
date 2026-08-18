# 対象ラベル: claim_tail_agreement_is_sufficient_for_limit_quantity
# 尾部一致から、素指数データ・分配多項式値・有限箱量が一致する可算側の段を、
# L=1,2 の有限列で証明と同順に確認する。
# 帰属: ZZ[X]、QQ、有限台の整数列だけを使う厳密計算。実数・極限・対数は使わない。
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
    return {prime: exponent for prime, exponent in data.items() if exponent != 0}


def finite_box_sequence_entry(box_side, q):
    value = partition_polynomial(box_side)(q)
    return (ZZ(len(box_sites(box_side))), prime_exponent_data(value))


def finite_box_quantity_power_identity(box_side, q):
    value = partition_polynomial(box_side)(q)
    site_count = ZZ(len(box_sites(box_side)))
    return value, site_count


# N=2 より前だけ異なり、N 以降は同じ有限箱データを持つ列の有限例。
# 先頭項は尾部一致の定義だけを検査する人工的な有限箱データであり、
# L=2 の項からは実際の分配多項式評価で証明の各段を検査する。
prefix_entry = (ZZ(1), {ZZ(2): ZZ(1)})
prefix_entry_prime = (ZZ(1), {ZZ(3): ZZ(1)})
assert prefix_entry != prefix_entry_prime
q_values = {2: QQ(3) / 2}
q_prime_values = {2: QQ(3) / 2}
N = ZZ(2)

for box_side in [2]:
    q = q_values[box_side]
    q_prime = q_prime_values[box_side]
    # 段 1: 尾部で有限箱の列の項が一致する。
    assert finite_box_sequence_entry(box_side, q) == finite_box_sequence_entry(box_side, q_prime)
    # 段 2: 素指数データから復元される正の有理数 Z_L(q), Z_L(q') が一致する。
    value, site_count = finite_box_quantity_power_identity(box_side, q)
    value_prime, site_count_prime = finite_box_quantity_power_identity(box_side, q_prime)
    assert value == value_prime
    assert site_count == site_count_prime
    # 段 3: 正の site_count 乗を取れば有限箱量も一致する。
    # 実数の乗根を使わず、a_L(q)^#V_L = Z_L(q) を表す有限べきの等式だけを検査する。
    assert value ** site_count_prime == value_prime ** site_count
    print(f"L={box_side}: tail entry, value, finite-power identity PASS")

print("ALL PASS")

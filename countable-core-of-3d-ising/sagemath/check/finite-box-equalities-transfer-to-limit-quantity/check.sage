# 対象ラベル: claim_finite_box_equalities_transfer_to_limit_quantity
# 有限箱の等式 Z_L(q)=Z_L(q') から有限箱の列 (#V_L, λ(Z_L(q))) の一致までを、
# 証明と同順に QQ 上で確認する（極限量への最終段は実数の極限なので検査対象外。
# その段は claim_limit_quantity_depends_only_on_finite_box_sequence に帰着している）。
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
    return {p: e for p, e in data.items() if e != 0}


def finite_box_sequence_entry(box_side, q):
    return (ZZ(len(box_sites(box_side))), prime_exponent_data(partition_polynomial(box_side)(QQ(q))))


# 仮定 Z_L(q)=Z_L(q') を満たす有理点の対: 同じ有理数の異なる表示（2/3 と 4/6）と、
# 分配多項式が回文なので Z_L(q)=q^{#E_L} Z_L(1/q) となるが、これは等式ではないので対に含めない。
pairs = [(QQ(2) / 3, QQ(4) / 6), (QQ(5) / 7, QQ(10) / 14), (QQ(3), QQ(6) / 2)]
for box_side in [1, 2]:
    Z = partition_polynomial(box_side)
    for q, q_prime in pairs:
        # 段 1: 仮定 Z_L(q)=Z_L(q')（正の有理数の等式）
        assert Z(q) == Z(q_prime) and Z(q) > 0
        # 段 2: λ は写像なので λ(Z_L(q))=λ(Z_L(q'))
        assert prime_exponent_data(Z(q)) == prime_exponent_data(Z(q_prime))
        # 段 3: 第 1 成分 #V_L は q によらず、列の項が一致する
        assert finite_box_sequence_entry(box_side, q) == finite_box_sequence_entry(box_side, q_prime)
    print(f"L={box_side}: #V_L={len(box_sites(box_side))}, Z_L={Z}, 対 {len(pairs)} 組 PASS")
print("ALL PASS")

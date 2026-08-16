# 対象ラベル: claim_limit_quantity_depends_only_on_finite_box_sequence
# 有限箱の列 (#V_L, λ(Z_L(q))) の一致から、素指数データによる正の有理数の一意な復元
# （∏ p^{e_p}）を経て有限箱の等式 Z_L(q)=Z_L(q') に至る可算側の段を、証明と同順に QQ 上で確認する。
# 続く段（#V_L 乗根の底と指数の一致、同一実数列の極限の一意性）は実数の話なので検査対象外。
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


def reconstruct_from_prime_exponent_data(data):
    value = QQ(1)
    for prime, exponent in data.items():
        value *= QQ(prime) ** ZZ(exponent)
    return value


def finite_box_sequence_entry(box_side, q):
    return (ZZ(len(box_sites(box_side))), prime_exponent_data(partition_polynomial(box_side)(QQ(q))))


# 仮定「有限箱の列が一致する」を満たす有理点の対（同じ有理数の異なる表示）
pairs = [(QQ(2) / 3, QQ(4) / 6), (QQ(5) / 7, QQ(10) / 14), (QQ(3), QQ(6) / 2)]
for box_side in [1, 2]:
    Z = partition_polynomial(box_side)
    for q, q_prime in pairs:
        # 仮定: 列の項 (#V_L, λ(Z_L(q))) が一致する
        entry, entry_prime = finite_box_sequence_entry(box_side, q), finite_box_sequence_entry(box_side, q_prime)
        assert entry == entry_prime
        # 段 1: 素指数データから正の有理数が ∏ p^{e_p} として一意に復元される
        assert reconstruct_from_prime_exponent_data(entry[1]) == Z(q)
        assert reconstruct_from_prime_exponent_data(entry_prime[1]) == Z(q_prime)
        # 段 2: したがって Z_L(q)=Z_L(q')（可算側の等式）
        assert Z(q) == Z(q_prime) and Z(q) > 0
        # 段 3: 第 1 成分 #V_L が一致する（乗根の指数の一致。乗根そのものは実数なので取らない）
        assert entry[0] == entry_prime[0] == ZZ(len(box_sites(box_side)))
    print(f"L={box_side}: #V_L={len(box_sites(box_side))}, 対 {len(pairs)} 組 PASS")
print("ALL PASS")

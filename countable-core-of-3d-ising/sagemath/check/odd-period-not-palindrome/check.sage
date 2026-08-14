# 奇数周期では多重度が回文でないことの検証。
# 本文の定義と証明の各段を、ZZ と有限集合の全数列挙で確かめる。
# 浮動小数点は使わない。

from itertools import product


def box_sites(box_side):
    # def_box: V_L = {0,..,L-1}^3
    return [
        (ZZ(a), ZZ(b), ZZ(c))
        for a in range(box_side)
        for b in range(box_side)
        for c in range(box_side)
    ]


def periodic_edges(box_side):
    # def_periodic_edge_set と def_periodic_endpoint_maps:
    # 辺は始点と方向の組で、終点の該当成分だけを周期的に一つ進める。
    edges = []
    for start in box_sites(box_side):
        for axis in range(3):
            end = list(start)
            end[axis] = ZZ((end[axis] + 1) % box_side)
            edges.append((start, axis, tuple(end)))
    return edges


def all_configurations(box_side):
    # def_configuration: V_L -> {+1,-1} を全数列挙する。
    sites = box_sites(box_side)
    for values in product([ZZ(1), ZZ(-1)], repeat=len(sites)):
        yield dict(zip(sites, values))


def periodic_broken_count(configuration, edges):
    # def_periodic_broken_count: 両端の値が異なる周期辺の本数。
    return ZZ(sum(
        1
        for (start, _axis, end) in edges
        if configuration[start] != configuration[end]
    ))


def periodic_multiplicities_by_enumeration(box_side):
    # def_periodic_multiplicity: 破れ数ごとの配位数を全数列挙する。
    edges = periodic_edges(box_side)
    multiplicity = {}
    for configuration in all_configurations(box_side):
        broken = periodic_broken_count(configuration, edges)
        multiplicity[broken] = multiplicity.get(broken, ZZ(0)) + ZZ(1)
    return multiplicity, ZZ(len(edges))


def check_constant_configuration(box_side):
    # claim_periodic_constant_unbroken: 定数配位の破れ数は 0。
    sites = box_sites(box_side)
    configuration = {site: ZZ(1) for site in sites}
    edges = periodic_edges(box_side)
    assert periodic_broken_count(configuration, edges) == 0
    print("claim_periodic_constant_unbroken: L=%d で定数配位の破れ数 0 を確認" % box_side)


def check_cycle_product_chain(box_side):
    # claim_periodic_no_all_broken の積の鎖を、方向 1 の一周の全 2^L 配位で確認する。
    assert box_side % 2 == 1
    for values in product([ZZ(1), ZZ(-1)], repeat=box_side):
        edge_products = [values[k] * values[(k + 1) % box_side] for k in range(box_side)]
        product_of_edge_products = prod(edge_products)
        product_of_starts_times_product_of_ends = prod(values) * prod(
            values[(k + 1) % box_side] for k in range(box_side)
        )
        square_of_spin_product = prod(values) ** 2

        # 本文の積の並べ替え二段。
        assert product_of_edge_products == product_of_starts_times_product_of_ends
        assert product_of_starts_times_product_of_ends == square_of_spin_product

        # 全辺が破れていれば各辺積は -1 だが、奇数周期では積の鎖と矛盾する。
        all_broken = all(edge_product == -1 for edge_product in edge_products)
        if all_broken:
            assert product_of_edge_products == (-1) ** box_side
            assert (-1) ** box_side == -1
            assert square_of_spin_product >= 0
            raise AssertionError("奇数周期ですべての辺を破る配位が存在した")
    print("claim_periodic_no_all_broken: L=%d の一周の全 %d 配位で全辺破れが無いことを確認"
          % (box_side, 2 ** box_side))


def check_multiplicity_counterexample():
    # L=1 は最小の奇数周期で、周期族の全配位を列挙できる。
    multiplicity_1, edge_count_1 = periodic_multiplicities_by_enumeration(1)
    assert edge_count_1 == 3
    assert sum(multiplicity_1.values()) == 2
    assert multiplicity_1.get(ZZ(0), ZZ(0)) == 2
    assert multiplicity_1.get(edge_count_1, ZZ(0)) == 0
    assert multiplicity_1.get(ZZ(0), ZZ(0)) != multiplicity_1.get(edge_count_1, ZZ(0))
    print("claim_periodic_not_palindrome: L=1 の全 2 配位で Omega(0)=2, Omega(#E)=0 を確認")


def check_even_period_calibration():
    # L=2 は最小の非自明な偶数周期。全 2^8 配位で回文性が保たれることを校正する。
    multiplicity_2, edge_count_2 = periodic_multiplicities_by_enumeration(2)
    assert edge_count_2 == 24
    assert sum(multiplicity_2.values()) == 2 ** 8
    for broken in range(edge_count_2 + 1):
        assert (
            multiplicity_2.get(ZZ(broken), ZZ(0))
            == multiplicity_2.get(edge_count_2 - ZZ(broken), ZZ(0))
        )
    print("偶数周期の校正: L=2 の全 256 配位で回文性を確認")


for side in [1, 3, 5]:
    check_constant_configuration(side)
    check_cycle_product_chain(side)

check_multiplicity_counterexample()
check_even_period_calibration()

print("all checks passed")

# 対象ラベル: claim_full_boundary_response_monomial_maps_to_monomial_under_outer_edges_to_one
# 内箱 V_{L'}={(0,0,0)}、外箱 V_L={0,1}^3、広い外箱 V_{L''}={0,1,2}x{0,1}x{0,1} について、
# 各配位 σ の単項式 ∏_{e∈B(σ)} X_e が π_{L'',L} で ∏_{e∈B(σ)∩E_L} X_e に写ることを、証明と同順で ZZ 上の厳密計算により確認する。
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
mid_sites, mid_edges = box_sites((2, 2, 2)), box_edges((2, 2, 2))
big_sites, big_edges = box_sites((3, 2, 2)), box_edges((3, 2, 2))

# 箱の包含 V_{L'} ⊂ V_L ⊂ V_{L''} と辺の包含 E_L ⊂ E_{L''}
assert set(inner_sites) <= set(mid_sites) <= set(big_sites)
assert set(mid_edges) <= set(big_edges)

# 多変数分配多項式 Z_{L''} の環（E_{L''} の全辺の不定元）と Z_L の環（E_L の全辺の不定元）
big_ring = PolynomialRing(ZZ, ["x%s" % i for i in range(len(big_edges))])
mid_ring = PolynomialRing(ZZ, ["x%s" % i for i in range(len(mid_edges))])
big_index = {edge: i for i, edge in enumerate(big_edges)}
mid_index = {edge: i for i, edge in enumerate(mid_edges)}


def partition_polynomial(ring, index, site_list, edge_list):
    """多変数分配多項式: 配位についての有限和、破れ辺の不定元の有限積。"""
    result = ring.zero()
    for values in product([ZZ(-1), ZZ(1)], repeat=len(site_list)):
        configuration = dict(zip(site_list, values))
        monomial = ring.one()
        for edge in edge_list:
            if configuration[edge[0]] != configuration[edge[1]]:
                monomial *= ring.gen(index[edge])
        result += monomial
    return result

# 定義: 辺変数を 1 に置かない境界応答多項式は多変数分配多項式そのもの
R_full_big = partition_polynomial(big_ring, big_index, big_sites, big_edges)

# 代入 pi_{L'',L}: E_{L''}\E_L の不定元を 1 に、E_L の不定元を同名の不定元に送る環準同型
images = []
for edge in big_edges:
    if edge in mid_index:
        images.append(mid_ring.gen(mid_index[edge]))
    else:
        images.append(mid_ring.one())
pi = big_ring.hom(images, mid_ring)

# 環準同型は有限積を保ち、不定元の行き先は e∈E_L なら X_e、e∈E_{L''}\E_L なら 1
for edge in big_edges:
    X = big_ring.gen(big_index[edge])
    if edge in mid_index:
        assert pi(X) == mid_ring.gen(mid_index[edge])
    else:
        assert pi(X) == mid_ring.one()

count_checked = 0
for values in product([ZZ(-1), ZZ(1)], repeat=len(big_sites)):
    configuration = dict(zip(big_sites, values))
    broken = [edge for edge in big_edges if configuration[edge[0]] != configuration[edge[1]]]
    # B(σ) は B(σ)∩E_L と B(σ)\E_L の互いに素な和集合
    broken_in_mid = [edge for edge in broken if edge in mid_index]
    broken_outside = [edge for edge in broken if edge not in mid_index]
    assert set(broken_in_mid).isdisjoint(broken_outside)
    assert set(broken_in_mid) | set(broken_outside) == set(broken)
    monomial = prod([big_ring.gen(big_index[edge]) for edge in broken], big_ring.one())
    # 環準同型は有限積を保つ
    image = pi(monomial)
    assert image == prod([pi(big_ring.gen(big_index[edge])) for edge in broken], mid_ring.one())
    # 行き先の場合分け: E_L の辺は同名の不定元、増えた辺は 1
    assert image == prod([mid_ring.gen(mid_index[edge]) for edge in broken_in_mid], mid_ring.one()) * prod([mid_ring.one() for edge in broken_outside], mid_ring.one())
    # 結論: 像は B(σ)∩E_L 上の相異なる不定元の積（単項式）
    expected = prod([mid_ring.gen(mid_index[edge]) for edge in broken_in_mid], mid_ring.one())
    assert image == expected
    assert image.is_monomial() or image == mid_ring.one()
    assert all(exponent <= 1 for exponent in image.exponents()[0])
    count_checked += 1

assert count_checked == ZZ(2) ** len(big_sites) == 4096
print("RESULT: PASS  checked %d configurations of the wide box; each monomial maps to the monomial over B(sigma) ∩ E_L" % count_checked)

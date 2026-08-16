# 対象ラベル: claim_full_boundary_response_degree_at_most_one
# 内箱 V_{L'}={(0,0,0)}、外箱 V_L={0,1}^3（8 点・12 辺）の自由境界の箱で、
# 辺変数を 1 に置かない境界応答多項式 R~_{L,L'} の各辺変数 X_{e0} についての次数が
# 高々 1 であることを、証明と同順（破れ辺集合の単項式の指数 → 有限和の次数の最大値評価）で
# ZZ 上の厳密計算により確認する。
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

# 箱の包含 V_{L'} ⊂ V_L
assert set(inner_sites) <= set(sites)
assert len(sites) == 8 and len(edges) == 12

ring = PolynomialRing(ZZ, ["x%s" % i for i in range(len(edges))])
index = {edge: i for i, edge in enumerate(edges)}

# 証明第一段: 配位ごとの破れ辺の有限集合 B(σ) と、単項式 ∏_{e∈B(σ)} X_e の有限和としての R~_{L,L'}
R_full = ring.zero()
for values in product([ZZ(-1), ZZ(1)], repeat=len(sites)):
    configuration = dict(zip(sites, values))
    broken = [edge for edge in edges if configuration[edge[0]] != configuration[edge[1]]]
    # B(σ) は相異なる辺の集合（リストに重複が無い）
    assert len(broken) == len(set(broken))
    monomial = ring.one()
    for edge in broken:
        monomial *= ring.gen(index[edge])
    # 証明第二段の前半: 各項の X_{e0} の指数は e0∈B(σ) なら 1、そうでなければ 0（いずれも高々 1）
    for edge in edges:
        exponent = monomial.degree(ring.gen(index[edge]))
        assert exponent == (1 if edge in broken else 0)
        assert exponent <= 1
    R_full += monomial

# 定義との一致: R~_{L,L'} は多変数分配多項式そのもの（2^8 配位の有限和）
assert len(list(product([ZZ(-1), ZZ(1)], repeat=len(sites)))) == 2 ** 8

# 証明第二段の後半: 有限和の X_{e0} についての次数は各項の次数の最大値以下（和で新しい単項式は生じない）。
# 実際に R~_{L,L'} の全単項式の全指数ベクトルを列挙し、各成分が高々 1 であることを確かめる。
for exponent_vector in R_full.exponents():
    for exponent in exponent_vector:
        assert exponent <= 1

# 結論: 任意の e0∈E_L について R~_{L,L'} の X_{e0} についての次数は高々 1
for edge in edges:
    degree = R_full.degree(ring.gen(index[edge]))
    assert degree <= 1
    assert degree in ZZ and degree >= 0 or degree == -1  # 値は自然数（非零多項式なので -1 は生じない）
    assert degree == 1  # この箱ではどの辺も或る配位で破れるので、次数はちょうど 1 になる

print("RESULT: PASS  #V_L=%d, #E_L=%d, all per-variable degrees of R~_{L,L'} are exactly 1 (<= 1)" % (len(sites), len(edges)))

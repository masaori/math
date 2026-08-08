# 対象ラベル: claim_edge_row_partition, claim_broken_bond_row_decomposition
#
# 本文（structured-latex/content/main-text.ts）の章「転送行列」の 2 つの主張
#   (1) 辺の集合は行ごとに分割される
#         j |-> iL+j+1 が {0,...,L-1} から E_{L,h,i} への全単射（縦は L^2 を足したもの）、
#         E_{L,h} = 互いに素な合併 E_{L,h,i}（i = 0,...,L-1）、|E_{L,h,i}| = L
#         端点は番号から直接読める
#   (2) 破れボンド数は行内の破れと行間の破れに分かれる
#         b(sigma) = sum_i b_h(rho_i(sigma)) + sum_i b_v(rho_i(sigma), rho_{i+1}(sigma))
# を、小さい L で総当たりに数え上げて確かめる。
#
# 左辺 b(sigma) は _shared/defs.sage の broken_bond_count（辺の番号を全部走って数える）、
# 右辺は行配位への制限から作る。両者は作り方が独立である。
# 独立でないと、この主張の検証は構成から自明になり空になる。
#
# 厳密計算のみ（ZZ）。浮動小数点は使わない。
# 本文がこの章で R へ脱出していないので、検証側にも脱出を持ち込まない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


def check_edge_row_partition(L):
    """claim_edge_row_partition の 5 つの主張を、本文の Step の順に確かめる。"""
    horizontal_rows = [horizontal_edge_numbers_of_row(L, i) for i in range(L)]
    vertical_rows = [vertical_edge_numbers_of_row(L, i) for i in range(L)]

    # 1 つめと 2 つめ（Step 3）: 番号付けの写像 j |-> iL+j+1（縦は L^2 を足したもの）が
    # {0,...,L-1} から各行の辺の集合への全単射であること（値に重複が無いこと）と、
    # その結果として本数が L であること。
    for i in range(L):
        assert horizontal_rows[i] == [i * L + j + 1 for j in range(L)], (L, i)
        assert vertical_rows[i] == [L * L + i * L + j + 1 for j in range(L)], (L, i)
        assert len(set(horizontal_rows[i])) == L, (L, i)
        assert len(set(vertical_rows[i])) == L, (L, i)

    # 3 つめ（Step 4）: 異なる行どうしは互いに素。
    for i in range(L):
        for i2 in range(i + 1, L):
            assert not (set(horizontal_rows[i]) & set(horizontal_rows[i2])), (L, i, i2)
            assert not (set(vertical_rows[i]) & set(vertical_rows[i2])), (L, i, i2)

    # 4 つめ（Step 5）: 合併がもとの集合に一致する。
    union_horizontal = set()
    for row in horizontal_rows:
        union_horizontal |= set(row)
    assert union_horizontal == set(horizontal_edge_numbers(L)), L

    union_vertical = set()
    for row in vertical_rows:
        union_vertical |= set(row)
    assert union_vertical == set(vertical_edge_numbers(L)), L

    # 5 つめ（Step 6）: 端点が番号から読める形と一致する。
    # 比較相手 endpoints は def_lattice の定義そのままなので、作り方は独立である。
    for i in range(L):
        for j in range(L):
            e = i * L + j + 1
            assert endpoints(L, e) == ((i, j), (i, (j + 1) % L)), (L, i, j)
            e = L * L + i * L + j + 1
            assert endpoints(L, e) == ((i, j), ((i + 1) % L, j)), (L, i, j)


def decomposed_broken_bond_count(L, sigma):
    """claim_broken_bond_row_decomposition の右辺を、行配位への制限から作る。"""
    rows = [row_restriction(L, sigma, i) for i in range(L)]
    intra = sum(intra_row_broken_count(L, rows[i]) for i in range(L))
    inter = sum(inter_row_broken_count(L, rows[i], rows[(i + 1) % L]) for i in range(L))
    return ZZ(intra + inter)


def check_decomposition(L):
    """すべての配位について、左辺（辺を全部走って数える）と右辺（行ごと）の一致を見る。"""
    for sigma in configurations(L):
        left = ZZ(broken_bond_count(L, sigma))
        right = decomposed_broken_bond_count(L, sigma)
        assert left == right, (L, sorted(sigma.items()), left, right)


def check_row_configurations(L):
    """def_row_configuration: 行配位の個数が 2^L であること。

    あわせて、配位の各行への制限がすべて行配位として現れることを見る
    （rho_i の値が R_L に入っていることの確認）。
    """
    all_rows = set(tuple(tau[j] for j in range(L)) for tau in row_configurations(L))
    assert len(all_rows) == 2 ** L, L
    for sigma in configurations(L):
        for i in range(L):
            tau = row_restriction(L, sigma, i)
            assert tuple(tau[j] for j in range(L)) in all_rows, (L, i)


def report(L):
    check_edge_row_partition(L)
    check_row_configurations(L)
    check_decomposition(L)
    print('L = %d: 辺の行ごとの分割・行配位の個数 2^%d・破れボンド数の分解 をすべて確認' % (L, L))


for L in [1, 2, 3]:
    report(L)

print('すべてのアサーションが成立した（L = 1, 2, 3。厳密計算のみ）')

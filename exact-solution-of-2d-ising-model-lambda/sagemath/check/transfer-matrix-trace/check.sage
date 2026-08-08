# 対象ラベル: claim_closed_walk_bijection / theorem_partition_polynomial_is_trace
#
# 本文（structured-latex/content/main-text.ts）の章「転送行列」の
#   主張   行配位の族全体と閉じた道全体は 1 対 1 に対応する（Theta が全単射、逆写像は Xi）
#   定理   分配多項式は転送行列の冪のトレースである（Z_L = Tr(T^L)）
# を、小さい L で総当たりに確かめる。
#
# 定理の左辺は配位を全列挙して x^{b(sigma)} を足して作り（partition_polynomial）、
# 右辺は転送行列の積を L-1 回繰り返してから対角成分を足して作る
# （row_matrix_pow / row_matrix_trace）。両者は作り方が独立である。
# 独立でないと、この検証は構成から自明になり空になる。
#
# 証明の途中の 2 つの準備も別々に確かめる。
#   準備 1: 閉じた道の全体が、両端の値 tau ごとの W_{L,L}(tau,tau) の互いに素な合併であること。
#   準備 2: 族から作った閉じた道の重みが x^{b(sigma)} に等しいこと。
#
# 厳密計算のみ（ZZ / ZZ[x]）。浮動小数点は使わない。
# 本文がこの章で R へ脱出していないので、検証側にも脱出を持ち込まない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


def check_theta_lands_in_closed_walks(L):
    """def_walk_of_family: Theta(c) が長さ L の閉じた道であること。"""
    for c in row_families(L):
        p = walk_of_family(L, c)
        assert len(p) == L + 1, (L, c)
        assert p[0] == p[L], (L, c)


def check_closed_walk_bijection(L):
    """claim_closed_walk_bijection: Theta と Xi が互いに逆であり、Theta が全単射であること。"""
    families = list(row_families(L))
    closed = list(closed_row_walks(L))

    # Xi ∘ Theta = id。
    for c in families:
        assert family_of_walk(L, walk_of_family(L, c)) == c, (L, c)

    # Theta ∘ Xi = id。
    for p in closed:
        assert walk_of_family(L, family_of_walk(L, p)) == p, (L, p)

    # 像がちょうど閉じた道の全体であること（重複なく尽くす）。
    image = [walk_of_family(L, c) for c in families]
    assert len(set(image)) == len(image), L
    assert set(image) == set(closed), L
    assert len(closed) == (2 ** L) ** L, L


def check_closed_walk_partition(L):
    """準備 1: 閉じた道の全体が両端の値ごとの類の互いに素な合併であること。"""
    keys = row_matrix_keys(L)
    closed = set(closed_row_walks(L))
    seen = set()
    total = 0
    for tau in keys:
        cls = set(row_walks(L, L, tau, tau))
        assert cls <= closed, (L, tau)
        assert cls & seen == set(), (L, tau)
        seen |= cls
        total += len(cls)
    assert seen == closed, L
    assert total == len(closed), L


def check_walk_weight_of_family(L):
    """準備 2: w_T(Theta(rows(sigma))) = x^{b(sigma)}。

    左辺は転送行列の成分を道に沿って掛けて作り、右辺は辺の番号を全部走って
    数えた破れボンド数から作っており、作り方が独立である。
    """
    T = transfer_matrix(L)
    for sigma in configurations(L):
        p = walk_of_family(L, rows_map(L, sigma))
        assert walk_weight(L, T, p) == x ** ZZ(broken_bond_count(L, sigma)), (L, sigma)


def check_partition_polynomial_is_trace(L):
    """theorem_partition_polynomial_is_trace: Z_L = Tr(T^L)。"""
    T = transfer_matrix(L)
    left = partition_polynomial(L)
    right = row_matrix_trace(L, row_matrix_pow(L, T, L))
    assert left == right, (L, left, right)
    return left


def report(L):
    check_theta_lands_in_closed_walks(L)
    check_closed_walk_bijection(L)
    check_closed_walk_partition(L)
    check_walk_weight_of_family(L)
    value = check_partition_polynomial_is_trace(L)
    print('L = %d: Theta の全単射性・閉じた道の類別・族から作った道の重み・'
          'Z_L = Tr(T^L) を確認（Z_%d = %s）' % (L, L, value))


for L in [1, 2, 3]:
    report(L)

print('すべてのアサーションが成立した（L = 1, 2, 3。厳密計算のみ）')

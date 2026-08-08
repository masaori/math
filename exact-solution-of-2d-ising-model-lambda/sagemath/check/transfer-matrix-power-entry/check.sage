# 対象ラベル: claim_matrix_pow_entry
#
# 本文（structured-latex/content/main-text.ts）の章「転送行列」の主張
#   行列の冪の成分は、道に沿った成分の積の和である
#     (A^k)_{tau,tau''} = sum_{p in W_{L,k}(tau,tau'')} w_A(p)
# を、小さい L と小さい k で総当たりに確かめる。
#
# 左辺は行列の積を k-1 回繰り返して作る（row_matrix_pow）。
# 右辺は道を全列挙して各道の成分の積を足す（row_walks / walk_weight）。
# 両者は作り方が独立である。独立でないと、この検証は構成から自明になり空になる。
#
# 行列は 2 種類で試す。
#   (1) 転送行列 T（本文が実際に使うもの）。
#   (2) 成分がすべて異なる x の冪である行列（成分どうしの偶然の一致で誤りが隠れないようにする。
#       T は対称な成分を多く持つので、添字の順序を取り違えても気づけない場合がある）。
#
# 厳密計算のみ（ZZ / ZZ[x]）。浮動小数点は使わない。
# 本文がこの章で R へ脱出していないので、検証側にも脱出を持ち込まない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


def distinct_entry_matrix(L):
    """成分がすべて異なる x の冪である行列を作る。

    添字の順序（行と列）を取り違えると値が変わるようにするため、
    (行の番号, 列の番号) の組ごとに違う指数を与える。
    """
    keys = row_matrix_keys(L)
    entries = {}
    for a, key_row in enumerate(keys):
        for b, key_col in enumerate(keys):
            entries[(key_row, key_col)] = x ** ZZ(a * len(keys) + b + 1)
    return entries


def check_walk_count(L, k):
    """def_row_walk: W_{L,k}(tau,tau'') の個数が (2^L)^{k-1} であること。"""
    keys = row_matrix_keys(L)
    for start in keys:
        for goal in keys:
            walks = list(row_walks(L, k, start, goal))
            assert len(walks) == (2 ** L) ** (k - 1), (L, k)
            assert len(set(walks)) == len(walks), (L, k)
            for p in walks:
                assert len(p) == k + 1, (L, k, p)
                assert p[0] == start and p[k] == goal, (L, k, p)


def check_pow_entry(L, k, A, name):
    """claim_matrix_pow_entry: 冪の成分が道に沿った積の和に等しいこと。"""
    keys = row_matrix_keys(L)
    power = row_matrix_pow(L, A, k)
    for start in keys:
        for goal in keys:
            left = power[(start, goal)]
            right = sum(
                (walk_weight(L, A, p) for p in row_walks(L, k, start, goal)),
                PolynomialRingZx(0),
            )
            assert left == right, (name, L, k, start, goal, left, right)


def check_base_case(L, A, name):
    """本文の Step 1: k = 1 のとき道はちょうど 1 つで、その重みは A_{tau,tau''}。"""
    keys = row_matrix_keys(L)
    for start in keys:
        for goal in keys:
            walks = list(row_walks(L, 1, start, goal))
            assert len(walks) == 1, (name, L)
            assert walk_weight(L, A, walks[0]) == A[(start, goal)], (name, L)


def check_extension_bijection(L, k, A, name):
    """本文の Step 6・Step 7: 道の延長 Phi が全単射で、w_A(Phi(tau'',p)) = w_A(p) A_{tau'',tau'''}。"""
    keys = row_matrix_keys(L)
    for start in keys:
        for goal_next in keys:
            image = []
            for middle in keys:
                for p in row_walks(L, k, start, middle):
                    q = p + (goal_next,)
                    image.append(q)
                    # Step 7: 対応する項が等しいこと。
                    assert walk_weight(L, A, q) == walk_weight(L, A, p) * A[(middle, goal_next)], \
                        (name, L, k, p)
                    # Psi(Phi(tau'', p)) = (tau'', p)。
                    assert q[k] == middle and q[:k + 1] == p, (name, L, k, p)
            # Step 6: 像が重複なく W_{L,k+1}(start, goal_next) を尽くすこと。
            target = set(row_walks(L, k + 1, start, goal_next))
            assert len(set(image)) == len(image), (name, L, k)
            assert set(image) == target, (name, L, k)


def report(L):
    matrices = [(transfer_matrix(L), '転送行列 T'), (distinct_entry_matrix(L), '成分がすべて異なる行列')]
    for A, name in matrices:
        check_base_case(L, A, name)
        for k in [1, 2, 3]:
            check_walk_count(L, k)
            check_pow_entry(L, k, A, name)
        for k in [1, 2]:
            check_extension_bijection(L, k, A, name)
    print('L = %d: 道の個数・k = 1,2,3 での冪の成分表示・延長の全単射性を、'
          '転送行列と成分がすべて異なる行列の 2 つで確認' % L)


for L in [1, 2, 3]:
    report(L)

print('すべてのアサーションが成立した（L = 1, 2, 3、k = 1, 2, 3。厳密計算のみ）')

# 対象ラベル: def_permutation_sign / claim_permutation_sign_mul
#
# 本文の定義 def_permutation_sign と主張「符号は合成について乗法的である」は、
# 線型順序 ≺ を持つ任意の有限集合 J の上で述べられている。check.sage は J を行配位に
# 取った場合だけを見るので、ここでは J = {0,...,n-1} に「全ての線型順序」を載せて確かめる
# （Lean の具体版 finiteOrderedSign_comp が述べる一般の場合に対応する）。
#
# 確かめること（本文の証明の段と同じ順）。
#   1. Psi(u,u') が P の元であること。Psi' (psi^{-1} から同じ作り方) が逆写像であること。
#   2. |A| = inv(phi∘psi)、|B| = inv(psi)、|C| = inv(phi)。
#   3. 各対 (u,u') ∈ P について A, B, C のうち属するものの個数が偶数。
#   4. sgn(phi∘psi) sgn(phi) sgn(psi) = 1 と sgn(phi∘psi) = sgn(phi) sgn(psi)。
#   否定の対照: 三分律を満たさない関係（全順序でない半順序）では、本文の定義どおりに作った
#   「符号」の乗法性が崩れる例が実際にあることを確かめる（検算が素通りしていないことの確認）。
#
# 走らせる範囲: n = 1,...,4 は全ての線型順序（n! 個）と全ての置換の全対。
#               n = 5 は線型順序 3 個（標準・逆・一つの並べ替え）と全ての置換の全対。
# 厳密計算のみ（ZZ と有限集合）。浮動小数点は使わない。

import itertools

def make_lt(rank):
    return lambda u, v: rank[u] < rank[v]

def ordered_pairs(n, lt):
    return [(u, v) for u in range(n) for v in range(n) if lt(u, v)]

def inv_count(phi, pairs, lt):
    return len([(u, v) for (u, v) in pairs if lt(phi[v], phi[u])])

def sgn(phi, pairs, lt):
    return ZZ(-1) ** inv_count(phi, pairs, lt)

def compose(phi, psi):
    return tuple(phi[psi[u]] for u in range(len(psi)))

def inverse(psi):
    out = [None] * len(psi)
    for u, w in enumerate(psi):
        out[w] = u
    return tuple(out)

def pair_map(psi, p, lt):
    u, v = p
    return (psi[u], psi[v]) if lt(psi[u], psi[v]) else (psi[v], psi[u])

def check_one_order(n, rank):
    lt = make_lt(rank)
    pairs = ordered_pairs(n, lt)
    pair_set = set(pairs)
    perms = list(itertools.permutations(range(n)))
    count = 0
    for psi in perms:
        psi_inv = inverse(psi)
        for p in pairs:
            q = pair_map(psi, p, lt)
            assert q in pair_set
            assert pair_map(psi_inv, q, lt) == p
            assert pair_map(psi, pair_map(psi_inv, p, lt), lt) == p
        for phi in perms:
            comp = compose(phi, psi)
            A = [p for p in pairs if lt(comp[p[1]], comp[p[0]])]
            B = [p for p in pairs if lt(psi[p[1]], psi[p[0]])]
            C = [p for p in pairs if lt(phi[pair_map(psi, p, lt)[1]], phi[pair_map(psi, p, lt)[0]])]
            assert len(A) == inv_count(comp, pairs, lt)
            assert len(B) == inv_count(psi, pairs, lt)
            assert len(C) == inv_count(phi, pairs, lt)
            sA, sB, sC = set(A), set(B), set(C)
            for p in pairs:
                assert ((p in sA) + (p in sB) + (p in sC)) % 2 == 0
            s_comp, s_phi, s_psi = sgn(comp, pairs, lt), sgn(phi, pairs, lt), sgn(psi, pairs, lt)
            assert s_comp * s_phi * s_psi == 1
            assert s_comp == s_phi * s_psi
            count += 1
    return count

total = 0
for n in range(1, 5):
    orders = list(itertools.permutations(range(n)))
    for rank in orders:
        total += check_one_order(n, rank)
    print("n = %d: 線型順序 %d 個すべて、置換の全対で 1〜4 が成立" % (n, len(orders)))
for rank in [(0, 1, 2, 3, 4), (4, 3, 2, 1, 0), (2, 0, 4, 1, 3)]:
    total += check_one_order(5, rank)
print("n = 5: 線型順序 3 個（標本）、置換の全対で 1〜4 が成立")
print("乗法性を確かめた (順序, phi, psi) の組: %d" % total)

# 否定の対照: 0 < 1 だけを持つ {0,1,2} 上の関係（2 は 0,1 と比べられない。三分律が崩れる）。
lt_bad = lambda u, v: (u, v) == (0, 1)
pairs_bad = ordered_pairs(3, lt_bad)
perms3 = list(itertools.permutations(range(3)))
failures = [(phi, psi) for phi in perms3 for psi in perms3
            if sgn(compose(phi, psi), pairs_bad, lt_bad) != sgn(phi, pairs_bad, lt_bad) * sgn(psi, pairs_bad, lt_bad)]
assert len(failures) > 0
print("否定の対照: 三分律を満たさない関係では乗法性が %d 組で崩れる（例 %s）" % (len(failures), failures[0]))
print("すべてのアサーションが成立した（厳密計算のみ）")

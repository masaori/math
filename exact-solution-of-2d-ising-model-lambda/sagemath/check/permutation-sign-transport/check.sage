"""全単射で移した置換の符号がもとの置換の符号に等しいことを、証明の各段とともに検査する。

対象: claim_permutation_sign_transport。
J = {0,...,n-1} に線型順序 rank_J（rank_J[u] が小さいほど前）を、K = {0,...,n-1} に標準順序を置く。
全単射 d と置換 sigma を走査し、次を整数上で確かめる。
  (1) Pi_d, Pi_sigma が順序対の集合の間の全単射であること
  (2) |C| = inv_K(tau), |A| = inv_J(sigma), |B'| = |B|
  (3) 各対で A, B, B', C に属するものの個数が偶数であること
  (4) sgn_K(tau) = sgn_J(sigma)
"""
from itertools import permutations


def ordered_pairs(n, less):
    return [(u, v) for u in range(n) for v in range(n) if less(u, v)]


def pair_map(f, p, less_target):
    a, b = f[p[0]], f[p[1]]
    return (a, b) if less_target(a, b) else (b, a)


def run(n, rank_J):
    lessJ = lambda u, v: rank_J[u] < rank_J[v]
    lessK = lambda u, v: u < v
    PJ = ordered_pairs(n, lessJ)
    PK = ordered_pairs(n, lessK)
    checked = 0
    for d in permutations(range(n)):
        d_inv = [d.index(v) for v in range(n)]
        assert sorted(pair_map(d, p, lessK) for p in PJ) == sorted(PK)
        assert all(pair_map(d_inv, pair_map(d, p, lessK), lessJ) == p for p in PJ)
        for sigma in permutations(range(n)):
            tau = [d[sigma[d_inv[v]]] for v in range(n)]
            assert sorted(pair_map(sigma, p, lessJ) for p in PJ) == sorted(PJ)
            A = {p for p in PJ if lessJ(sigma[p[1]], sigma[p[0]])}
            B = {p for p in PJ if lessK(d[p[1]], d[p[0]])}
            Bp = {p for p in PJ if pair_map(sigma, p, lessJ) in B}
            C = {p for p in PJ
                 if lessK(tau[pair_map(d, p, lessK)[1]], tau[pair_map(d, p, lessK)[0]])}
            inv_tau = sum(1 for (v, w) in PK if lessK(tau[w], tau[v]))
            inv_sigma = sum(1 for (u, w) in PJ if lessJ(sigma[w], sigma[u]))
            assert len(C) == inv_tau and len(A) == inv_sigma and len(Bp) == len(B)
            for p in PJ:
                assert ((p in A) + (p in B) + (p in Bp) + (p in C)) % 2 == 0
            assert ZZ(-1) ** inv_tau == ZZ(-1) ** inv_sigma
            checked += 1
    return checked


total = 0
for n in range(0, 5):
    for order in permutations(range(n)):
        rank_J = list(order)
        total += run(n, rank_J)
total += run(5, list(range(5)))
total += run(5, [3, 0, 4, 1, 2])
print(f"PASS: sgn_K(d o sigma o d^-1) = sgn_J(sigma) and every step holds ({total} pairs (d, sigma))")

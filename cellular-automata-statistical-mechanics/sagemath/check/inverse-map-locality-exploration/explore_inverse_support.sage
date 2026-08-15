# 探索（未昇格）: 巡回舞台 V = Z/LZ 上の全 256 初等 CA 規則について、大域写像 F が単射のとき
# 逆写像 F^{-1} : A^V → A^V の各セルの本質的依存台（一点反転検査。章「本質的依存台の有限決定」の
# 判定法を A^V 上の写像へそのまま適用）を厳密に数え、順写像の依存台（N(v) = {v-1, v, v+1} の
# 部分集合。個数 ≤ 3）と比べる。浮動小数点・R/C は使わない。
import itertools

def eca_rule_table(rule):
    return {(a, b, c): (rule >> (4 * a + 2 * b + c)) & 1 for a in (0, 1) for b in (0, 1) for c in (0, 1)}

def global_map(L, table):
    confs = list(itertools.product((0, 1), repeat=L))
    F = {}
    for x in confs:
        F[x] = tuple(table[(x[(v - 1) % L], x[v], x[(v + 1) % L])] for v in range(L))
    return confs, F

def flip(x, u):
    # Sage は ^ を冪に前処理するので XOR を使わない
    y = list(x); y[u] = 1 - y[u]
    return tuple(y)

def support_of_map(confs, G, L):
    # supp(G_v) := { u : ∃ y, G(y)_v ≠ G(flip_u y)_v }
    supp = {v: set() for v in range(L)}
    for y in confs:
        Gy = G[y]
        for u in range(L):
            Gyu = G[flip(y, u)]
            for v in range(L):
                if Gy[v] != Gyu[v]:
                    supp[v].add(u)
    return supp

summary = []
for L in range(1, 8):
    for rule in range(256):
        table = eca_rule_table(rule)
        confs, F = global_map(L, table)
        if len(set(F.values())) != len(confs):
            continue  # 単射でない
        Finv = {F[x]: x for x in confs}
        supp_F = support_of_map(confs, F, L)
        supp_Finv = support_of_map(confs, Finv, L)
        max_fwd = max(len(supp_F[v]) for v in range(L))
        max_inv = max(len(supp_Finv[v]) for v in range(L))
        nbhd = {v: {(v - 1) % L, v % L, (v + 1) % L} for v in range(L)}
        inv_in_nbhd = all(supp_Finv[v] <= nbhd[v] for v in range(L))
        summary.append((L, rule, max_fwd, max_inv, inv_in_nbhd))

print("L rule max|supp f_v| max|supp (F^-1)_v| inv⊆N(v)")
worst = {}
for (L, rule, mf, mi, ok) in summary:
    if mi > mf or not ok:
        print(L, rule, mf, mi, ok)
    worst[L] = max(worst.get(L, 0), mi)
print("injective count per L:", {L: sum(1 for s in summary if s[0] == L) for L in range(1, 8)})
print("max inverse support size per L:", worst)
print("cases with inverse support not inside N(v):", sum(1 for s in summary if not s[4]))
print("cases with inverse support larger than forward:", sum(1 for s in summary if s[3] > s[2]))

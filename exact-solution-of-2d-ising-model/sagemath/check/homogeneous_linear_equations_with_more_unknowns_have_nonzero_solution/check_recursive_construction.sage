# 対象ラベル: homogeneous_linear_equations_with_more_unknowns_have_nonzero_solution
# 証明の帰納法を、そのとおりの再帰で実装して解 c を作り、各段で現れる鎖を一行ずつ確かめる:
#   q = 0: c = (1, 0, …, 0)
#   場合 1（a_{pj} がすべて 0）: c = (0, …, 0, 1)、7 行の鎖
#   場合 2（a_{pj_0} ≠ 0。j_0 は最小のものを取る）: g_{kj_0} の 5 行の鎖、Σ_i c_i a_ij の 11 行の鎖、
#     j = j_0 の 3 行の鎖、j ≠ j_0 の 3 行の鎖（δ^q_{j_0} は def_index_skipping_map を 0 始まりで書いたもの）
# 帰属: K = QQ(i)（厳密計算）。乱数の係数は半分ほどを 0 にして、場合 1 と場合 2 の両方を通す。
load("../../_shared/linear_algebra_families.sage")
import random
rng = random.Random(int(5))
cases = {"q=0": 0, "case1": 0, "case2": 0}


def csum(zs):
    return fsum(zs)


def solve(a, p, q):
    """証明の帰納法どおりに c を返す。a は p 行 q 列のリストのリスト（0 始まり）。"""
    if q == 0:
        cases["q=0"] += 1
        return [K(1)] + [K(0)] * (p - 1)
    if all(a[p - 1][j] == 0 for j in range(q)):
        cases["case1"] += 1
        c = [K(0)] * (p - 1) + [K(1)]
        for j in range(q):
            chain = [csum([c[i] * a[i][j] for i in range(p)]),
                     csum([c[i] * a[i][j] for i in range(p - 1)]) + c[p - 1] * a[p - 1][j],
                     csum([K(0) * a[i][j] for i in range(p - 1)]) + K(1) * a[p - 1][j],
                     csum([K(0)] * (p - 1)) + K(1) * a[p - 1][j],
                     K(0) + K(1) * a[p - 1][j], K(1) * a[p - 1][j], a[p - 1][j], K(0)]
            for t in range(len(chain) - 1):
                ok(chain[t] == chain[t + 1], ("case1", t))
        return c
    cases["case2"] += 1
    j0 = min(j for j in range(q) if a[p - 1][j] != 0)
    alpha = a[p - 1][j0] ^ (-1)
    ok(alpha * a[p - 1][j0] == 1, "α a = 1")
    tau = [-(alpha * a[p - 1][j]) for j in range(q)]
    g = [[a[k][j] + a[k][j0] * tau[j] for j in range(q)] for k in range(p - 1)]
    for k in range(p - 1):
        chain = [g[k][j0], a[k][j0] + a[k][j0] * (-(alpha * a[p - 1][j0])), a[k][j0] + a[k][j0] * (-K(1)),
                 a[k][j0] + (-(a[k][j0] * K(1))), a[k][j0] + (-a[k][j0]), K(0)]
        for t in range(len(chain) - 1):
            ok(chain[t] == chain[t + 1], ("g_kj0", t))
    qq = q - 1
    delta = lambda l: l if l < j0 else l + 1
    b = [[g[k][delta(l)] for l in range(qq)] for k in range(p - 1)]
    cp = solve(b, p - 1, qq)
    ok(any(x != 0 for x in cp), "c' ≠ 0")
    for l in range(qq):
        ok(csum([cp[k] * b[k][l] for k in range(p - 1)]) == 0, "c' の取り方")
    S = csum([cp[k] * a[k][j0] for k in range(p - 1)])
    c = list(cp) + [-(S * alpha)]
    for j in range(q):
        chain = [
            csum([c[i] * a[i][j] for i in range(p)]),
            csum([c[i] * a[i][j] for i in range(p - 1)]) + c[p - 1] * a[p - 1][j],
            csum([cp[k] * a[k][j] for k in range(p - 1)]) + (-(S * alpha)) * a[p - 1][j],
            csum([cp[k] * a[k][j] for k in range(p - 1)]) + (-((S * alpha) * a[p - 1][j])),
            csum([cp[k] * a[k][j] for k in range(p - 1)]) + (-(S * (alpha * a[p - 1][j]))),
            csum([cp[k] * a[k][j] for k in range(p - 1)]) + S * (-(alpha * a[p - 1][j])),
            csum([cp[k] * a[k][j] for k in range(p - 1)]) + S * tau[j],
            csum([cp[k] * a[k][j] for k in range(p - 1)]) + csum([(cp[k] * a[k][j0]) * tau[j] for k in range(p - 1)]),
            csum([cp[k] * a[k][j] + (cp[k] * a[k][j0]) * tau[j] for k in range(p - 1)]),
            csum([cp[k] * a[k][j] + cp[k] * (a[k][j0] * tau[j]) for k in range(p - 1)]),
            csum([cp[k] * (a[k][j] + a[k][j0] * tau[j]) for k in range(p - 1)]),
            csum([cp[k] * g[k][j] for k in range(p - 1)]),
        ]
        for t in range(len(chain) - 1):
            ok(chain[t] == chain[t + 1], ("main", j, t))
        if j == j0:
            sub = [chain[-1], csum([cp[k] * K(0) for k in range(p - 1)]), csum([K(0)] * (p - 1)), K(0)]
        else:
            ok(qq >= 1, "j ≠ j0 なら q ≥ 1")
            l = j if j < j0 else j - 1
            ok(delta(l) == j, "δ(l) = j")
            sub = [chain[-1], csum([cp[k] * g[k][delta(l)] for k in range(p - 1)]), csum([cp[k] * b[k][l] for k in range(p - 1)]), K(0)]
        for t in range(len(sub) - 1):
            ok(sub[t] == sub[t + 1], ("tail", j, t))
    return c


trials = 0
for q in range(0, 5):
    for p in range(q + 1, q + 4):
        for _ in range(6):
            a = [[(small_K(rng) if rng.random() < 0.5 else K(0)) for j in range(q)] for i in range(p)]
            if rng.random() < 0.3 and q > 0:
                a[p - 1] = [K(0)] * q
            c = solve(a, p, q)
            ok(any(x != 0 for x in c), "主張: c ≠ 0")
            for j in range(q):
                ok(csum([c[i] * a[i][j] for i in range(p)]) == 0, "主張: 方程式")
            trials += 1
ok(min(cases.values()) > 0, cases)
# 対照: 未知数が式より多くない（p ≤ q）と、0 でない解が無い場合がある（係数行列が単位行列）
for q in range(1, 4):
    A = identity_matrix(K, q)
    ok(A.left_kernel().dimension() == 0, "対照")
print("trials", trials, "cases", cases)
print("checked", count(), "items")
print("RESULT: PASS")

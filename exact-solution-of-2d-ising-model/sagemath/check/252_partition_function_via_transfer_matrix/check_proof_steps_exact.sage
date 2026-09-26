# ---------------------------------------------------------
# SageMath: 証明の中間目標を一つずつ厳密に（ZZ[x_1^{±1}, x_2^{±1}]、x_i = exp(K_i)）
#   (R)   有限和の添字の付け替え Σ_k g(k) = Σ_ν g(ord(ν))           （ord が全単射であることの帰結）
#   積の成分  A_{ord(μ),ord(μ')} = Σ_ν (V_1)_{ord μ, ord ν}(V_2)_{ord ν, ord μ'}
#                               = x_1^{Σ μ(m)μ(m+1)} x_2^{Σ μ(m)μ'(m)}           （A := V_1V_2）
#   (*)   (A^r)_{ord μ^(1), ord μ^(r+1)} = Σ_{μ^(2..r)} Π_k A_{ord μ^(k), ord μ^(k+1)}   （r = 1,2,3）
#   トレースの展開  tr(A^N) = Σ_{(μ^(1..N))} Π_k A_{ord μ^(k), ord μ^(k+1)}（μ^(N+1) := μ^(1)）
#   指数の積  Π_k A_{…} = x_1^{Σ_{k,m} μ^(k)(m)μ^(k)(m+1)} x_2^{Σ_{k,m} μ^(k)(m)μ^(k+1)(m)}
#   Φ : 𝔐^N → 𝔖 が全単射で、延長後の s について (P) s(i,j+1) = μ^(i)(j+1), s(i+1,j) = μ^(i+1)(j)
# 対象ラベル: partition_function_via_transfer_matrix
# 帰属: ZZ 係数の Laurent 多項式と ZZ。ℝ 脱出なし。
# ---------------------------------------------------------
import os
import itertools
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/row_configurations.sage"))
L = LaurentPolynomialRing(ZZ, 'x1,x2')
x1, x2 = L.gens()
ok_all = True


def row_bond(mu):
    M = len(mu)
    return sum(mu[m] * mu[(m + 1) % M] for m in range(M))


def inter_bond(mu, mup):
    return sum(mu[m] * mup[m] for m in range(len(mu)))


for M_col in range(1, 4):
    cfg = row_configurations(M_col)
    V1 = V1_by_components(M_col, lambda n: x1 ** n, L)
    V2 = V2_by_components(M_col, lambda n: x2 ** n, L)
    A = V1 * V2
    o = {mu: ord_number(mu) - 1 for mu in cfg}          # 0 始まりの配列添字
    ok = True
    # (R): 任意の g で Σ_k g(k) = Σ_ν g(ord ν)。g を成分の列にとる
    for g in [A.column(0), V2.row(0), vector(L, [x1 ** k for k in range(2 ** M_col)])]:
        ok = ok and (sum(g) == sum(g[o[nu]] for nu in cfg))
    # 積の成分の 4 段
    for mu in cfg:
        for mup in cfg:
            chain = [A[o[mu], o[mup]],
                     sum(V1[o[mu], k] * V2[k, o[mup]] for k in range(2 ** M_col)),
                     sum(V1[o[mu], o[nu]] * V2[o[nu], o[mup]] for nu in cfg),
                     sum((x1 ** row_bond(mu) if mu == nu else L(0)) * x2 ** inter_bond(nu, mup) for nu in cfg),
                     x1 ** row_bond(mu) * x2 ** inter_bond(mu, mup)]
            ok = ok and all(c == chain[0] for c in chain)
    # (*) for r = 1, 2, 3
    for r in range(1, 4):
        Ar = A ** r
        for mu1 in cfg:
            for mulast in cfg:
                s = L(0)
                for mid in itertools.product(cfg, repeat=r - 1):
                    path = (mu1,) + mid + (mulast,)
                    s += prod([A[o[path[k]], o[path[k + 1]]] for k in range(r)], L(1))
                ok = ok and (Ar[o[mu1], o[mulast]] == s)
    # トレースの展開・指数の積・Φ と (P)、N_row = 1..3
    for N_row in range(1, 4):
        tr = (A ** N_row).trace()
        path_sum = L(0)
        images = set()
        Z_via_S = L(0)
        for rows in itertools.product(cfg, repeat=N_row):
            ext = rows + (rows[0],)                        # μ^(N_row+1) := μ^(1)
            p = prod([A[o[ext[k]], o[ext[k + 1]]] for k in range(N_row)], L(1))
            e1 = sum(row_bond(ext[k]) for k in range(N_row))
            e2 = sum(inter_bond(ext[k], ext[k + 1]) for k in range(N_row))
            ok = ok and (p == x1 ** e1 * x2 ** e2)
            path_sum += p
            # Φ(μ^(1..N)) = s, s(i,j) = μ^(i)(j)。周期的に延長した s で (P) を確かめる
            s = {(i, j): rows[i - 1][j - 1] for i in range(1, N_row + 1) for j in range(1, M_col + 1)}
            sx = lambda i, j: s[(((i - 1) % N_row) + 1, ((j - 1) % M_col) + 1)]
            mu_ext = lambda i, j: ext[i - 1][(j - 1) % M_col]      # μ^(i)(M_col+1) := μ^(i)(1)
            for i in range(1, N_row + 1):
                for j in range(1, M_col + 1):
                    ok = ok and sx(i, j) == mu_ext(i, j) and sx(i, j + 1) == mu_ext(i, j + 1) and sx(i + 1, j) == mu_ext(i + 1, j)
            images.add(tuple(sorted(s.items())))
            f1 = sum(sx(i, j) * sx(i, j + 1) for i in range(1, N_row + 1) for j in range(1, M_col + 1))
            f2 = sum(sx(i, j) * sx(i + 1, j) for i in range(1, N_row + 1) for j in range(1, M_col + 1))
            ok = ok and (f1 == e1) and (f2 == e2)
            Z_via_S += x1 ** f1 * x2 ** f2
        ok = ok and (len(images) == 2 ** (N_row * M_col))    # Φ は単射、元数が等しいので全単射
        ok = ok and (tr == path_sum) and (path_sum == Z_via_S)
    print(f"  M_col={M_col}: (R)、積の成分の 4 段、(*) r=1..3、トレースの展開、指数の積、Φ の全単射と (P)（N_row=1..3） -> {'PASS' if ok else 'FAIL'}")
    ok_all = ok_all and ok
exact_result(ok_all)

# 対象ラベル: power_of_real_symmetric_complex_matrix_is_real_symmetric
# 人手証明の鎖を、実対称な A（成分 a_{kl} = a_{lk} を QQ 上の不定元にした n = 1..3 の行列と、QQ の具体の対称行列 n = 1..5）で
# 1 行ずつ確かめる。
#   準備:       A^1 = A^{0+1} = A^0A = IA = A
#   p = 0:      (I)_kl = δ_kl ∈ {1_C, 0_C}（成分が実）、(I^⊤)_kl = I_lk = δ_lk = δ_kl = I_kl
#   p → p+1:    ((A^{p+1})^⊤)_kl = (A^{p+1})_lk = (A^pA)_lk = Σ_j (A^p)_lj A_jk = Σ_j ((A^p)^⊤)_jl (A^⊤)_kj = Σ_j (A^p)_jl A_kj
#               = Σ_j A_kj (A^p)_jl = (AA^p)_kl = (A^1A^p)_kl = (A^{1+p})_kl = (A^{p+1})_kl
# 冪は def_exp (1)、積は mat_mult の成分の式、転置は def_matrix_transpose（共通の準備 matrix_operations_by_definition.sage）。
# 不定元の環は実数を代表する（成分は QQ 上の多項式なので、虚部を持たない。実部・虚部の対で組んで虚部が 0 であることも確かめる）。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/complex_as_real_pairs.sage")
set_random_seed(20261104)

steps = 0


def eq(a, b, what):
    global steps
    assert a == b, what
    steps += 1


def power_by_def_exp(A, k):
    X = body_identity(A.base_ring(), A.nrows())
    for _ in range(k):
        X = body_product(X, A)
    return X


def symmetric_generic(n):
    names = [f"a_{k}_{l}" for k in range(n) for l in range(k, n)]
    P = PolynomialRing(QQ, names)
    g = iter(P.gens())
    e = {}
    for k in range(n):
        for l in range(k, n):
            e[(k, l)] = e[(l, k)] = next(g)
    return matrix(P, n, n, lambda k, l: e[(k, l)])


def check_chains(A, pmax, what):
    n = A.nrows()
    R = A.base_ring()
    I = body_identity(R, n)
    eq(body_transpose(A), A, f"{what}: 仮定 A^⊤ = A")
    Z2 = PolynomialRing(QQ, ["zx", "zy"])
    zgen = Z2.gens()                                   # ℂ の一般の元 (x, y)（x, y は QQ 上の不定元）
    pw = [power_by_def_exp(A, k) for k in range(pmax + 2)]
    # 準備 A^1 = A
    L = [pw[1], pw[0 + 1], body_product(pw[0], A), body_product(I, A), A]
    for a, b in zip(L, L[1:]):
        eq(a, b, f"{what}: 準備 A^1 = A")
    # p = 0
    for k in range(n):
        for l in range(n):
            eq(I[k, l], body_delta(R, k, l), f"{what}: I_kl = δ_kl")
            # δ_kl を ℂ の元（実数の組）として: 場合分けの 1_C・0_C と、その ι(1)・ι(0) の表記。ι は definition_of_cc の (r, 0)
            one_c, zero_c = (R(1), R(0)), (R(0), R(0))                     # 1_C = (1, 0)、0_C = (0, 0)（ℂ の乗法・加法の単位元）
            delta_c = one_c if k == l else zero_c
            eq(cc_mul(tuple(Z2(QQ(c)) for c in one_c), zgen), zgen, f"{what}: 1_C は ℂ の積の単位元")
            eq(cc_add(tuple(Z2(QQ(c)) for c in zero_c), zgen), zgen, f"{what}: 0_C は ℂ の和の単位元")
            eq(delta_c, iota(1, R) if k == l else iota(0, R), f"{what}: δ_kl = ι(1) または ι(0)")
            eq(delta_c[1], R(0), f"{what}: I_kl の虚部は 0")
            eq(delta_c[0], I[k, l], f"{what}: I_kl の実部は単位行列の成分")
            eq(body_transpose(I)[k, l], I[l, k], f"{what}: (I^⊤)_kl = I_lk")
            eq(I[l, k], body_delta(R, l, k), f"{what}: I_lk = δ_lk")
            eq(body_delta(R, l, k), body_delta(R, k, l), f"{what}: δ_lk = δ_kl")
    # p → p+1
    for p in range(pmax + 1):
        Ap = pw[p]
        eq(body_transpose(Ap), Ap, f"{what}: 帰納法の仮定 p={p}")
        Ap1T = body_transpose(pw[p + 1])
        ApT = body_transpose(Ap)
        AT = body_transpose(A)
        AAp = body_product(A, Ap)
        A1Ap = body_product(pw[1], Ap)
        for k in range(n):
            for l in range(n):
                L = [Ap1T[k, l],
                     pw[p + 1][l, k],
                     body_product(Ap, A)[l, k],
                     sum(Ap[l, j] * A[j, k] for j in range(n)),
                     sum(ApT[j, l] * AT[k, j] for j in range(n)),
                     sum(Ap[j, l] * AT[k, j] for j in range(n)),
                     sum(Ap[j, l] * A[k, j] for j in range(n)),
                     sum(A[k, j] * Ap[j, l] for j in range(n)),
                     AAp[k, l],
                     A1Ap[k, l],
                     pw[1 + p][k, l],
                     pw[p + 1][k, l]]
                for a, b in zip(L, L[1:]):
                    eq(a, b, f"{what}: 帰納法の段 p={p}, (k,l)=({k},{l})")
        # 成分が実: product_of_real_entry_matrices_has_real_entries を当てる形を、実数の組で組んだ積の虚部 0 で
        for k in range(n):
            for l in range(n):
                z = iota(0, R)
                for j in range(n):
                    z = cc_add(z, cc_mul(iota(Ap[k, j], R), iota(A[j, l], R)))
                eq(z, iota(pw[p + 1][k, l], R), f"{what}: (A^pA)_kl は実数の組で虚部 0")
        # 主張を Sage の冪と転置で
        eq((A**(p + 1)).transpose(), A**(p + 1), f"{what}: 主張（組み込み）p={p+1}")


for n in range(1, 4):
    check_chains(symmetric_generic(n), 3 if n < 3 else 2, f"不定元 n={n}")
for n in range(1, 6):
    B = random_matrix(QQ, n, n, num_bound=5, den_bound=3)
    check_chains(B + B.transpose(), 5, f"QQ n={n}")

# 否定コントロール: 対称でない A = [[1,1],[0,1]] では A^2 = [[1,2],[0,1]] が対称でない（仮定 A^⊤ = A が効いている）。
N = matrix(QQ, [[1, 1], [0, 1]])
assert body_transpose(power_by_def_exp(N, 2)) != power_by_def_exp(N, 2)
# 否定コントロール: 対称な A と B の積は一般に対称でない（冪であること、すなわち同じ A を掛けることが効いている）。
S1 = matrix(QQ, [[1, 0], [0, 2]]); S2 = matrix(QQ, [[0, 1], [1, 0]])
assert body_transpose(body_product(S1, S2)) != body_product(S1, S2)
print(f"  {steps} 段（不定元の n = 1..3、QQ の対称行列 n = 1..5。厳密計算）")
print("  否定コントロール 2 件: 対称でない A の冪、異なる対称行列の積は対称でない")
print("RESULT: PASS")

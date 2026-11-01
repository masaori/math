# 対象ラベル: end_preserves_matrix_exponential
# 中間目標「冪の保存」と「部分和の書き換え」の鎖を確かめる。
#   基底: end(A^0) = end(I) = id_F = end(A)^0
#   帰納の段: end(A^{n+1}) = end(A^n A) = end(A^n)∘end(A) = end(A)^n∘end(A) = end(A)^{n+1}
#   部分和: S_N•f = (end S_N)(f) = (end(Σ_n A^n/n!))(f) = (Σ_n end(A^n)/n!)(f) = (Σ_n end(A)^n/n!)(f)
#           = Σ_n (end(A)^n)(f)/n!
# end は _shared/end_by_definition.sage が定義の文言どおりに作る（end の値が行列と数ベクトルの積に等しいという主張は使わない）。
# 線型写像の等号は、不定元の数ベクトル f での値の等号として確かめる（f の成分が独立な不定元なので、
# 値の等号はすべての f での等号を意味する）。B•f は本文 mat_mult の積で、Sage の B*f と和の式の両方で作る。
# 行列の冪は本文 def_exp (1) の A^{n+1} := A^n A、線型写像の冪は主張の約束 end(A)^{n+1} := end(A)^n∘end(A) で作る。
# 帰属: M = 1, 2 は A・f の成分を QQ(i) 上の多項式環の独立な不定元に、M = 3 は A を QQ(i) の具体の行列、
# f を不定元にする。全て厳密。
load("../../_shared/one_by_one_matrix.sage")
load("../../_shared/end_by_definition.sage")


def bullet(B, g):
    """本文 mat_mult の積 (B•g)_k := Σ_l B_kl g_l を和の式で作る。"""
    n = B.nrows()
    return vector(g.base_ring(), [sum(B[k, l] * g[l] for l in range(n)) for k in range(n)])


def end_power_value(E, A, n, g):
    """主張の約束 end(A)^0 := id、end(A)^{n+1} := end(A)^n ∘ end(A) による (end(A)^n)(g)。"""
    if n == 0:
        return g
    return end_power_value(E, A, n - 1, E.apply(A, g))


cases = []
for M, symbolic_A, nmax in [(1, True, 6), (2, True, 4), (3, False, 3)]:
    n = 2^M
    if symbolic_A:
        R = PolynomialRing(GAUSSIAN, [f"a{p}_{q}" for p in range(1, n + 1) for q in range(1, n + 1)] + [f"x{p}" for p in range(1, n + 1)])
        A = matrix(R, n, n, R.gens()[:n * n])
        f = vector(R, R.gens()[n * n:])
    else:
        R = PolynomialRing(GAUSSIAN, [f"x{p}" for p in range(1, n + 1)])
        ii_ = GAUSSIAN.gen()
        A = matrix(R, n, n, lambda p, q: GAUSSIAN((p + 1) * (q + 2) % 5 - 2) + ii_ * ((p + 2 * q) % 3 - 1) / 2)
        f = vector(R, R.gens())
    cases.append((M, A, f, nmax))
    E = EndByDefinition(M)
    I_n = identity_matrix(R, n)
    # 基底
    A0 = matrix_power_by_definition(A, 0)
    assert A0 == I_n
    assert E.apply(A0, f) == E.apply(I_n, f) == f == end_power_value(E, A, 0, f), M
    # 帰納の段（n = 0..nmax-1）
    for p in range(nmax):
        Ap = matrix_power_by_definition(A, p)
        line1 = E.apply(matrix_power_by_definition(A, p + 1), f)
        line2 = E.apply(Ap * A, f)
        line3 = E.apply(Ap, E.apply(A, f))                 # (end(A^p) ∘ end(A))(f)
        line4 = end_power_value(E, A, p, E.apply(A, f))    # (end(A)^p ∘ end(A))(f)
        line5 = end_power_value(E, A, p + 1, f)
        assert line1 == line2 == line3 == line4 == line5, (M, p)
    # 部分和の書き換え（N = 0..nmax）
    for N in range(nmax + 1):
        SN = matrix_partial_sum(A, N)
        line1 = bullet(SN, f)
        assert line1 == SN * f
        line2 = E.apply(SN, f)
        line3 = E.apply(sum(QQ(1) / factorial(p) * matrix_power_by_definition(A, p) for p in range(N + 1)), f)
        line4 = sum(QQ(1) / factorial(p) * E.apply(matrix_power_by_definition(A, p), f) for p in range(N + 1))
        line5 = sum(QQ(1) / factorial(p) * end_power_value(E, A, p, f) for p in range(N + 1))
        assert line1 == line2 == line3 == line4 == line5, (M, N)
    print(f"M = {M}: 冪の保存の基底と帰納の段（n ≤ {nmax}）、部分和の書き換えの 6 行（N ≤ {nmax}）が厳密に成り立つ")

# 対照: end(A^n) を end(A^⊤)^n に替えると M = 1 の不定元で一致しない（検算が A の向きを見分けること）
M, A, f, _ = cases[0]
E = EndByDefinition(M)
assert E.apply(matrix_power_by_definition(A, 2), f) != end_power_value(E, A.transpose(), 2, f)
print("対照: end(A^2)(f) は end(A^⊤)^2(f) と一致しない")
print("RESULT: PASS")

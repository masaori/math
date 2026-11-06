# 対象ラベル: real_matrix_of_real_entry_matrix_preserves_power
# q = 0 の 4 行の鎖 I_st = δ_st = {1_ℂ, 0_ℂ} = {(1)_ℂ, (0)_ℂ} = ((I_{Mat(n,ℝ)})_st)_ℂ と
# (((A^0)_ℝ)_st)_ℂ = (A^0)_st = I_st = ((I_{Mat(n,ℝ)})_st)_ℂ = (((A_ℝ)^0)_st)_ℂ、
# q + 1 の 4 行の鎖 (A^{q+1})_ℝ = (A^qA)_ℝ = (A^q)_ℝA_ℝ = (A_ℝ)^qA_ℝ = (A_ℝ)^{q+1} を、
# 冪を def_exp (1) の漸化式（X^0 := I、X^{m+1} := X^mX）で組んで厳密に確かめる。帰属: ℂ は QQbar、ℝ は AA。
def iota(r):
    return QQbar(r)


def varrho(B):
    assert all(z.imag() == 0 for z in B.list())                    # def_matrix_with_real_entries
    return matrix(AA, B.nrows(), B.ncols(), lambda p, q: AA(B[p, q].real()))


def power(X, q, ring):
    """def_exp (1): X^0 := I、X^{m+1} := X^mX。"""
    P = identity_matrix(ring, X.nrows())
    for _ in range(q):
        P = P * X
    return P


set_random_seed(20261106)
cands = [QQ(-2), QQ(-1)/3, QQ(0), QQ(1), QQ(3)/2, AA(2).sqrt()]
count = 0
for trial in range(12):
    n = randint(1, 4)
    A = matrix(AA, n, n, lambda s, t: cands[randint(0, len(cands) - 1)]).apply_map(iota)
    AR = varrho(A)
    # q = 0
    I_C = identity_matrix(QQbar, n); I_R = identity_matrix(AA, n)  # def_identity_matrix・def_real_identity_matrix
    for s in range(n):
        for t in range(n):
            delta = QQbar(1) if s == t else QQbar(0)                   # def_kronecker_delta
            assert I_C[s, t] == delta == (iota(1) if s == t else iota(0)) == iota(I_R[s, t])
            assert iota(varrho(power(A, 0, QQbar))[s, t]) == power(A, 0, QQbar)[s, t] == I_C[s, t] \
                == iota(I_R[s, t]) == iota(power(AR, 0, AA)[s, t])
    assert varrho(power(A, 0, QQbar)) == power(AR, 0, AA)
    # q + 1（q = 0..5）
    for q in range(6):
        Aq = power(A, q, QQbar)
        lhs = varrho(power(A, q + 1, QQbar))
        l2 = varrho(Aq * A)
        l3 = varrho(Aq) * AR
        l4 = power(AR, q, AA) * AR
        l5 = power(AR, q + 1, AA)
        assert varrho(Aq) == power(AR, q, AA)                          # 帰納法の仮定
        assert lhs == l2 == l3 == l4 == l5, (trial, q)
        count += 1
# 否定コントロール: 冪の漸化式を X^{m+1} := X^mX ではなく X^{m+1} := X^m + X にすると鎖の 1→2 行が外れる
A = matrix(QQbar, 2, 2, [1, 1, 0, 1])
assert power(A, 2, QQbar) != power(A, 1, QQbar) + A
print(f"{count} 組の (A, q) で q + 1 の 4 行の鎖を、12 個の A で q = 0 の鎖を確かめた。否定コントロール 1 件")
print("RESULT: PASS")

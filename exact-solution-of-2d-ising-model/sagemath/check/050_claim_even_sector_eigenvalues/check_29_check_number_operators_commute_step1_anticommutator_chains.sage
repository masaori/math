# 対象ラベル: check_number_operators_commute
# Step 1 の 4 式（μ ≠ ν）の各行と、続く 2 行の鎖 XW + WX = [X, W]_+ = O、
# matrix_equals_negation_if_sum_is_zero（主張の X → XW、主張の Y → WX）による XW = -(WX) を一行ずつ確かめる（M = 2, 3, 4、μ ≠ ν の全組）。
#   D_μ := ψ̌_μ^†、P_μ := ψ̌_{M+1-μ}（check_23・check_28 と同じ Jordan–Wigner の模型。D_μ := c_μ^T、P_μ := c_μ）。
#   第 1 式: [D_μ, D_ν]_+ = O
#   第 2 式: [D_μ, P_ν]_+ = δ_{M+1-ν, M+1-μ} I = 0_C I = O
#   第 3 式: [P_μ, D_ν]_+ = P_μD_ν + D_νP_μ = D_νP_μ + P_μD_ν = [D_ν, P_μ]_+ = δ_{M+1-μ, M+1-ν} I = δ_{M+1-ν, M+1-μ} I = 0_C I = O
#   第 4 式: [P_μ, P_ν]_+ = O
# δ は添字から def_kronecker_delta で計算する（直前の δ の計算 δ_{M+1-ν, M+1-μ} = δ_{μ,ν} = 0 も確かめる）。
# 否定コントロール: 不定元の成分の行列では、反交換関係を引く行（仮定の行）と XW = -(WX) だけが外れることを確かめる。
# 反交換子の定義・和の交換・δ の対称性・0_C I = O の行は、反交換関係を使わずに成り立つ比較である。
# 帰属: 成分は QQ と、QQ 上の多項式環（厳密計算）。

def kron(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


def anticomm(X, W):
    # def_matrix_anticommutator
    return X * W + W * X


def neg(A):
    # def_matrix_negation（成分ごとの符号反転）
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda r, c: -A[r, c])


def kronecker_delta(i, j):
    # def_kronecker_delta
    return 1 if i == j else 0


# 各行は (名前, 値, 仮定の行か)。仮定の行 = その行への等号が反交換関係（anticommutator_of_check_psi）を引く行。
def chain_first(D_mu, D_nu, Id):
    return [("[D_mu,D_nu]_+", anticomm(D_mu, D_nu), False), ("O", 0 * Id, True)]


def chain_second(D_mu, P_nu, Id, M, mu, nu):
    d = kronecker_delta(M + 1 - nu, M + 1 - mu)
    return [
        ("[D_mu,P_nu]_+", anticomm(D_mu, P_nu), False),
        ("delta I", d * Id, True),                       # 第 2 式（ν → M+1-ν）
        ("0_C I", 0 * Id, False),                        # 直前の δ の計算（δ = 0 を代入。d == 0 を別に確かめる）
        ("O", Id.parent().zero(), False),                # zero_scalar_multiple_is_zero_matrix
    ]


def chain_third(P_mu, D_nu, Id, M, mu, nu):
    d1 = kronecker_delta(M + 1 - mu, M + 1 - nu)
    d2 = kronecker_delta(M + 1 - nu, M + 1 - mu)
    return [
        ("[P_mu,D_nu]_+", anticomm(P_mu, D_nu), False),
        ("P_mu D_nu + D_nu P_mu", P_mu * D_nu + D_nu * P_mu, False),   # def_matrix_anticommutator
        ("D_nu P_mu + P_mu D_nu", D_nu * P_mu + P_mu * D_nu, False),   # matrix_sum_is_commutative
        ("[D_nu,P_mu]_+", anticomm(D_nu, P_mu), False),                # def_matrix_anticommutator を右辺から左辺へ
        ("delta1 I", d1 * Id, True),                                   # 第 2 式（μ → ν, ν → M+1-μ）
        ("delta2 I", d2 * Id, False),                                  # def_kronecker_delta の対称性
        ("0_C I", 0 * Id, False),                                      # 直前の δ の計算
        ("O", Id.parent().zero(), False),                              # zero_scalar_multiple_is_zero_matrix
    ]


def chain_fourth(P_mu, P_nu, Id):
    return [("[P_mu,P_nu]_+", anticomm(P_mu, P_nu), False), ("O", 0 * Id, True)]


def chain_conclusion(X, W, Id):
    return [
        ("XW+WX", X * W + W * X, False),
        ("[X,W]_+", anticomm(X, W), False),       # def_matrix_anticommutator を右辺から左辺へ
        ("O", 0 * Id, True),                      # 上の 4 式のうち [X, W]_+ を左辺に持つ式
    ]


count = 0


def check_chain(lines, label):
    global count
    for (a, A, _), (b, B, hyp) in zip(lines, lines[1:]):
        assert A == B, (label, a, b)
        count += 1


sz = matrix(QQ, [[1, 0], [0, -1]])
lower = matrix(QQ, [[0, 1], [0, 0]])
id2 = identity_matrix(QQ, 2)
pairs = 0
for M in range(2, 5):
    Id = kron([id2] * M)
    c = [kron([sz] * (k - 1) + [lower] + [id2] * (M - k)) for k in range(1, M + 1)]
    D = [ck.transpose() for ck in c]
    P = c
    for mu in range(1, M + 1):
        for nu in range(1, M + 1):
            if mu == nu:
                continue
            pairs += 1
            # 直前の δ の計算: δ_{M+1-ν, M+1-μ} = δ_{μ,ν}（1 行目）と δ_{μ,ν} = 0（2 行目）
            assert kronecker_delta(M + 1 - nu, M + 1 - mu) == kronecker_delta(mu, nu)
            assert kronecker_delta(mu, nu) == 0
            count += 2
            Dm, Dn, Pm, Pn = D[mu - 1], D[nu - 1], P[mu - 1], P[nu - 1]
            check_chain(chain_first(Dm, Dn, Id), ("first", M, mu, nu))
            check_chain(chain_second(Dm, Pn, Id, M, mu, nu), ("second", M, mu, nu))
            check_chain(chain_third(Pm, Dn, Id, M, mu, nu), ("third", M, mu, nu))
            check_chain(chain_fourth(Pm, Pn, Id), ("fourth", M, mu, nu))
            for X in (Dm, Pm):
                for W in (Dn, Pn):
                    check_chain(chain_conclusion(X, W, Id), ("conclusion", M, mu, nu))
                    # matrix_equals_negation_if_sum_is_zero（主張の X → XW、主張の Y → WX）
                    assert X * W == neg(W * X), ("XW = -(WX)", M, mu, nu)
                    count += 1

# 否定コントロール: 不定元の成分の 2×2 行列（反交換関係を満たさない）。δ は μ ≠ ν の値 0 で組む。
R = PolynomialRing(QQ, ["x%d" % k for k in range(8)])
xs = R.gens()
X = matrix(R, 2, 2, xs[0:4])
W = matrix(R, 2, 2, xs[4:8])
IdR = identity_matrix(R, 2)
neg_count = 0
for lines in [chain_first(X, W, IdR), chain_second(X, W, IdR, 2, 1, 2), chain_third(X, W, IdR, 2, 1, 2),
              chain_fourth(X, W, IdR), chain_conclusion(X, W, IdR)]:
    for (a, A, _), (b, B, hyp) in zip(lines, lines[1:]):
        if hyp:
            assert A != B, ("反交換関係を引く行が仮定なしで成り立ってしまう", a, b)
            neg_count += 1
        else:
            assert A == B, ("反交換関係を使わない行が外れた", a, b)
assert X * W != neg(W * X), "XW = -(WX) が仮定なしで成り立ってしまう"
neg_count += 1

print("PASS check_number_operators_commute Step 1: (M, μ, ν) %d 組、厳密等号 %d 個、否定コントロール %d 行" % (pairs, count, neg_count))

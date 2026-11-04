# 対象ラベル: check_joint_eigenspace_decomposition
# check_joint_eigenspace_decomposition の証明の冒頭で、定義の因子 ε_μň_μ + (1−ε_μ)(I−ň_μ) が R_μ^{(ε_μ)} に等しいことの
# 二場合の 10 行の鎖と、それを各因子へ同時に適用する Q̌_ε = ∏(定義の因子) = ∏R_μ^{(ε_μ)} の 2 行の鎖を、括弧どおりに一行ずつ
# 厳密に確かめる（全ての μ と全ての ε ∈ {0,1}^{M_col}）。
#   R^{(1)} := ň、R^{(0)} := I − ň。ň_μ は _number_operators.sage から取る（既定は Jordan–Wigner の模型、check_with_check_psi.sage からは本文の ψ̌）。
#   有限積は def_finite_product_of_matrices の左から掛ける積。
# 二場合の鎖は ň の性質を使わないので、不定元の成分の 2×2 行列でも全ての行が等号で成り立つことも確かめる。
# 否定コントロール: 場合の仮定を取り違える（ε_μ = 1 の鎖の先頭に ε_μ = 0 の因子を置く等）と、場合の仮定の行が等号を外れる。
# 帰属: 成分は QQ か本文の ψ̌ の数体 F と、その上の多項式環（否定コントロールは QQ 上）（厳密計算）。スカラーの差・−1 倍・単位元の行は QQ[i] の元で行ごとに確かめる（scalar_chains）。
# 行列の行のうち、スカラーの行と「R の定義」「場合の仮定」の行は、行列としては同じ式を二度作って比べているだけで、行列の検算としては確かめていない。
load("_number_operators.sage")

def sub(A, B):
    # def_matrix_difference
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda r, c: A[r, c] - B[r, c])


def smul(a, A):
    # def_matrix_scalar_multiple
    return matrix(A.base_ring(), A.nrows(), A.ncols(), lambda r, c: a * A[r, c])


def def_factor(e, n, Id):
    # 主張の定義の因子 ε_μň_μ + (1−ε_μ)(I−ň_μ)
    return smul(e, n) + smul(1 - e, sub(Id, n))


def case_one_chain(n, Id):
    O = 0 * Id
    one, zero = CC_one, CC_zero
    return [
        ("eps n+(1-eps)(I-n)", None),                     # 先頭（場合の仮定で置き換える式）
        ("1n+(1-1)(I-n)", smul(one, n) + smul(one - one, sub(Id, n))),   # 場合の仮定 ε_μ = 1
        ("1n+(1+(-1))(I-n)", smul(one, n) + smul(one + (-one), sub(Id, n))),          # def_complex_difference
        ("1n+(1+(-1)1)(I-n)", smul(one, n) + smul(one + (-one) * one, sub(Id, n))),   # multiply_by_minus_one
        ("1n+(1+(-1))(I-n)", smul(one, n) + smul(one + (-one), sub(Id, n))),          # 乗法の単位元
        ("1n+0(I-n)", smul(one, n) + smul(zero, sub(Id, n))),           # complex_numbers_form_a_field の加法の逆元
        ("n+0(I-n)", n + smul(zero, sub(Id, n))),                       # scalar_multiple_by_one
        ("n+O", n + O),                                                 # zero_scalar_multiple_is_zero_matrix
        ("n", n),                                                       # matrix_plus_zero_matrix
        ("R^{(1)}", n),                                                 # R^{(1)} の定義
    ]


def case_zero_chain(n, Id):
    O = 0 * Id
    one, zero = CC_one, CC_zero
    return [
        ("eps n+(1-eps)(I-n)", None),
        ("0n+(1-0)(I-n)", smul(zero, n) + smul(one - zero, sub(Id, n))),  # 場合の仮定 ε_μ = 0
        ("0n+(1+(-0))(I-n)", smul(zero, n) + smul(one + (-zero), sub(Id, n))),        # def_complex_difference
        ("0n+(1+(-1)0)(I-n)", smul(zero, n) + smul(one + (-one) * zero, sub(Id, n))), # multiply_by_minus_one
        ("0n+(1+0)(I-n)", smul(zero, n) + smul(one + zero, sub(Id, n))),              # complex_times_zero_is_zero
        ("0n+1(I-n)", smul(zero, n) + smul(one, sub(Id, n))),            # complex_numbers_form_a_field の加法の単位元
        ("O+1(I-n)", O + smul(one, sub(Id, n))),                         # zero_scalar_multiple_is_zero_matrix
        ("O+(I-n)", O + sub(Id, n)),                                     # scalar_multiple_by_one
        ("I-n", sub(Id, n)),                                             # zero_matrix_plus_matrix
        ("R^{(0)}", sub(Id, n)),                                         # R^{(0)} の定義
    ]


def run_case_chain(e, n, Id, label):
    # 先頭を、場合の仮定 ε_μ = e のもとの定義の因子で埋め、隣り合う行の等号を確かめる。末尾の R^{(ε_μ)} は R^{(e)}。
    global count
    lines = (case_one_chain if e == 1 else case_zero_chain)(n, Id)
    lines[0] = (lines[0][0], def_factor(e, n, Id))
    for (a, A), (b, B) in zip(lines, lines[1:]):
        assert A == B, (label, e, a, b)
        count += 1
    R = n if e == 1 else sub(Id, n)
    assert lines[-1][1] == R, (label, e, "R^{(eps)}")
    count += 1


def left_product(factors, Id):
    # def_finite_product_of_matrices（左から掛ける）
    P = factors[0]
    for A in factors[1:]:
        P = P * A
    return P


# スカラーの鎖は、Python の整数ではなく QQ[i]（ℂ の可算な部分体）の元で、行ごとに値を確かめる。
# 行列の行は成分が QQ なので、スカラーは QQ の元へ戻して掛ける（虚部 0 を確かめてから）。
K.<ii> = QuadraticField(-1)
def to_QQ(z):
    assert z.imag() == 0
    return QQ(z.real())
def scalar_chains():
    o, z = K(1), K(0)
    one_case = [o - o, o + (-o), o + (-o) * o, o + (-o), z]
    zero_case = [o - z, o + (-z), o + (-o) * z, o + z, o]
    for chain in (one_case, zero_case):
        for a, b in zip(chain, chain[1:]):
            assert a == b
    return len(one_case) - 1 + len(zero_case) - 1
CC_one, CC_zero = to_QQ(K(1)), to_QQ(K(0))

count = scalar_chains()
words = 0
for (tag, M, F, n) in number_operator_settings():
    Id = identity_matrix(F, 2 ^ M)
    for mu in range(M):
        assert n[mu] * n[mu] == n[mu] and n[mu] != 0 * Id and n[mu] != Id
        for e in (0, 1):
            run_case_chain(e, n[mu], Id, (tag, mu))
    for eps in cartesian_product([[0, 1]] * M):
        eps = list(eps)
        R = [n[mu] if eps[mu] == 1 else sub(Id, n[mu]) for mu in range(M)]
        Q_def = left_product([def_factor(eps[mu], n[mu], Id) for mu in range(M)], Id)   # Q̌_ε の定義（主張）
        Q_R = left_product(R, Id)                                                         # 各因子へ同時に適用
        assert Q_def == Q_R, (tag, eps)
        assert Q_R.trace() == 1                                                           # 参考: (4) の tr(Q̌_ε) = 1 と矛盾しない
        count += 1
        words += 1

# 不定元の成分の 2×2 行列（冪等でない）でも二場合の鎖は全ての行で成り立つ（ň の性質を使わない）
Rg = PolynomialRing(QQ, ["x%d" % k for k in range(4)])
X = matrix(Rg, 2, 2, Rg.gens())
IdR = identity_matrix(Rg, 2)
assert X * X != X
for e in (0, 1):
    run_case_chain(e, X, IdR, ("generic",))

# 否定コントロール: 場合の仮定を取り違えると、場合の仮定の行（1 行目 → 2 行目）が等号を外れる
neg_control = 0
for (e_chain, e_wrong) in ((1, 0), (0, 1)):
    lines = (case_one_chain if e_chain == 1 else case_zero_chain)(X, IdR)
    assert def_factor(e_wrong, X, IdR) != lines[1][1], ("場合の仮定を取り違えても等号が成り立ってしまう", e_chain)
    neg_control += 1

print("PASS check_joint_eigenspace_decomposition 冒頭の定義の因子 = R_μ^{(ε_μ)} の二場合の鎖と Q̌_ε = ∏R の鎖: %d 段（語 %d 個）、否定コントロール %d 件" % (count, words, neg_control))

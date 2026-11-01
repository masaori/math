# 対象ラベル: end_preserves_matrix_exponential
# 主張の式変形（左辺と 5 本の等号）と主張そのものを確かめる。
#   (end(exp A))(f) = (end S)(f) = S•f = (Σ_m A^m/m!)•f = lim_N S_N•f = lim_N Σ_{n≤N} (end(A)^n)(f)/n!
# 帰属: A は QQ(i) を成分とする 2^M 次の行列（M = 1, 2, 3）、f は QQ(i)^{2^M} の数ベクトル。
#   S_N•f と Σ_{n≤N} (end(A)^n)(f)/n! は QQ(i) の中で厳密に作り、各 N で厳密に等しいこと（最後の等号）を確かめる。
#   S = exp(A) は極限で定まり QQ(i) に収まらない（R への脱出）。本文の部分和 S_K（K は既定で max(150, ⌈8c⌉)）を中心に、
#   尾の評価 2c^{K+1}/(K+1)! を半径に付けた ComplexBallField(512) のボールで囲む（c ≥ ‖A‖ の有理数の上界、K+2 ≥ 2c。
#   ‖A^m‖ ≤ ‖A‖^m（matrix_norm_submultiplicativity）と比 1/2 の等比級数による。尾の評価は本文には無く、検算の側で導いた）。
#   第一行・第二行は、S のボールの行列に end（定義の文言どおり、_shared/end_by_definition.sage）と mat_mult の積を
#   それぞれ施し、ボールが成分ごとに重なることで確かめる（end は、end の値が行列と数ベクトルの積に等しいという主張を使わずに作る）。
#   極限の行は、‖S_N•f - S•f‖ を含むボールの下端が尾の評価 2c^{N+1}/(N+1)!·‖f‖ 以下であることで確かめる
#   （‖B•f‖ ≤ ‖B‖‖f‖ は matrix_norm_vector_bound）。S = Σ_m A^m/m! の行は def_exp (1) の書き直しで、計算は無い。
#   主張は、end(exp A)(f) のボールと、Arb の行列の exp（本文の定義とは独立な経路）による exp(A)•f のボールの重なりでも確かめる。
load("../../_shared/one_by_one_matrix.sage")
load("../../_shared/end_by_definition.sage")

PREC = 512
RBF_ = RealBallField(PREC)
CBF_ = ComplexBallField(PREC)
ii = GAUSSIAN.gen()


def to_ball(z):
    return CBF_(RBF_(QQ(z[0])), RBF_(QQ(z[1])))


def norm_upper(entries):
    """√(Σ|a|^2) ≤ Σ(|Re a| + |Im a|) の有理数の上界。"""
    return sum(abs(QQ(a[0])) + abs(QQ(a[1])) for a in entries)


def body_matrix_exp_ball(A, K=None):
    c = norm_upper(A.list())
    if K is None:
        K = max(150, ceil(8 * c))
    assert K + 2 >= 2 * c
    SK = matrix_partial_sum(A, K)
    rad = RBF_(2 * c^(K + 1) / factorial(K + 1)).upper()
    return matrix(CBF_, A.nrows(), A.ncols(), [to_ball(a).add_error(rad) for a in SK.list()])


def bullet(B, g):
    """本文 mat_mult の積 (B•g)_k := Σ_l B_kl g_l。"""
    n = B.nrows()
    return vector(g.base_ring(), [sum(B[k, l] * g[l] for l in range(n)) for k in range(n)])


def overlaps(u, v):
    return all(x.overlaps(y) for x, y in zip(u, v))


cases = [
    (1, matrix(GAUSSIAN, [[1, 2 - ii], [-3, ii / 2]]), vector(GAUSSIAN, [1, -ii])),
    (2, matrix(GAUSSIAN, 4, 4, lambda p, q: GAUSSIAN((p * q + p + 1) % 4 - 1) / 2 + ii * ((p + q) % 3 - 1) / 3),
     vector(GAUSSIAN, [1, 0, ii, -2])),
    (3, matrix(GAUSSIAN, 8, 8, lambda p, q: GAUSSIAN((3 * p + q) % 5 - 2) / 16 + ii * ((p * q) % 3 - 1) / 20),
     vector(GAUSSIAN, [1, -1, 0, ii, 2, 0, -ii, 1])),
]
for M, A, f in cases:
    n = 2^M
    E = EndByDefinition(M)
    S = body_matrix_exp_ball(A)
    fb = vector(CBF_, [to_ball(x) for x in f])
    line1 = E.apply(S, fb)             # (end(exp A))(f)。S は exp(A) を含むボールの行列
    line2 = line1                      # (end S)(f)。S := exp(A) は同じ行列
    line3 = bullet(S, fb)              # S•f
    assert overlaps(line1, line3), M
    # 極限の等号・最後の等号
    c = norm_upper(A.list())
    nf = norm_upper(f.list())
    g = f
    end_partial = f * 0
    checked = 0
    Nmax = 120
    checkpoints = {5, 20, 60, 120}
    for N in range(Nmax + 1):
        # end_partial = Σ_{n≤N} (end(A)^n)(f)/n!。end(A)^n(f) は end(A) を n 回かける（主張の約束）
        if N > 0:
            g = E.apply(A, g)
        end_partial = end_partial + QQ(1) / factorial(N) * g
        if N in checkpoints:
            SNf = bullet(matrix_partial_sum(A, N), f)
            assert SNf == end_partial, (M, N)                        # 最後の等号: 二つの列は各 N で等しい（厳密）
            diff = vector(CBF_, [to_ball(x) for x in SNf]) - line3
            dist = sum((d.real()^2 + d.imag()^2) for d in diff).sqrtpos()
            if N + 2 < 2 * c:
                continue
            # dist は真の距離 ‖S_N•f - exp(A)•f‖ を含むボール（Arb のボール演算）。真の距離が尾の評価を超えるなら、
            # 半径が十分小さいボールの下端も尾の評価を超えるので、この判定で見つかる。
            tail_N = RBF_(2 * c^(N + 1) / factorial(N + 1)) * nf
            assert dist.lower() <= tail_N.upper(), (M, N)
            assert dist.rad() < 2^(-300), (M, N)
            checked += 1
    assert checked >= 2, (M, checked)
    # 主張: end(exp A)(f) のボールが、十分大きい N の部分和 Σ (end(A)^n)(f)/n! を中心にした尾の評価の範囲と重なる
    tail = RBF_(2 * c^(Nmax + 1) / factorial(Nmax + 1)) * nf
    approx = vector(CBF_, [to_ball(x).add_error(tail.upper()) for x in end_partial])
    assert overlaps(line1, approx), M
    # 対照（Arb の行列の exp。本文の定義とは独立な経路）
    arb_exp = A.change_ring(CBF_).exp()
    assert overlaps(line1, arb_exp * fb), M
    assert max(max(x.real().rad(), x.imag().rad()) for x in line1) < 2^(-150)
    print(f"M = {M}: 第一・第二の等号のボールの重なり、極限の等号の尾の評価、最後の等号の厳密な等号（N = 5, 20, 60, 120）、主張が成り立つ")

# 対照: A を転置した行列の exp を使うと、M = 2 の例で end(exp A)(f) と重ならない
M, A, f = cases[1]
fb = vector(CBF_, [to_ball(x) for x in f])
lhs = EndByDefinition(M).apply(body_matrix_exp_ball(A), fb)
assert not overlaps(lhs, body_matrix_exp_ball(A.transpose()) * fb)
print("対照: end(exp A)(f) は exp(A^⊤)•f と重ならない")
print("RESULT: PASS")

# 対象ラベル: exp_of_diagonal_matrix
# 中間目標「極限」の行と主張そのものを確かめる。
#   k ≠ l: |(S_N)_kl - 0| = |0 - 0| = |0| = 0（厳密）
#   k = l: |(S_N)_kk - exp(d_k)| = |Σ_{p≤N} d_k^p/p! - exp(d_k)| → 0
#   主張: exp(D)_kl = exp(d_k)（k = l）、0（k ≠ l）
# 帰属: D は QQ(i) を成分とする対角行列（n = 1..4）。部分和は QQ(i) の中で厳密に作る。exp(D) と exp(d_k) は極限で、
# QQ(i) に収まらない（R への脱出）。どちらも本文の定義の部分和を中心に、尾の評価を半径に付けた複素数のボールで囲む。
#   行列の exp(D): 中心は本文の部分和 S_M（冪は D^{p+1} := D^p D を右から掛けて作り、行列の成分を全部持つ。
#     対角であることを使わない）。各成分の誤差は |(exp D - S_M)_kl| ≤ ‖exp D - S_M‖ ≤ Σ_{m>M} ‖D‖^m/m!
#     ≤ 2 c^{M+1}/(M+1)!（c ≥ ‖D‖ の有理数の上界、M+2 ≥ 2c。劣乗法性 matrix_norm_submultiplicativity と比 1/2 の等比級数。
#     尾の評価は本文には無く、検算の側で導いたもの）。
#   数の exp(d_k): 本文 def_scalar_exp の 1 行 1 列の行列の部分和の成分を中心に、同じ形の尾の評価を半径にする。
# 二つのボールは別の経路（n 行 n 列の行列の冪と、1 行 1 列の行列の冪）から作る。Arb の exp は対照にだけ使う。
load("../../_shared/one_by_one_matrix.sage")

PREC = 512
RBF_ = RealBallField(PREC)
CBF_ = ComplexBallField(PREC)
ii = GAUSSIAN.gen()


def to_ball(z):
    return CBF_(RBF_(QQ(z[0])), RBF_(QQ(z[1])))


def norm_upper(A):
    """‖A‖ = √(Σ|a_kl|^2) ≤ Σ(|Re a_kl| + |Im a_kl|) の有理数の上界。"""
    return sum(abs(QQ(a[0])) + abs(QQ(a[1])) for a in A.list())


def body_matrix_exp_balls(A, N=None):
    c = norm_upper(A)
    if N is None:
        N = max(150, ceil(8 * c))
    assert N + 2 >= 2 * c
    S = matrix_partial_sum(A, N)
    rad = RBF_(2 * c^(N + 1) / factorial(N + 1)).upper()
    return [[to_ball(entry(S, k, l)).add_error(rad) for l in range(1, A.ncols() + 1)] for k in range(1, A.nrows() + 1)]


def body_scalar_exp_ball(z):
    return body_matrix_exp_balls(one_by_one(GAUSSIAN, GAUSSIAN(z)))[0][0]


def abs_aa(z):
    return AA(QQ(z[0])^2 + QQ(z[1])^2).sqrt()


diagonals = [
    [GAUSSIAN(0)],
    [3 - 2 * ii],
    [GAUSSIAN(1), -ii],
    [GAUSSIAN(-5), 2 * ii, GAUSSIAN(1) / 3 + ii / 7],
    [GAUSSIAN(10), -10 + ii, ii / 2, GAUSSIAN(0)],
]
for dg in diagonals:
    n = len(dg)
    Dm = diagonal_matrix(GAUSSIAN, dg)
    expD = body_matrix_exp_balls(Dm)
    for k in range(1, n + 1):
        dk = dg[k - 1]
        expdk = body_scalar_exp_ball(dk)
        prev = None
        for N in [5, 20, 60, 120]:
            SN = matrix_partial_sum(Dm, N)
            # k ≠ l の鎖（厳密）
            for l in range(1, n + 1):
                if l != k:
                    assert abs_aa(entry(SN, k, l) - 0) == abs_aa(GAUSSIAN(0) - 0) == abs_aa(GAUSSIAN(0)) == 0
            # k = l の鎖: 第一行と第二行は同じ数（厳密）、|… - exp(d_k)| は N に依る上界の下にある
            s = sum(scalar_power_by_definition(dk, p) / factorial(p) for p in range(N + 1))
            assert entry(SN, k, k) == s
            diff = to_ball(s) - expdk
            dist = (diff.real()^2 + diff.imag()^2).sqrtpos()
            tailN = RBF_(2 * norm_upper(one_by_one(GAUSSIAN, dk))^(N + 1) / factorial(N + 1)) if N + 2 >= 2 * norm_upper(one_by_one(GAUSSIAN, dk)) else None
            if tailN is None:
                continue
            bnd = (tailN + 3 * RBF_(max(expdk.real().rad(), expdk.imag().rad())) + RBF_(2)^(-400)).upper()
            assert dist.upper() <= bnd, (dg, k, N)
            if prev is not None:
                assert bnd <= prev
            prev = bnd
        assert prev is not None and prev < 2^(-100)
        # 主張: exp(D)_kk と exp(d_k) のボールが重なり、exp(D)_kl（k ≠ l）のボールが 0 を含む
        assert expD[k - 1][k - 1].overlaps(expdk), (dg, k)
        for l in range(1, n + 1):
            if l != k:
                assert expD[k - 1][l - 1].contains_zero()
        # 半径が十分小さい（重なりが意味を持つ）
        assert expD[k - 1][k - 1].rad() < 2^(-150) * (1 + abs(expD[k - 1][k - 1].mid()))
        # 対照（Arb の exp。本文の定義とは独立な経路）
        assert expdk.overlaps(to_ball(dk).exp())
print(f"{len(diagonals)} 個の対角行列（n = 1..4、成分は QQ(i)）で、k ≠ l の鎖（厳密）、k = l の部分和の一致（厳密）と")
print("exp(d_k) への収束の上界、主張 exp(D)_kk = exp(d_k)・exp(D)_kl = 0 のボールの重なりを確かめた")

# 対照: 対角でない N = [[1,1],[0,1]] では exp(N)_12 = e ≠ 0、exp(N)_11 = e なので非対角成分のボールが 0 を含まない
Nm = matrix(GAUSSIAN, [[1, 1], [0, 1]])
expN = body_matrix_exp_balls(Nm)
assert not expN[0][1].contains_zero()
print("対照: [[1,1],[0,1]] の exp の (1,2) 成分は 0 を含まないボール %s" % expN[0][1])
print("RESULT: PASS")

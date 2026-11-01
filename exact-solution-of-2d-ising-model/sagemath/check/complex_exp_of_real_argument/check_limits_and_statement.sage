# 対象ラベル: complex_exp_of_real_argument
# 二つの収束の鎖と、極限の一意性の帰結（主張そのもの）を確かめる。
#   ‖[(E_N)_C]_C - [(exp x)_C]_C‖ = ‖[(E_N)_C - (exp x)_C]_C‖ = |(E_N)_C - (exp x)_C| = |(E_N - exp x)_C|
#                                  = |E_N - exp x| = |Σ x^m/m! - exp x| → 0
#   ‖[(E_N)_C]_C - [exp(x_C)]_C‖ = ‖[(E_N)_C - exp(x_C)]_C‖ = |(E_N)_C - exp(x_C)| = |Σ (x_C)^m/m! - exp(x_C)| → 0
#   exp(x_C) = ([exp(x_C)]_C)_11 = ([(exp x)_C]_C)_11 = (exp x)_C
# 帰属: 部分和は QQ と QQ(i) の中で厳密に作る。exp(x)・exp(x_C) は極限なので QQ・QQ(i) に収まらない（R への脱出）。
# 本文の exp（1 行 1 列の行列の部分和の成分）を、尾の評価 2|x|^{N+1}/(N+1)! を半径に付けたボールで囲む。
# 実数の exp は共通の準備の body_real_exp_ball、複素数の exp は下の body_complex_exp_ball。Arb の exp は使わない。
load("../../_shared/one_by_one_matrix.sage")
load("../../_shared/complex_as_real_pairs.sage")

PREC = 512
RBF_ = RealBallField(PREC)
CBF_ = ComplexBallField(PREC)


def body_complex_exp_ball(z0, N=None):
    """本文の複素数の exp(z) := (exp([z]_C))_11（z ∈ QQ(i)）を含む複素数のボール。
    中心は S_N([z]_C) の成分（QQ(i) の中で厳密）、半径は 2|z|^{N+1}/(N+1)!（|z| の上界を使う）。
    根拠は body_real_exp_ball と同じ比 1/2 の等比級数との比較（|z|/(N+2) ≤ 1/2。検算の側で導いたもの）。"""
    z0 = GAUSSIAN(z0)
    absz_up = RBF_(AA(z0[0]^2 + z0[1]^2).sqrt()).upper()
    if N is None:
        N = max(150, ceil(8 * absz_up))
    assert N + 2 >= 2 * absz_up
    c = entry11(matrix_partial_sum(one_by_one(GAUSSIAN, z0), N))
    radius = RBF_(2) * RBF_(absz_up)^(N + 1) / factorial(N + 1)
    return CBF_(RBF_(QQ(c[0])), RBF_(QQ(c[1]))).add_error(radius.upper()), c, N


def E_N(x0, N):
    return sum(scalar_power_by_definition(QQ(x0), m) / factorial(m) for m in range(N + 1))


def ball_abs(re, im):
    """abs_basic_properties (1) の |(p,q)| = √(p^2+q^2) を、実数のボールの対について。"""
    # 根号の中のボールが丸めで負の側へ出ても、本文の値は非負なので sqrtpos（負の部分を 0 とみなす平方根）を使う。
    return (re^2 + im^2).sqrtpos()


points = [QQ(0), QQ(1) / 10^6, QQ(1) / 3, QQ(-1), QQ(5), QQ(-37) / 2, QQ(37)]
for x0 in points:
    expx = body_real_exp_ball(x0)
    expxC, centerC, Nc = body_complex_exp_ball(x0)
    # 二つの exp の部分和が同じ数であること（厳密）: S_N([x_C]_C) の成分 = ι(S_N([x]_R) の成分)。
    centerR = entry11(matrix_partial_sum(one_by_one(QQ, x0), Nc))
    assert (QQ(centerC[0]), QQ(centerC[1])) == iota(centerR, QQ)
    prev = None
    for N in [5, 20, 60, 120, 240]:
        if N + 2 < 2 * abs(x0):
            continue
        EN = E_N(x0, N)
        ENC = iota(EN, QQ)
        # 第一の鎖（(exp x)_C を対 (exp x のボール, 0) で持つ）
        d_pair = cc_sub((RBF_(ENC[0]), RBF_(ENC[1])), (expx, RBF_(0)), RBF_)
        line3 = ball_abs(*d_pair)                                  # |(E_N)_C - (exp x)_C|
        line4 = ball_abs(RBF_(EN) - expx, RBF_(0))                 # |(E_N - exp x)_C|
        line5 = (RBF_(EN) - expx).abs()                            # |E_N - exp x|
        assert line3.overlaps(line4) and line4.overlaps(line5)
        # 第二の鎖（exp(x_C) は複素数のボール）
        s = iota(0, QQ)
        for m in range(N + 1):
            s = cc_add(s, cc_mul(iota(QQ(1) / factorial(m), QQ), cc_power(iota(x0, QQ), m, QQ)))
        assert s == ENC                                            # Σ (x_C)^m/m! = (E_N)_C（厳密）
        d2 = CBF_(RBF_(ENC[0]), RBF_(ENC[1])) - expxC
        line2b = ball_abs(d2.real(), d2.imag())
        # → 0 の行: |E_N - exp x| ≤ |E_N - c| + |c - exp x| ≤ (尾の評価(N) + 尾の評価(N_c)) + ρ（c はボールの中心、
        # ρ = 尾の評価(N_c) はボールの半径）。計算したボールの上端はさらに ρ を含むので、上界を 尾の評価(N) + 2ρ とする
        # （複素数のボールは実部と虚部の両方に ρ が付くので 3ρ）。この上界が N とともに減り、2^-100 を下回る。
        # 512 ビットのボールの丸め（中心を QQ からボールへ移す誤差）の分として 2^-400 を足す。
        tail = RBF_(2 * abs(x0)^(N + 1) / factorial(N + 1)) + RBF_(2)^(-400)
        assert line5.upper() <= (tail + 2 * RBF_(expx.rad())).upper() and line2b.upper() <= (tail + 3 * RBF_(expxC.rad())).upper(), (x0, N)
        bound = (tail + 3 * RBF_(expxC.rad())).upper()
        if prev is not None:
            assert bound <= prev
        prev = bound
    assert prev < 2^(-100), x0
    # 主張: exp(x_C) = (exp x)_C。複素数の exp のボールの実部が実数の exp のボールと重なり、虚部が 0 を含む。
    assert expxC.real().overlaps(expx) and expxC.imag().contains_zero(), x0
print(f"{len(points)} 点で、二つの収束の鎖の各行、部分和の一致（厳密）、主張 exp(x_C) = (exp x)_C のボールの重なりを確かめた")

# 対照: 実数でない引数 z = (0,1) では、本文の exp(z) の虚部のボールが 0 を含まない（主張は実数の引数に限る）。
expi, _, _ = body_complex_exp_ball(GAUSSIAN.gen())
assert not expi.imag().contains_zero()
print("対照: exp((0,1)) の虚部は 0 を含まないボール %s" % expi.imag())
print("RESULT: PASS")

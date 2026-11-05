# 対象ラベル: limit_of_log_Z_in_N_row
# 証明の含意の鎖（十行）と、極限の段（log 2 > 0 の準備の三行と、ε と N_0 の三行の鎖）を、本文の Z と c で確かめる。
# 帰属:
# - K_1 := 2 log y、K_2 := log x（x, y ∈ QQ_{>1} なので K_1, K_2 > 0）と置くと、def_partition_function_2d_ising の Z は
#   Σ_s y^{2h(s)} x^{v(s)}（h は同じ行の隣り合う組の積の和、v は隣り合う行の同じ列の組の積の和）で QQ の元になる。
#   小さい格子（M_col·N_row ≤ 12）では全ての配位の和で作り、大きい N_row では tr(W^{N_row})（Z_equals_trace_of_W）で作る。
#   両方を作れる格子では二つが一致することを確かめる。
# - W は rayleigh_bounds_operator_norm の準備の W_exact（QQ の行列）。c = c(M_col) は rayleigh_sup_exact で、特性多項式の
#   最大の実根（AA）として作り、上界であることと到達することを確かめる（最大固有値と上限の一致は本文に無い。値を作る独立な経路）。
# - 一行目（挟み込み）と、Z > 0、c > 0 は QQ・AA の厳密な比較である。
# - log を含む行は QQ・AA に入らないので RealBallField(512) へ脱出する（実対数による ℝ 脱出）。log は Arb の log で、
#   各行の両辺は行ごとに別々に計算する。大小は差のボールの下端の符号、等号は差のボールが 0 を含み半径が 2^-200 未満であることで判定し、
#   許容誤差は置かない（共通の準備 _shared/log_integral_by_balls.sage）。
load("../rayleigh_bounds_operator_norm/_prelude.sage")
load("../../_shared/log_integral_by_balls.sage")
import itertools


def Z_by_configurations(M, N, x, y):
    """def_partition_function_2d_ising の Z(K_1, K_2) を K_1 = 2 log y、K_2 = log x で、N 行 M 列の全ての配位の和として QQ で作る（周期境界）。"""
    total = QQ(0)
    for bits in itertools.product([-1, 1], repeat=M * N):
        s = [[bits[i * M + j] for j in range(M)] for i in range(N)]
        h = sum(s[i][j] * s[i][(j + 1) % M] for i in range(N) for j in range(M))
        v = sum(s[i][j] * s[(i + 1) % N][j] for i in range(N) for j in range(M))
        total += QQ(y)**(2 * h) * QQ(x)**v
    return total


def Z_by_trace(W, N):
    """Z_equals_trace_of_W の tr(W^{N_row})。冪は def_exp (1) の再帰（power_by_def_exp）。"""
    return power_by_def_exp(W, N).trace()


def le(a, b):
    return surely_le(a, b)


def check_chain(M, N, Z, c):
    """含意の鎖の十行を、与えられた M_col、N_row、Z、c で確かめる。各行の (左, 中, 右) をボールで作り、
    (i) 各行の二つの不等号、(ii) 前の行から変わった辺の等号（または一行目から二行目への単調性）を見る。返り値は確かめた比較の数。"""
    k = 0
    cN = power_by_definition_real(c, N)
    tM = power_by_definition_real(QQ(2), M)
    # 一行目（partition_function_sandwich）: QQ・AA の厳密な比較
    assert cN <= Z and Z <= tM * cN
    k += 2
    lc, lZ, l2 = log_ball(c), log_ball(Z), log_ball(QQ(2))
    rows = []
    rows.append((log_ball(cN), lZ, log_ball(tM * cN)))                     # 二行目
    rows.append((N * lc, lZ, log_ball(tM * cN)))                           # 三行目
    rows.append((N * lc, lZ, log_ball(tM) + log_ball(cN)))                 # 四行目
    rows.append((N * lc, lZ, M * l2 + log_ball(cN)))                       # 五行目
    rows.append((N * lc, lZ, M * l2 + N * lc))                             # 六行目
    rows.append(((N * lc) / (M * N), lZ / (M * N), (M * l2 + N * lc) / (M * N)))   # 七行目
    rows.append((lc / M, lZ / (M * N), lc / M + l2 / N))                   # 八行目
    rows.append((RBF512(0), lZ / (M * N) - lc / M, l2 / N))                # 九行目
    rows.append((None, abs(lZ / (M * N) - lc / M), l2 / N))                # 十行目
    for (lo, mid, hi) in rows:
        if lo is not None:
            assert le(lo, mid)
            k += 1
        assert le(mid, hi)
        k += 1
    # 一行目 → 二行目: u ≤ v ⇒ log u ≤ log v。u < v の側は real_log_strictly_increasing（ボールで log u < log v）
    assert (cN < Z) <= surely_lt(log_ball(cN), lZ)
    assert (Z < tM * cN) <= surely_lt(lZ, log_ball(tM * cN))
    # 変わった辺の等号（各行の根拠）
    eqs = [
        (log_ball(cN), N * lc),                                            # 三行目: real_log_of_power（a = c, n = N）
        (log_ball(tM * cN), log_ball(tM) + log_ball(cN)),                  # 四行目: real_log_of_product
        (log_ball(tM), M * l2),                                            # 五行目: real_log_of_power（a = 2, n = M）
        (log_ball(cN), N * lc),                                            # 六行目: real_log_of_power（a = c, n = N）
        ((N * lc) / (M * N), lc / M),                                      # 八行目の左辺（約分）
        ((M * l2 + N * lc) / (M * N), lc / M + l2 / N),                    # 八行目の右辺（約分）
        (lc / M - lc / M, RBF512(0)),                                      # 九行目の左辺
        (lc / M + l2 / N - lc / M, l2 / N),                                # 九行目の右辺
    ]
    for a, b in eqs:
        assert surely_equal(a, b)
        k += 1
    # 十行目: 非負の実数の絶対値はそれ自身
    d = lZ / (M * N) - lc / M
    assert d.lower() >= 0 and surely_equal(abs(d), d)
    k += 1
    return k


def power_by_definition_real(a, n):
    """def_power_of_real_number の冪: a^0 := 1、a^{m+1} := a^m a。"""
    p = a.parent()(1)
    for _ in range(n):
        p = p * a
    return p


def check_limit_step(eps, N0, Ns, a_of, a):
    """極限の段: N_0 ε > log 2 と、N ≥ N_0 での |a_N − a| ≤ (log 2)/N ≤ (log 2)/N_0 < ε。"""
    l2 = log_ball(QQ(2))
    # 準備の鎖: log 2 > log 1 = log(exp 0) = 0（exp は本文の部分和に尾の評価を足したボール。exp(0) = 1 は scalar_exp_zero）
    assert surely_lt(log_ball(QQ(1)), l2)
    assert exp_ball_of_ball(RBF512(0)).contains_exact(1)                    # log 1 = log(exp 0)（scalar_exp_zero）
    assert surely_equal(log_ball(exp_ball_of_ball(RBF512(0))), RBF512(0))  # log(exp 0) = 0
    assert l2.lower() > 0
    assert N0 >= 1 and surely_lt(l2, N0 * eps)
    k = 1
    for N in Ns:
        assert N >= N0
        dN = abs(a_of(N) - a)
        assert le(dN, l2 / N)
        # (log 2)/N ≤ (log 2)/N_0: N = N_0 なら等号、N > N_0 なら（log 2 > 0 なので）狭義
        assert surely_equal(l2 / N, l2 / N0) if N == N0 else surely_lt(l2 / N, l2 / N0)
        assert surely_lt(l2 / N0, RBF512(eps))
        k += 3
    return k


PARAMS = [(2, 2, 2), (2, 3, 2), (2, 2, 3), (2, 3, 3), (3, 2, 2), (3, 3, 2), (3, 2, 3), (3, QQ(3)/2, QQ(5)/4)]
total = 0
direct_agree = 0
for (M, x, y) in PARAMS:
    W = W_exact(M, x, y)
    assert is_real_symmetric(W)
    c = rayleigh_sup_exact(W)
    assert c > 0                                                            # def_rayleigh_sup の c > 0
    NMAX = 60
    Zs = {}
    for N in range(1, NMAX + 1):
        Z = Z_by_trace(W, N)
        if M * N <= 12:
            Zd = Z_by_configurations(M, N, x, y)
            assert Zd == Z
            direct_agree += 1
        assert Z > 0                                                        # def_partition_function_2d_ising の Z > 0
        Zs[N] = Z
        total += check_chain(M, N, Z, c)
    lc = log_ball(c)
    a = lc / M
    a_of = lambda N: log_ball(Zs[N]) / (M * N)
    for eps in [QQ(1), QQ(1)/2, QQ(1)/10, QQ(1)/40]:
        N0 = floor(log(2.0) / float(eps)) + 1                               # アルキメデス性の証人（ボールで N_0 ε > log 2 を確かめる）
        total += check_limit_step(eps, N0, [N for N in range(N0, NMAX + 1)], a_of, a)
    print(f"M_col = {M}, (x, y) = ({x}, {y}): c = {RR(c):.6f}、N_row = 1..{NMAX} の鎖と ε = 1, 1/2, 1/10, 1/40 の極限の段が成り立つ。"
          f" |a_60 − a| = {RR((a_of(60) - a).abs().upper()):.3e}")
print(f"含意の鎖と極限の段の比較 {total} 個が成り立つ。全ての配位の和と tr(W^N) の一致 {direct_agree} 件")

# 否定コントロール
M, x, y = 2, 3, 2
W = W_exact(M, x, y)
c = rayleigh_sup_exact(W)
lc = log_ball(c)
bad = 0
# (a) 極限値を (1/M) log(2c) に替えると |a_N − a'| ≤ (log 2)/N が破れる N がある
a_bad = log_ball(2 * c) / M
assert any(not le(abs(log_ball(Z_by_trace(W, N)) / (M * N) - a_bad), log_ball(QQ(2)) / N) for N in range(1, 61)); bad += 1
# (b) 上界の 2^M を 1 にした c^N ≥ Z は成り立たない
assert all(power_by_definition_real(c, N) < Z_by_trace(W, N) for N in range(1, 21)); bad += 1
# (c) 五行目の根拠を log(2^M) = (M+1) log 2 と書き違えると等号が破れる
assert not surely_equal(log_ball(QQ(2)**M), (M + 1) * log_ball(QQ(2))); bad += 1
# (d) 下界の c を 1.05c にすると (1.05c)^N ≤ Z が破れる N がある
assert any(not (power_by_definition_real(c * QQ(105)/100, N) <= Z_by_trace(W, N)) for N in range(1, 200)); bad += 1
print(f"否定コントロール {bad} 件: 極限値 (1/M)log(2c)、Z ≤ c^N、log(2^M) = (M+1)log 2、(1.05c)^N ≤ Z は成り立たない")
print("RESULT: PASS")

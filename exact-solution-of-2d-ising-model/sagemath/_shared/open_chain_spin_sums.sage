# 1 次元開鎖のスピン和（def_open_chain_spin_energy、open_chain_partition_sum、
# open_chain_endpoint_product_sum、open_chain_spin_sums_positive）の検算の共通の準備。
#
# 帰属:
# - スピン配置 s ∈ 𝔐 = Map({1,…,M_col},{-1,1}) は長さ M_col の ZZ の組で持ち、s(m) は s[m-1]。
# - 組合せの層: exp(K) と exp(-K) を、関係を一切持たない QQ[x, y] の不定元 x, y に置く。
#   exp(Kτ)（τ ∈ {-1,1}）は w(1) := x、w(-1) := y。和の付け替え・積の展開・二元集合の和・cosh/sinh の
#   定義の行は x, y の多項式の等式として厳密に確かめる（x y = 1 すら使わないので、特別な値で偶然合うことが無い）。
# - 実数の層: exp の値は ℝ への脱出なので RealBallField(200) の球で持つ（丸めの誤差を半径に含め、真の値を必ず囲む）。
#   等号は球が交わること（overlaps）で、半径が値の大きさに比べて 1e-40 未満であることも確かめる。
#   不等号 > 0 は球の下端が 0 より大きいこと（RB の `> 0` が真）で確かめる。

import itertools

RB = RealBallField(200)
Rxy = PolynomialRing(QQ, ["x", "y"])
X, Y = Rxy.gens()


def configs(M):
    # 𝔐 の全ての元（def_row_configurations）
    return [tuple(c) for c in itertools.product([-1, 1], repeat=M)]


def spin(s, m):
    # s(m)、m ∈ {1,…,M_col}
    return s[m - 1]


def energy(s):
    # def_open_chain_spin_energy: E(s) := Σ_{m=1}^{M_col-1} s(m)s(m+1) ∈ ZZ。左から足す
    M = len(s)
    e = ZZ(0)
    for m in range(1, M):
        e = e + spin(s, m) * spin(s, m + 1)
    return e


def t(s, m):
    # Step 1: t_m(s) := s(m)s(m+1)
    return spin(s, m) * spin(s, m + 1)


def Phi(s):
    # Step 1: Φ(s) := (s(1); t_1(s),…,t_{M_col-1}(s))
    return (spin(s, 1), tuple(t(s, m) for m in range(1, len(s))))


def Phi_inv(u, taus):
    # Step 1 の復元: s(1) := u、s(m+1) := s(m)τ_m
    s = [u]
    for tau in taus:
        s.append(s[-1] * tau)
    return tuple(s)


def codomain(M):
    # {-1,1} × {-1,1}^{M_col-1}
    return [(u, tuple(taus)) for u in [-1, 1] for taus in itertools.product([-1, 1], repeat=M - 1)]


def finite_sum(xs, zero):
    # 有限和を左から畳み込む（def_finite_sum_of_real_numbers と同じ順序）。空の和は使わない
    acc = zero
    for v in xs:
        acc = acc + v
    return acc


def finite_prod(ys):
    # def_finite_product_of_real_numbers: Π_{j=1}^1 r_j := r_1、Π_{j=1}^{m+1} r_j := (Π_{j=1}^m r_j) r_{m+1}。
    # m ≥ 1 だけを定めるので、因子の無い積は呼ばない
    assert len(ys) >= 1
    p = ys[0]
    for v in ys[1:]:
        p = p * v
    return p


def w_sym(tau):
    # 組合せの層の exp(Kτ)
    return X if tau == 1 else Y


def same(a, b):
    scale = max(1, abs(a.mid()), abs(b.mid()))
    assert a.rad() < 1e-40 * scale and b.rad() < 1e-40 * scale, (a, b)
    return a.overlaps(b)


def rexp(v):
    # def_scalar_exp の実数の exp（ℝ への脱出）。球の exp は真の値を囲む
    return RB(v).exp()


def rcosh_def(K):
    # def_cosh_sinh: cosh K := (exp(K) + exp(-K))/2
    return (rexp(K) + rexp(-K)) / 2


def rsinh_def(K):
    # def_cosh_sinh: sinh K := (exp(K) - exp(-K))/2
    return (rexp(K) - rexp(-K)) / 2


K_SAMPLES = [QQ(1) / 3, QQ(1), QQ(5) / 2, QQ(-7) / 4, QQ(0), QQ(1) / 100, QQ(6), QQ(-2) / 9]


def varsigma(e):
    # Step 1: ς : {0,1} → {-1,1}、ς(e) := 2e - 1
    return 2 * e - 1


def binword_sum(f, r, zero):
    # def_sum_over_binary_words_of_real_numbers（と同じ順序の多項式の和）:
    # Σ_{ϵ∈{0,1}^1} x_ϵ := x_(1) + x_(0)、Σ_{ϵ∈{0,1}^{r+1}} x_ϵ := Σ_{ϵ'∈{0,1}^r} (x_(ϵ',1) + x_(ϵ',0))
    def rec(r):
        if r == 1:
            return [((1,), (0,))]
        return [((*w, 1), (*w, 0)) for pair in rec(r - 1) for w in pair]
    if r == 1:
        return zero + f((1,)) + f((0,))
    words_r_minus_1 = [w for pair in rec(r - 1) for w in pair]
    acc = zero
    for w in words_r_minus_1:
        acc = acc + (f((*w, 1)) + f((*w, 0)))
    return acc

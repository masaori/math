# 対象ラベル: eigenvalues_of_check_Vprime の検算が使う ň_μ・γ_μ の供給元（各 check_*.sage が読み込む）。
# ň_μ は check_joint_eigenspace_decomposition の検算と同じ _number_operators.sage の number_operator_settings() から取る。
#   既定は Jordan–Wigner の模型 n_μ := c_μ^T c_μ（QQ、M_col = 2, 3, 4）。
#   check_with_check_psi.sage が USE_CHECK_PSI = True と置いてから読み込むと、本文の ψ̌ の ň_μ := ψ̌_μ^† ψ̌_{σ(μ)}
#   （数体 F := E_1、結合定数 3 組 × M_col = 2, 3）。
# γ_μ（本文の γ(θ̃_μ)）の与え方は二通りある。
#   chain_settings: 鎖の厳密計算用。既定は有理数 MODEL_GAMMAS（模型でも本物の ψ̌ でも）。symbolic_gamma=True のとき、本物の ψ̌ では
#     F 上の多項式環の不定元 γ_1, …, γ_M（鎖は γ_μ を係数としてしか使わないので、不定元で等号が成り立てば γ(θ̃_μ) の実際の値を
#     代入しても成り立つ）。不定元を使うのは γ_μ について一次の Step 1 の鎖だけで、冪 X̌^k を作る鎖では数体上の多項式の計算が
#     重すぎて終わらないので有理数を使う（どちらでも、鎖が ň_μ について使う性質は本物の ň_μ で試される）。
#   ball_settings: ℝ への脱出を含む量（exp の値・極限）用。模型では有理数 MODEL_GAMMAS、本物の ψ̌ では
#     γ(θ̃_μ) = log(g + √(g^2 − 1))（g = γ_1(θ̃_μ)、def_gamma_theta・def_arccosh）の RealBallField(512) の球。
#     F の元は to_cb_factory(E_1)（ζ ↦ exp(2πi/(4M))、σ > 0、R ↦ +r_1 の埋め込み）で ComplexBallField(512) へ移す。
# 帰属: 鎖の設定は QQ か F 上の多項式環（厳密）、球の設定は ℝ・ℂ の値を囲む球（ℝ への脱出: arccosh の実対数と exp）。

load("../check_joint_eigenspace_decomposition/_number_operators.sage")

MODEL_GAMMAS = [QQ(3) / 2, QQ(5) / 7, QQ(2), QQ(11) / 3]
RBv = RealBallField(512)
CBv = ComplexBallField(512)
if "_VPRIME_BALL_CACHE" not in globals():
    _VPRIME_BALL_CACHE = {}


def chain_settings(Ms, symbolic_gamma=False):
    """(tag, M, R, ns, gammas) の並び。R は成分の環、ns[μ-1] = ň_μ ∈ Mat(2^M, R)、gammas[μ-1] = γ_μ ∈ R。"""
    out = []
    for (tag, M, F, ns) in number_operator_settings():
        if M not in Ms:
            continue
        if USE_CHECK_PSI and symbolic_gamma:
            R = PolynomialRing(F, [f"gamma_{mu}" for mu in range(1, M + 1)])
            out.append((tag, M, R, [n.change_ring(R) for n in ns], list(R.gens())))
        else:
            out.append((tag, M, F, ns, [F(g) for g in MODEL_GAMMAS[:M]]))
    return out


def joint_projector(ns, eps, Id):
    """check_joint_eigenspace_decomposition の Q̌_ε = Π_μ R_μ^{(ε_μ)}（R^{(1)} := ň、R^{(0)} := I − ň）を左から掛ける。"""
    Q = Id
    for mu in range(len(ns)):
        Q = Q * (ns[mu] if eps[mu] == 1 else Id - ns[mu])
    return Q


def _check_psi_extras(Ms):
    """本物の ψ̌ の設定ごとに (γ の球の並び, E_1 → CBv の写像)。number_operator_settings と同じ順に作る。"""
    out = []
    for (x, y) in COUPLINGS:
        for M in globals().get("CHECK_PSI_MS", [2, 3]):
            key = (x, y, M)
            if key not in _VPRIME_BALL_CACHE:
                f = Factors(M, x, y)
                st = NumberOperatorSetting(f)
                gams = []
                for m in st.J:
                    g = RBv(st.S[m].g1_AA)
                    assert g > 1                                       # arccosh の定義域（γ_1(θ̃_μ) > 1）
                    gams.append((g + (g ** 2 - 1).sqrt()).log())        # def_arccosh（実対数）
                g1s = [st.S[m].g1_AA for m in st.J]
                _VPRIME_BALL_CACHE[key] = (gams, to_cb_factory(st.S[1]), g1s)
            out.append((f"本物の ψ̌ (x,y)=({x},{y}) M={M}", M) + _VPRIME_BALL_CACHE[key])
    return [o for o in out if o[1] in Ms]


def ball_settings(Ms):
    """(tag, M, F, ns, gam_balls, to_cb, g1s) の並び。ns は厳密な ň_μ（F の行列）、gam_balls[μ-1] は γ_μ の RBv の球、
    to_cb は F → CBv、g1s は本物の ψ̌ では γ_1(θ̃_μ) の AA の値（模型では None）。"""
    out = []
    if USE_CHECK_PSI:
        extras = {e[0]: e for e in _check_psi_extras(Ms)}
        for (tag, M, F, ns) in number_operator_settings():
            if M not in Ms:
                continue
            (_, _, gams, to_cb, g1s) = extras[tag]
            out.append((tag, M, F, ns, gams, lambda z, to_cb=to_cb: CBv(to_cb(z)), g1s))
    else:
        for (tag, M, F, ns) in number_operator_settings():
            if M not in Ms:
                continue
            out.append((tag, M, F, ns, [RBv(g) for g in MODEL_GAMMAS[:M]], lambda z: CBv(z), None))
    return out


def mat_to_cb(A, to_cb):
    return matrix(CBv, A.nrows(), A.ncols(), lambda r, c: to_cb(A[r, c]))


def frobenius_norm_ball(A):
    """def_matrix_norm の ‖A‖ = √(Σ|a_rs|^2)（RBv の球）。成分が 0 に近いと 2 乗和の球が負の側を含み平方根が定まらないので、
    2 乗和の真の値が 0 以上であることを使って球の下端を 0 で切ってから平方根を取る。"""
    s = sum(a.real() ** 2 + a.imag() ** 2 for a in A.list())
    lo = s.lower() if s.lower() > 0 else 0
    return RBv(lo).sqrt().union(RBv(s.upper()).sqrt())


def exp_ball_by_partial_sums(A):
    """def_exp の部分和 Σ_{p=0}^{N} A^p/p!（冪は A^{p+1} := A^p A）に、尾の上界 s^{N+1}/(N+1)!/(1 − s/(N+2))
    （s は ‖A‖ の上界。matrix_norm_submultiplicativity と |成分| ≤ ‖·‖）を各成分の半径として足した球の行列。"""
    n = A.nrows()
    s = RBv(frobenius_norm_ball(A).upper())
    N = 20
    while not (s < N + 2 and (s ** (N + 1) / factorial(N + 1)) < RBv(2) ** (-300)):
        N += 10
    E = matrix(CBv, n, n, 0)
    P = identity_matrix(CBv, n)
    for p in range(N + 1):
        E = E + (CBv(1) / factorial(p)) * P
        P = P * A
    rad = (s ** (N + 1) / factorial(N + 1) / (1 - s / (N + 2))).upper()
    return matrix(CBv, n, n, lambda r, c: CBv(E[r, c].real().add_error(rad), E[r, c].imag().add_error(rad)))


def balls_overlap_mat(A, B):
    return all(A[r, c].overlaps(B[r, c]) for r in range(A.nrows()) for c in range(A.ncols()))


def max_radius(A):
    return RBv(max(max(a.real().rad(), a.imag().rad()) for a in A.list()))


def gcheck_ball(gams, eps):
    """ǧ(ε) = Σ_{μ=1}^{M} γ_μ(ε_μ − 1/2)（def_finite_sum_of_real_numbers どおり左から足す）。"""
    out = gams[0] * (RBv(eps[0]) - RBv(1) / 2)
    for mu in range(1, len(gams)):
        out = out + gams[mu] * (RBv(eps[mu]) - RBv(1) / 2)
    return out

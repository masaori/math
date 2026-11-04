# 対象ラベル: check_joint_eigenspace_decomposition の検算が使う ň_μ の供給元（各 check_*.sage が読み込む）。
# number_operator_settings() は (tag, M, F, ns) の並びを返す。F は成分の体、ns[μ-1] = ň_μ ∈ Mat(2^M, F)。
# 鎖が ň_μ について使う性質は check_number_operator_idempotent (3)（ň_μň_μ = ň_μ）と
# check_number_operators_commute (2)（ň_μň_ν = ň_νň_μ）だけなので、既定では二つを満たす模型を使う:
#   Jordan–Wigner のフェルミ演算子 c_μ から n_μ := c_μ^T c_μ（M = 2, 3, 4、F = QQ）。
# check_with_check_psi.sage が USE_CHECK_PSI = True と置いてから読み込むと、本文の ψ̌（def_check_fermi の式どおりの行列）から
#   ň_μ := ψ̌_μ^† ψ̌_{σ(μ)}（def_check_number_operator、σ(μ) := M_col + 1 - μ）を作り、全ての μ を一つの数体 F := E_1 に移して返す
#   （結合定数 3 組 × M_col = 2, 3。移し方は trace_of_check_number_operator_product/check_with_check_psi.sage の to_common_field と同じ）。
# どちらの供給元でも、返す前に二つの性質と ň_μ ≠ O, I を確かめる（等号が自明でないこと）。
# 帰属: QQ か数体 F の元（厳密計算）。

if "USE_CHECK_PSI" not in globals():
    USE_CHECK_PSI = False
if "_NUMBER_OPERATOR_CACHE" not in globals():
    _NUMBER_OPERATOR_CACHE = {}
if USE_CHECK_PSI and "NumberOperatorSetting" not in globals():
    load("../def_check_number_operator/_prelude.sage")


def _kron_jw(factors):
    out = matrix(factors[0].base_ring(), 1, 1, [1])
    for A in factors:
        out = out.tensor_product(A)
    return out


def _jordan_wigner_settings():
    sz = matrix(QQ, [[1, 0], [0, -1]])
    lower = matrix(QQ, [[0, 1], [0, 0]])
    id2 = identity_matrix(QQ, 2)
    out = []
    for M in range(2, 5):
        c = [_kron_jw([sz] * (k - 1) + [lower] + [id2] * (M - k)) for k in range(1, M + 1)]
        ns = [c[mu].transpose() * c[mu] for mu in range(M)]
        out.append((f"Jordan–Wigner の模型 M={M}", M, QQ, ns))
    return out


def _check_psi_settings():
    out = []
    Ms = globals().get("CHECK_PSI_MS", [2, 3])
    for (x, y) in COUPLINGS:
        for M in Ms:
            f = Factors(M, x, y)
            st = NumberOperatorSetting(f)
            F = st.S[1].E
            maps = {}
            for m in st.J:
                s = st.S[m]
                if m == 1:
                    maps[m] = lambda X: X
                elif s.E is st.f.F:
                    maps[m] = lambda X, F=F: X.change_ring(F)
                else:
                    assert m == st.sigma[1], (M, m)
                    maps[m] = transport(s, st.S[1])
            assert F.is_field()
            ns = [maps[m](st.dag[m]) * maps[m](st.psi_sig[m]) for m in st.J]
            out.append((f"本物の ψ̌ (x,y)=({x},{y}) M={M}", M, F, ns))
    return out


def number_operator_settings():
    key = "check_psi" if USE_CHECK_PSI else "jordan_wigner"
    if key not in _NUMBER_OPERATOR_CACHE:
        settings = _check_psi_settings() if USE_CHECK_PSI else _jordan_wigner_settings()
        for (tag, M, F, ns) in settings:
            N = 2 ^ M
            Id = identity_matrix(F, N)
            for mu in range(M):
                assert ns[mu] * ns[mu] == ns[mu], (tag, mu)                      # check_number_operator_idempotent (3)
                assert ns[mu] != 0 * Id and ns[mu] != Id, (tag, mu)              # 等号が自明でない
                for nu in range(M):
                    assert ns[mu] * ns[nu] == ns[nu] * ns[mu], (tag, mu, nu)     # check_number_operators_commute (2)
        _NUMBER_OPERATOR_CACHE[key] = settings
    return _NUMBER_OPERATOR_CACHE[key]


def generic_ring_over(F, shapes):
    """F 上の多項式環で、shapes の各 (文字, 行数, 列数) について成分を不定元とする行列を返す（_shared の generic_ring の F 版）。"""
    names = [f"{x}_{r}_{s}" for (x, m, n) in shapes for r in range(m) for s in range(n)]
    P = PolynomialRing(F, names)
    g = P.gens()
    pos = 0
    mats = []
    for (x, m, n) in shapes:
        mats.append(matrix(P, m, n, g[pos:pos + m * n]))
        pos += m * n
    return P, mats

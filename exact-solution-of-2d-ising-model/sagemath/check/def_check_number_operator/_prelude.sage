# 対象ラベル: def_check_number_operator の検算の準備。
# 数体の組み方・ψ̌ の作り方は T_V_plus_eq_T_check_Vprime_on_check_Z_Y の検算の準備をそのまま読み込んで使う
#（K_1 = 2 log y、K_2 = log x と選び、Ž_μ・Y̌_μ・位相を一つの数体 F に、ψ̌_μ^†・ψ̌_μ を E_μ := F(r_μ) に置く。r_μ := |γ_2(θ̃_μ)|）。
# この検算で足したもの: σ(μ) := M_col + 1 - μ の ψ̌_{σ(μ)} を E_μ へ移す写像。
#   r_{σ(μ)}^2 と r_μ^2 が F の同じ元であることを毎回確かめ、E_{σ(μ)} → E_μ を R ↦ R（r_{σ(μ)} ↦ r_μ）で定める。
#   r_{σ(μ)} = r_μ（ともに正の実数）は AA でも確かめる。
load("../T_V_plus_eq_T_check_Vprime_on_check_Z_Y/_prelude.sage")


def transport(sfrom, sto):
    """E_{sfrom} → E_{sto}。両者の r^2 が F の同じ元で、r の正の値が等しいときだけ作る。"""
    F = sfrom.f.F
    assert sfrom.r_AA == sto.r_AA and sfrom.r_AA > 0
    if sfrom.E is F and sto.E is F:
        assert sfrom.r == sto.r
        return lambda A: A
    assert sfrom.E is not F and sto.E is not F
    nf, nt = (sfrom.r**2).list(), (sto.r**2).list()   # E = F(R) の元の F 上の係数 [c_0, c_1]
    assert nf[1] == 0 and nt[1] == 0 and nf[0] == nt[0]   # 同じ F の元の平方根を付け加えた体
    h = sfrom.E.hom([sto.E.gen()], sto.E)            # R ↦ R（F の上では恒等）
    assert h(sfrom.r) == sto.r
    return lambda A: A.apply_map(h)


class NumberOperatorSetting:
    """一つの (M_col, x, y) について、各 μ ∈ M̌ の ψ̌_μ^†・ψ̌_{σ(μ)}（ともに E_μ の成分）を持つ。"""

    def __init__(self, f):
        self.f = f
        M = f.M
        self.M = M
        self.J = list(range(1, M + 1))                  # def_check_index_set の M̌
        self.sigma = {m: M + 1 - m for m in self.J}      # σ(μ) := M_col + 1 - μ
        self.S = {m: PsiSetting(f, m) for m in self.J}
        self.dag, self.psi_sig, self.psi_self, self.I = {}, {}, {}, {}
        for m in self.J:
            s = self.S[m]; t = self.S[self.sigma[m]]
            tr = transport(t, s)
            # def_check_fermi の ψ̌^†・ψ̌ を (Ž, Y̌)P̌ の組の積でも作り、明示した一次結合と一致することを確かめる
            for u in (s, t):
                pp = pair_times_two_by_two((u.Z, u.Y), u.P)
                assert pp[0] == u.psid and pp[1] == u.psi
            # 分母 2√M_col b が 0 でない（def_check_fermi の「除外される μ は無い」）
            assert s.b != 0 and t.b != 0 and s.r_AA > 0
            self.dag[m] = s.psid
            self.psi_sig[m] = tr(t.psi)
            self.psi_self[m] = s.psi                     # 対照用: 対を μ 自身に取り違えたもの
            self.I[m] = body_identity(s.E, f.n)

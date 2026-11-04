# 対象ラベル: check_number_operators_commute
# 本文の ψ̌（def_check_fermi の式どおりの行列）で、主張 (1)(2) と証明の全ての鎖を厳密に確かめる（μ ≠ ν の全ての組）。
#   D_λ := ψ̌_λ^†、P_λ := ψ̌_{σ(λ)}（σ(λ) := M_col + 1 - λ）、n_λ := D_λP_λ（def_check_number_operator の ň_λ）。λ ∈ {μ, ν}。
# ψ̌ は def_check_number_operator の検算の準備（../def_check_number_operator/_prelude.sage の NumberOperatorSetting）が作る:
#   D_λ・P_λ は E_λ := F(r_λ)（r_λ := |γ_2(θ̃_λ)|）の成分の行列である。
# μ と ν の行列を一つの環で掛けるため、次の環 C に移す（いずれも、本物の値への環の準同型 C → QQbar がある）。
#   - E_ν = F なら C := E_μ。
#   - r_ν^2 と r_μ^2 が F の同じ元なら（ν = σ(μ) の場合を含む）、r_ν = r_μ（AA で確かめる）なので C := E_μ、E_ν → E_μ は R ↦ R。
#   - それ以外は C := E_μ[S]/(S^2 - r_ν^2)、E_ν → C は R ↦ S。C → QQbar は E_μ の埋め込みと S ↦ +r_ν。
#     r_ν^2 が E_μ の平方でなければ C は体で、そうでなければ体でない。
# 等号は C の中で判定する。C の中の等号は準同型で本物の値の等号に移るので、等号の確認としては十分である
#（C が体でない場合、C の中で等しくないことは本物の値で等しくないことを意味しないので、対照と ň_μň_ν ≠ O は C が体のときだけ行う）。
# 鎖の組み立ては _chains.sage（Jordan–Wigner の模型の検算と同じ関数）で、ここでは仮定の行も含めて全ての等号を本物の ψ̌ で確かめる。
# 対照: ν = σ(μ) ≠ μ のとき、P_μ を対を取り違えた ψ̌_μ に替えると Step 1 の [ψ̌_μ, ψ̌_ν^†]_+ = O が成り立たない。
# 範囲: 結合定数 3 組 × M_col = 2, 3 × μ ≠ ν の全ての組。
# 帰属: 成分はすべて数体 E_μ とその上の二次の剰余環の元（厳密計算。浮動小数点は使わない）。
load("../def_check_number_operator/_prelude.sage")
load("_chains.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3]
rep = Report("check_number_operators_commute: 本物の ψ̌ での主張と鎖（厳密）")


def all_steps_hold(lines):
    return all(A == B for (_, A, _), (_, B, _) in zip(lines, lines[1:]))


def common_ring(st, m, n):
    """(C, E_μ → C, E_ν → C, C が体か) を返す。"""
    sm, sn = st.S[m], st.S[n]
    F = st.f.F
    Em, En = sm.E, sn.E
    to_m = lambda A: A
    if En is F:
        return Em, to_m, (lambda A: A.change_ring(Em)), True
    if Em is not F:
        nm_, nn_ = (sm.r**2).list(), (sn.r**2).list()
        if nm_[1] == 0 and nn_[1] == 0 and nm_[0] == nn_[0]:
            return Em, to_m, transport(sn, sm), True
    c = (sn.r**2).list()
    assert c[1] == 0
    PS = PolynomialRing(Em, 'S')
    C = PS.quotient(PS.gen()**2 - Em(c[0]), 'Sbar')
    Sbar = C.gen()

    def to_n(A):
        def h(e):
            l = En(e).list()
            return C(Em(l[0])) + C(Em(l[1])) * Sbar
        return matrix(C, A.nrows(), A.ncols(), lambda r_, c_: h(A[r_, c_]))
    # S^2 - r_ν^2 が E_μ 上で既約（r_ν^2 が E_μ の平方でない）なら C は体で、C → QQbar は単射になる
    return C, (lambda A: A.change_ring(C)), to_n, (not Em(c[0]).is_square())


for (x, y) in COUPLINGS:
    for M in Ms:
        f = Factors(M, x, y)
        st = NumberOperatorSetting(f)
        for m in st.J:
            for n in st.J:
                if m == n:
                    continue
                tag = f"(x,y)=({x},{y}) M={M} μ={m} ν={n}"
                # 直前の δ の計算: δ_{σ(ν),σ(μ)} = δ_{μ,ν} = 0
                rep.check(kronecker_delta(M + 1 - n, M + 1 - m) == kronecker_delta(m, n) == 0, f"{tag}: δ の計算", quiet=True)
                C, tm, tn, is_field = common_ring(st, m, n)
                Dm, Pm = tm(st.dag[m]), tm(st.psi_sig[m])
                Dn, Pn = tn(st.dag[n]), tn(st.psi_sig[n])
                Id = tm(st.I[m])
                O = 0 * Id
                nm, nn = Dm * Pm, Dn * Pn
                # Step 1 の 4 式
                rep.check(all_steps_hold(chain_first(Dm, Dn, Id)), f"{tag}: Step 1 第 1 式", quiet=True)
                rep.check(all_steps_hold(chain_second(Dm, Pn, Id, M, m, n)), f"{tag}: Step 1 第 2 式の鎖", quiet=True)
                rep.check(all_steps_hold(chain_third(Pm, Dn, Id, M, m, n)), f"{tag}: Step 1 第 3 式の鎖", quiet=True)
                rep.check(all_steps_hold(chain_fourth(Pm, Pn, Id)), f"{tag}: Step 1 第 4 式", quiet=True)
                # Step 1 の結びと matrix_equals_negation_if_sum_is_zero
                for X in (Dm, Pm):
                    for W in (Dn, Pn):
                        rep.check(all_steps_hold(chain_conclusion(X, W, Id)), f"{tag}: XW + WX = [X,W]_+ = O", quiet=True)
                        rep.check(X * W == neg(W * X), f"{tag}: XW = -(WX)", quiet=True)
                # Step 2（主張 (1)）
                for X, nmX in ((Dm, "ψ̌_μ^†"), (Pm, "ψ̌_{σ(μ)}")):
                    lines = commute_step2_chain(X, Dn, Pn)
                    for (a, A, _), (b, B, _) in zip(lines, lines[1:]):
                        rep.check(A == B, f"{tag}: Step 2 ({nmX}) {a} = {b}", quiet=True)
                    rep.check(X * nn == nn * X, f"{tag}: 主張 (1) {nmX} ň_ν = ň_ν {nmX}", quiet=True)
                # Step 3（主張 (2)）
                lines = commute_step3_chain(Dm, Pm, Dn, Pn)
                for (a, A, _), (b, B, _) in zip(lines, lines[1:]):
                    rep.check(A == B, f"{tag}: Step 3 {a} = {b}", quiet=True)
                rep.check(nm * nn == nn * nm, f"{tag}: 主張 (2) ň_μ ň_ν = ň_ν ň_μ", quiet=True)
                if is_field:
                    rep.check(nm * nn != O, f"{tag}: ň_μ ň_ν は O でない（等号が自明でない）", quiet=True)
                # 対照
                if is_field and n == st.sigma[m]:
                    Pw = st.psi_self[m]
                    rep.check(anticomm(Pw, Dn) != O, f"対照 {tag}: 対を取り違えた ψ̌_μ では [ψ̌_μ, ψ̌_ν^†]_+ ≠ O", quiet=True)
        print(f"  (x,y)=({x},{y}) M={M}: 済（累計 {rep.n} 件、失敗 {rep.fail} 件）", flush=True)

rep.finish()

# 対象ラベル: trace_of_check_number_operator_product
# 本文の ψ̌（def_check_fermi の式どおりの行列）で、主張と証明の全ての鎖を厳密に確かめる
#（相異なる添字の全ての列 μ_1, …, μ_k（k = 1..M_col）と全ての e_1, …, e_k ∈ {0,1}）。
#   D_μ := ψ̌_μ^†、A_μ := ψ̌_{σ(μ)}（σ(μ) := M_col + 1 - μ）、n_μ := D_μA_μ（def_check_number_operator の ň_μ）。
# ψ̌ は def_check_number_operator の検算の準備（../def_check_number_operator/_prelude.sage の NumberOperatorSetting）が作る:
#   D_μ・A_μ は E_μ := F(r_μ)（r_μ := |γ_2(θ̃_μ)|）の成分の行列である。
# 主張は全ての μ の積を扱うので、全ての行列を一つの体 K := E_1 に移す。M_col = 2, 3 では、
#   - E_μ = F なら（M_col = 3 の μ = 2）F ⊂ K で移す。
#   - μ ≠ 1 で E_μ ≠ F なら μ = σ(1) であり、r_μ^2 と r_1^2 は F の同じ元、r_μ = r_1（AA で確かめる）なので、E_μ → K を R ↦ R で移す
#     （../def_check_number_operator/_prelude.sage の transport。条件が成り立たなければ止まる。Sage が E_{σ(1)} と E_1 を同じ体として持つ場合も、
#     μ = σ(1) は必ず transport を通す）。
# K は体で、K → QQbar の埋め込みで本物の値に移るので、K の中の等号も不等号も本物の値の等号・不等号である。
# 鎖の組み立ては _chains.sage（Jordan–Wigner の模型の検算と同じ関数）で、ここでは鎖が引く仮定の主張も本物の ψ̌ で確かめる。
# 等号が自明でないことの確認: ň_μ は O でも I でもない。否定コントロール: 添字が重なる列では準備 2 の可換性と 2^{M_col-k} が外れる。
# 範囲: 結合定数 3 組 × M_col = 2, 3。
# 帰属: 成分はすべて数体 K の元（厳密計算。浮動小数点は使わない）。
load("../def_check_number_operator/_prelude.sage")
load("_chains.sage")

Ms = [int(a) for a in sys.argv[1:]] or [2, 3]
rep = Report("trace_of_check_number_operator_product: 本物の ψ̌ での主張と鎖（厳密）")


def to_common_field(st):
    """各 μ の行列を K := E_1 へ移す写像の辞書を返す。"""
    F = st.f.F
    s1 = st.S[1]
    K = s1.E
    maps = {}
    for m in st.J:
        s = st.S[m]
        if m == 1:
            maps[m] = lambda X: X
        elif s.E is F:
            maps[m] = lambda X, K=K: X.change_ring(K)
        else:
            assert m == st.sigma[1], (st.M, m)
            maps[m] = transport(s, s1)
    return K, maps


def check(ok, label):
    rep.check(ok, label, quiet=True)


for (x, y) in COUPLINGS:
    for M in Ms:
        f = Factors(M, x, y)
        st = NumberOperatorSetting(f)
        K, maps = to_common_field(st)
        assert K.is_field()
        D = [maps[m](st.dag[m]) for m in st.J]
        A = [maps[m](st.psi_sig[m]) for m in st.J]
        Id = maps[1](st.I[1])
        O = 0 * Id
        n = assumption_lines(M, Id, D, A, check)
        for m in range(M):
            rep.check(n[m] != O and n[m] != Id, f"(x,y)=({x},{y}) M={M} μ={m + 1}: ň_μ は O でも I でもない（等号が自明でない）", quiet=True)
        base_case(M, Id, check)
        for mus, es in all_sequences(M):
            induction_step(M, Id, D, A, n, mus, es, check)
            # 主張そのもの
            R = [n[m] if e == 1 else Id - n[m] for m, e in zip(mus, es)]
            rep.check(left_product(R).trace() == 2 ** (M - len(mus)), f"(x,y)=({x},{y}) M={M} μ={tuple(m + 1 for m in mus)} e={es}: 主張", quiet=True)
        negative_controls(M, A, n, check)
        print(f"  (x,y)=({x},{y}) M={M}: 済（累計 {rep.n} 件、失敗 {rep.fail} 件）", flush=True)

rep.finish()

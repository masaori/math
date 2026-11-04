# 対象ラベル: eigenvalues_of_check_Vprime
# 主張そのものを、証明の行を経ずに確かめる。ň_μ・γ_μ は _vprime_settings.sage の ball_settings から取る
# （既定は Jordan–Wigner の模型 n_μ := c_μ^T c_μ と有理数 γ_μ、M_col = 2, 3, 4。check_with_check_psi.sage からは本文の ψ̌ の ň_μ と
# γ(θ̃_μ) の実際の値、結合定数 3 組 × M_col = 2, 3）。
#   V̌' := exp(X̌)、X̌ := Σ_μ γ_μ(ň_μ − (1/2)I)（def_check_number_operator (2)）。Sage の球の行列の exp と、def_exp の部分和に尾の上界を
#   足した球（_vprime_settings.sage の exp_ball_by_partial_sums）の二つの経路で作り、重なることを確かめてから使う。
#   (i)   V̌'Q̌_ε = Q̌_εV̌' = (exp(ǧ(ε)))_ℂ Q̌_ε（全ての ε。三つの球の行列が重なり、半径 < 10^{-100}）。
#   (ii)  im Q̌_ε の 0 でない元 v_ε（Q̌_ε の 0 でない列。Q̌_ε の rank が 1 であることは F の上で厳密に確かめる）を並べた行列 P の rank が
#         2^{M_col}（F の上で厳密）で、P^{-1}V̌'P が対角行列 diag(exp(ǧ(ε)))_ε と重なる。すなわち V̌' は対角化可能で、固有値は
#         各 ε が重複度 1 で与える exp(ǧ(ε)) で尽くされる（総個数 2^{M_col}）。
#   (iii) 固有値の重複度を込めた一致を、P を使わない経路でも確かめる: k = 1, …, 2^{M_col} で tr(V̌'^k) と Σ_ε exp(ǧ(ε))^k が重なる
#         （両方の半径が 10^{-100}(1 + |Σ_ε exp(ǧ(ε))^k|) 未満）
#         （冪和が 2^{M_col} 個まで一致すれば、Newton の恒等式で固有多項式が一致する）。
#   (iv)  exp(ǧ(ε)) > 0（実数の球の全体が正）。
#   (v)   主張の末尾「相異なる ε が同じ固有値を与えることは実際に起こる」（本文の ψ̌ だけ）: periodicity_of_check_fermi (3) の
#         γ(θ̃_{σ(μ)}) = γ(θ̃_μ) を γ_1(θ̃_μ) の AA の値の等号で厳密に確かめ（arccosh は単射）、ε' := ε∘σ ≠ ε の組で ǧ(ε) = ǧ(ε') を
#         γ_μ の値の等しい類ごとの係数の和で厳密に確かめ、そのような組が在ることを確かめる。
# 否定コントロール: (i) で ǧ(ε) ≠ 0 の ε について exp(−ǧ(ε))Q̌_ε とは重ならない。(ii) で固有値の並びを一つずらした対角行列とは重ならない。
#   (v) の模型（γ_μ が周期性を持たない有理数）では ε∘σ ≠ ε の組の固有値の球が重ならない組が在る。
# 球の等号は、重なりに加えて半径が 10^{-100}（P^{-1}V̌'P は 10^{-60}、(iii) は値の大きさに比例した 10^{-100}(1 + |値|)）未満であることを確かめる。
# 帰属: Q̌_ε・P・rank は QQ か本文の ψ̌ の数体 F の上の厳密計算。γ_μ・ǧ(ε)・exp・V̌' は ℝ・ℂ の値を囲む球（ℝ への脱出: arccosh の実対数、
#   実数の exp と行列の exp の値。いずれも極限で定まる）。
load("_vprime_settings.sage")
import itertools

claim_count = 0
claim_neg = 0
tiny = RBv(10) ** -100


def claim(ok, label):
    global claim_count
    assert ok, label
    claim_count += 1


def negative(ok, label):
    global claim_neg
    assert ok, label
    claim_neg += 1


for (tag, M, F, ns, gams, to_cb, g1s) in ball_settings([2, 3, 4]):
    N = 2 ^ M
    IdF = identity_matrix(F, N)
    IdC = identity_matrix(CBv, N)
    nC = [mat_to_cb(A, to_cb) for A in ns]
    X = sum(CBv(gams[mu]) * (nC[mu] - IdC / 2) for mu in range(M))
    V = X.exp()
    claim(balls_overlap_mat(V, exp_ball_by_partial_sums(X)) and max_radius(V) < tiny, (tag, "V̌' の二つの経路"))
    W = [tuple(w) for w in itertools.product([1, 0], repeat=M)]
    cols, evals = [], []
    for eps in W:
        Q = joint_projector(ns, eps, IdF)
        QC = mat_to_cb(Q, to_cb)
        g = gcheck_ball(gams, eps)
        e = g.exp()
        VQ, QV, eQ = V * QC, QC * V, CBv(e) * QC
        claim(balls_overlap_mat(VQ, eQ) and max(max_radius(VQ), max_radius(eQ)) < tiny, (tag, eps, "(i) V̌'Q̌ = eQ̌"))
        claim(balls_overlap_mat(QV, eQ) and max_radius(QV) < tiny, (tag, eps, "(i) Q̌V̌' = eQ̌"))
        if not g.contains_zero():
            negative(not balls_overlap_mat(VQ, CBv((-g).exp()) * QC), (tag, eps, "対照 (i)"))
        claim(e > 0, (tag, eps, "(iv) exp(ǧ) > 0"))
        claim(Q.rank() == 1, (tag, eps, "Q̌_ε の rank が 1"))
        v = next(Q.column(j) for j in range(N) if Q.column(j) != 0)
        claim(Q * v == v, (tag, eps, "v_ε ∈ im Q̌_ε"))
        cols.append(v)
        evals.append(e)
    P = matrix(F, cols).transpose()
    claim(P.rank() == N, (tag, "(ii) 固有ベクトルが基底をなす"))
    PC, PinvC = mat_to_cb(P, to_cb), mat_to_cb(P.inverse(), to_cb)
    D = PinvC * V * PC
    claim(balls_overlap_mat(D, diagonal_matrix(CBv, evals)) and max_radius(D) < RBv(10) ** -60, (tag, "(ii) P^{-1}V̌'P = diag(exp ǧ)"))
    shifted = evals[1:] + evals[:1]
    if any(not a.overlaps(b) for (a, b) in zip(evals, shifted)):
        negative(not balls_overlap_mat(D, diagonal_matrix(CBv, shifted)), (tag, "対照 (ii)"))
    Vk = IdC
    for k in range(1, N + 1):
        Vk = Vk * V
        tk, sk = Vk.trace(), CBv(sum(e ** k for e in evals))
        claim(tk.overlaps(sk) and RBv(max(tk.real().rad(), tk.imag().rad(), sk.real().rad())) < tiny * (1 + RBv(sk.abs().upper())),
              (tag, k, "(iii) tr(V̌'^k) = Σ exp(ǧ)^k"))
    sigma = lambda mu: M - 1 - mu                       # 0 始まりの添字での σ(μ) := M_col + 1 − μ
    if g1s is not None:
        for mu in range(M):
            claim(g1s[sigma(mu)] == g1s[mu], (tag, mu, "(v) γ_1(θ̃_σ(μ)) = γ_1(θ̃_μ)（AA で厳密）"))
        classes = sorted(set(g1s))
        pairs = 0
        for (j, eps) in enumerate(W):
            eps2 = tuple(eps[sigma(mu)] for mu in range(M))
            if eps2 == eps:
                continue
            coeff = lambda w, c: sum(QQ(w[mu]) - QQ(1) / 2 for mu in range(M) if g1s[mu] == c)
            claim(all(coeff(eps, c) == coeff(eps2, c) for c in classes), (tag, eps, "(v) ǧ(ε) = ǧ(ε∘σ)（厳密）"))
            e2 = evals[W.index(eps2)]
            claim(evals[j].overlaps(e2) and RBv(max(evals[j].rad(), e2.rad())) < tiny, (tag, eps, "(v) 同じ固有値の球"))
            pairs += 1
        claim(pairs > 0, (tag, "(v) 相異なる ε が同じ固有値を与える組が在る"))
    else:
        sep = [j for (j, eps) in enumerate(W) if tuple(eps[sigma(mu)] for mu in range(M)) != eps
               and not evals[j].overlaps(evals[W.index(tuple(eps[sigma(mu)] for mu in range(M)))])]
        negative(len(sep) > 0, (tag, "対照 (v): 周期性の無い γ では ε∘σ の固有値が分かれる"))
    print(f"  {tag}: 主張 {claim_count} 件まで、否定コントロール {claim_neg} 件まで", flush=True)

print(f"checked {claim_count} claims and {claim_neg} negative controls")
print("RESULT: PASS")

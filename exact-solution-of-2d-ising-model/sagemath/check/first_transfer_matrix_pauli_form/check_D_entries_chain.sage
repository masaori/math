# ---------------------------------------------------------
# SageMath: 証明の前半の三つの中間目標（m^+ := m+1 (m ≤ M_col-1)、m^+ := 1 (m = M_col)）
#   D は対角行列（k ≠ l）:
#     D_{kl} = Σ_m (σ_mσ_{m+1})_{kl} = Σ_m (σ_mσ_{m^+})_{kl} = Σ_m 0 = 0
#   D の対角成分（k = ν(ι(μ))）:
#     D_{kk} = Σ_m (σ_mσ_{m+1})_{kk} = Σ_m (σ_mσ_{m^+})_{kk} = Σ_m μ(m)_C μ(m^+)_C
#            = Σ_m (μ(m)μ(m^+))_C = (Σ_m μ(m)μ(m^+))_C = (Σ_m μ(m)μ(m+1))_C = d(μ)_C
#   K_1 D: (K_1 D)_{kl} = (K_1)_C D_{kl} = (K_1)_C·0 = 0、(K_1 D)_{kk} = (K_1)_C D_{kk} = (K_1)_C d(μ)_C
# 対象ラベル: first_transfer_matrix_pauli_form
# 帰属: σ^z, D は ZZ 成分。ℝ から ℂ への包含 r ↦ r_C = (r, 0) は、ℂ を実数の対として持つ
#       sagemath/_shared/complex_as_real_pairs.sage を使わず、整数 r の対 (r, 0) と対の積
#       (a,b)(c,d) = (ac-bd, ad+bc) を直接書いて確かめる。K_1 は QQ 上の不定元 K として持つ。厳密計算。
# D は bond_sum_D（σ_{M_col+1} := σ_1 で延長した和）、和の各項は site_pauli の積を別に作って足す。
# ---------------------------------------------------------
load("_prelude.sage")

def incl(r):
    """inclusion_rr_to_cc: r_C := (r, 0)。"""
    return (r, 0)

def pair_mul(z, w):
    """definition_of_cc の積 (a,b)(c,d) = (ac - bd, ad + bc)。"""
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])

def pair_sum(zs):
    acc = zs[0]
    for w in zs[1:]:
        acc = (acc[0] + w[0], acc[1] + w[1])
    return acc

RK.<K> = PolynomialRing(QQ)
count = 0
for M_col in range(1, 8):
    N = 2 ** M_col
    sz = [None] + [site_pauli('z', k, M_col) for k in range(1, M_col + 1)]
    sz_ext = sz + [sz[1]]
    plus = {m: (m + 1 if m <= M_col - 1 else 1) for m in range(1, M_col + 1)}
    for m in range(1, M_col + 1):
        assert sz_ext[m + 1] == sz[plus[m]]                      # σ_{m+1} = σ_{m^+}
    D = bond_sum_D(M_col)
    terms = {m: sz_ext[m] * sz_ext[m + 1] for m in range(1, M_col + 1)}
    terms_plus = {m: sz[m] * sz[plus[m]] for m in range(1, M_col + 1)}
    # D は対角行列
    for k in range(N):
        for l in range(N):
            if k == l:
                continue
            chain = [D[k, l],
                     sum(terms[m][k, l] for m in range(1, M_col + 1)),
                     sum(terms_plus[m][k, l] for m in range(1, M_col + 1)),
                     sum(0 for m in range(1, M_col + 1)),
                     0]
            assert all(x == chain[0] for x in chain)
            KD_chain = [(K * D)[k, l], K * D[k, l], K * 0, 0]
            assert all(x == KD_chain[0] for x in KD_chain)
            count += 1
    # D の対角成分
    for mu in row_configurations(M_col):
        k = nu_number(iota(mu)) - 1
        assert k == ord_number(mu) - 1
        mu_ext = list(mu) + [mu[0]]                               # μ(M_col+1) := μ(1)
        for m in range(1, M_col + 1):
            assert mu_ext[m] == mu[plus[m] - 1]                   # μ(m+1) = μ(m^+)
        line1 = D[k, k]
        line2 = sum(terms[m][k, k] for m in range(1, M_col + 1))
        line3 = sum(terms_plus[m][k, k] for m in range(1, M_col + 1))
        # 第四行: μ(m)_C μ(m^+)_C を対の積で作り、和を対の和で取る
        line4 = pair_sum([pair_mul(incl(mu[m - 1]), incl(mu[plus[m] - 1])) for m in range(1, M_col + 1)])
        line5 = pair_sum([incl(mu[m - 1] * mu[plus[m] - 1]) for m in range(1, M_col + 1)])
        line6 = incl(sum(mu[m - 1] * mu[plus[m] - 1] for m in range(1, M_col + 1)))
        line7 = incl(sum(mu_ext[m - 1] * mu_ext[m] for m in range(1, M_col + 1)))
        line8 = incl(bond_count(mu))
        assert line1 == line2 == line3
        assert (line3, 0) == line4 == line5 == line6 == line7 == line8
        KD_diag = [(K * D)[k, k], K * D[k, k], K * bond_count(mu)]
        assert all(x == KD_diag[0] for x in KD_diag)
        count += 1
print(f"checked {count} entries (M_col = 1..7)")
print("RESULT: PASS")

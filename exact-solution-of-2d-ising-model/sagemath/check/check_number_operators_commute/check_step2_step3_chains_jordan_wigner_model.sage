# 対象ラベル: check_number_operators_commute
# Step 2 の 10 個の等号の鎖（X ∈ {ψ̌_μ^†, ψ̌_{M+1-μ}} の両方）と Step 3 の 7 個の等号の鎖を、括弧どおりに一行ずつ厳密に確かめる
#（M = 2, 3, 4、μ ≠ ν の全組）。
#   D_μ := ψ̌_μ^†、P_μ := ψ̌_{M+1-μ}、n_μ := D_μ P_μ（def_check_number_operator）。
# 鎖が使う仮定は Step 1 の XW = -(WX) と (1) だけなので、それを満たす具体的な行列として Jordan–Wigner のフェルミ演算子 c_μ を取り、
# D_μ := c_μ^T、P_μ := c_μ とする。本物の ψ̌ で同じ鎖を確かめるのは check_with_check_psi.sage である。
# 否定コントロール: 仮定を満たさない不定元の成分の行列では、仮定を使う行（Step 2 の 2 行、Step 3 の 2 行）だけが等号を外れ、
# 結合律・符号の外出し・二重の符号反転の行は等号のまま残ることを確かめる。
# 帰属: 成分は QQ と、QQ 上の多項式環（厳密計算）。
# 由来: 2026-11-04 まで 050_claim_even_sector_eigenvalues/check_23 の後半（check_number_operator_idempotent (3) の鎖は
#       ../check_number_operator_idempotent/check_part3_chain_jordan_wigner_model.sage へ分けた）。中身は変えていない。
load("_chains.sage")

for M in range(2, 5):
    Id, D, P = jordan_wigner_model(M)
    for mu in range(M):
        for nu in range(M):
            if nu == mu:
                continue
            for A in (D[mu], P[mu]):
                check_chain_lines(commute_step2_chain(A, D[nu], P[nu]), ("step2", M, mu, nu))
            check_chain_lines(commute_step3_chain(D[mu], P[mu], D[nu], P[nu]), ("step3", M, mu, nu))

# 否定コントロール: 不定元の成分の 2×2 行列（仮定を満たさない）
R = PolynomialRing(QQ, ["x%d" % k for k in range(16)])
xs = R.gens()
X = matrix(R, 2, 2, xs[0:4])
Y = matrix(R, 2, 2, xs[4:8])
Z = matrix(R, 2, 2, xs[8:12])
W = matrix(R, 2, 2, xs[12:16])
neg_control = 0
for lines, label in [(commute_step2_chain(X, Y, Z), "step2"),
                     (commute_step3_chain(X, Y, Z, W), "step3")]:
    check_chain_lines(lines, ("generic", label), False)
    for (a, A, _), (b, B, hyp) in zip(lines, lines[1:]):
        if hyp:
            assert A != B, ("仮定を使う行が仮定なしで成り立ってしまう", label, a, b)
            neg_control += 1

print("PASS check_number_operators_commute Step 2・Step 3 の鎖: %d 段、否定コントロール %d 行" % (chain_count, neg_control))
print("RESULT: PASS")

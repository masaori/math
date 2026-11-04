# 対象ラベル: check_number_operator_idempotent
# (3) の 24 行の鎖（23 個の等号。先頭 4 個は def_exp (1) の冪を積へ運ぶ）を、括弧どおりに一行ずつ厳密に確かめる（M = 2, 3, 4）。
#   D_μ := ψ̌_μ^†、P_μ := ψ̌_{M+1-μ}、n_μ := D_μ P_μ（def_check_number_operator）。
# 鎖が使う仮定は (1) D_μD_μ = O・P_μP_μ = O と (2) P_μD_μ = I - n_μ だけなので、
# それを満たす具体的な行列として Jordan–Wigner のフェルミ演算子 c_μ を取り、D_μ := c_μ^T、P_μ := c_μ とする。
# 本物の ψ̌ で同じ鎖を確かめるのは check_with_check_psi.sage である。
# 否定コントロール: 仮定を満たさない不定元の成分の行列では、仮定を使う行（(2) と (1) の第 1 式の 2 行）だけが等号を外れ、
# 結合律・分配律・単位行列・符号の外出し・差の書き換えの行は等号のまま残ることを確かめる。
# 帰属: 成分は QQ と、QQ 上の多項式環（厳密計算）。
# 由来: 2026-11-04 まで 050_claim_even_sector_eigenvalues/check_23 の前半（check_number_operators_commute の Step 2・Step 3 の鎖は
#       ../check_number_operators_commute/check_step2_step3_chains_jordan_wigner_model.sage へ分けた）。中身は変えていない。
load("_chains.sage")

for M in range(2, 5):
    Id, D, P = jordan_wigner_model(M)
    for i in range(M):
        for j in range(M):
            assert D[i] * P[j] + P[j] * D[i] == (Id if i == j else 0 * Id)
            assert D[i] * D[j] + D[j] * D[i] == 0 * Id
            assert P[i] * P[j] + P[j] * P[i] == 0 * Id
    for mu in range(M):
        check_chain_lines(idempotent_chain(D[mu], P[mu], Id), ("idem", M, mu), True)

# 否定コントロール: 不定元の成分の 2×2 行列（仮定を満たさない）
R = PolynomialRing(QQ, ["x%d" % k for k in range(8)])
xs = R.gens()
X = matrix(R, 2, 2, xs[0:4])
Y = matrix(R, 2, 2, xs[4:8])
IdR = identity_matrix(R, 2)
lines = idempotent_chain(X, Y, IdR)
check_chain_lines(lines, ("generic", "idem"), False)
neg_control = 0
for (a, A, _), (b, B, hyp) in zip(lines, lines[1:]):
    if hyp:
        assert A != B, ("仮定を使う行が仮定なしで成り立ってしまう", a, b)
        neg_control += 1

print("PASS check_number_operator_idempotent (3) の鎖: %d 段、否定コントロール %d 行" % (chain_count, neg_control))
print("RESULT: PASS")

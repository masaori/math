# 対象ラベル: distinct_site_pauli_matrices_commute
# 準備の表示 σ_j^a = x_1⊠⋯⊠x_M、σ_k^b = y_1⊠⋯⊠y_M、各 i の y_ix_i = x_iy_i の 3 つの場合の鎖（4 行・4 行・2 行）、
# 主張の 3 行の鎖 σ_j^aσ_k^b = (⊠x)(⊠y) = (⊠y)(⊠x) = σ_k^bσ_j^a を、M = 2, 3, 4、j ≠ k、a, b ∈ {x, y, z} の全てで確かめる。
# 積は mat_mult の成分の式（body_product）、クロネッカー積は def_kronecker (2) の成分の式と Sage の tensor_product の一致を見てから使う。
# 対照: j = k かつ σ^a, σ^b が反可換（a ≠ b）なら、i = j = k の場合の鎖が崩れ、主張の両辺も一致しない。
load("_prelude.sage")

steps = 0
cases = 0
for M in [2, 3, 4]:
    for j in range(1, M + 1):
        for k in range(1, M + 1):
            if j == k:
                continue
            for a in "xyz":
                for b in "xyz":
                    xs = [PAULI[a] if i == j else I2 for i in range(1, M + 1)]
                    ys = [PAULI[b] if i == k else I2 for i in range(1, M + 1)]
                    assert site(M, j, a) == kron(xs) and site(M, k, b) == kron(ys)   # 準備の表示
                    for i in range(1, M + 1):
                        x, y = xs[i - 1], ys[i - 1]
                        if i == j:
                            ln = [body_product(y, x), body_product(I2, PAULI[a]), PAULI[a], body_product(PAULI[a], I2), body_product(x, y)]
                        elif i == k:
                            ln = [body_product(y, x), body_product(PAULI[b], I2), PAULI[b], body_product(I2, PAULI[b]), body_product(x, y)]
                        else:
                            ln = [body_product(y, x), body_product(I2, I2), body_product(x, y)]
                        check_chain(ln, f"M={M} j={j} k={k} a={a} b={b} i={i}")
                        steps += len(ln) - 1
                    X, Y = kron(xs), kron(ys)
                    ln = [body_product(site(M, j, a), site(M, k, b)), body_product(X, Y), body_product(Y, X),
                          body_product(site(M, k, b), site(M, j, a))]
                    check_chain(ln, f"M={M} j={j} k={k} a={a} b={b}")
                    steps += 3
                    cases += 1
# 対照
neg = 0
for M in [2, 3]:
    for j in range(1, M + 1):
        for a, b in [("x", "y"), ("y", "z"), ("z", "x")]:
            x, y = PAULI[a], PAULI[b]
            assert body_product(y, x) != body_product(x, y)
            assert body_product(site(M, j, a), site(M, j, b)) != body_product(site(M, j, b), site(M, j, a))
            neg += 1
print(f"  {cases} 組（M = 2, 3, 4、j ≠ k、a, b ∈ {{x, y, z}}）、{steps} 段が成り立つ")
print(f"  対照 {neg} 件: j = k で σ^a, σ^b が反可換なら、場合の鎖も主張も崩れる")
print("RESULT: PASS")

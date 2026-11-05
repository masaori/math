# 対象ラベル: transpose_preserves_matrix_norm
# ‖A^⊤‖ = ‖A‖ の鎖を一行ずつ。根号の中は A の成分を QQ 上の不定元の対に置いて厳密に、
# 根号を取った値は実代数的数 AA の具体の行列で厳密に確かめる。浮動小数点は使わない。
load("_prelude.sage")


def radicands(A):
    """鎖の各行の根号の中を、その行に書かれた式どおりに組む。"""
    n = len(A)
    At = body_transpose(A)
    return [
        sum(abs2(At[k][l]) for k in range(n) for l in range(n)),   # Σ_kΣ_l |(A^⊤)_kl|^2  (def_matrix_norm)
        sum(abs2(A[l][k]) for k in range(n) for l in range(n)),    # Σ_kΣ_l |A_lk|^2      (def_matrix_transpose)
        sum(abs2(A[l][k]) for l in range(n) for k in range(n)),    # Σ_lΣ_k |A_lk|^2      (順序の入れ替え)
        sum(abs2(A[i][j]) for i in range(n) for j in range(n)),    # Σ_iΣ_j |A_ij|^2 = ‖A‖^2 の中 (def_matrix_norm)
    ]


count = 0
for n in SIZES:
    P, (A,) = generic_pairs(n, ["A"])
    r = radicands(A)
    for t in range(len(r) - 1):
        assert r[t] == r[t + 1], (n, t)
        count += 1
print(f"根号の中の 3 個の等号を不定元で確かめた（n = 1,…,4、{count} 段）")

set_random_seed(37)
for n in SIZES:
    for _ in range(4):
        gA = matrix(K, n, n, lambda r_, s: K(QQ.random_element(8, 8)) + i_K * K(QQ.random_element(8, 8)))
        A = to_pairs(gA)
        lines = [AA(q).sqrt() for q in radicands(A)]
        for t in range(len(lines) - 1):
            assert lines[t] == lines[t + 1]
        assert lines[0] == frob(gA.transpose()) and lines[-1] == frob(gA)
print("具体の QQ(i) の行列（n = 1,…,4、各 4 個）で、鎖の 3 個の等号と両端の Sage の値（transpose と QQbar の abs）との一致を AA で確かめた")

# 否定コントロール: 転置に加えて成分を 2 倍すると、ノルムは ‖A‖ と変わる（検査が値の違いを見分けること）。
gA = matrix(K, 2, 2, [1 + i_K, 2, 0, 3 * i_K])
assert frob(2 * gA.transpose()) != frob(gA)
# 転置の定義を (A^⊤)_{kl} := A_{kk} と取り違えると鎖の 1→2 行目が成り立たない（n = 2 の不定元で）
P, (A,) = generic_pairs(2, ["A"])
wrong = sum(abs2(A[k][k]) for k in range(2) for l in range(2))
assert wrong != radicands(A)[1]
print("否定コントロール 2 件: 2A^⊤ のノルムは ‖A‖ と違う。転置を対角成分と取り違えると 1→2 行目が成り立たない")
print("RESULT: PASS")

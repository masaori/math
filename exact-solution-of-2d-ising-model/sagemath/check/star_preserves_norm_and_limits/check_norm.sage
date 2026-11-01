# 対象ラベル: star_preserves_norm_and_limits
# (2) ‖A^*‖ = ‖A‖ の鎖を一行ずつ。根号の中（|·|^2 の有限和）は A の成分を QQ 上の不定元の対に置いて厳密に、
# 根号を取った値は実代数的数 AA の具体の行列で厳密に確かめる。|z|^2 は abs_basic_properties (2) の x^2 + y^2、
# |z| は abs_basic_properties (1) の √(x^2+y^2)（_shared の cc_abs_aa）。浮動小数点は使わない。
load("_prelude.sage")


def abs2(z):
    return z[0]^2 + z[1]^2


def radicands(A):
    """(2) の鎖の各行の根号の中を、その行に書かれた式どおりに組む。"""
    n = len(A)
    As = body_star(A)
    return [
        sum(abs2(As[k][l]) for k in range(n) for l in range(n)),            # Σ_kΣ_l |(A^*)_kl|^2   (def_matrix_norm)
        sum(abs2(cc_conj(A[l][k])) for k in range(n) for l in range(n)),    # Σ_kΣ_l |conj A_lk|^2  (def_hermitian_positive_definite)
        sum(abs2(A[l][k]) for k in range(n) for l in range(n)),             # Σ_kΣ_l |A_lk|^2       (abs_of_complex_conjugate)
        sum(abs2(A[l][k]) for l in range(n) for k in range(n)),             # Σ_lΣ_k |A_lk|^2       (順序の入れ替え)
        sum(abs2(A[i][j]) for i in range(n) for j in range(n)),             # Σ_iΣ_j |A_ij|^2 = ‖A‖^2 の中 (def_matrix_norm)
    ]


for n in SIZES:
    P, _, (A,) = generic_pairs(n, ["A"])
    r = radicands(A)
    for t in range(len(r) - 1):
        assert r[t] == r[t + 1], (n, t)
    print(f"n = {n}: 根号の中の 4 個の等号を不定元で確かめた")

set_random_seed(29)
for n in SIZES:
    for _ in range(4):
        gA = matrix(K, n, n, lambda r_, s: K(QQ.random_element(8, 8)) + i_K * K(QQ.random_element(8, 8)))
        A = [[(QQ(gA[r_, s].real()), QQ(gA[r_, s].imag())) for s in range(n)] for r_ in range(n)]
        lines = [AA(q).sqrt() for q in radicands(A)]
        for t in range(len(lines) - 1):
            assert lines[t] == lines[t + 1]
        # 根号の中の各項 |·|^2 が cc_abs_aa の 2 乗（abs_basic_properties (1)(2)）と一致すること
        As = body_star(A)
        assert all(cc_abs_aa(As[k][l])^2 == AA(As[k][l][0]^2 + As[k][l][1]^2) for k in range(n) for l in range(n))
        # 比べる側: QQbar の abs で組んだ Frobenius ノルム
        frob = lambda M: AA(sum(QQbar(M[k, l]).abs()^2 for k in range(n) for l in range(n))).sqrt()
        assert lines[0] == frob(gA.conjugate_transpose()) and lines[-1] == frob(gA)
print("具体の QQ(i) の行列（n = 1,…,4、各 4 個）で、鎖の 4 個の等号と両端の Sage の値との一致を AA で確かめた")
print("RESULT: PASS")

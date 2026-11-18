# frobenius_inner_product_axioms Step 5 場合 1 の前提の段
#   ‖B‖ = 0 ⟹ B = O   （matrix_norm_triangle_inequality (1)（K = ℂ、A → B）の ⇒）
# を確かめる。ノルムは def_matrix_norm の ‖B‖ = √(Σ_{i=1}^{n}Σ_{j=1}^{n} |b_ij|²)。
# ℂ の元はガウス有理数体 QQ[i]、平方根は代数的実数 AA で厳密に扱う（浮動小数点は使わない）。
K.<i> = QuadraticField(-1)

def norm(B):                                           # def_matrix_norm (K = ℂ)
    s = sum(QQ(B[r, c].norm()) for r in range(B.nrows()) for c in range(B.ncols()))   # |b|² = b·conj(b)
    return AA(s).sqrt()

count = 0
vals = [K(0), K(1), K(-1), i, -i, 1 + i]
# n = 1, 2 で成分を vals から全て選び、‖B‖ = 0 ⟺ B = O を確かめる（⇒ が場合 1 で使う向き）
for n in [1, 2]:
    for entries in cartesian_product([vals]*(n*n)):
        B = matrix(K, n, n, list(entries))
        isO = (B == matrix(K, n, n, 0))
        nz = (norm(B) == 0)
        assert nz == isO, (n, B)
        assert norm(B) >= 0                            # (1) の ‖B‖ ≥ 0
        count += 2
# n = 3, 4 は乱数の B と零行列で
set_random_seed(1407)
for n in [3, 4]:
    assert norm(matrix(K, n, n, 0)) == 0; count += 1
    for trial in range(20):
        B = matrix(K, n, n, lambda r, c: K(QQ.random_element(num_bound=3)) + K(QQ.random_element(num_bound=3))*i)
        assert (norm(B) == 0) == (B == matrix(K, n, n, 0)); count += 1

# 否定コントロール 1 件: |b|² を共役なしの b² に替えた和は、B = [[1, i], [0, 0]] で 0 になるが B ≠ O。
# ‖B‖ = 0 ⟹ B = O は def_matrix_norm の |b_ij|² ≥ 0 に依ることを表す。同じ B で ‖B‖ ≠ 0 も確かめる（正の判定）
neg = 0
B = matrix(K, 2, 2, [K(1), i, K(0), K(0)])
assert sum(B[r, c]^2 for r in range(2) for c in range(2)) == 0 and B != 0; neg += 1
assert norm(B) != 0; count += 1

print("check_cauchy_schwarz_case1_norm_zero_gives_zero_matrix: %d 判定 PASS（否定コントロール %d 件）" % (count, neg))

# frobenius_inner_product_axioms Step 4 の後の同値の鎖
#   ⟨A,A⟩ = 0_ℂ ⟺ (‖A‖²)_ℂ = 0_ℂ ⟺ (‖A‖²)_ℂ = (0)_ℂ ⟺ ‖A‖² = 0 ⟺ ‖A‖‖A‖ = 0 ⟺ ‖A‖ = 0 ⟺ A = O
# を 1 段ずつ確かめる。各段の両辺の真偽が一致すること、各段の根拠（ι の値・単射性、r² = rr、
# 0 でない実数どうしの積は 0 でない、x·0 = 0、‖A‖ = 0 ⟺ A = O）をその段の値で確かめる。
# ℂ の元はガウス有理数体 QQ[i]、‖A‖ は代数的実数体 AA で厳密に扱う（浮動小数点は使わない）。
K.<i> = QuadraticField(-1)
def iota(r):                           # inclusion_rr_to_cc: r ↦ (r, 0)
    z = K(r)
    assert tuple(z.vector()) == (QQ(r), 0)
    return z
def inner(A, B):                       # def_frobenius_inner_product: ⟨A,B⟩ = tr(A^* B)
    return (A.conjugate_transpose()*B).trace()
def norm(A):                           # def_matrix_norm (K = ℂ): √(Σ_iΣ_j |a_ij|²)、|a_ij| は QQbar の絶対値
    n = A.nrows()
    return AA(sum(QQbar(K.embeddings(QQbar)[0](A[r, c])).abs()**2 for r in range(n) for c in range(n))).sqrt()

set_random_seed(1405)
def rnd():
    return K(QQ.random_element(num_bound=9, den_bound=5)) + K(QQ.random_element(num_bound=9, den_bound=5))*i
zeroC = K(0)
assert tuple(zeroC.vector()) == (0, 0) and zeroC == iota(0)   # 0_ℂ = ι(0) = (0)_ℂ（inclusion_rr_to_cc の略記 r → 0）。値 (0,0) も確かめる
samples = []
for n in [1, 2, 3]:
    samples.append(matrix(K, n, n, 0))                          # A = O
    for trial in range(5):
        samples.append(matrix(K, n, n, lambda r, c: rnd()))
    for (r0, c0) in sorted(set([(0, 0), (n - 1, 0)])):          # 成分が 1 つだけ 0 でない行列
        E = matrix(K, n, n, 0); E[r0, c0] = rnd() or K(1)
        samples.append(E)
count = 0
true_count = 0
false_count = 0
for A in samples:
    n = A.nrows()
    nA = norm(A)
    sq = QQ(nA**2)                                              # ‖A‖² ∈ ℝ（Step 4 の鎖で有理数）
    assert inner(A, A) == iota(sq)                              # 上の鎖の ⟨A,A⟩ = (‖A‖²)_ℂ
    lines = [inner(A, A) == zeroC,
             iota(sq) == zeroC,
             iota(sq) == iota(0),
             sq == 0,
             nA*nA == 0,
             nA == 0,
             A == matrix(K, n, n, 0)]
    for k in range(1, len(lines)):
        assert lines[k] == lines[k-1], (n, k)
        count += 1
    # 段ごとの根拠
    assert (iota(sq) == iota(0)) == (sq == 0)                   # 単射性（⇒）と ι を施すこと（⇐）
    assert AA(sq) == nA**2 == nA*nA                             # square_of_real_number_is_product (r → ‖A‖)
    if nA != 0:
        assert nA*nA != 0                                       # real_product_of_nonzero_is_nonzero (a, b → ‖A‖)
    else:
        assert nA*0 == 0 and nA*nA == nA*0                      # 右の因子へ ‖A‖ = 0 を代入して real_times_zero_is_zero
    assert (nA == 0) == (A == 0)                                # matrix_norm_triangle_inequality (1)
    if lines[0]:
        true_count += 1
    else:
        false_count += 1
assert true_count > 0 and false_count > 0                       # 両方の向きの標本を踏む
# 否定コントロール: 共役を落とした Σ a_ij a_ij = 0 は A = O と同値でない（B = [[1, i], [0, 0]] で 1 + i² = 0）
B = matrix(K, 2, 2, [1, i, 0, 0])
assert sum(B[r, c]*B[r, c] for r in range(2) for c in range(2)) == 0 and B != 0
assert inner(B, B) != zeroC
# 否定コントロール: 零因子のある環 ℤ/4ℤ では 2·2 = 0 かつ 2 ≠ 0 なので、
# real_product_of_nonzero_is_nonzero の段（‖A‖‖A‖ = 0 ⇒ ‖A‖ = 0）は実数の性質に依っている
def product_step(x):                   # 鎖の「‖A‖‖A‖ = 0 ⟺ ‖A‖ = 0」の段と同じ判定
    return (x*x == 0) == (x == 0)
assert all(product_step(norm(A)) for A in samples)
R4 = Integers(4)
assert not product_step(R4(2))                                  # 2·2 = 0 かつ 2 ≠ 0 で、この段は偽になる
print("判定した同値の段の数:", count, "真の標本:", true_count, "偽の標本:", false_count, "否定コントロールの数:", 2)
print("ALL PASS")

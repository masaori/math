# 対象ラベル: Z_Y_generate_algebra
# Step 1 の鎖を一行ずつ確かめる。
# (1) 第 1 式 σ^xσ^x = I_{Mat(2,C)}（pauli_matrix_products を引く 1 行）。
# (2) 第 2 式 σ^yσ^z = iσ^x の 14 行（mat_mult の和の形・complex_zero_times_is_zero・加法の単位元・積の可換律・
#     multiply_by_minus_one・double_negation_in_cc・積の単位元・def_matrix_scalar_multiple・1 行目と最後の行の def_pauli_matrices）。
# (3) 第 3 式 σ^x = (-i)(σ^yσ^z) の 4 行（scalar_multiple_by_one・negative_i_times_i_is_one_in_cc・
#     scalar_multiple_is_associative・第 2 式）。negative_i_times_i_is_one_in_cc の鎖そのものはその主張の検算が確かめる。
#     ここではその結論 (-i)i = 1_C だけを使う。
# (4) 第 4 式 σ_k^aσ_k^b = I⊠…⊠(σ^aσ^b)⊠…⊠I の 3 行を、全ての a, b ∈ {x,y,z}、M = 1, 2, 3、k で。
#     σ_k^a はクロネッカー積を使わず、成分 (σ_k^a)_{s,t} = (σ^a)_{s_k,t_k} ∏_{j≠k} δ_{s_j,t_j} から独立に組み立てる。
# (5) σ_k^xσ_k^x = I_{Mat(2^M,C)} の 3 行と σ_k^x = (-i)(σ_k^yσ_k^z) の 4 行を、M = 1, 2, 3 と全ての k で。
# (6) 引いた distinct_site_pauli_matrices_commute の場合 σ_k^aσ_l^b = σ_l^bσ_k^a（k ≠ l）を M = 2, 3 で。
# 行列は QQ(i) 上で厳密に計算する。浮動小数点なし。
import sys

n_check = 0
n_fail = 0
def check(ok, label):
    global n_check, n_fail
    n_check += 1
    if not ok:
        n_fail += 1
    print(("PASS " if ok else "FAIL ") + label)

def chain_check(lines, name):
    for k in range(len(lines) - 1):
        check(lines[k] == lines[k + 1], f"{name} 第 {k+1} 行 = 第 {k+2} 行")

K0.<i> = QuadraticField(-1)
one = K0(1); zero = K0(0); m1 = K0(-1)
I2 = identity_matrix(K0, 2)
sx = matrix(K0, [[0, 1], [1, 0]])
sy = matrix(K0, [[0, -i], [i, 0]])
sz = matrix(K0, [[1, 0], [0, -1]])
pauli = dict(x=sx, y=sy, z=sz)

def neg(z):  # multiply_by_minus_one: -z := (-1_C) z
    return m1 * z

def kron(mats):  # def_kronecker: A_1 ⊠ … ⊠ A_M（Sage の tensor_product は第 1 因子が最上位の桁）
    out = mats[0]
    for m in mats[1:]:
        out = out.tensor_product(m)
    return out

def digits(M, s):
    return [(s >> (M - 1 - j)) & 1 for j in range(M)]

def sigma_site_entrywise(M, k, name):  # def_site_pauli_matrices の σ_k^a を成分から（k は 0 始まり）
    a = pauli[name]
    def entry(s, t):
        ds, dt = digits(M, s), digits(M, t)
        if any(ds[j] != dt[j] for j in range(M) if j != k):
            return K0(0)
        return a[ds[k], dt[k]]
    return matrix(K0, 2^M, 2^M, entry)

def at_site(M, k, e):  # I⊠…⊠e(第 k 因子)⊠…⊠I
    return kron([e if j == k else I2 for j in range(M)])

# (1) 第 1 式
check(sx * sx == I2, "第 1 式: σ^xσ^x = I_Mat(2,C)")

# (2) 第 2 式の 14 行
neg_i = neg(i)
lines = [
    sy * sz,
    matrix(K0, [[0, neg_i], [i, 0]]) * matrix(K0, [[1, 0], [0, m1]]),
    matrix(K0, [[zero * one + neg_i * zero, zero * zero + neg_i * m1],
                [i * one + zero * zero, i * zero + zero * m1]]),
    matrix(K0, [[zero + neg_i * zero, zero + neg_i * m1], [i * one + zero, i * zero + zero]]),
    matrix(K0, [[neg_i * zero, neg_i * m1], [i * one, i * zero]]),
    matrix(K0, [[zero * neg_i, m1 * neg_i], [i * one, i * zero]]),
    matrix(K0, [[zero, m1 * neg_i], [i * one, i * zero]]),
    matrix(K0, [[zero, neg(neg_i)], [i * one, i * zero]]),
    matrix(K0, [[zero, i], [i * one, i * zero]]),
    matrix(K0, [[zero * i, i], [i * one, i * zero]]),
    matrix(K0, [[i * zero, i], [i * one, i * zero]]),
    matrix(K0, [[i * zero, i * one], [i * one, i * zero]]),
    i * matrix(K0, [[0, 1], [1, 0]]),
    i * sx,
]
chain_check(lines, "第 2 式 σ^yσ^z")
# mat_mult の行は、2 次の行列の積の成分 Σ_j A_{rj}B_{jc} を 2 項に開いた形であること
A_ = matrix(K0, [[0, neg_i], [i, 0]]); B_ = matrix(K0, [[1, 0], [0, m1]])
check(all((A_ * B_)[r, c] == A_[r, 0] * B_[0, c] + A_[r, 1] * B_[1, c] for r in range(2) for c in range(2)),
      "第 2 式の 2 行目の根拠: mat_mult の成分の和")
check(zero * one == zero and zero * zero == zero and zero * m1 == zero,
      "第 2 式の 3 行目の根拠: complex_zero_times_is_zero (z → 1, 0, -1)")
check(zero + neg_i * zero == neg_i * zero and i * one + zero == i * one, "第 2 式の 4 行目の根拠: 加法の単位元")
check(neg_i * zero == zero * neg_i and neg_i * m1 == m1 * neg_i, "第 2 式の 5 行目の根拠: 積の可換律")
check(zero * neg_i == zero, "第 2 式の 6 行目の根拠: complex_zero_times_is_zero (z → -i)")
check(m1 * neg_i == neg(neg_i), "第 2 式の 7 行目の根拠: multiply_by_minus_one (z → -i)")
check(neg(neg_i) == i, "第 2 式の 8 行目の根拠: double_negation_in_cc (z → i)")
check(zero * i == zero and i * zero == zero * i and i * one == i,
      "第 2 式の 9〜11 行目の根拠: 0_C z = 0_C、積の可換律、積の単位元")

# (3) 第 3 式の 4 行
check(neg_i * i == one, "根拠 negative_i_times_i_is_one_in_cc: (-i)i = 1_C")
lines = [
    sx,
    one * sx,
    (neg_i * i) * sx,
    neg_i * (i * sx),
    neg_i * (sy * sz),
]
chain_check(lines, "第 3 式 σ^x")

# (4) 第 4 式の 3 行
for M in (1, 2, 3):
    for k in range(M):
        for a in "xyz":
            for b in "xyz":
                A, B = pauli[a], pauli[b]
                lines = [
                    sigma_site_entrywise(M, k, a) * sigma_site_entrywise(M, k, b),
                    at_site(M, k, A) * at_site(M, k, B),
                    kron([A * B if j == k else I2 * I2 for j in range(M)]),
                    kron([A * B if j == k else I2 for j in range(M)]),
                ]
                chain_check(lines, f"第 4 式 M={M} k={k+1} a={a} b={b}")

# (5) σ_k^xσ_k^x と σ_k^x の鎖
for M in (1, 2, 3):
    IM = identity_matrix(K0, 2^M)
    for k in range(M):
        lines = [
            sigma_site_entrywise(M, k, "x") * sigma_site_entrywise(M, k, "x"),
            at_site(M, k, sx * sx),
            at_site(M, k, I2),
            IM,
        ]
        chain_check(lines, f"σ_k^xσ_k^x M={M} k={k+1}")
        lines = [
            sigma_site_entrywise(M, k, "x"),
            at_site(M, k, sx),
            at_site(M, k, neg_i * (sy * sz)),
            neg_i * at_site(M, k, sy * sz),
            neg_i * (sigma_site_entrywise(M, k, "y") * sigma_site_entrywise(M, k, "z")),
        ]
        chain_check(lines, f"σ_k^x M={M} k={k+1}")

# (6) 異サイトの可換性（引いた主張の場合）
for M in (2, 3):
    for k in range(M):
        for l in range(M):
            if k == l:
                continue
            for a in "xyz":
                for b in "xyz":
                    X = sigma_site_entrywise(M, k, a); Y = sigma_site_entrywise(M, l, b)
                    check(X * Y == Y * X, f"異サイトの可換性 M={M} k={k+1} l={l+1} a={a} b={b}")

# 否定の対照（人手の行の書き間違いを入れると落ちること）
check(sy * sz != neg_i * sx, "否定の対照: 第 2 式の係数を -i にすると成り立たない")
check(sx != i * (sy * sz), "否定の対照: 第 3 式の係数を i にすると成り立たない")
check(neg_i * m1 != neg_i, "否定の対照: (-i)(-1) を -i と読み違えると 5 行目以降が成り立たない")
check(sigma_site_entrywise(2, 0, "y") * sigma_site_entrywise(2, 0, "z") != at_site(2, 1, sy * sz),
      "否定の対照: 第 4 式の積の因子を別のサイトに置くと成り立たない")
check(sigma_site_entrywise(2, 0, "y") * sigma_site_entrywise(2, 0, "z")
      != sigma_site_entrywise(2, 0, "z") * sigma_site_entrywise(2, 0, "y"),
      "否定の対照: 同じサイトの σ^y と σ^z は可換ではない")

print(f"-- Z_Y_generate_algebra の Step 1 の鎖: {n_check - n_fail}/{n_check} PASS")
if n_fail:
    print("RESULT: FAIL")
    sys.exit(1)
print("RESULT: PASS")

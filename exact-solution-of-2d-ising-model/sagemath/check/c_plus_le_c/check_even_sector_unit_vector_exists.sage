# 対象ラベル: c_plus_le_c（証明が引く「R_+ は空でない」。def_sector_rayleigh_sup の後半の構成）
#   a_+ := (1/√2, 1/√2) ∈ R^2,  b_+ := ι^2(a_+) ∈ C^2
#   σ^x b_+ = ((b_+)_2, (b_+)_1) = ((b_+)_1, (b_+)_2) = b_+
#   (x^{(+)})_{ν(I)} := Π_k (a_+)_{i_k} ∈ R（各成分 (1/√2)^M = 2^{-M/2}）
#   (ι(x^{(+)}))_{ν(I)} = ((x^{(+)})_{ν(I)})_C = (Π_k (a_+)_{i_k})_C = Π_k ((a_+)_{i_k})_C = Π_k (b_+)_{i_k} = (b_+⊠⋯⊠b_+)_{ν(I)}
#   ε ι(x^{(+)}) = (σ^x⊠⋯)ι(x^{(+)}) = (σ^x⊠⋯)(b_+⊠⋯) = (σ^x b_+)⊠⋯ = b_+⊠⋯ = ι(x^{(+)})
#   ε_ℝ x^{(+)} = x^{(+)}（ε_ℝ := ϱ(ε)。epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors の ⇐）
#   ||x^{(+)}||^2 = Σ_I (2^{-M/2})^2 = 2^M · 2^{-M} = 1
# 帰属: 実数の側は AA（実代数的数）、複素数の側は QQbar で厳密に判定する。浮動小数点を使わない。
# ι は AA → QQbar の包含 QQbar(r)、ν は def_kronecker の ν(I) = 1 + Σ(i_k - 1)2^{M-k}（0 始まりでは Σ(i_k-1)2^{M-k}）。
import itertools

r = 1 / AA(2).sqrt()
a_plus = vector(AA, [r, r])                       # ℝ^2
iota = lambda v: vector(QQbar, [QQbar(c) for c in v])
b_plus = iota(a_plus)                             # ℂ^2
sx = matrix(QQbar, [[0, 1], [1, 0]])
i2 = identity_matrix(QQbar, 2)

# σ^x b_+ の 3 行の鎖
chain = [sx * b_plus, vector(QQbar, [b_plus[1], b_plus[0]]), vector(QQbar, [b_plus[0], b_plus[1]]), b_plus]
for u, w in zip(chain, chain[1:]):
    assert u == w
assert b_plus[0] == QQbar(r) == b_plus[1]
# 否定コントロール: (1, 0) は σ^x で動く
assert sx * vector(QQbar, [1, 0]) != vector(QQbar, [1, 0])


def nu(I):
    M = len(I)
    return sum((I[k] - 1) * 2 ** (M - 1 - k) for k in range(M))


def kron_vec_by_components(vs):
    M = len(vs)
    out = [None] * 2 ** M
    for I in itertools.product([1, 2], repeat=M):
        out[nu(I)] = prod(vs[k][I[k] - 1] for k in range(M))
    return vector(vs[0].base_ring(), out)


def kron_mat(ms):
    out = matrix(QQbar, [[1]])
    for m in ms:
        out = out.tensor_product(m)
    return out


n_eq = 0
for M in [1, 2, 3, 4, 5]:
    d = 2 ** M
    # x^{(+)} の成分の定義（ℝ の有限積）
    xp = [None] * d
    for I in itertools.product([1, 2], repeat=M):
        xp[nu(I)] = prod(a_plus[i - 1] for i in I)
    xp = vector(AA, xp)
    assert all(c == r ** M for c in xp)
    assert all(c == AA(2) ** (-M / 2) for c in xp)   # (1/√2)^M = 2^{-M/2}
    assert all(c ** 2 == AA(2) ** (-M) for c in xp)
    # ι(x^{(+)}) の成分の 5 行の鎖
    bb = kron_vec_by_components([b_plus] * M)
    for I in itertools.product([1, 2], repeat=M):
        rows = [
            iota(xp)[nu(I)],
            QQbar(xp[nu(I)]),
            QQbar(prod(a_plus[i - 1] for i in I)),
            prod(QQbar(a_plus[i - 1]) for i in I),
            prod(b_plus[i - 1] for i in I),
            bb[nu(I)],
        ]
        for u, w in zip(rows, rows[1:]):
            assert u == w
            n_eq += 1
    # ε = σ^x_1⋯σ^x_M（定義）と σ^x⊠⋯⊠σ^x（引用する表示）
    eps_def = identity_matrix(QQbar, d)
    for site in range(1, M + 1):
        eps_def = eps_def * kron_mat([sx if j == site else i2 for j in range(1, M + 1)])
    eps_kron = kron_mat([sx] * M)
    assert eps_def == eps_kron
    # ε ι(x^{(+)}) の 5 行の鎖
    rows = [eps_def * iota(xp), eps_kron * iota(xp), eps_kron * bb, kron_vec_by_components([sx * b_plus] * M), bb, iota(xp)]
    for u, w in zip(rows, rows[1:]):
        assert u == w
        n_eq += 1
    # ε_ℝ := ϱ(ε)（成分がすべて実数）と ε_ℝ x^{(+)} = x^{(+)}
    assert all(c.imag() == 0 for c in eps_def.list())
    eps_R = matrix(AA, d, d, [AA(c.real()) for c in eps_def.list()])
    assert eps_R.change_ring(QQbar) == eps_def
    assert iota(eps_R * xp) == eps_def * iota(xp)
    assert eps_R * xp == xp
    # 否定コントロール: x^{(+)} の 1 成分の符号を変えると ε_ℝ で動く
    y = vector(AA, list(xp)); y[0] = -y[0]
    assert eps_R * y != y
    # ノルムの鎖
    norm2 = sum(c ** 2 for c in xp)
    assert norm2 == sum((AA(2) ** (-M / 2)) ** 2 for _ in range(d)) == AA(2) ** M * AA(2) ** (-M) == 1
    print(f"  M_col={M}: ι(x^(+)) = b_+⊠…⊠b_+、ε ι(x^(+)) = ι(x^(+))、ε_ℝ x^(+) = x^(+)、||x^(+)||^2 = {norm2}")

print(f"  鎖の等号 {n_eq} 個")
print("RESULT: PASS")

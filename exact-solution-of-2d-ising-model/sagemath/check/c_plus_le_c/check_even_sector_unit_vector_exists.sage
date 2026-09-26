# 対象ラベル: c_plus_le_c（証明が引く「R_+ は空でない」。def_sector_rayleigh_sup の後半の構成）
#   a_+ := (1,1)/√2,  sigma^x a_+ = a_+
#   x^{(+)} := a_+ ⊠ … ⊠ a_+（M_col 個）
#   epsilon x^{(+)} = (sigma^x ⊠ …)(a_+ ⊠ …) = (sigma^x a_+) ⊠ … = a_+ ⊠ … = x^{(+)}
#   x^{(+)} の各成分は 2^{-M_col/2}、||x^{(+)}||^2 = sum 2^{-M_col} = 1
# 帰属: 成分は QQ(√2) の元。厳密に判定し、浮動小数点を使わない。
K.<r2> = QuadraticField(2)
sx = matrix(K, [[0, 1], [1, 0]])
i2 = identity_matrix(K, 2)
a_plus = vector(K, [1, 1]) / r2
assert sx * a_plus == a_plus


def kron_vec(vs):
    out = vector(K, [1])
    for v in vs:
        out = vector(K, [x * y for x in out for y in v])
    return out


def kron_mat(ms):
    out = matrix(K, [[1]])
    for m in ms:
        out = out.tensor_product(m)
    return out


for M in [1, 2, 3, 4, 5, 6]:
    x = kron_vec([a_plus] * M)
    # epsilon = sigma^x_1 … sigma^x_M（定義）と sigma^x ⊠ … ⊠ sigma^x（引用する表示）
    eps_def = identity_matrix(K, 2 ** M)
    for site in range(1, M + 1):
        eps_def = eps_def * kron_mat([sx if j == site else i2 for j in range(1, M + 1)])
    eps_kron = kron_mat([sx] * M)
    assert eps_def == eps_kron
    chain = [eps_def * x, eps_kron * x, kron_vec([sx * a_plus] * M), kron_vec([a_plus] * M), x]
    for a, b in zip(chain, chain[1:]):
        assert a == b
    # 成分と実数性、ノルム
    assert all(c == 1 / r2 ** M for c in x)
    assert all(c in QQ or (c * r2) in QQ for c in x)   # x^{(+)} ∈ R^{2^M}（QQ(√2) ⊂ R の元）
    norm2 = sum(c ** 2 for c in x)
    assert norm2 == 2 ** M * (1 / r2 ** M) ** 2 == 1
    print(f"  M_col={M}: epsilon x^(+) = x^(+)、成分 2^(-M/2)、||x^(+)||^2 = {norm2}")

print("RESULT: PASS")

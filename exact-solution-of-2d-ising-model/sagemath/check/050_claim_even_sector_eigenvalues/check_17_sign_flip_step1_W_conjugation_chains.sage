# 対象ラベル: sign_flip_conjugation
# Step 1 の E・F による共役の鎖の先頭を一行ずつ厳密に確かめる（QQ(i) 上、M = 2, 3, 4、全ての k と a ∈ {x, y, z}）。
# (W, W_1..W_M) は (F, σ^z..σ^z) または (E, E_1..E_M)（E_m は m 奇数で σ^x、偶数で I）。WXW^{-1} は (WX)W^{-1}。
#   Wσ_k^aW^{-1}
#   = (Wσ_k^a)W                                               （Step 0 の W^{-1} = W）
#   = ((W_1⊠…⊠W_M)σ_k^a)(W_1⊠…⊠W_M)                          （W の定義）
#   = ((W_1⊠…⊠W_M)(I⊠…⊠σ^a⊠…⊠I))(W_1⊠…⊠W_M)                （def_site_pauli_matrices）
#   = ((W_1I)⊠…⊠(W_kσ^a)⊠…⊠(W_MI))(W_1⊠…⊠W_M)               （kronecker_product_rule (1)）
#   = ((W_1I)W_1)⊠…⊠((W_kσ^a)W_k)⊠…⊠((W_MI)W_M)              （kronecker_product_rule (1)）
#   = (W_1W_1)⊠…⊠((W_kσ^a)W_k)⊠…⊠(W_MW_M)                    （identity_matrix_is_right_unit_of_mat_mult）
#   = I⊠…⊠((W_kσ^a)W_k)⊠…⊠I                                  （Step 0 の W_mW_m = I）
# p ∈ {x, z}:
#   I⊠…⊠((σ^pσ^a)σ^p)⊠…⊠I
#   = (II)⊠…⊠((σ^pσ^a)σ^p)⊠…⊠(II)                            （identity_matrix_is_left_unit_of_mat_mult）
#   = ((II)I)⊠…⊠((σ^pσ^a)σ^p)⊠…⊠((II)I)                      （identity_matrix_is_right_unit_of_mat_mult）
#   = ((II)⊠…⊠(σ^pσ^a)⊠…⊠(II))(I⊠…⊠σ^p⊠…⊠I)                 （kronecker_product_rule (1)）
#   = ((I⊠…⊠σ^p⊠…⊠I)(I⊠…⊠σ^a⊠…⊠I))(I⊠…⊠σ^p⊠…⊠I)           （kronecker_product_rule (1)）
#   = (σ_k^pσ_k^a)σ_k^p                                       （def_site_pauli_matrices）
# k 偶数: I⊠…⊠((E_kσ^a)E_k)⊠…⊠I = I⊠…⊠((Iσ^a)I)⊠…⊠I = I⊠…⊠(σ^aI)⊠…⊠I = I⊠…⊠σ^a⊠…⊠I = σ_k^a
# 続けて F・E の鎖の 1 行目どうしを、Step 1 の結論 Fσ_k^aF^{-1}・Eσ_k^aE^{-1} の値（±σ_k^a）とも突き合わせる。
GAUSSIAN = QuadraticField(-1, "i")
I_ = GAUSSIAN.gen()
sx = matrix(GAUSSIAN, [[0, 1], [1, 0]])
sy = matrix(GAUSSIAN, [[0, -I_], [I_, 0]])
sz = matrix(GAUSSIAN, [[1, 0], [0, -1]])
id2 = matrix(GAUSSIAN, 2, 2, lambda k, l: 1 if k == l else 0)   # def_identity_matrix
pauli = {"x": sx, "y": sy, "z": sz}


def kron(factors):
    # def_kronecker: 多重添字 (s_1..s_M), (t_1..t_M) の成分は ∏_k (A_k)_{s_k t_k}
    M = len(factors)
    d = 2 ** M
    def entry(r, c):
        val = GAUSSIAN(1)
        for k in range(M):
            s = (r >> (M - 1 - k)) & 1
            t = (c >> (M - 1 - k)) & 1
            val *= factors[k][s, t]
        return val
    out = matrix(GAUSSIAN, d, d, entry)
    ref = matrix(GAUSSIAN, 1, 1, [1])
    for A in factors:
        ref = ref.tensor_product(A)
    assert out == ref
    return out


def at(M, k, A, other):
    return [A if m == k else other for m in range(1, M + 1)]


count = 0
for M in range(2, 5):
    Ws = {"F": [sz] * M, "E": [sx if m % 2 == 1 else id2 for m in range(1, M + 1)]}
    for name, ws in Ws.items():
        W = kron(ws)
        Winv = W.inverse()
        assert Winv == W
        for k in range(1, M + 1):
            for a, sa in pauli.items():
                sig = kron(at(M, k, sa, id2))
                wk = ws[k - 1]
                chainA = [
                    (W * sig) * Winv,
                    (W * sig) * W,
                    (kron(ws) * sig) * kron(ws),
                    (kron(ws) * kron(at(M, k, sa, id2))) * kron(ws),
                    kron([(wk * sa) if m == k else (ws[m - 1] * id2) for m in range(1, M + 1)]) * kron(ws),
                    kron([((wk * sa) * wk) if m == k else ((ws[m - 1] * id2) * ws[m - 1]) for m in range(1, M + 1)]),
                    kron([((wk * sa) * wk) if m == k else (ws[m - 1] * ws[m - 1]) for m in range(1, M + 1)]),
                    kron(at(M, k, (wk * sa) * wk, id2)),
                ]
                assert all(c == chainA[0] for c in chainA), (M, name, k, a)
                count += len(chainA) - 1
                if name == "E" and k % 2 == 0:
                    chainC = [
                        kron(at(M, k, (wk * sa) * wk, id2)),
                        kron(at(M, k, (id2 * sa) * id2, id2)),
                        kron(at(M, k, sa * id2, id2)),
                        kron(at(M, k, sa, id2)),
                        sig,
                    ]
                    assert all(c == chainC[0] for c in chainC), (M, k, a)
                    count += len(chainC) - 1
                    assert (W * sig) * W == sig
                    count += 1
                else:
                    sp = sz if name == "F" else sx
                    assert wk == sp
                    sigp = kron(at(M, k, sp, id2))
                    chainB = [
                        kron(at(M, k, (sp * sa) * sp, id2)),
                        kron(at(M, k, (sp * sa) * sp, id2 * id2)),
                        kron(at(M, k, (sp * sa) * sp, (id2 * id2) * id2)),
                        kron(at(M, k, sp * sa, id2 * id2)) * kron(at(M, k, sp, id2)),
                        (kron(at(M, k, sp, id2)) * kron(at(M, k, sa, id2))) * kron(at(M, k, sp, id2)),
                        (sigp * sig) * sigp,
                    ]
                    assert all(c == chainB[0] for c in chainB), (M, name, k, a)
                    count += len(chainB) - 1
                    # Step 1 の結論の符号: F は (−, −, +)、E（k 奇数）は (+, −, −)
                    sign = {"F": {"x": -1, "y": -1, "z": 1}, "E": {"x": 1, "y": -1, "z": -1}}[name][a]
                    assert (W * sig) * W == sign * sig
                    count += 1

# 否定コントロール: k 以外の W_m を自乗が I でない σ^xσ^y にすると、鎖の最後の段（W_mW_m = I）で落ちる
M = 2
ws = [sz, sx * sy]
W = kron(ws)
sig = kron([sz, id2])
assert (W * sig) * W != kron([(ws[0] * sz) * ws[0], id2])
print("PASS sign_flip_conjugation Step 1 の Wσ_k^aW^{-1}・(σ_k^pσ_k^a)σ_k^p・k 偶数の鎖: %d 段" % count)

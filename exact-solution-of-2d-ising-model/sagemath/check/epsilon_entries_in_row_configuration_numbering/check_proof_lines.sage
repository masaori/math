# 対象ラベル: epsilon_entries_in_row_configuration_numbering
# 証明の準備の 2 本の 3 行の含意と、場合ごとの鎖（s' = -s の 5 行、s' ≠ -s の 4 行）
#   ε_{ord(s),ord(s')} = ε_{ν(I),ν(J)} = (σ^x⊠⋯⊠σ^x)_{ν(I),ν(J)} = Π_m (σ^x)_{i_m j_m} = …
# を、M_col = 1, 2, 3, 4 の全ての (s, s') で厳密に（QQbar）確かめる。
load("_epsilon_exact.sage")

count = 0
for M in [1, 2, 3, 4]:
    E = epsilon_site_product(M)                                  # def_global_spin_flip_matrix
    K = epsilon_kronecker_form(M)                                # global_spin_flip_kronecker_form の右辺
    assert sorted(ord_(s) for s in configurations(M)) == list(range(1, 2 ** M + 1))
    for s in configurations(M):
        for t in configurations(M):                              # t が主張の s'
            I, J = iota(s), iota(t)
            for m in range(M):                                   # 準備の 2 本の 3 行の含意
                if t[m] == -s[m]:
                    assert t[m] != s[m]                          # s(m) ∈ {-1,1} なので -s(m) ≠ s(m)
                    assert I[m] != J[m]                          # def_config_basis_iso の場合分け
                    assert sigma_x[I[m] - 1, J[m] - 1] == 1      # (σ^x)_12 = (σ^x)_21 = 1
                else:
                    assert t[m] == s[m]                          # {-1,1} = {s(m), -s(m)}
                    assert I[m] == J[m]                          # def_config_basis_iso の場合分け
                    assert sigma_x[I[m] - 1, J[m] - 1] == 0      # (σ^x)_11 = (σ^x)_22 = 0
            line1 = E[ord_(s) - 1, ord_(t) - 1]                  # ε_{ord(s),ord(s')}
            assert ord_(s) == nu(I) and ord_(t) == nu(J)         # config_numbering_equals_kronecker_numbering
            line2 = E[nu(I) - 1, nu(J) - 1]                      # ε_{ν(I),ν(J)}
            line3 = K[nu(I) - 1, nu(J) - 1]                      # (σ^x⊠⋯⊠σ^x)_{ν(I),ν(J)}
            line4 = prod(sigma_x[I[m] - 1, J[m] - 1] for m in range(M))  # def_kronecker (2)
            if t == neg(s):                                      # s' = -s の鎖の 4・5 行
                line5 = prod(QQbar(1) for m in range(M))
                assert line1 == line2 == line3 == line4 == line5 == 1, (M, s, t)
            else:                                                # s' ≠ -s の鎖の 4 行目（0 の因子が在る）
                n = next(m for m in range(M) if t[m] != -s[m])
                assert sigma_x[I[n] - 1, J[n] - 1] == 0
                assert line1 == line2 == line3 == line4 == 0, (M, s, t)
            count += 1
# 否定コントロール: σ^x の代わりに単位行列を置くと（ε ではない行列）、s' = -s の成分が 0 になって外れる
M = 2
wrong = kron([identity_two] * M)
s = configurations(M)[0]
assert wrong[ord_(s) - 1, ord_(neg(s)) - 1] != 1
print(f"{count} 組の (M_col, s, s') で準備の含意と場合ごとの鎖と主張の値が一致した。否定コントロール 1 件")
print("RESULT: PASS")

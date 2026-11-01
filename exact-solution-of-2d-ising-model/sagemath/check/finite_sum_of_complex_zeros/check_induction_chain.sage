# 対象ラベル: finite_sum_of_complex_zeros
# Σ_{j=1}^{m} 0_C = 0_C の帰納法の各行（m = 1 の 1 行、m → m+1 の 6 行）を m = 1,…,9 で厳密に確かめる。
load("../../_shared/complex_as_real_pairs.sage")


def fsum_cc(zs):
    s = zs[0]
    for q in zs[1:]:
        s = cc_add(s, q)
    return s


z = iota(0, QQ)
assert fsum_cc([z]) == z
for m in range(1, 9):
    assert fsum_cc([z] * m) == z                                      # 帰納法の仮定
    lines = [
        fsum_cc([z] * (m + 1)),                                        # Σ^{m+1} 0_C
        cc_add(fsum_cc([z] * m), z),                                   # (Σ^m 0_C) + 0_C   (def_finite_sum)
        cc_add(z, z),                                                  # 0_C + 0_C        (帰納法の仮定)
        cc_add((QQ(0), QQ(0)), (QQ(0), QQ(0))),                        # (0,0) + (0,0)    (inclusion_rr_to_cc)
        (QQ(0) + QQ(0), QQ(0) + QQ(0)),                                # (0+0, 0+0)       (definition_of_cc の和)
        (QQ(0), QQ(0)),                                                # (0,0)
        z,                                                             # 0_C
    ]
    for t in range(len(lines) - 1):
        assert lines[t] == lines[t + 1], (m, t)
    assert sum([QuadraticField(-1, 'i')(0)] * (m + 1)) == 0            # 比べる側: Sage の和
print("m = 1,…,9 で帰納法の各行を確かめた")
print("RESULT: PASS")

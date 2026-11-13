# 対象ラベル: claim_perfect_matching_sign_enumeration_independent
# 本文の行: sgn(D) = epsilon(W(L_0)) = sgn(pi) = (-1)^inv(pi) in {-1,1}
# 式ペア: 各行の左辺と右辺。最後の行は (-1)^k の偶奇による値。
# 帰属: 有限集合・有限列と ZZ。浮動小数点を使わない。
if "_matching_sign_cases_ready" not in globals():
    load("sagemath/check/perfect-matching-sign/_prelude.sage")

checked = 0
for J, D, canonical in _matching_cases:
    w0 = pair_word(canonical)
    pi = word_permutation(J, w0)
    sgn_D = word_sign(w0)                      # 完全マッチングの符号の定義
    eps = permutation_sign(J, pi)              # 完全列挙の符号の定義
    k = inversion_count(tuple(pi[x] for x in J))
    power = ZZ(-1) ** k                        # 置換の符号の定義
    assert sgn_D == eps
    assert eps == power
    assert power == (ZZ(1) if k % 2 == 0 else ZZ(-1))
    assert power in (ZZ(-1), ZZ(1))
    checked += 4
# 否定の対照: 偶奇を取り違えた値とは一致しない。
for k in range(20):
    assert ZZ(-1) ** k != (ZZ(-1) if k % 2 == 0 else ZZ(1))
    checked += 1

print("PASS sign_values: %s 等式" % checked)

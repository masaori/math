# 対象ラベル: def_matching_word_sign
# 本文の行: 基準列の各位置と実際の置換
# 式ペア: pi_w(j_k) = w_k
# 帰属: 有限集合・有限列と ZZ。浮動小数点を使わない。
if "_matching_sign_cases_ready" not in globals():
    load("sagemath/check/perfect-matching-sign/_prelude.sage")

checked = 0
for J, D, canonical, L, w in _enumeration_cases:
    p = word_permutation(J, w)
    inverse = dict(zip(w, J))
    for k, x in enumerate(J):
        assert p[x] == w[k]
        assert inverse[p[x]] == x and p[inverse[x]] == x
        checked += 1

print("PASS permutation_definition: %s 等式" % checked)

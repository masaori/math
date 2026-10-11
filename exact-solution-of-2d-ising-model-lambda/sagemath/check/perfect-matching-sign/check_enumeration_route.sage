# 対象ラベル: claim_perfect_matching_enumeration_complete
# 本文の行: 先頭を合わせる隣接交換の帰納法
# 式ペア: adjacent_route(L_0,L) ends at L
# 帰属: 有限集合・有限列と ZZ。浮動小数点を使わない。
if "_matching_sign_cases_ready" not in globals():
    load("sagemath/check/perfect-matching-sign/_prelude.sage")

checked = 0
for J, D, canonical, L, w in _enumeration_cases:
    route = adjacent_route(canonical, L)
    assert route[0] == canonical and route[-1] == L
    for previous, following in zip(route, route[1:]):
        positions = [k for k in range(len(L)) if previous[k] != following[k]]
        assert len(positions) == 2 and positions[1] == positions[0] + 1
        i, j = positions
        assert previous[i] == following[j] and previous[j] == following[i]
        assert complete_word(J, pair_word(following))
        assert word_sign(pair_word(previous)) == word_sign(pair_word(following))
    checked += 1

print("PASS enumeration_route: %s 経路確認" % checked)

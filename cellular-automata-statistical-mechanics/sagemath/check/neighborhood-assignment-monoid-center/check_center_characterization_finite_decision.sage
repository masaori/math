# 対象ラベル: claim_neighborhood_assignment_monoid_center_finite_decidability
# 併せて検証: claim_neighborhood_assignment_monoid_center_characterization
# 中心の全数走査による集合そのものの一致 Z_star(V) = {O_V, I_V} と、その有限決定を検査する。
#   - 全走査で得た Z_star(V) が {O_V, I_V} に一致する
#   - 空舞台では O_V = I_V なので右辺は一元集合、|V| >= 1 では二元集合
#   - 所属の判定を「N = O_V または N = I_V」で行った結果が、全走査の判定と一致する
#   - 写像の等号は |V|^2 回の有限な所属判定で決まる
# 帰属: 有限集合、有限写像表、自然数の等号だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

decision_count = 0
membership_test_count = 0

for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    O = empty_assignment(cells)
    I = identity_assignment(cells)
    scanned = set(center(cells))
    expected = {O, I}
    assert scanned == expected, (n, scanned, expected)
    if n == 0:
        assert O == I
        assert len(expected) == 1
    else:
        assert O != I
        assert len(expected) == 2

    for N in neighborhood_assignments(cells):
        decision_count += 1
        by_scan = is_central(cells, N)
        # 特徴づけによる判定。写像の等号を |V|^2 回の所属判定へ展開して行う
        equals_O = True
        equals_I = True
        for v in cells:
            for w in cells:
                membership_test_count += 1
                if (w in N[v]) != (w in O[v]):
                    equals_O = False
                if (w in N[v]) != (w in I[v]):
                    equals_I = False
        assert equals_O == (N == O)
        assert equals_I == (N == I)
        by_characterization = equals_O or equals_I
        assert by_scan == by_characterization

print("PASS check_center_characterization_finite_decision")
print("  assignments decided:", decision_count)
print("  membership tests used for map equality:", membership_test_count)

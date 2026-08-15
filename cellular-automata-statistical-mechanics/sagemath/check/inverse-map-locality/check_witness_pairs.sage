# 対象ラベル: claim_inverse_support_not_in_neighborhood_counterexample
# 証明 (2): 本文の 10 組 (v, u, z) について、
#   - u ∉ N(v)（V∖N(v) は各 v で 2 元、10 組が V∖N(v) の全 (v,u) を尽くす）
#   - φ_u z が z の u の位置だけを入れ替えたもの
#   - 表の F^{-1}(z), F^{-1}(φ_u z) が本文の値に一致
#   - (F^{-1}(z))(v) ≠ (F^{-1}(φ_u z))(v)
# を分けて検査する。帰属: 有限集合の等号だけ。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

WITNESS_TABLE = """
0 2 00000 11111 00100 00111
0 3 00100 00111 00110 11011
1 3 00000 11111 00010 10011
1 4 00010 10011 00011 11101
2 0 00001 11001 10001 11110
2 4 00000 11111 00001 11001
3 0 00000 11111 10000 11100
3 1 10000 11100 11000 01111
4 1 00000 11111 01000 01110
4 2 01000 01110 01100 10111
"""

inv = inverse_table()
seen_pairs = set()
rows = 0
for line in WITNESS_TABLE.strip().splitlines():
    v_s, u_s, z_s, finv_z_s, flip_s, finv_flip_s = line.split()
    v, u = int(v_s), int(u_s)
    z = from_string(z_s)
    assert u in V and v in V
    assert u not in NEIGHBORHOOD[v], "u must lie outside N(v)"
    seen_pairs.add((v, u))
    # φ_u z は u の位置だけを入れ替える
    fz = flip(u, z)
    assert fz == from_string(flip_s)
    for w in V:
        assert (fz[w] != z[w]) == (w == u)
    # 表から読んだ F^{-1} の値
    assert inv[z] == from_string(finv_z_s), (v, u)
    assert inv[fz] == from_string(finv_flip_s), (v, u)
    # v の位置の値が異なる
    assert inv[z][v] != inv[fz][v], (v, u)
    rows += 1

assert rows == 10
# 各 v で V∖N(v) は 2 元、10 組がそれらを尽くす
expected_pairs = set()
for v in V:
    outside = [u for u in V if u not in NEIGHBORHOOD[v]]
    assert len(outside) == 2, v
    for u in outside:
        expected_pairs.add((v, u))
assert seen_pairs == expected_pairs

print("witness rows checked: {}; (v,u) pairs outside N(v) covered: {}".format(rows, len(seen_pairs)))
print("RESULT: PASS")

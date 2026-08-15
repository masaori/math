# 対象ラベル: claim_inverse_support_not_in_neighborhood_counterexample
# 証明 (1) の表: 32 配位 y と F y を、定義 (F y)(v) = g(y(ℓ(v)), y(v), y(r(v))) から再計算し、
# 本文に書かれた表と一致することを検査する。
# 帰属: 有限集合の等号だけ。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

# 本文の表（左 y、右 F y）を、そのままの行・列順で写す
TEXT_TABLE = """
00000 11111 01000 01011 10000 10110 11000 10010
00001 01101 01001 11001 10001 00101 11001 00001
00010 11010 01010 01110 10010 10011 11010 10111
00011 01010 01011 11110 10011 00010 11011 00110
00100 10101 01100 01001 10100 11100 11100 10000
00101 00111 01101 11011 10101 01111 11101 00011
00110 10100 01110 01000 10110 11101 11110 10001
00111 00100 01111 11000 10111 01100 11111 00000
"""
text_pairs = {}
for line in TEXT_TABLE.strip().splitlines():
    cells = line.split()
    assert len(cells) == 8
    for i in range(0, 8, 2):
        y = from_string(cells[i])
        assert y not in text_pairs, "duplicated y in text table"
        text_pairs[y] = from_string(cells[i + 1])

configurations = all_configurations()
assert len(configurations) == 32
assert set(text_pairs.keys()) == set(configurations), "text table does not list all 32 configurations"

checked = 0
for y in configurations:
    computed = global_map(y)
    # 各 v について定義の一段を分けて確認する
    for v in V:
        assert computed[v] == g(y[LEFT[v]], y[v], y[RIGHT[v]])
    assert computed == text_pairs[y], "row {}: text {} vs computed {}".format(
        as_string(y), as_string(text_pairs[y]), as_string(computed))
    checked += 1

print("rows checked against the text table: {}".format(checked))
print("RESULT: PASS")

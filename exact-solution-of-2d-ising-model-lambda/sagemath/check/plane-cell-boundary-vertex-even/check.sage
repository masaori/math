from itertools import product

# 対象ラベル: claim_plane_cell_boundary_even_at_vertex
# 四セルの所属の全16通りで、境界辺の指示関数の和を検査する。
for a, b, d, f in product((ZZ(0), ZZ(1)), repeat=4):
    horizontal_right = a != b
    horizontal_left = d != f
    vertical_down = a != d
    vertical_up = b != f
    edge_count = sum(ZZ(x) for x in (
        horizontal_right, horizontal_left, vertical_down, vertical_up))
    # xor は二を法とした加法。各所属は四辺のうち二度現れる。
    assert edge_count % 2 == (a + b + d + f + a + d + b + f) % 2
    assert (a + b + d + f + a + d + b + f) % 2 == (2 * (a + b + d + f)) % 2
    assert (2 * (a + b + d + f)) % 2 == 0

print("PASS: all 16 local cell-membership patterns have even boundary degree")

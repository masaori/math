# 対象ラベル: nonnegative_real_order_from_squares
# 証明（背理法）: v < u と仮定すると u > 0 で、v² = v·v ≤ v·u < u·u = u² となり u² ≤ v² に矛盾する。
# 帰属:
# - 等号の行（v² = v·v、u·u = u²）と、不等号の各行の「右辺 - 左辺」の因数分解は QQ[u, v] で厳密に。
#   v·u - v·v = v(u - v)、u·u - v·u = u(u - v) で、仮定 0 ≤ v < u の下で前者は ≥ 0、後者は > 0 になる。
# - 主張と各行の大小は、AA（実代数的数）の非負の点の組の全てで厳密に確かめる（浮動小数点なし）。
R.<u, v> = QQ[]
assert v^2 == v*v and u*u == u^2                                     # 等号の行
assert v*u - v*v == v*(u - v)                                        # 2 行目（≤）の差: v ≥ 0 と u - v > 0 の積
assert u*u - v*u == u*(u - v)                                        # 3 行目（<）の差: u > 0 と u - v > 0 の積
print("鎖の等号の行と、不等号の行の差の因数分解が QQ[u, v] で成り立つ")
PTS = [AA(0), AA(1)/3, AA(1)/2, AA(1), AA(2).sqrt(), AA(3)/2, AA(2), AA(5).sqrt(), AA(7)]
n_claim = 0; n_chain = 0
for u0 in PTS:
    for v0 in PTS:
        if u0^2 <= v0^2:                                             # 主張
            assert u0 <= v0; n_claim += 1
        if v0 < u0:                                                  # 背理法の仮定が成り立つ組で鎖の各行
            assert u0 > 0
            assert v0^2 == v0*v0 and v0*v0 <= v0*u0 and v0*u0 < u0*u0 and u0*u0 == u0^2
            assert not (u0^2 <= v0^2)                                # 仮定の下では u² ≤ v² が成り立たない（矛盾の形）
            n_chain += 1
print(f"AA の点の組で主張（{n_claim} 組）と背理法の鎖の各行（{n_chain} 組）が成り立つ")
u0, v0 = AA(1), AA(-2)
assert u0^2 <= v0^2 and not (u0 <= v0)
print("対照: v ≥ 0 を外すと成り立たない（u = 1, v = -2）")
print("RESULT: PASS")

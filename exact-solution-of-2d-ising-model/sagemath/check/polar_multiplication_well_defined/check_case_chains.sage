# 対象ラベル: polar_multiplication_well_defined
# 証明の二つの場合の鎖（一般の点）
#   場合 (a): r = r~ = 0 のとき rr' = 0·r' = 0 = 0·r~' = r~ r~'
#             r' = r~' = 0 のとき rr' = r·0 = 0 = r~·0 = r~ r~'
#   場合 (b): (θ+θ') - (θ~+θ~') = (θ-θ~) + (θ'-θ~') = 2nπ + (θ'-θ~') = 2nπ + 2n'π = 2(n+n')π
#             rr' = r~ r' = r~ r~'
# 各行の両辺を別の式から作り、その行が根拠に挙げる仮定だけを代入して多項式として比べる。
load("../../_shared/polar_representation.sage")

# 場合 (a)、r = r~ = 0: 代入の行は r = 0・r~ = 0 だけを使い、0·x = 0 の行は real_zero_times_is_zero
assert (r * rp).subs({r: 0}) == 0 * rp           # r = 0
assert 0 * rp == 0                               # real_zero_times_is_zero (x -> r')
assert 0 == 0 * rtp                              # real_zero_times_is_zero (x -> r~') を右辺から左辺へ
assert (rt * rtp).subs({rt: 0}) == 0 * rtp       # r~ = 0
assert r * rp != rt * rtp                        # 対照: 仮定なしでは等しくない
# 場合 (a)、r' = r~' = 0: x·0 = 0 の行は real_times_zero_is_zero
assert (r * rp).subs({rp: 0}) == r * 0           # r' = 0
assert r * 0 == 0                                # real_times_zero_is_zero (x -> r)
assert 0 == rt * 0                               # real_times_zero_is_zero (x -> r~) を右辺から左辺へ
assert (rt * rtp).subs({rtp: 0}) == rt * 0       # r~' = 0

# 場合 (b): 角度の鎖。row_k は鎖の k 行目の式
row0 = (th + thp) - (tht + thtp)
row1 = (th - tht) + (thp - thtp)
row2 = 2*n*PI + (thp - thtp)
row3 = 2*n*PI + 2*np*PI
row4 = 2*(n + np)*PI
h1 = {th: tht + 2*n*PI}          # θ - θ~ = 2nπ
h2 = {thp: thtp + 2*np*PI}       # θ' - θ~' = 2n'π
assert row0 == row1                              # 和と差の整理（仮定を使わない）
assert row1.subs(h1) == row2.subs(h1)            # θ - θ~ = 2nπ だけを使う
assert row1 != row2                              # 対照: 仮定なしでは等しくない
assert row2.subs(h2) == row3                     # θ' - θ~' = 2n'π だけを使う
assert row3 == row4                              # 分配則
assert row0.subs(h1).subs(h2) == row4            # 鎖の両端

# 場合 (b): 半径の鎖
assert (r * rp).subs({r: rt}) == rt * rp         # r = r~
assert (rt * rp).subs({rp: rtp}) == rt * rtp     # r' = r~'
print("case (a) and case (b) chains as polynomial identities in QQ[r, r~, r', r~', θ, θ~, θ', θ~', n, n', π]")
print("RESULT: PASS")

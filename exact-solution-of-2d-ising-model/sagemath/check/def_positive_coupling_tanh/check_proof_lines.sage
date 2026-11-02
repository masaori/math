# 対象ラベル: def_positive_coupling_tanh
# 証明の行: cosh K > sinh K > 0、cosh K ≠ 0、sinh K・cosh K ∈ ℝ、商 ∈ ℝ、
#   tanh K = sinh K/cosh K > 0、tanh K = sinh K/cosh K < cosh K/cosh K = 1、主張 0 < tanh K < 1。
# 帰属: 等号の行は QQ(E)（E は exp(K) の値の不定元）と QQ（K = log q の点）で厳密に、
#   K ∈ QQ の点の不等号は本文の exp のボール（RealBallField(512)）で。
load("../../_shared/positive_coupling_and_real_log.sage")

# 等号の行を QQ(E) で: cosh = (E + 1/E)/2, sinh = (E - 1/E)/2。
cE = cosh_by_definition(E, 1 / E); sE = sinh_by_definition(E, 1 / E)
tE = tanh_by_definition(sE, cE)
assert tE == (E^2 - 1) / (E^2 + 1)                 # tanh K = sinh K/cosh K の値の形
assert cE - sE == 1 / E                             # cosh K - sinh K = exp(-K)（(3) の cosh > sinh の差）
assert cE / cE == 1                                 # cosh K/cosh K = 1（体の中で恒等的に真。定義の書き写しだけを見る）
assert 1 - tE == 2 / (E^2 + 1)                      # 上側の評価の差
assert (cE - sE) / cE == 1 - tE                     # 1 - tanh K = (cosh K - sinh K)/cosh K（上側の評価の 2 行目の差。実効のある検査）

# K = log q の点: exp(K) = q, exp(-K) = 1/q で QQ の中で厳密に。
for q in Q_EXACT_POINTS:
    assert q > 1                                    # K = log q > 0 となる条件
    c = cosh_by_definition(q, 1 / q); s = sinh_by_definition(q, 1 / q)
    assert c in QQ and s in QQ
    assert c > s > 0                                # 1 行目（cosh_sinh_basic_properties (3)）
    assert c != 0                                   # 2 行目
    t = tanh_by_definition(s, c)
    assert t in QQ                                  # 商が実数（ここでは有理数）に入る
    assert t > 0                                    # 正値性の鎖
    assert s / c < c / c and c / c == 1             # 上側の評価の鎖の 2 行
    assert 0 < t < 1                                # 主張

# K ∈ QQ の点: 本文の exp のボールで。
for K0 in K_RATIONAL_POINTS:
    assert K0 > 0
    c = cosh_ball(K0); s = sinh_ball(K0)
    assert c > s and s > 0                          # 1 行目
    assert c > 0 and not c.contains_exact(0)        # 2 行目
    t = tanh_by_definition(s, c)
    assert t > 0                                    # 正値性
    assert t < c / c                                # 上側の評価の 1 行目 sinh K/cosh K < cosh K/cosh K
    # cosh K/cosh K = 1 は QQ(E) で確かめた。ボールの c/c が 1 を含むのは構成上かならず成り立つので比べない。
    assert 1 - t > 0                                # tanh K < 1
print(f"等号の行が QQ(E) で、{len(Q_EXACT_POINTS)} 点 K = log q で QQ の中で、{len(K_RATIONAL_POINTS)} 点 K ∈ QQ でボールで成り立つ")
print("RESULT: PASS")

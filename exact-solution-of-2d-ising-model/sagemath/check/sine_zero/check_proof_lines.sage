# 対象ラベル: sine_zero
# 証明: y0 := sin 0、arcsin(y0) = 0。y0 > 0 と y0 < 0 をそれぞれ arcsin の奇関数の形（def_arcsin の第二の式）と
# 狭義単調増加（arcsin_is_bijection）で否定する。
# 帰属:
# - 主張 sin 0 = 0 は AA で厳密に（_shared の sin_exact は e^{i·0} の虚部）。
# - def_arcsin の第二の式 arcsin(y') = -arcsin(-y') と、各鎖の等号は、y の具体の値 y ∈ QQ で Arb の arcsin のボール
#   （RealBallField(256)。arcsin の値は QQ に収まらないため）で確かめる。本文の arcsin が標準の arcsin に等しいことは
#   arcsin_is_bijection の検算（弧の長さを折れ線で挟む）で確かめてある。
# - 仮定 y0 ≠ 0 が矛盾することは、y0 ≠ 0 の具体の値で arcsin(y0) ≠ 0（ボールが 0 を含まない）と、
#   -y0 < y0 なら arcsin(-y0) < arcsin(y0) を確かめる形で見る。
load("../../_shared/sine_cosine_by_definition.sage")
assert sin_exact(0) == 0
print("主張: sin 0 = 0 が AA で成り立つ")
ys = [QQ(k) / 20 for k in range(1, 21)]
for y0 in ys:
    a = RBF256(y0).arcsin()
    am = RBF256(-y0).arcsin()
    # 第一の鎖（y0 > 0）: arcsin(-y0) = -arcsin(-(-y0)) = -arcsin(y0)
    assert am.overlaps(-RBF256(-(-y0)).arcsin()) and am.overlaps(-a)
    # 第二の鎖（y0 < 0 の場合。y' := -y0 < 0 と置く）: arcsin(-y') = -(-arcsin(-y')) は四則、
    # -(-arcsin(-y')) = -arcsin(y') は def_arcsin の第二の式 arcsin(y') = -arcsin(-y') を Arb の値で比べる
    yp = -y0
    assert RBF256(yp).arcsin().overlaps(-RBF256(-yp).arcsin())
    # y0 ≠ 0 なら arcsin(y0) ≠ 0（矛盾の元）、-y0 < y0 なら arcsin(-y0) < arcsin(y0)
    assert not a.contains_exact(0) and not am.contains_exact(0)
    assert surely_gt(a, am)
print(f"y0 = ±k/20（k = 1..20）で、二つの鎖の各行と、y0 ≠ 0 のとき arcsin(y0) ≠ 0・狭義単調増加の比較がボールで成り立つ")
assert RBF256(0).arcsin().contains_exact(0)
print("対照: y0 = 0 では arcsin(y0) = 0")
print("RESULT: PASS")

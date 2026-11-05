# 対象ラベル: critical_point_iff_kappa_zero
# 証明の各行と主張を、具体の (K_1, K_2^*) で、値を囲む実数のボール（RealBallField）で確かめる。
# ℝ への脱出: sinh・cosh の値は実数の exp の値（部分和の極限）、K_2^* は実対数の値なので、ここだけ区間計算を使う。
#   許容誤差は置かない。等号はボールの重なりと差の半径が 2^{-100} 未満であること、
#   「等号が成り立たない」と不等号はボールが 0 を含まないこと（符号の確定）で判定する。どちらにも決まらなければ失敗とする。
# - K_1, K_2^* は QQ に取り、sinh 2K_1・cosh 2K_1・sinh 2K_2^* は本文の実数の exp を囲むボール（body_real_exp_ball）から作る。
# - K_2 は K_2 := artanh(exp(−2K_2^*)) とおいて Arb で囲み、K_2 > 0 と −(1/2)log tanh K_2 = K_2^*（def_second_dual_coupling_constant）を確かめる。
#   K_2 は QQ に無いので、sinh 2K_2・cosh 2K_2 だけは Arb の sinh・cosh を使う。
# - 同値の鎖の各行は、各点で行の左右の条件の真偽が一致することで確かめる。臨界の点（K_1 = K_2^*）で
#   s_1 s_2 = 1 が成り立つことは、ここではボールの重なりで確かめる。同じことは check_lines_generic.sage が
#   t = exp(−2K_2^*) の有理関数体 QQ(t) の中で厳密に確かめている。
load("../../_shared/one_by_one_matrix.sage")
import sys

PREC = 256
RB = RealBallField(PREC)
ok = True
ncount = {"check": 0, "control": 0}
def check(name, cond):
    global ok
    ncount["check"] += 1
    if name.startswith("対照"):
        ncount["control"] += 1
    if not cond:
        print("FAIL " + name)
    ok = ok and bool(cond)

def is_zero(x):
    """ボール x について、0 と等しいなら True、0 と異なると確定するなら False、決まらなければ None。"""
    x = RB(x)
    if x.contains_zero() and float(x.rad()) < 2.0^(-100):
        return True
    if not x.contains_zero():
        return False
    return None

def eq(x, y, name):
    check(name, is_zero(RB(x) - RB(y)) is True)

def bexp(q):
    return RB(body_real_exp_ball(q, prec=PREC))
def bcosh(q):
    return (bexp(q) + bexp(-q)) / 2
def bsinh(q):
    return (bexp(q) - bexp(-q)) / 2

K2s_list = [QQ(1)/5, QQ(1)/3, QQ(1)/2, QQ(7)/10, QQ(3)/2]
offsets = [QQ(0), QQ(1)/10^6, -QQ(1)/10^6, QQ(1)/7, -QQ(1)/10, QQ(1)]
ncrit = 0
nnon = 0
for K2s in K2s_list:
    K2 = RB(exp(-2 * K2s)).arctanh()
    check(f"K_2 > 0 (K_2^*={K2s})", K2 > 0)
    eq(-(K2.tanh().log()) / 2, K2s, f"K_2^* = −(1/2)log tanh K_2 (K_2^*={K2s})")
    s2 = (2 * K2).sinh()
    c2 = (2 * K2).cosh()
    s2s = bsinh(2 * K2s)
    eq(s2s, RB(2 * K2s).sinh(), f"本文の exp から作った sinh と Arb の sinh (K_2^*={K2s})")
    # 準備
    check(f"準備: s_2 > 0 (K_2^*={K2s})", s2 > 0)
    check(f"準備: s_2 ≠ 0 (K_2^*={K2s})", is_zero(s2) is False)
    P = [s2s, s2 * s2s / s2, (2 * K2).sinh() * bsinh(2 * K2s) / s2, 1 / s2]
    for k in range(len(P) - 1):
        eq(P[k], P[k + 1], f"準備: {k+1}→{k+2} 行目 (K_2^*={K2s})")
    for d in offsets:
        K1 = K2s + d
        if K1 <= 0:
            continue
        tag = f"(K_1, K_2^*)=({K1},{K2s})"
        s1 = bsinh(2 * K1)
        c1 = bcosh(2 * K1)
        kappa = 2 * K1 - 2 * K2s                      # QQ（def_kappa）
        # 同値の鎖の各行の条件（f = 0 の形）。QQ の量は厳密に、実数の量はボールで判定する
        conds = [
            ("s_1 s_2 = 1", is_zero(s1 * s2 - 1)),
            ("s_1 = 1/s_2", is_zero(s1 - 1 / s2)),
            ("s_1 = s_2^*", is_zero(s1 - s2s)),
            ("sinh 2K_1 = sinh 2K_2^*", is_zero(bsinh(2 * K1) - bsinh(2 * K2s))),
            ("2K_1 = 2K_2^*", 2 * K1 - 2 * K2s == 0),
            ("K_1 = K_2^*", K1 - K2s == 0),
        ]
        for name, v in conds:
            check(f"条件 {name} の真偽が決まる {tag}", v is not None)
        # 3 行目（略記の展開）は両辺を同じ式から作るので、真偽の一致は書き写しの形の一致だけを確かめる
        for k in range(len(conds) - 1):
            check(f"(1)⟺(2) {k+1} 行目: 「{conds[k][0]}」⟺「{conds[k+1][0]}」 {tag}", conds[k][1] == conds[k + 1][1])
        # (2)⟺(3) の条件は κ を def_kappa の式 2K_1 − 2K_2^* から作った同じ有理数の比較なので、真偽の一致は形の一致だけである。
        # 内容（def_kappa を法として成り立ち、抜くと成り立たないこと）は check_lines_generic.sage が確かめる
        kconds = [
            ("κ = 0", kappa == 0),
            ("2K_1 − 2K_2^* = 0", 2 * K1 - 2 * K2s == 0),
            ("2(K_1 − K_2^*) = 0", 2 * (K1 - K2s) == 0),
            ("K_1 − K_2^* = 0", K1 - K2s == 0),
            ("K_1 = K_2^*", K1 == K2s),
        ]
        for k in range(len(kconds) - 1):
            check(f"(2)⟺(3) {k+1} 行目: 「{kconds[k][0]}」⟺「{kconds[k+1][0]}」 {tag}", kconds[k][1] == kconds[k + 1][1])
        cc = is_zero(c1 - s1 * c2)
        check(f"c_1 = s_1c_2 の真偽が決まる {tag}", cc is not None)
        check(f"c_1 = s_1c_2 ⟺ s_1s_2 = 1 {tag}", cc == conds[0][1])
        check(f"c_1 = s_1c_2 ⟺ κ = 0 {tag}", cc == kconds[0][1])
        # 主張: (1)・(2)・(3) の真偽が一致する
        check(f"主張: (1)⟺(2)⟺(3) {tag}", conds[0][1] == conds[-1][1] == kconds[0][1])
        if d == 0:
            ncrit += 1
            check(f"臨界の点で (1) が成り立つ {tag}", conds[0][1] is True)
        else:
            nnon += 1
            check(f"臨界でない点で (1) が成り立たない {tag}", conds[0][1] is False)
        # 対照: 準備の s_2^* = 1/s_2 を s_2^* = s_2 と誤ると、臨界の点で s_1 = s_2 が成り立たない（K_2 ≠ K_2^* のとき）
        if d == 0 and is_zero(s2 - s2s) is False:
            check(f"対照 臨界の点で s_1 ≠ s_2 {tag}", is_zero(s1 - s2) is False)

print(f"臨界の点 {ncrit} 個、臨界でない点 {nnon} 個（差 ±10^(-6) の点を含む）")
print(f"真偽の確認 {ncount['check']} 件（うち対照 {ncount['control']} 件）")
print("RESULT: " + ("PASS" if ok else "FAIL"))
if not ok:
    sys.exit(1)

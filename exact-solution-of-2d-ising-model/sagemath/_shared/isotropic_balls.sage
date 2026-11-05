# 等方な場合（K_1 = K_2 = K）の主張の検算で共有する、ボールの判定と本文の関数。
# 先に ../../_shared/one_by_one_matrix.sage を読み込むこと（body_real_exp_ball を使う）。
# 許容誤差は置かない。等号はボールの重なりと差の半径が 2^{-100} 未満であること、
# 「等号が成り立たない」はボールが 0 を含まないことで判定する。どちらにも決まらなければ失敗とする。
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
    x = RB(x)
    if x.contains_zero() and float(x.rad()) < 2.0^(-100):
        return True
    if not x.contains_zero():
        return False
    return None
def eq(x, y, name):
    check(name, is_zero(RB(x) - RB(y)) is True)
def ne(x, y, name):
    check(name, is_zero(RB(x) - RB(y)) is False)
def bexp(q):
    return RB(body_real_exp_ball(q, prec=PREC))
def bcosh(q):
    return (bexp(q) + bexp(-q)) / 2
def bsinh(q):
    return (bexp(q) - bexp(-q)) / 2
def btanh(q):
    return bsinh(q) / bcosh(q)
def body_arccosh(y):
    return (y + (y^2 - 1).sqrt()).log()
def body_arcsinh(y):
    return (y + (y^2 + 1).sqrt()).log()
def finish():
    print(f"真偽の確認 {ncount['check']} 件（うち対照 {ncount['control']} 件）")
    print("RESULT: " + ("PASS" if ok else "FAIL"))
    if not ok:
        sys.exit(1)

# K_c = (1/2)log(1 + √2) ≈ 0.44069 の近くの 4407/10000 を含む
K_list = [QQ(1)/10, QQ(1)/5, QQ(2)/5, QQ(4407)/10000, QQ(1)/2, QQ(1), QQ(3)/2]

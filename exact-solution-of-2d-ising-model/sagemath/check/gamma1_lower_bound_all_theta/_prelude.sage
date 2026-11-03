# 対象ラベル: gamma1_lower_bound_all_theta
# 証明の行を二通りに写す。
#  (a) 略記のまま: QQ[c1, s1, c2s, s2s, co] の多項式（co = cos θ）。
#  (b) 双曲線関数の値: Y = exp(2K_1)、X = exp(2K_2^*) を不定元とする有理関数体 QQ(Y, X) の元。
#      def_cosh_sinh により cosh t = (exp(t) + exp(-t))/2、sinh t = (exp(t) - exp(-t))/2 なので、
#      c_1 = (Y + 1/Y)/2、s_1 = (Y - 1/Y)/2、c_2^* = (X + 1/X)/2、s_2^* = (X - 1/X)/2、
#      cosh(2K_1 - 2K_2^*) は exp(2K_1 - 2K_2^*) = Y/X から (Y/X + X/Y)/2 と独立に作る。
import sys

P = PolynomialRing(QQ, 'c1,s1,c2s,s2s,co')
c1, s1, c2s, s2s, co = P.gens()
F = FractionField(PolynomialRing(QQ, 'Y,X'))
Y, X = F.gens()

def cosh_from_exp(E):
    return (E + 1/E) / 2

def sinh_from_exp(E):
    return (E - 1/E) / 2

# 準備の含意の連鎖: cos θ ≤ 1 ⇒ s_1s_2^* cos θ ≤ s_1s_2^*·1 ⇒ −s_1s_2^*·1 ≤ −s_1s_2^* cos θ
# 各段を (左辺, 右辺) で持つ（左辺 ≤ 右辺）
PREP_IMPL = [
    (co, P(1)),
    (s1*s2s*co, s1*s2s*1),
    (-s1*s2s*1, -s1*s2s*co),
]
# 主鎖の行（略記のまま書ける行）
LINE1 = c1*c2s - s1*s2s*co          # γ_1(θ) の定義式
LINE2 = c1*c2s - s1*s2s*1           # 準備の終点の両辺に c_1c_2^* を加えたものの左辺
LINE3 = c1*c2s - s1*s2s             # 1 は積の単位元
# 双曲線関数の値で書いた行
def line4(Yv, Xv):                  # cosh 2K_1 cosh 2K_2^* - sinh 2K_1 sinh 2K_2^*
    return cosh_from_exp(Yv)*cosh_from_exp(Xv) - sinh_from_exp(Yv)*sinh_from_exp(Xv)
def line5(Yv, Xv):                  # cosh(2K_1 - 2K_2^*)
    return cosh_from_exp(Yv/Xv)
LINE6 = 1


class Report:
    def __init__(self, title):
        self.title = title
        self.n = 0
        self.fail = 0
        print("==", title)

    def check(self, ok, label):
        self.n += 1
        if not ok:
            self.fail += 1
        print(("PASS " if ok else "FAIL ") + label)

    def finish(self):
        print(f"-- {self.title}: {self.n - self.fail}/{self.n} PASS")
        if self.fail:
            print("RESULT: FAIL")
            sys.exit(1)
        print("RESULT: PASS")

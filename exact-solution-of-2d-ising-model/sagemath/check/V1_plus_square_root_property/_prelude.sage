# 対象ラベル: V1_plus_square_root_property の検算の共通の準備。
# Y_m・Z_m・H_1^{(+)} は _shared/pauli_sites_exact.sage（def_kronecker (2) の成分の式と mat_mult の成分の式）で QQ(i) に組む。
# 積・スカラー倍・和・有限和・差は本文の定め方どおりに成分から組む（_shared の body_*）。
# exp は ℝ への脱出を含むので、def_exp の部分和に尾の上界を半径として足したボール（body_exp_ball）と、
# Sage の ComplexBallField の行列の exp の両方で囲み、重なることを確かめてから使う（exp_ball）。
load("../../_shared/pauli_sites_exact.sage")

i_ = i_K
P_ = body_product
S_ = body_scalar
A_ = body_sum
F_ = body_finite_sum
D_ = body_difference


def cc_add_pairs(z, w):
    """definition_of_cc の加法 (a,b)+(c,d) := (a+c, b+d) を QQ の対で計算し KG へ戻す。"""
    a, b = z.list()
    c, d = w.list()
    return KG([a + c, b + d])


def iota(r):
    """inclusion_rr_to_cc の ι(r) := (r, 0)。"""
    return KG([QQ(r), 0])


def complex_finite_sum(zs):
    """def_finite_sum_of_complex_numbers: 左から順に足す。"""
    total = zs[0]
    for z in zs[1:]:
        total = total + z
    return total


class Report:
    def __init__(self, title):
        self.title, self.n, self.neg, self.fail = title, 0, 0, 0
        print(f"=== {title} ===", flush=True)

    def chain(self, lines, label, eq=None):
        eq = eq or (lambda A, B: A == B)
        for (a, A), (b, B) in zip(lines, lines[1:]):
            self.n += 1
            if not eq(A, B):
                self.fail += 1
                print(f"FAIL: {label}: 「{a}」≠「{b}」", flush=True)

    def check(self, ok, label):
        self.n += 1
        if not ok:
            self.fail += 1
            print(f"FAIL: {label}", flush=True)

    def negative(self, differs, label):
        self.neg += 1
        if not differs:
            self.fail += 1
            print(f"FAIL（否定コントロールが外れない）: {label}", flush=True)

    def finish(self):
        print(f"等号・主張 {self.n} 件、否定コントロール {self.neg} 件、失敗 {self.fail} 件")
        print("RESULT: " + ("PASS" if self.fail == 0 else "FAIL"))
        assert self.fail == 0

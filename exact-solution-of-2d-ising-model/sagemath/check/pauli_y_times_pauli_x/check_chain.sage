# 対象ラベル: pauli_y_times_pauli_x（σ^yσ^x = (−i)σ^z）
# 証明の鎖の 7 行を、各行に書かれた行列のとおりに QQ(i) で組み、隣どうしを厳密に比べる。
# 1 行目の積は mat_mult の成分の式（body_product）で、6 行目のスカラー倍は def_matrix_scalar_multiple（body_scalar）で組む。
# ℂ の積の行（(−i)·1、(−i)·0、(−i)·(−1)）は、definition_of_cc の積を実数の対で計算した値とも比べる。
# 浮動小数点は使わない。
load("../../_shared/matrix_operations_by_definition.sage")

K = QuadraticField(-1, 'i')
i = K.gen()
SX = matrix(K, [[0, 1], [1, 0]])
SY = matrix(K, [[0, -i], [i, 0]])
SZ = matrix(K, [[1, 0], [0, -1]])


def cc_mul(z, w):
    """definition_of_cc の積 (a,b)(c,d) = (ac − bd, ad + bc) を QQ の対で計算し K へ戻す。"""
    a, b = z.list()
    c, d = w.list()
    return K([a*c - b*d, a*d + b*c])


n = 0
lines = [
    ("σ^yσ^x", body_product(SY, SX)),
    ("(0 −i; i 0)(0 1; 1 0)", body_product(matrix(K, [[0, -i], [i, 0]]), matrix(K, [[0, 1], [1, 0]]))),
    ("(−i 0; 0 i)", matrix(K, [[-i, 0], [0, i]])),
    ("((−i)·1 0; 0 i)", matrix(K, [[cc_mul(-i, K(1)), 0], [0, i]])),
    ("((−i)·1 (−i)·0; (−i)·0 i)", matrix(K, [[cc_mul(-i, K(1)), cc_mul(-i, K(0))], [cc_mul(-i, K(0)), i]])),
    ("((−i)·1 (−i)·0; (−i)·0 (−i)·(−1))", matrix(K, [[cc_mul(-i, K(1)), cc_mul(-i, K(0))], [cc_mul(-i, K(0)), cc_mul(-i, K(-1))]])),
    ("(−i)(1 0; 0 −1)", body_scalar(-i, matrix(K, [[1, 0], [0, -1]]))),
    ("(−i)σ^z", body_scalar(-i, SZ)),
]
# 1 行目は「σ^yσ^x」とその成分表示の積の両方で組んだ（主張の左辺と鎖の 1 行目）。
for (a, A), (b, B) in zip(lines, lines[1:]):
    assert A == B, f"{a} ≠ {b}"
    n += 1
# ℂ の個々の積（行 4〜6 の根拠）を definition_of_cc の積で確かめる
assert cc_mul(-i, K(1)) == -i; n += 1
assert cc_mul(-i, K(0)) == 0; n += 1
assert cc_mul(-i, K(-1)) == i; n += 1
# 主張を Sage の行列積と独立に比べる
assert SY * SX == -i * SZ; n += 1

# 否定コントロール: 符号を変えた (+i)σ^z、順序を入れ替えた σ^xσ^y とは一致しない
neg = 0
assert body_product(SY, SX) != body_scalar(i, SZ); neg += 1
assert body_product(SX, SY) != body_scalar(-i, SZ); neg += 1

print(f"等号 {n} 件、否定コントロール {neg} 件")
print("RESULT: PASS")

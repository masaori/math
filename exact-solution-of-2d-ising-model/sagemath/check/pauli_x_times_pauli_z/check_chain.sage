# 対象ラベル: pauli_x_times_pauli_z（σ^xσ^z = (−i)σ^y）
# 証明の鎖の 7 行を、各行に書かれた行列のとおりに QQ(i) で組み、隣どうしを厳密に比べる。
# 1 行目の積は mat_mult の成分の式（body_product）で、6 行目のスカラー倍は def_matrix_scalar_multiple（body_scalar）で組む。
# ℂ の積の行（(−i)·0、(−i)·(−i)、(−i)·i）は、definition_of_cc の積を実数の対で計算した値で組む。
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
z0 = cc_mul(-i, K(0))
lines = [
    ("σ^xσ^z", body_product(SX, SZ)),
    ("(0 1; 1 0)(1 0; 0 −1)", body_product(matrix(K, [[0, 1], [1, 0]]), matrix(K, [[1, 0], [0, -1]]))),
    ("(0 −1; 1 0)", matrix(K, [[0, -1], [1, 0]])),
    ("((−i)·0 −1; 1 (−i)·0)", matrix(K, [[z0, -1], [1, z0]])),
    ("((−i)·0 (−i)(−i); 1 (−i)·0)", matrix(K, [[z0, cc_mul(-i, -i)], [1, z0]])),
    ("((−i)·0 (−i)(−i); (−i)i (−i)·0)", matrix(K, [[z0, cc_mul(-i, -i)], [cc_mul(-i, i), z0]])),
    ("(−i)(0 −i; i 0)", body_scalar(-i, matrix(K, [[0, -i], [i, 0]]))),
    ("(−i)σ^y", body_scalar(-i, SY)),
]
for (a, A), (b, B) in zip(lines, lines[1:]):
    assert A == B, f"{a} ≠ {b}"
    n += 1
assert z0 == 0; n += 1
assert cc_mul(-i, -i) == -1; n += 1
assert cc_mul(-i, i) == 1; n += 1
assert SX * SZ == -i * SY; n += 1

neg = 0
assert body_product(SX, SZ) != body_scalar(i, SY); neg += 1
assert body_product(SZ, SX) != body_scalar(-i, SY); neg += 1

print(f"等号 {n} 件、否定コントロール {neg} 件")
print("RESULT: PASS")

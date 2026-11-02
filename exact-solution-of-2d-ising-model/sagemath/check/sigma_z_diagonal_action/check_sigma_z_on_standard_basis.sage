# 対象ラベル: sigma_z_diagonal_action
# 証明の準備の二つの鎖:
#   σ^z e_1 = [[1,0],[0,-1]](1,0)^⊤ = (1·1+0·0, 0·1+(-1)·0)^⊤ = (1+0, 0+0)^⊤ = (1,0)^⊤ = e_1
#   σ^z e_2 = [[1,0],[0,-1]](0,1)^⊤ = (1·0+0·1, 0·0+(-1)·1)^⊤ = (0+0, 0+(-1))^⊤ = (0,-1)^⊤
#           = ((-1)·0, (-1)·1)^⊤ = (-(0), -(1))^⊤ = -e_2
# 第一行は Sage の行列の積、第二行は mat_mult の和の式を一項ずつ足す経路と、手で書いた和、
# 第三行は積だけを済ませた和（各積を別に計算して並べる）、第四行は手で書いた列、
# e_2 の第五行は (-1)·z を、第六行は成分ごとの符号反転を、最後の行は def_matrix_negation の -e_2 を作る。帰属: ZZ。
load("../../_shared/site_sigma_z_kronecker.sage")

def mat_mult_by_definition(A, v):
    """mat_mult の (Av)_i = Σ_j A_{ij} v_j を一項ずつ足す（Sage の行列の積を使わない経路）。"""
    return matrix(ZZ, 2, 1, [sum(A[i, j] * v[j, 0] for j in range(2)) for i in range(2)])

def negate_entrywise(v):
    """def_matrix_negation の (-v)_i := -(v_i)。"""
    return matrix(ZZ, v.nrows(), v.ncols(), lambda i, j: -v[i, j])

def col(a, b):
    return matrix(ZZ, 2, 1, [a, b])

# e_1
p = [1 * 1, 0 * 0, 0 * 1, (-1) * 0]          # 積だけを先に計算する
assert p == [1, 0, 0, 0]
chain = [SIGMA_Z * E[1],
         col(1 * 1 + 0 * 0, 0 * 1 + (-1) * 0),
         col(p[0] + p[1], p[2] + p[3]),
         col(1, 0),
         E[1]]
assert chain[0] == mat_mult_by_definition(SIGMA_Z, E[1])
assert all(c == chain[0] for c in chain)
# e_2
p = [1 * 0, 0 * 1, 0 * 0, (-1) * 1]
assert p == [0, 0, 0, -1]
chain = [SIGMA_Z * E[2],
         col(1 * 0 + 0 * 1, 0 * 0 + (-1) * 1),
         col(p[0] + p[1], p[2] + p[3]),
         col(0, -1),
         col((-1) * 0, (-1) * 1),
         col(-(E[2][0, 0]), -(E[2][1, 0])),
         negate_entrywise(E[2])]
assert chain[0] == mat_mult_by_definition(SIGMA_Z, E[2])
assert all(c == chain[0] for c in chain)
# 対照: σ^z e_2 は e_2 ではない（符号が効いている）
assert SIGMA_Z * E[2] != E[2]
print("checked sigma^z e_1 = e_1 (5 terms) and sigma^z e_2 = -e_2 (7 terms) line by line")
print("RESULT: PASS")

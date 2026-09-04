"""一辺二の単純閉路鍵の頂点項を、署名の指示関数ではなく閉じた局所式で書く。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-simple-cycle-relative-configuration/construction.sage")

SLOT_NAMES = ("up", "down", "left", "right")
FLAG_NAMES = ("row0", "rowTop", "col0", "colTop")


def signature_variables(signature):
    memberships, flags = signature
    values = {}
    for name, in_doubled, in_single in memberships:
        values["d_" + name] = GF(2)(in_doubled)
        values["e_" + name] = GF(2)(in_single)
    for flag_name, flag in zip(FLAG_NAMES, flags):
        values[flag_name] = GF(2)(flag)
    return values


DE_VARIABLES = tuple(prefix + name
                     for name in SLOT_NAMES for prefix in ("d_", "e_"))
FLAG_VARIABLES = FLAG_NAMES


ALL_VARIABLES = DE_VARIABLES + FLAG_VARIABLES


def monomials_up_to_degree(variables, degree):
    from itertools import combinations
    names = []
    for size in range(degree + 1):
        names.extend(combinations(variables, size))
    return names


def feature_classes():
    return tuple(
        ("全変数の次数 %d 以下" % degree,
         monomials_up_to_degree(ALL_VARIABLES, degree))
        for degree in range(1, 7)
    )


def evaluate_monomial(monomial, values):
    result = GF(2)(1)
    for variable in monomial:
        result = result * values[variable]
    return result


def sparsify(solution, kernel_basis):
    current = solution
    improved = True
    while improved:
        improved = False
        for basis_vector in kernel_basis:
            candidate = current + basis_vector
            if candidate.hamming_weight() < current.hamming_weight():
                current = candidate
                improved = True
    return current


signature_values = [signature_variables(signature)
                    for signature in all_signatures]
statistic_matrix = matrix(GF(2), rows)
vertex_vector = vector(GF(2), vertex_terms)

chosen = None
for class_name, monomials in feature_classes():
    feature_matrix = matrix(GF(2), [
        [evaluate_monomial(monomial, values) for values in signature_values]
        for monomial in monomials
    ])
    combined = statistic_matrix * feature_matrix.transpose()
    try:
        solution = combined.solve_right(vertex_vector)
    except ValueError:
        continue
    kernel_basis = combined.right_kernel().basis()
    sparse_solution = sparsify(solution, kernel_basis)
    support = [monomials[index]
               for index in range(len(monomials))
               if sparse_solution[index] != 0]
    chosen = (class_name, monomials, sparse_solution, support)
    break

class_name, monomials, sparse_solution, support = chosen


def local_formula_value(signature):
    values = signature_variables(signature)
    return sum(evaluate_monomial(monomial, values) for monomial in support)


for (doubled, single), vertex_term in zip(cycle_keys, vertex_terms):
    vertices = sorted({
        endpoint
        for edge in doubled.union(single)
        for endpoint in base_endpoints(side, edge)
    })
    formula_value = sum(
        local_formula_value(
            relative_vertex_signature(side, vertex, doubled, single))
        for vertex in vertices
    )

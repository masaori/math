"""一辺二の単純閉路鍵の頂点項を、署名の指示関数ではなく閉じた局所式で書く。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

parity-identity-simple-cycle-relative-configuration では、頂点項が 124 種の
局所署名の指示関数の F_2 線型結合（46 種の和）で書けることまでを固定した。
指示関数の一覧は一辺二の列挙に依存するので、一般の辺長へ持ち上がらない。
そこで署名の成分そのもの——各頂点の上下左右のスロットの D 所属 d_s と
E 所属 e_s（s は up/down/left/right）、切断隣接旗 4 つ——を F_2 変数とみなし、
その単項式（次数 2 まで）を特徴量として、頂点項の頂点和表示

  頂点項 = Σ_{v ∈ V(D∪E)} f(署名(v))   (mod 2)

を与える多項式 f を厳密な線型方程式で探す。特徴クラスは、全 12 変数の
次数 k 以下の単項式全体を k = 1 から順に大きくして試し、解ける最小の次数と、
核ベクトルで支持台を貪欲に縮めた式を記録する。署名の指示関数は次数 12 の
多項式なので、指示関数解が存在する以上、どこかの k で必ず解ける。
解ける最小の k が小さいほど、公式は局所配置の少数ビットの積で閉じる。
有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-simple-cycle-local-sign-formula/construction.sage")

for class_name, monomials in feature_classes():
    feature_matrix = matrix(GF(2), [
        [evaluate_monomial(monomial, values) for values in signature_values]
        for monomial in monomials
    ])
    combined = statistic_matrix * feature_matrix.transpose()
    try:
        solution = combined.solve_right(vertex_vector)
    except ValueError:
        print("CLASS %s: 解なし（特徴 %d 個）" % (class_name, len(monomials)))
        continue
    kernel_basis = combined.right_kernel().basis()
    sparse_solution = sparsify(solution, kernel_basis)
    support = [monomials[index]
               for index in range(len(monomials))
               if sparse_solution[index] != 0]
    print("CLASS %s: 解あり（特徴 %d 個、核次元 %d、支持台 %d 項）"
          % (class_name, len(monomials), len(kernel_basis), len(support)))
    chosen = (class_name, monomials, sparse_solution, support)
    break
for monomial in support:
    print("TERM: %s" % ("1" if not monomial else "*".join(monomial),))


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
    assert formula_value == vertex_term

print("PASS: 一辺二の単純閉路鍵の頂点項は、クラス「%s」の閉じた局所式"
      "（%d 項）の頂点和で書ける" % (class_name, len(support)))

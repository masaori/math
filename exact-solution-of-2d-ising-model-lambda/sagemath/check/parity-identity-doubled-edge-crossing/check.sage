"""一辺三の二重辺つき鍵で偶奇恒等式の交差対項を検査する。

対象: claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

未ねじれの符号同定を還元した F_2 偶奇恒等式

  |2D sqcup o(E)| + r + c + q
    = eh(E)+ev(E)+eh(E)ev(E)+<D union C0,E>  (mod 2)

は、一辺三ではこれまで D=empty の自明文字対象でしか検査されておらず、
そこでは選択集合 C0 が E の巡回空間の元になるため交差対項
<D union C0,E> が恒等的に零だった。本検査は、巻き付き偶奇が非零の
自明文字 E に二重辺 D={d} を付けた鍵を作り、交差対項が 0 の場合と
1 の場合の両方で恒等式を照合する。選択集合は GF(2) の接続行列の
線型方程式で構成する。有限集合、F_2、整数、Q(zeta_8) だけを使う。
"""

load("sagemath/check/curved-free-class-sign-parity-reduction/check.sage")


def solve_selector(side, doubled, single):
    edges = sorted(single)
    vertices = sorted({vertex for base in edges
                       for vertex in base_endpoints(side, base)})
    vertex_index = {vertex: index for index, vertex in enumerate(vertices)}
    incidence = matrix(GF(2), len(vertices), len(edges))
    for column, base in enumerate(edges):
        for vertex in base_endpoints(side, base):
            incidence[vertex_index[vertex], column] += 1
    demand = vector(GF(2), len(vertices))
    for base in doubled:
        for vertex in base_endpoints(side, base):
            if vertex not in vertex_index:
                return None
            demand[vertex_index[vertex]] += 1
    try:
        solution = incidence.solve_right(demand)
    except ValueError:
        return None
    return frozenset(edges[column] for column in range(len(edges))
                     if solution[column] == 1)


probe_crossing = ZZ(0)
probe_plain = ZZ(0)
for single in sorted(even_subgraphs_three, key=lambda item: tuple(sorted(item))):
    if not single or not character_is_trivial_general(3, single):
        continue
    single_h, single_v = subset_parities(3, single)
    if (single_h, single_v) == (0, 0):
        continue
    orientations = curved_free_orientations(3, single)
    if not orientations:
        continue
    orientation = orientations[0]
    found = {0: None, 1: None}
    for base in sorted(base_edges_of_side(3)):
        if base in single:
            continue
        doubled = frozenset([base])
        selector = solve_selector(3, doubled, single)
        if selector is None:
            continue
        union_h, union_v = subset_parities(3, doubled.union(selector))
        pairing = (union_h * single_v + single_h * union_v) % 2
        if found[pairing] is None:
            found[pairing] = (doubled, selector)
        if found[0] is not None and found[1] is not None:
            break
    for pairing in (0, 1):
        if found[pairing] is None:
            continue
        doubled, selector = found[pairing]
        target = target_exponent(3, doubled, single, selector)
        assert untwisted_sign_exponent(3, doubled, single, orientation) == target
        if pairing == 1:
            probe_crossing += 1
        else:
            probe_plain += 1

assert probe_crossing > 0
assert probe_plain > 0
print("PASS: 一辺三の二重辺つき鍵で偶奇恒等式を検査（交差対 1 の鍵 %d 件、"
      "交差対 0 の鍵 %d 件）" % (probe_crossing, probe_plain))

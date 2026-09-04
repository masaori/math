"""四つの Kac--Ward 行列式が非後退置換の位相表示の和に一致することを厳密検査する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/torus-kac-ward-even-subgraph-square/construction.sage")

def successors(L, oriented, edge):
    return [other for other in oriented
            if endpoints(L, edge)[1] == endpoints(L, other)[0]
            and other != reversal(edge)]


def step_turning(edge, successor):
    turn = (direction(successor) - direction(edge)) % 4
    assert turn in (0, 1, 3)
    return {0: ZZ(0), 1: ZZ(1), 3: ZZ(-1)}[turn]


L = 2
oriented = edges(L)
successor_lists = {edge: successors(L, oriented, edge) for edge in oriented}
edge_count = len(oriented)

# 非後退置換の全列挙。各辺を固定するか後続の一つへ写し、単射なものだけ残す。
# 有限集合の単射な自己写像は全単射なので、これで置換が尽くされる。
nonbacktracking_permutations = []


def extend(position, images, used):
    if position == edge_count:
        nonbacktracking_permutations.append(dict(images))
        return
    edge = oriented[position]
    for image in [edge] + successor_lists[edge]:
        if image in used:
            continue
        images[edge] = image
        used.add(image)
        extend(position + 1, images, used)
        used.discard(image)
        del images[edge]


extend(0, {}, set())


def moved_orbits(phi):
    """動く辺の軌道を、oriented の順で最初に現れる基点からの軌道列として拾う。"""
    seen = set()
    orbits = []
    for edge in oriented:
        if phi[edge] == edge or edge in seen:
            continue
        walk = []
        current = edge
        while current not in seen:
            seen.add(current)
            walk.append(current)
            current = phi[current]
        assert current == edge
        orbits.append(walk)
    return orbits

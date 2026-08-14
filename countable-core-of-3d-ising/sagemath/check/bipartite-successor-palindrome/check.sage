# 有限二部後続系の多重度の回文性の検証。
# 本文（structural-core）の証明の各段を、ZZ と有限集合の全数列挙で確かめる。
# 浮動小数点は使わない。

from itertools import product


# ---------------------------------------------------------------------------
# 有限二部後続系（def_bipartite_successor_system）を、点の集合・方向ごとの
# 部分写像・二色塗り分けの三つ組で持つ。整数の加法・順序・座標和は使わない
# （点はタプルや文字列などの単なるラベルとして扱う）。
# ---------------------------------------------------------------------------

def edges_of(system):
    # def_bipartite_successor_system: E = {(a,i) : a in A_i}、
    # ∂0(a,i)=a、∂1(a,i)=succ_i(a)。
    successors = system["successors"]
    return [
        (start, axis, successors[axis][start])
        for axis in sorted(successors)
        for start in sorted(successors[axis])
    ]


def check_bipartite(system):
    # def_bipartite_successor_system の仮定: すべての辺で両端の色が異なる。
    coloring = system["coloring"]
    for (start, _axis, end) in edges_of(system):
        assert coloring[start] != coloring[end]


def all_configurations(system):
    # def_structural_configuration: V -> {+1,-1} を全数列挙する。
    points = sorted(system["points"])
    for values in product([ZZ(1), ZZ(-1)], repeat=len(points)):
        yield dict(zip(points, values))


def broken_edge_set(system, configuration):
    # def_structural_broken_count: D(σ) = {e in E : σ(∂0 e) ≠ σ(∂1 e)}。
    return set(
        (start, axis, end)
        for (start, axis, end) in edges_of(system)
        if configuration[start] != configuration[end]
    )


def color_flip(system, configuration):
    # def_structural_color_flip: 色 1 の点だけ符号を反転する。
    coloring = system["coloring"]
    return {
        point: (-value if coloring[point] == 1 else value)
        for point, value in configuration.items()
    }


def check_proof_steps(system, name):
    check_bipartite(system)
    edges = edges_of(system)
    edge_count = ZZ(len(edges))
    multiplicity = {}
    for configuration in all_configurations(system):
        flipped = color_flip(system, configuration)

        # 証明の第一段: T は対合（T(Tσ) = σ）。
        assert color_flip(system, flipped) == configuration

        # 証明の第二段: 各辺で (Tσ)(∂0e) ≠ (Tσ)(∂1e) ⟺ σ(∂0e) = σ(∂1e)。
        for (start, _axis, end) in edges:
            assert (flipped[start] != flipped[end]) == (
                configuration[start] == configuration[end]
            )

        # 証明の第三段: D(Tσ) = E \ D(σ)（集合として）。
        broken = broken_edge_set(system, configuration)
        assert broken_edge_set(system, flipped) == set(edges) - broken

        # 証明の第四段: b(Tσ) = #E - b(σ)。
        assert ZZ(len(broken_edge_set(system, flipped))) == edge_count - ZZ(len(broken))

        broken_count = ZZ(len(broken))
        multiplicity[broken_count] = multiplicity.get(broken_count, ZZ(0)) + ZZ(1)

    # 主張（claim_structural_palindrome）: Ω_E(m) = Ω_E(#E - m)。
    point_count = len(system["points"])
    assert sum(multiplicity.values()) == ZZ(2) ** point_count
    for broken_count in range(edge_count + 1):
        assert (
            multiplicity.get(ZZ(broken_count), ZZ(0))
            == multiplicity.get(edge_count - ZZ(broken_count), ZZ(0))
        )
    print(
        "%s: 点 %d・辺 %d・全 %d 配位で証明の四段と回文性を確認"
        % (name, point_count, edge_count, 2 ** point_count)
    )
    return multiplicity, edge_count


# ---------------------------------------------------------------------------
# 具体例その一: 一方向の道（点 4 つ、succ_1 だけが定義され単射、交互の二色）。
# ---------------------------------------------------------------------------

path_system = {
    "points": ["p0", "p1", "p2", "p3"],
    "successors": {1: {"p0": "p1", "p1": "p2", "p2": "p3"}},
    "coloring": {"p0": 0, "p1": 1, "p2": 0, "p3": 1},
}

# ---------------------------------------------------------------------------
# 具体例その二: 整数の箱 L=2 を有限二部後続系として表す。
# 点は座標の三つ組、succ_i は第 i 成分を一つ進める写像、色は座標和の偶奇。
# 箱がこの定義の例になっていること（本文の claim_edge_endpoints_parity に相当）は
# check_bipartite が検査する。
# ---------------------------------------------------------------------------

def box_as_system(box_side):
    points = [
        (a, b, c)
        for a in range(box_side)
        for b in range(box_side)
        for c in range(box_side)
    ]
    successors = {}
    for axis in range(3):
        mapping = {}
        for point in points:
            moved = list(point)
            moved[axis] += 1
            if moved[axis] <= box_side - 1:
                mapping[point] = tuple(moved)
        successors[axis + 1] = mapping
    coloring = {point: (point[0] + point[1] + point[2]) % 2 for point in points}
    return {"points": points, "successors": successors, "coloring": coloring}


# ---------------------------------------------------------------------------
# 具体例その三: succ が単射でない星（中心 1 点へ三つの葉が写る）。
# 定義（def_bipartite_successor_system）は単射を仮定するが、証明の最終段の観察
# 「単射性は回文性そのものには不要」を、単射でない系で回文性が保たれることで確かめる。
# ---------------------------------------------------------------------------

star_system = {
    "points": ["center", "leaf_a", "leaf_b", "leaf_c"],
    "successors": {1: {"leaf_a": "center", "leaf_b": "center", "leaf_c": "center"}},
    "coloring": {"center": 1, "leaf_a": 0, "leaf_b": 0, "leaf_c": 0},
}


check_proof_steps(path_system, "道（単射な succ_1 のみ）")

box_multiplicity, box_edge_count = check_proof_steps(box_as_system(2), "整数の箱 L=2")
# 校正: 箱 L=2 の多重度は自由境界の検証（free-boundary-palindrome）と同じ値になるはず。
assert box_edge_count == 12
assert sum(box_multiplicity.values()) == 256
assert box_multiplicity == {
    ZZ(0): ZZ(2),
    ZZ(3): ZZ(16),
    ZZ(4): ZZ(30),
    ZZ(5): ZZ(48),
    ZZ(6): ZZ(64),
    ZZ(7): ZZ(48),
    ZZ(8): ZZ(30),
    ZZ(9): ZZ(16),
    ZZ(12): ZZ(2),
}
print("整数の箱 L=2 の多重度が自由境界の検証と係数ごとに一致することを確認")

check_proof_steps(star_system, "星（単射でない succ_1。観察の確認）")

print("all checks passed")

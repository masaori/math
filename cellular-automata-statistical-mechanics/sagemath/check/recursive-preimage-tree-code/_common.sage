# 章「周期成分に付随する再帰的前像木符号」の検算で共有する補助。
# 帰属: 有限集合の写像の真理値表、有限集合の等号・所属・個数、非負整数の加減・大小比較、
# 有限列・有限集合・入れ子有限多重集合の等号だけを使う。R/C 脱出なし。
# 入れ子有限多重集合は整列した入れ子タプル、有限集合は重複を除いて整列したタプルで正準表現する。

import itertools
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'iterate-monoid-conjugacy-numerical-profile', '_common.sage'))
load(os.path.join(_dir, '..', 'iterate-monoid-stable-fiber-depth', '_common.sage'))


def preperiod_period_tables(table):
    """各配位の (μ(y), π(y)) を def_min_preperiod / def_min_period の走査で求める。"""
    return {y: min_preperiod_period(table, y) for y in range(len(table))}


def periodic_set(mp):
    """def_periodic_points と claim_periodic_iff_min_preperiod_zero: Per(F) = { y | μ(y) = 0 }。"""
    return frozenset(y for y in mp if mp[y][0] == 0)


def children_table(table, periodic):
    """def_recursive_preimage_tree_code_children: C_F(y) = { z | F(z) = y かつ z ∉ Per(F) }。"""
    children = {y: [] for y in range(len(table))}
    for z in range(len(table)):
        if z not in periodic:
            children[table[z]].append(z)
    return {y: tuple(children[y]) for y in children}


def recursive_codes(table, mp, children):
    """def_recursive_preimage_tree_code: μ(y) の大きい側から c_F(y) を計算する。
    多重集合は要素の整列タプルで正準表現する。"""
    codes = {}
    for y in sorted(range(len(table)), key=lambda y: mp[y][0], reverse=True):
        codes[y] = tuple(sorted(codes[z] for z in children[y]))
    return codes


def orbit_set(table, q):
    """def_recursive_preimage_tree_code_periodic_orbits: O_F(q) = { F^n(q) | n ∈ N }。"""
    values = set()
    value = q
    for _ in range(len(table)):
        if value in values:
            break
        values.add(value)
        value = table[value]
    return frozenset(values)


def periodic_orbits(table, periodic):
    """def_recursive_preimage_tree_code_periodic_orbits: 𝒪_F（相異なる周期軌道の集合）。"""
    return frozenset(orbit_set(table, q) for q in periodic)


def base_word(table, mp, codes, q):
    """def_recursive_preimage_tree_code_base_word: 長さ π(q) の有限列 w_F(q)。"""
    word = []
    value = q
    for _ in range(mp[q][1]):
        word.append(codes[value])
        value = table[value]
    return tuple(word)


def component_code(table, mp, codes, orbit_points):
    """def_recursive_preimage_tree_code_component_code: K_F(O) = { w_F(q) | q ∈ O }。
    集合なので重複を除いて整列する。"""
    return tuple(sorted(set(base_word(table, mp, codes, q) for q in orbit_points)))


def code_data(table):
    """μπ 表、周期点集合、非周期一段前像、再帰符号、周期軌道、写像符号 𝒦(F) を返す。"""
    mp = preperiod_period_tables(table)
    periodic = periodic_set(mp)
    children = children_table(table, periodic)
    codes = recursive_codes(table, mp, children)
    orbits = periodic_orbits(table, periodic)
    map_code = tuple(sorted(component_code(table, mp, codes, orbit) for orbit in orbits))
    return mp, periodic, children, codes, orbits, map_code


def hierarchy_member(code, level):
    """def_recursive_preimage_tree_code_multiset_hierarchy: code ∈ M_level の所属検査。"""
    if level == 0:
        return code == ()
    return all(hierarchy_member(element, level - 1) for element in code)


def all_self_map_instances():
    """元数 1・2・4 の配位集合上の全自己写像（N(v)=V の局所規則で実現できる 2 値 CA の大域写像表）。"""
    tables = [(0,)]
    for size in (2, 4):
        for values in itertools.product(range(size), repeat=size):
            tables.append(values)
    return tuple(tables)


def build_conjugacy_from_codes(table_f, table_g):
    """claim_recursive_preimage_tree_code_completeness の再帰構成。
    𝒦(F) = 𝒦(G) を前提に、周期軌道の対応、等しい基点語による周期辺の接着、
    等しい子符号の多重集合からの前像木全単射の再帰構成で h を作って返す。"""
    mp_f, per_f, children_f, codes_f, orbits_f, map_code_f = code_data(table_f)
    mp_g, per_g, children_g, codes_g, orbits_g, map_code_g = code_data(table_g)
    assert map_code_f == map_code_g
    # 写像符号の多重集合の等号により、同じ成分符号の周期軌道を重複度を保って対応させる。
    remaining_g = list(orbits_g)
    h = {}
    for orbit_f in sorted(orbits_f, key=lambda o: component_code(table_f, mp_f, codes_f, o)):
        comp_f = component_code(table_f, mp_f, codes_f, orbit_f)
        matched = None
        for orbit_g in remaining_g:
            if component_code(table_g, mp_g, codes_g, orbit_g) == comp_f:
                matched = orbit_g
                break
        assert matched is not None
        remaining_g.remove(matched)
        # 成分符号の等号により、等しい基点語を持つ基点 q ∈ O、r ∈ P を選ぶ。
        pair = None
        for q in sorted(orbit_f):
            for r in sorted(matched):
                if base_word(table_f, mp_f, codes_f, q) == base_word(table_g, mp_g, codes_g, r):
                    pair = (q, r)
                    break
            if pair is not None:
                break
        assert pair is not None
        q, r = pair
        assert mp_f[q][1] == mp_g[r][1]
        # 周期辺の接着 h(F^n(q)) := G^n(r)。
        value_f, value_g = q, r
        stack = []
        for _ in range(mp_f[q][1]):
            assert value_f not in h
            h[value_f] = value_g
            stack.append((value_f, value_g))
            value_f = table_f[value_f]
            value_g = table_g[value_g]
        # 等しい子符号の多重集合から、前像木の全単射を葉側まで再帰構成する。
        while stack:
            y, u = stack.pop()
            kids_f = sorted(children_f[y], key=lambda z: codes_f[z])
            kids_g = sorted(children_g[u], key=lambda z: codes_g[z])
            assert len(kids_f) == len(kids_g)
            for z, w in zip(kids_f, kids_g):
                assert codes_f[z] == codes_g[w]
                assert z not in h
                h[z] = w
                stack.append((z, w))
    return h

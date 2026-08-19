# 対象ラベル: claim_iterate_monoid_conjugacy_finite_decidability
# 全単射走査による共役の有限決定を検査する。セル数 0,1,2 の配位空間（元数 1,2,4）上の
# 全自己写像対で走査を実行し、見つけた証人が h∘F=G∘h を全点で満たすこと、判定が対称なこと、
# h∘F∘h^{-1} と作った対では必ず存在と判定されること、存在と判定された対では数値プロファイルが
# 一致すること（claim_iterate_monoid_conjugacy_numerical_profile_invariant との整合）、
# 元数が異なる対では存在しないと判定されることを確かめる。
# 帰属: 有限集合の写像の真理値表、有限集合の等号・所属・個数、非負整数の除法・乗算・大小比較だけを使う。R/C 脱出なし。
import os
import itertools
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

pair_scans = 0
conjugate_found = 0
profile_cache = {}


def cached_profile(table):
    if table not in profile_cache:
        profile_cache[table] = numerical_profile(table)
    return profile_cache[table]


for size in (1, 2, 4):
    tables = [tuple(t) for t in itertools.product(range(size), repeat=size)]
    for table_f in tables:
        for table_g in tables:
            exists_fg, witness = conjugacy_scan(table_f, table_g)
            exists_gf, _ = conjugacy_scan(table_g, table_f)
            assert exists_fg == exists_gf
            if exists_fg:
                assert all(witness[table_f[y]] == table_g[witness[y]] for y in range(size))
                assert cached_profile(table_f) == cached_profile(table_g)
                conjugate_found += 1
            pair_scans += 1
    # 正の対照: 各写像と各全単射から作った共役対では必ず存在と判定される。
    for table_f in tables:
        for h in itertools.permutations(range(size)):
            exists, _ = conjugacy_scan(table_f, conjugate_table(h, table_f))
            assert exists is True

# 元数が異なる対では存在しないと判定される。
exists, witness = conjugacy_scan((0, 0), (0, 0, 0, 0))
assert exists is False and witness is None

print("map pairs scanned: {}".format(pair_scans))
print("conjugate pairs found: {}".format(conjugate_found))
print("RESULT: PASS")

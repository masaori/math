# 対象ラベル: claim_iterate_monoid_idempotent_uniqueness_fails
# 反例: 一元舞台 V = {v}、A = {0,1}、近傍 N(v) = {v}、定値局所規則 f_v(x) = 0 では、
# F ∘ F = F かつ F^0 = id も冪等で、配位 y(v) = 1 が F(y)(v) = 0 ≠ 1 = F^0(y)(v) を証言して
# F ≠ F^0 となることを、構造化記述の構成どおりに全数検査する。
# 反例は一つの有限対象なので全数検査が主張の範囲を尽くす。
# 帰属: 有限集合の写像の等号と 2 値状態の等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

confs = configurations(1)
assert confs == ((0,), (1,))
index = {c: k for k, c in enumerate(confs)}

# 定値局所規則 f_v(x) = 0 から大域写像を構成する
table = tuple(index[(0,)] for c in confs)
assert table == (0, 0)  # 全配位を零配位へ送る

# F ∘ F = F
assert compose(table, table) == table

# F^0 = id も冪等
ident = identity_table(2)
assert compose(ident, ident) == ident

# 証人 y(v) = 1: F(y)(v) = 0 != 1 = F^0(y)(v)
y = (1,)
Fy = confs[table[index[y]]]
F0y = confs[ident[index[y]]]
assert Fy[0] == 0
assert F0y[0] == 1
assert Fy[0] != F0y[0]
assert table != ident  # F ≠ F^0

# 両者は P_F に属し（F^1 と F^0）、Idem(P_F) の相異なる 2 元である
powers = power_tables(table, 4)
found = first_collision(powers)
assert found is not None
i, j = found
representatives = set(powers[:j])
assert table in representatives and ident in representatives
idempotents = {G for G in representatives if compose(G, G) == G}
assert table in idempotents and ident in idempotents
assert len(idempotents) >= 2

print("counterexample verified: constant rule on one cell has two distinct idempotents")
print("RESULT: PASS")

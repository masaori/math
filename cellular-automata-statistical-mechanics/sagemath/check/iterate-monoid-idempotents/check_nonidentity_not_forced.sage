# 対象ラベル: claim_nonidentity_idempotent_not_forced
# 反例: 一元舞台 V = {v}、近傍 N(v) = {v}、局所規則 f_v(x) = x(v)（恒等 CA）では、
# 大域写像が恒等写像になり P_F = {id}、Idem(P_F) は単位元だけからなることを、
# 構造化記述の構成どおりに全数検査する。反例は一つの有限対象なので全数検査が主張の範囲を尽くす。
# 帰属: 有限集合の写像の等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

# 一元舞台の配位は (0,), (1,) の 2 つ
confs = configurations(1)
assert confs == ((0,), (1,))
index = {c: k for k, c in enumerate(confs)}

# 局所規則 f_v(x) = x(v) から大域写像を構成する
def local_rule_identity(x_restricted_to_neighborhood):
    return x_restricted_to_neighborhood[0]

table = tuple(index[(local_rule_identity((c[0],)),)] for c in confs)
assert table == identity_table(2)  # F = id_{A^V}

# 全ての n について F^n = id（有限範囲で検査。id の合成が id であることは 1 段で閉じる）
powers = power_tables(table, 8)
for n in range(9):
    assert powers[n] == identity_table(2)

# P_F = {id}: 衝突は i = 0, j = 1 で見つかり、代表は id だけ
found = first_collision(powers)
assert found == (0, 1)
representatives = set(powers[:1])
assert representatives == {identity_table(2)}

# Idem(P_F) は単位元だけからなる（単位元でない冪等元は存在しない）
idempotents = [G for G in representatives if compose(G, G) == G]
assert idempotents == [identity_table(2)]
non_identity = [G for G in idempotents if G != identity_table(2)]
assert non_identity == []

print("counterexample verified: identity CA on one cell has no non-identity idempotent")
print("RESULT: PASS")

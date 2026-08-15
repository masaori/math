# 対象ラベル: def_boundary_response_polynomial
# 多変数分配多項式が有限な全配位の単項式和であることを確認する。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, "_prelude.sage"))

assert len(outer_sites) == 8
assert len(outer_edges) == 12
assert partition_polynomial(*([ZZ(1)] * len(outer_edges))) == 2 ** len(outer_sites)
assert partition_polynomial.parent() is source_ring

print("RESULT: PASS")

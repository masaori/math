# ---------------------------------------------------------
# 共通: why_008_applies_only_to_minus_sector（参照用ノートへ退避したブロック）の検証用
#   整数運動量の hatZ^{(pm)}, hatY と H_2 は _shared/spin_ops.sage の SpinOps が持つ。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../../_shared/spin_ops.sage'))

EVEN_CASES_M = [2, 3, 4, 5]
TOL = 1e-8

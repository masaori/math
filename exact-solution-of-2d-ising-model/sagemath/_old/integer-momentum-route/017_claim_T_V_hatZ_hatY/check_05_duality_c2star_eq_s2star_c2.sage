# ---------------------------------------------------------
# SageMath: 双対関係 c_2^* = s_2^* c_2 （および s_2^* = 1/s_2, c_2^* = c_2/s_2）
# 対象: structured-latex duality_c2_star_eq_s2_star_c2
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

numerical_check(s_2_star, 1 / s_2,        label="s_2^* = 1/s_2")
numerical_check(c_2_star, c_2 / s_2,      label="c_2^* = c_2/s_2")
numerical_check(c_2_star, s_2_star * c_2, label="c_2^* = s_2^* c_2")

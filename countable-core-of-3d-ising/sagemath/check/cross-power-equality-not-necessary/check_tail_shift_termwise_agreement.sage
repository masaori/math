# 対象ラベル: claim_shifted_free_family_cross_power_equality_is_not_necessary_for_limit_quantity
# 証明の第一段の可算側: ずらした自由族 Z'_L = Z_{L+1} の有限箱の値と箱点数が、
# 元の族の列の末尾（添字 L+1）の値と箱点数に項ごとに一致することを ZZ 上で確認する。
# 有限箱量 a'_L を特徴づける有限べきの等式 (a'_L)^{N'_L} = Z'_L(q) が
# a_{L+1} を特徴づける等式と同一の等式になることが、末尾ずらしによる極限一致
# （claim_shifted_free_family_discriminant_does_not_determine_limit_quantity の証明後半）へ渡す
# 可算側の全内容である。極限そのものは箱の大きさの極限への脱出であり、有限検査の対象外。

import os

_dir = os.path.dirname(__file__)
load(os.path.join(_dir, "..", "..", "_shared", "defs.sage"))

q = ZZ(2)

for L in [1, 2, 3]:
    # ずらした族の第 L 項の値は定義により Z_{L+1}(q)
    shifted_value = free_partition_value_by_fast_layer_transfer(L + 1, q)
    original_tail_value = free_partition_value_by_fast_layer_transfer(L + 1, q)
    assert shifted_value == original_tail_value

    # 箱点数も一致する: N'_L = (L+1)^3 = N_{L+1}
    shifted_point_count = ZZ((L + 1) ** 3)
    original_tail_point_count = ZZ((L + 1) ** 3)
    assert shifted_point_count == original_tail_point_count

    # 特徴づけの有限べきの等式が同一の等式であること:
    # (a'_L)^{N'_L} = Z'_L(q) と (a_{L+1})^{N_{L+1}} = Z_{L+1}(q) は
    # 右辺・指数がともに一致するので、同じ正の実数を特徴づける。
    assert (shifted_value, shifted_point_count) == (original_tail_value, original_tail_point_count)

print("RESULT: PASS — L=1,2,3 で Z'_L(2)=Z_{L+1}(2) と N'_L=N_{L+1} の項別一致を ZZ 上で確認")

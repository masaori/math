"""語長一・二は切断旗の二次式とし、語長三だけに固定非切断項を加える。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-three-joint-localization/construction.sage")


def length_three_fixed_interior_joint_system(entries, rhs, all_types, column_index):
    result, zero_rhs, blocks = joint_localized_system(
        entries, rhs, all_types, column_index, (1, 2, 3))
    values = list(rhs)
    for length, (types, names, pairs, start) in blocks.items():
        values.extend(GF(2)(sum(step[0][0] * step[0][2] for step in arc_type[1]) if length == 3 else 0)
                      for arc_type in types)
    return result, vector(GF(2), values), blocks

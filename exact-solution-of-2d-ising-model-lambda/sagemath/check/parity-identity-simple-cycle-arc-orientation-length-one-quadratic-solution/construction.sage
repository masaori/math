"""語長 1 の二次式解の係数構造の調査。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-one-existence/construction.sage")


def build_orient_d_congruence_system(compressor):
    """orient_d 圧縮での合同 F_2 線型系を疎な形で作る。

    行は joint_keys の各鍵、列は圧縮した弧型。行は「奇数回現れる弧型の台」
    だけを持つ（parity-identity-simple-cycle-arc-orientation-membership と同じ）。
    戻り値は (entries 辞書, 弧型の昇順リスト, 弧型→列番号, 右辺ベクトル)。
    """
    type_lists = []
    for side, doubled, single, _ in joint_keys:
        type_lists.append(compressed_arc_types(side, doubled, single, compressor))
    all_types = sorted({arc_type for types in type_lists for arc_type in types})
    column_index = {arc_type: index for index, arc_type in enumerate(all_types)}
    entries = {}
    one = GF(2)(1)
    for row_index, types in enumerate(type_lists):
        multiplicities = {}
        for arc_type in types:
            multiplicities[arc_type] = multiplicities.get(arc_type, 0) + 1
        for arc_type, count in multiplicities.items():
            if count % 2 == 1:
                entries[(row_index, column_index[arc_type])] = one
    rhs = vector(GF(2), [term for _, _, _, term in joint_keys])
    return entries, all_types, column_index, rhs


def length_one_feature_names():
    """length_one_feature_bits と同じ順序の特徴名の列。

    ビット配置は、単一ステップ（内部頂点）の向き（スロット順 up, down,
    left, right の E 所属）・切断旗（row0, rowlast, col0, collast）・
    D 所属（同スロット順）の 12 ビットに、両端点（切断頂点。正準順の対）の
    完全署名（スロット順に D/E/C 所属の 3 ビットずつ、続けて切断旗 4 ビット）
    16 ビットずつを平坦に並べた計 44 ビットである。
    """
    slots = ("up", "down", "left", "right")
    wraps = ("row0", "rowlast", "col0", "collast")
    names = ["step_e_%s" % slot for slot in slots]
    names += ["step_wrap_%s" % wrap for wrap in wraps]
    names += ["step_d_%s" % slot for slot in slots]
    for endpoint in ("end0", "end1"):
        for slot in slots:
            for kind in ("d", "e", "c"):
                names.append("%s_%s_%s" % (endpoint, kind, slot))
        names += ["%s_wrap_%s" % (endpoint, wrap) for wrap in wraps]
    return tuple(names)


def degree_two_feature_names(names):
    """degree_two_features と同じ順序の特徴名（一次の成分名＋相異なる積の名前）。"""
    extended = list(names)
    count = len(names)
    for first in range(count):
        for second in range(first + 1, count):
            extended.append("%s*%s" % (names[first], names[second]))
    return tuple(extended)


def coefficient_coset_analysis(system_matrix, rhs, coefficient_start):
    """係数座標への解空間の射影を調べ、正準な係数ベクトルを一つ返す。

    未知数の並びは「弧型の値、続けて式の係数」で、coefficient_start が
    係数座標の先頭である。戻り値は
    (核の次元, 係数座標へ射影した核の次元, 強制された係数座標の集合,
     正準な係数ベクトル)。

    強制された係数座標とは、核のどのベクトルもその座標で 0 になるもので、
    その値は解空間の全ての解で共通である。正準な係数ベクトルは、特殊解の
    係数部分から、射影した核の既約階段基底の各枢軸座標を 0 へ消去したもの
    （剰余類の正準代表）で、解の取り方に依存しない。
    """
    particular = system_matrix.solve_right(rhs)
    kernel_basis = system_matrix.right_kernel_matrix()
    kernel_dimension = kernel_basis.nrows()
    coefficient_columns = list(range(coefficient_start, system_matrix.ncols()))
    projected = kernel_basis.matrix_from_columns(coefficient_columns)
    projected_echelon = projected.echelon_form()
    projected_dimension = projected_echelon.rank()
    forced = {index for index in range(len(coefficient_columns))
              if projected_echelon.column(index).is_zero()}
    coefficient_vector = vector(
        GF(2), [particular[column] for column in coefficient_columns])
    for row_index in range(projected_dimension):
        row = projected_echelon.row(row_index)
        pivot = row.nonzero_positions()[0]
        if coefficient_vector[pivot] == 1:
            coefficient_vector = coefficient_vector + row
    return (kernel_dimension, projected_dimension, forced, coefficient_vector)

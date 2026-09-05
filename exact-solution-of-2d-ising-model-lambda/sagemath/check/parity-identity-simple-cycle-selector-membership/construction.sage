"""選択集合の局所所属を署名へ加えた合同局所符号式の検査。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-simple-cycle-joint-local-sign-formula/construction.sage")


def selector_vertex_signature(side, vertex, doubled, single, chosen):
    memberships = tuple(
        (name, ZZ(base in doubled), ZZ(base in single), ZZ(base in chosen))
        for name, base in incident_base_slots(side, vertex)
    )
    return memberships, vertex_wrap_flags(side, vertex)

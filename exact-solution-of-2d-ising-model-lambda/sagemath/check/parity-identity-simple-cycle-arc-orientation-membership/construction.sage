"""弧署名の内部頂点で向きと所属の組をどこまで落とせるかの切り分け。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-simple-cycle-arc-signature-compression/construction.sage")


def orientation_membership_step(signature, keep_d, keep_c, keep_wrap):
    memberships, wrap_flags = signature
    orientation = tuple(in_single for _, _, in_single, _ in memberships)
    extras = []
    if keep_d:
        extras.append(tuple(in_doubled for _, in_doubled, _, _ in memberships))
    if keep_c:
        extras.append(tuple(in_chosen for _, _, _, in_chosen in memberships))
    kept_wrap = wrap_flags if keep_wrap else ()
    return (orientation, kept_wrap, tuple(extras))


def make_orientation_membership_compressor(keep_d, keep_c, keep_wrap):
    def compressor(kind, word, endpoints=None):
        steps = tuple(
            orientation_membership_step(signature, keep_d, keep_c, keep_wrap)
            for signature in word)
        if kind == "cycle":
            assert endpoints is None
            return ("cycle", cyclic_reversal_invariant_word(steps))
        assert endpoints is not None
        return ("arc", reversal_invariant_word(steps), endpoints)
    return compressor

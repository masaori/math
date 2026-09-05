"""orient_d 署名の解の支持台の調査。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-membership/construction.sage")


def sparsify_by_kernel(solution, kernel_basis):
    current = solution
    improved = True
    while improved:
        improved = False
        for basis_vector in kernel_basis:
            candidate = current + basis_vector
            if candidate.hamming_weight() < current.hamming_weight():
                current = candidate
                improved = True
    return current


def arc_type_steps(arc_type):
    return arc_type[1]


def step_uses_doubled(step):
    _, _, extras = step
    return any(bool(value) for value in extras[0])


def step_uses_wrap(step):
    _, kept_wrap, _ = step
    return any(bool(flag) for flag in kept_wrap)

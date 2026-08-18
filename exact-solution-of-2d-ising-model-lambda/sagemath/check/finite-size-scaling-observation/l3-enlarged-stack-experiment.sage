# 対象ラベル: def_finite_size_scaling_reading
# L=3 の切り分け実験: PARI スタックを 8 GiB（上限 16 GiB）へ拡張して
# check.sage と同じ全根分離経路を再実行する。2026-08-18 の実行では
# 540 秒内にはスタック超過が再発せず、時間切れで打ち切られた。
# 実行段階の出力は永続化されていないため、停止した段階は確定していない。
# 実行例: timeout 540 sage l3-enlarged-stack-experiment.sage

import os, time

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

pari.allocatemem(1 << 33, 1 << 34)

t0 = time.time()
L = 3
polynomial = partition_polynomial(L)
print('degree', polynomial.degree(), flush=True)
roots = polynomial.roots(QQbar, multiplicities=False)
print('roots', len(roots), 'elapsed', time.time() - t0, flush=True)
critical_point = AA(QQbar(2).sqrt() - 1)
interval_field = RealIntervalField(256)
pairs = []
for root in roots:
    distance_squared = ((AA(root.real()) - critical_point) ** 2
                        + AA(root.imag()) ** 2)
    pairs.append((distance_squared, interval_field(distance_squared), root))
print('distances built, elapsed', time.time() - t0, flush=True)
candidate_distance, candidate_interval, candidate_root = min(
    pairs, key=lambda item: item[1].center())
conjugate_root = candidate_root.conjugate()
for _distance, interval, root in pairs:
    if root != candidate_root and root != conjugate_root:
        assert candidate_interval.upper() < interval.lower()
print('separation ok, elapsed', time.time() - t0, flush=True)
distance_minpoly = candidate_distance.minpoly()
print('d_1(3) minpoly degree', distance_minpoly.degree(), flush=True)
print('d_1(3) minpoly', distance_minpoly, flush=True)
print('total elapsed', time.time() - t0, flush=True)

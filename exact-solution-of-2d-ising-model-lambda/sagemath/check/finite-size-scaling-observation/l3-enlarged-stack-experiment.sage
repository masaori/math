# 対象ラベル: def_finite_size_scaling_reading
# L=3 の切り分け実験: PARI スタックを 8 GiB（上限 16 GiB）へ拡張して
# check.sage と同じ全根分離経路を再実行する。
# 2026-08-18 の 1 回目の実行では 540 秒内にスタック超過が再発せず時間切れで
# 打ち切られたが、段階の出力を永続化しておらず停止箇所が確定しなかった。
# そこで各段階と根ごとの進捗を経過秒つきでログファイルへ永続化する
# （出力先: このディレクトリの l3-stage-log-<日付>.txt。打ち切られても残る）。
# 実行例: timeout 480 sage l3-enlarged-stack-experiment.sage

import os, time, datetime

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

_log_path = os.path.join(
    _dir, 'l3-stage-log-%s.txt' % datetime.date.today().isoformat())
_log_file = open(_log_path, 'a')
t0 = time.time()


def log(*items):
    line = ' '.join(str(item) for item in items)
    stamped = '[%8.1fs] %s' % (time.time() - t0, line)
    print(stamped, flush=True)
    _log_file.write(stamped + '\n')
    _log_file.flush()
    os.fsync(_log_file.fileno())


log('=== run start', datetime.datetime.now().isoformat())
pari.allocatemem(1 << 33, 1 << 34)
log('pari stack: 8 GiB (limit 16 GiB)')

L = 3
polynomial = partition_polynomial(L)
log('stage: partition polynomial built, degree', polynomial.degree())
roots = polynomial.roots(QQbar, multiplicities=False)
log('stage: roots isolated, count', len(roots))
critical_point = AA(QQbar(2).sqrt() - 1)
interval_field = RealIntervalField(256)
pairs = []
for index, root in enumerate(roots):
    distance_squared = ((AA(root.real()) - critical_point) ** 2
                        + AA(root.imag()) ** 2)
    pairs.append((distance_squared, interval_field(distance_squared), root))
    log('  distance interval done for root', index + 1, 'of', len(roots))
log('stage: all distance intervals built')
candidate_distance, candidate_interval, candidate_root = min(
    pairs, key=lambda item: item[1].center())
conjugate_root = candidate_root.conjugate()
log('stage: candidate selected')
for index, (_distance, interval, root) in enumerate(pairs):
    if root != candidate_root and root != conjugate_root:
        assert candidate_interval.upper() < interval.lower()
    log('  separation checked against root', index + 1, 'of', len(pairs))
log('stage: separation ok')
distance_minpoly = candidate_distance.minpoly()
log('stage: d_1(3) minpoly degree', distance_minpoly.degree())
log('d_1(3) minpoly', distance_minpoly)
log('=== run complete')

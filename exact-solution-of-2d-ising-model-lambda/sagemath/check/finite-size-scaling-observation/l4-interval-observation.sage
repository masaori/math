# 対象ラベル: def_finite_size_scaling_reading
# L=4 の区間観察: tick 430 で確定した「律速は AA の最小多項式計算」を踏まえ、
# 最小多項式計算を含まない段階（分配多項式の構成・全根の QQbar での分離・
# 距離の二乗の 256 bit 包含区間・先頭候補の分離検証）だけを L=4 で実行し、
# 先頭距離 d_1(4) の包含区間と、実対数へ脱出した読み a_rho(4) を得る。
# d_1(4) の定義多項式（終結式による直接構成）はここではやらない。
# 各段階を経過秒つきでログファイルへ永続化する（打ち切られても残る）。
# 実行例: timeout 480 sage l4-interval-observation.sage

import os, time, datetime

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

_log_path = os.path.join(
    _dir, 'l4-stage-log-%s.txt' % datetime.date.today().isoformat())
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

L = 4
polynomial = partition_polynomial(L)
log('stage: partition polynomial built, degree', polynomial.degree())
factors = list(polynomial.factor())
log('stage: ZZ[x] factorization, (degree, multiplicity) =',
    sorted((factor.degree(), multiplicity) for factor, multiplicity in factors))
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
log('stage: separation ok (candidate and its conjugate below all others)')
log('d_1(4) interval =', candidate_interval)

# a_rho(4) の表示だけ実対数による実数体への脱出である。
real_field = RealBallField(128)
scaling_reading = (-real_field(candidate_interval.center()).log()
                   / (2 * real_field(L).log()))
log('a_rho(4) in RealBallField(128) =', scaling_reading)
log('=== run complete')

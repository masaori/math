# 対象ラベル: def_finite_size_scaling_reading
# L=6 の区間観察: L=5 と同じ区間経路（最小多項式計算を含まない）で、
# 分配多項式の構成・全根の QQbar での分離・距離の二乗の 256 bit 包含区間・
# 先頭候補の分離検証を実行し、先頭距離 d_1(6) の包含区間と、
# 実対数へ脱出した読み a_rho(6) を得る。
#
# 分配多項式の構成は L=5 と同じく、定義どおりの全配位の足し上げ（2^36 配位）が
# 現実的でないため、本文で証明済みの跡定理
# theorem_partition_polynomial_is_trace（Z_L = Tr T^L）を引いて、
# 転送行列 T in M_{2^6}(ZZ[x]) の 6 乗の跡として構成する。
# これは観察のための計算であり、定義との一致の検証ではない
# （一致の検証は check.sage が L<=3 で行っている）。
# 各段階を経過秒つきでログファイルへ永続化する（打ち切られても残る）。
# 実行例: timeout 480 sage l6-interval-observation.sage

import os, time, datetime

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

_log_path = os.path.join(
    _dir, 'l6-stage-log-%s.txt' % datetime.date.today().isoformat())
_log_file = open(_log_path, 'a')
t0 = time.time()


def log(*items):
    line = ' '.join(str(item) for item in items)
    stamped = '[%8.1fs] %s' % (time.time() - t0, line)
    print(stamped, flush=True)
    _log_file.write(stamped + '\n')
    os.fsync(_log_file.fileno())


log('=== run start', datetime.datetime.now().isoformat())

L = 6
transfer = transfer_matrix(L)
log('stage: transfer matrix built, size', 2 ** L)
polynomial = row_matrix_trace(L, row_matrix_pow(L, transfer, L))
log('stage: partition polynomial built as Tr T^L '
    '(theorem_partition_polynomial_is_trace), degree', polynomial.degree())
# 跡定理経由の構成の健全性検査: すべての配位の重みを 1 にすると配位の総数になる。
assert polynomial(1) == 2 ** (L * L)
log('stage: sanity check passed, Z_6(1) = 2^36')
factors = list(polynomial.factor())
log('stage: ZZ[x] factorization, (degree, multiplicity) =',
    sorted((factor.degree(), multiplicity) for factor, multiplicity in factors))
for factor, multiplicity in factors:
    log('  factor: degree', factor.degree(), 'multiplicity', multiplicity,
        'leading coefficient', factor.leading_coefficient(),
        'constant term', factor[0])
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
log('d_1(6) interval =', candidate_interval)

# a_rho(6) の表示だけ実対数による実数体への脱出である。
real_field = RealBallField(128)
scaling_reading = (-real_field(candidate_interval.center()).log()
                   / (2 * real_field(L).log()))
log('a_rho(6) in RealBallField(128) =', scaling_reading)
log('=== run complete')

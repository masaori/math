#!/usr/bin/env python
# SageMath 検算の全数掃引。sage -python から起動する。
#
# 目的: 1 本ごとに sage プロセスを起こすと起動時間（約 24 秒）が支配的になるため、
# ワーカー 1 プロセスの中で各検算を隔離名前空間へ load する。分割を静的に決めると
# 計算量の重い検算が特定のワーカーへ偏るため、共有カウンタから次の 1 本を取り出す
# 動的キューにする。
#
# 使い方:
#   sage -python sagemath/tools/sweep_all_checks.py driver --jobs 12 --timeout 600
#   （driver が同じスクリプトを worker として起動する）

import argparse
import ast
import fcntl
import json
import math
import os
import subprocess
import sys
import time
import traceback


def positive_int(raw):
    value = int(raw)
    if value <= 0:
        raise argparse.ArgumentTypeError('must be a positive integer')
    return value


def check_root():
    here = os.path.dirname(os.path.abspath(__file__))
    return os.path.normpath(os.path.join(here, '..', 'check'))


class CollectionError(Exception):
    """検算ファイルの収集が、掃引の対象を取りこぼしうる状態で行われたことを表す。"""


def collect_files(root=None):
    # 収集は fail-closed に行う。os.walk は既定で走査中のエラーを黙って捨て、
    # symlink になったディレクトリへは降りない。さらにファイルの symlink は
    # 検算木の外側を実行対象へ混入させる。取りこぼしや対象のすり替えを許さないため、
    # 収集の段階で例外にする。0 本の収集も同じ理由で失敗とする。
    if root is None:
        root = check_root()
    if os.path.islink(root):
        raise CollectionError('検算の根 {} が symlink である'.format(root))
    if not os.path.isdir(root):
        raise CollectionError('検算の根 {} がディレクトリとして存在しない'.format(root))

    def on_walk_error(error):
        raise CollectionError('検算の走査が {} で失敗した: {}'.format(
            getattr(error, 'filename', root), error))

    out = []
    for dirpath, dirnames, filenames in os.walk(root, onerror=on_walk_error):
        for name in sorted(dirnames):
            path = os.path.join(dirpath, name)
            if os.path.islink(path):
                raise CollectionError(
                    '{} は symlink のディレクトリで、走査が降りないまま読み飛ばされる'.format(
                        os.path.relpath(path, root)))
        for name in sorted(filenames):
            if name.endswith('.sage'):
                path = os.path.join(dirpath, name)
                if os.path.islink(path):
                    raise CollectionError(
                        '{} は symlink の検算ファイルである'.format(
                            os.path.relpath(path, root)))
                if not os.path.isfile(path):
                    raise CollectionError(
                        '{} は通常の検算ファイルではない'.format(
                            os.path.relpath(path, root)))
                out.append(path)
    if not out:
        raise CollectionError('検算ファイルが一本も収集できなかった（掃引が空振りしている）')
    out.sort()
    return out


# 検算の成功判定は「load が例外を出さなかったこと」だけで行われていた。この判定は、
# 中身が空の検算ファイルや、assert を消してしまった検算ファイルも PASS にする。
# 掃引は「一本も実行されていない」ことを収集の側では拒否できるようになったが、
# 「実行はしたが何も確かめていない」ことは拒否できていなかった。
# そこで .sage を前処理したあとの構文木で assert 文の直前に計数の呼び出しを差し込み、
# 実際に実行された assert の件数を検算ごとに記録する。件数 0 の検算は PASS にしない。
ASSERT_HIT_NAME = '__sweep_assert_hit__'


class AssertCounter(ast.NodeTransformer):
    def __init__(self, source_path):
        self.source_path = os.path.realpath(source_path)

    def visit_Assert(self, node):
        self.generic_visit(node)
        hit = ast.Expr(value=ast.Call(
            func=ast.Name(id=ASSERT_HIT_NAME, ctx=ast.Load()),
            args=[ast.Constant(value=self.source_path)], keywords=[]))
        return [ast.copy_location(hit, node), node]


def instrumented_code(path, preparse):
    # Sage の load と同じく .sage を前処理してから実行するが、実行前に構文木を書き換える。
    # 前処理の結果をそのまま exec する経路（sage.repl.load.load の既定）と同じ意味を保つ。
    with open(path) as fh:
        source = preparse(fh.read()) + '\n'
    tree = AssertCounter(path).visit(ast.parse(source, filename=path))
    ast.fix_missing_locations(tree)
    # optimize=0 を明示する。既定の -1 は起動した python の最適化水準を引き継ぐため、
    # 環境変数 PYTHONOPTIMIZE や -O のもとでは assert 文だけが実体を失う。差し込んだ
    # 計数の呼び出しは通常の式なので残り、件数は正のまま一つも検査されない掃引が
    # 全件 PASS になる。件数を成功判定に使う以上、assert が実行されることを固定する。
    return compile(tree, path, 'exec', dont_inherit=True, optimize=0)


def assertion_required(relative_path):
    # 対象外は二種類しかない。検算から load される共有定義（`_common.sage` /
    # `_prelude.sage`）と、まだ主張へ昇格していない探索用（`explore_*.sage`）である。
    # `check_` で始まらないというだけで免除すると、任意名の空ファイルが成功扱いになるため、
    # 明示した三パターン以外の `.sage` はすべて assert を要求する。
    # 免除された本数と名前は毎回印字して、対象外が黙って増えないようにする。
    basename = os.path.basename(relative_path)
    return not (
        basename in ('_common.sage', '_prelude.sage')
        or basename.startswith('explore_')
    )


def next_index(counter_path):
    with open(counter_path, 'r+') as fh:
        fcntl.flock(fh, fcntl.LOCK_EX)
        try:
            raw = fh.read().strip()
            idx = int(raw) if raw else 0
            fh.seek(0)
            fh.truncate()
            fh.write(str(idx + 1))
            fh.flush()
        finally:
            fcntl.flock(fh, fcntl.LOCK_UN)
    return idx


class Timeout(Exception):
    pass


def worker_main(args):
    import signal
    import sage.all as sage_all
    from sage.repl.preparse import preparse_file

    with open(args.list) as fh:
        files = [line.rstrip('\n') for line in fh if line.strip()]

    def on_alarm(signum, frame):
        raise Timeout()

    signal.signal(signal.SIGALRM, on_alarm)

    sage_base = {k: v for k, v in vars(sage_all).items() if not k.startswith('__')}

    out = open(args.result, 'a', 1)
    while True:
        idx = next_index(args.counter)
        if idx >= len(files):
            break
        path = files[idx]
        ns = dict(sage_base)
        ns['__name__'] = '__sweep__'
        ns['__file__'] = path

        hits = {}

        def assert_hit(source_path):
            hits[source_path] = hits.get(source_path, 0) + 1

        ns[ASSERT_HIT_NAME] = assert_hit

        def scoped_load(*names, **_kw):
            # 検算ファイル内の相対 load を、同じ隔離名前空間へ入れる。
            # 名前空間を指定しないと Sage の利用者名前空間へ入り、定義が検算から見えなくなる。
            # 読み込んだ側も計数するが、出典別に分ける。共有定義の assert だけが動いても、
            # 検算本体が何も確かめていない事実を覆い隠してはならない。
            for name in names:
                exec(instrumented_code(name, preparse_file), ns)

        ns['load'] = scoped_load

        started = time.time()
        cwd = os.getcwd()
        status = 'PASS'
        detail = ''
        try:
            os.chdir(os.path.dirname(path))
            signal.alarm(args.timeout)
            exec(instrumented_code(path, preparse_file), ns)
            signal.alarm(0)
        except Timeout:
            status = 'TIMEOUT'
            detail = 'exceeded {} s'.format(args.timeout)
        except BaseException:
            signal.alarm(0)
            status = 'FAIL'
            detail = traceback.format_exc().strip().splitlines()[-1][:400]
        finally:
            signal.alarm(0)
            os.chdir(cwd)
        rec = {
            'index': idx,
            'file': os.path.relpath(path, check_root()),
            'status': status,
            'seconds': round(time.time() - started, 2),
            'assertions': hits.get(os.path.realpath(path), 0),
            'detail': detail,
            'worker': args.worker,
        }
        out.write(json.dumps(rec, ensure_ascii=False) + '\n')
    out.close()


def summarize_results(files, outdir, jobs, codes, timeout):
    # 対象が空の掃引は、全件成功と区別が付かないまま成功として通ってしまう。
    if not files:
        print('EMPTY SWEEP: 検算ファイルが一本も無い', flush=True)
        return False
    records = []
    malformed = []
    for w in range(jobs):
        result_path = os.path.join(outdir, 'result-{}.jsonl'.format(w))
        with open(result_path) as fh:
            for line_number, line in enumerate(fh, 1):
                try:
                    record = json.loads(line)
                except (TypeError, ValueError) as exc:
                    malformed.append('{}:{}: {}'.format(result_path, line_number, exc))
                    continue
                if not isinstance(record, dict):
                    malformed.append('{}:{}: result is not an object'.format(
                        result_path, line_number))
                    continue
                records.append(record)

    by_index = {}
    invalid_records = []
    for record in records:
        idx = record.get('index')
        if (not isinstance(idx, int)
                or isinstance(idx, bool)
                or idx < 0
                or idx >= len(files)):
            invalid_records.append(record)
            continue
        expected_file = os.path.relpath(files[idx], check_root())
        if record.get('file') != expected_file:
            invalid_records.append(record)
            continue
        if record.get('status') not in {'PASS', 'FAIL', 'TIMEOUT'}:
            invalid_records.append(record)
            continue
        seconds = record.get('seconds')
        # NaN と Infinity は JSON の既定の構文で書けるうえ、NaN はどの比較も偽になるため
        # 所要時間の並べ替えを静かに壊し、余裕の倍率も無限大として印字されてしまう。
        # 巨大な整数も float への暗黙変換で OverflowError を起こす。後段の除算と書式化まで
        # 安全に行える、有限で非負の浮動小数点数へ正規化できる値だけを受理する。
        if (not isinstance(seconds, (int, float))
                or isinstance(seconds, bool)):
            invalid_records.append(record)
            continue
        try:
            normalized_seconds = float(seconds)
        except (OverflowError, ValueError):
            invalid_records.append(record)
            continue
        if not math.isfinite(normalized_seconds) or normalized_seconds < 0:
            invalid_records.append(record)
            continue
        record['seconds'] = normalized_seconds
        # 実行された assert の件数を報告しないワーカーは、旧い実装か壊れた実装である。
        # 件数を読めないまま PASS を受理すると、何も確かめていない検算を通してしまう。
        assertions = record.get('assertions')
        if (not isinstance(assertions, int)
                or isinstance(assertions, bool)
                or assertions < 0):
            invalid_records.append(record)
            continue
        by_index.setdefault(idx, []).append(record)

    missing = [idx for idx in range(len(files)) if idx not in by_index]
    duplicates = {idx: found for idx, found in by_index.items() if len(found) != 1}
    non_pass = [
        found[0] for found in by_index.values()
        if len(found) == 1 and found[0]['status'] != 'PASS'
    ]
    # 例外を出さずに終わっただけの検算を成功と呼ばない。共有定義ファイルだけを除外する。
    vacuous = [
        found[0] for found in by_index.values()
        if (len(found) == 1
            and found[0]['status'] == 'PASS'
            and found[0]['assertions'] == 0
            and assertion_required(found[0]['file']))
    ]
    exempt = sorted(
        found[0]['file'] for found in by_index.values()
        if len(found) == 1 and not assertion_required(found[0]['file'])
    )
    counts = {}
    for record in records:
        status = record.get('status')
        if status not in {'PASS', 'FAIL', 'TIMEOUT'}:
            status = 'INVALID'
        counts[status] = counts.get(status, 0) + 1

    print('status counts: {}'.format(counts), flush=True)
    print('completed unique files: {}/{}'.format(len(by_index), len(files)), flush=True)
    print('assertion-exempt files ({}): {}'.format(
        len(exempt), ', '.join(exempt)), flush=True)
    print('executed assertions: {}'.format(sum(
        found[0]['assertions'] for found in by_index.values() if len(found) == 1)), flush=True)

    # 打ち切り時間に対する余裕を毎回残す。余裕が小さい検算は、機械の負荷が上がった回だけ
    # TIMEOUT になり、掃引の結果が回ごとに揺れる。揺れを検算の失敗と読み違えないため、
    # 上位の所要時間と余裕の倍率を常に出力する。
    slowest = sorted(
        (found[0] for found in by_index.values() if len(found) == 1),
        key=lambda record: -record.get('seconds', 0),
    )[:10]
    print('slowest checks (limit {} s):'.format(timeout), flush=True)
    for record in slowest:
        seconds = record.get('seconds', 0)
        margin = (timeout / seconds) if seconds > 0 else float('inf')
        print('  {:8.2f} s  x{:5.2f} margin  {}  {}'.format(
            seconds, margin, record['status'], record['file']), flush=True)
    for record in sorted(non_pass, key=lambda item: item['index']):
        print('{}: {} ({})'.format(
            record['status'], record['file'], record.get('detail', '')), flush=True)
    for record in sorted(vacuous, key=lambda item: item['index']):
        print('NO ASSERTION EXECUTED: {}'.format(record['file']), flush=True)
    for message in malformed:
        print('MALFORMED: {}'.format(message), flush=True)
    for record in invalid_records:
        print('INVALID RECORD: {}'.format(record), flush=True)
    for idx in missing:
        print('MISSING: {}'.format(os.path.relpath(files[idx], check_root())), flush=True)
    for idx, found in sorted(duplicates.items()):
        print('DUPLICATE: {} ({} records)'.format(
            os.path.relpath(files[idx], check_root()), len(found)), flush=True)

    return not (
        any(code != 0 for code in codes)
        or bool(malformed)
        or bool(invalid_records)
        or bool(missing)
        or bool(duplicates)
        or bool(non_pass)
        or bool(vacuous)
    )


def driver_main(args):
    try:
        files = collect_files()
    except CollectionError as error:
        print('COLLECTION FAILED: {}'.format(error), flush=True)
        raise SystemExit(1)
    outdir = os.path.abspath(args.outdir)
    os.makedirs(outdir, exist_ok=True)
    list_path = os.path.join(outdir, 'files.txt')
    counter_path = os.path.join(outdir, 'counter.txt')
    with open(list_path, 'w') as fh:
        fh.write('\n'.join(files) + '\n')
    with open(counter_path, 'w') as fh:
        fh.write('0')

    print('files: {}'.format(len(files)), flush=True)

    procs = []
    self_path = os.path.abspath(__file__)
    for w in range(args.jobs):
        result_path = os.path.join(outdir, 'result-{}.jsonl'.format(w))
        open(result_path, 'w').close()
        log_path = os.path.join(outdir, 'worker-{}.log'.format(w))
        cmd = [
            'sage', '-python', self_path, 'worker',
            '--list', list_path, '--counter', counter_path,
            '--result', result_path, '--worker', str(w),
            '--timeout', str(args.timeout),
        ]
        log = open(log_path, 'w')
        procs.append((subprocess.Popen(cmd, stdout=log,
                                       stderr=subprocess.STDOUT), log))
    codes = []
    for proc, log in procs:
        codes.append(proc.wait())
        log.close()
    print('worker exit codes: {}'.format(codes), flush=True)
    if not summarize_results(files, outdir, args.jobs, codes, args.timeout):
        raise SystemExit(1)


def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest='mode', required=True)
    d = sub.add_parser('driver')
    d.add_argument('--jobs', type=positive_int, default=12)
    d.add_argument('--timeout', type=positive_int, default=600)
    d.add_argument('--outdir', default='/tmp/ca-sage-sweep')
    w = sub.add_parser('worker')
    w.add_argument('--list', required=True)
    w.add_argument('--counter', required=True)
    w.add_argument('--result', required=True)
    w.add_argument('--worker', type=int, required=True)
    w.add_argument('--timeout', type=positive_int, default=600)
    args = ap.parse_args()
    if args.mode == 'driver':
        driver_main(args)
    else:
        worker_main(args)


if __name__ == '__main__':
    main()

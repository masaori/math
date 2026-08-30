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
import fcntl
import json
import os
import subprocess
import sys
import time
import traceback


def check_root():
    here = os.path.dirname(os.path.abspath(__file__))
    return os.path.normpath(os.path.join(here, '..', 'check'))


def collect_files():
    root = check_root()
    out = []
    for dirpath, _dirnames, filenames in os.walk(root):
        for name in sorted(filenames):
            if name.endswith('.sage'):
                out.append(os.path.join(dirpath, name))
    out.sort()
    return out


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
    from sage.repl.load import load as sage_load

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

        def scoped_load(*names, **_kw):
            # 検算ファイル内の相対 load を、同じ隔離名前空間へ入れる。
            # 名前空間を指定しないと Sage の利用者名前空間へ入り、定義が検算から見えなくなる。
            for name in names:
                sage_load(name, ns)

        ns['load'] = scoped_load

        started = time.time()
        cwd = os.getcwd()
        status = 'PASS'
        detail = ''
        try:
            os.chdir(os.path.dirname(path))
            signal.alarm(args.timeout)
            sage_load(path, ns)
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
            'detail': detail,
            'worker': args.worker,
        }
        out.write(json.dumps(rec, ensure_ascii=False) + '\n')
    out.close()


def driver_main(args):
    files = collect_files()
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
        procs.append(subprocess.Popen(cmd, stdout=open(log_path, 'w'),
                                      stderr=subprocess.STDOUT))
    codes = [p.wait() for p in procs]
    print('worker exit codes: {}'.format(codes), flush=True)


def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest='mode', required=True)
    d = sub.add_parser('driver')
    d.add_argument('--jobs', type=int, default=12)
    d.add_argument('--timeout', type=int, default=600)
    d.add_argument('--outdir', default='/tmp/ca-sage-sweep')
    w = sub.add_parser('worker')
    w.add_argument('--list', required=True)
    w.add_argument('--counter', required=True)
    w.add_argument('--result', required=True)
    w.add_argument('--worker', type=int, required=True)
    w.add_argument('--timeout', type=int, default=600)
    args = ap.parse_args()
    if args.mode == 'driver':
        driver_main(args)
    else:
        worker_main(args)


if __name__ == '__main__':
    main()

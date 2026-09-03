"""名前空間の守りの費用を、合成コードではなく実際の検算 1 本の上で測る。

bench_namespace_guard.py は代入だけを行う合成コードで 3.90 倍という比を出したが、
掃引の余裕を決めるのは実際の検算の実行時間である。検算は Sage の演算に時間を使うので、
守り（module 水準の STORE_NAME が Python 水準の __setitem__ を通ること）が
実時間に占める割合は合成コードの比とは一致しない。ここではその割合を直接測る。

同じ検算を、同じ書き換え後コードで二つの名前空間の上で走らせる。

  GuardedNamespace  — 現行の守り
  plain dict        — 記録用の名前を置くだけで守らない（守りを外した場合の下限）

どちらも assert の計数は行うので、差は守りの分だけである。assert 件数が一致することを
確かめ、一致しない場合は測定を失敗とする（計測の対象がずれたまま比だけ出さない）。
両方を1回ずつ暖機し、「守りあり→素の辞書」と「素の辞書→守りあり」の両順序を
同数ずつ走らせる。各条件の中央値を比べ、遅延初期化と実行順序の偏りを比へ混ぜない。

使い方: sage -python sagemath/tools/bench_guard_on_check.py <検算ファイル> [繰り返し数]
"""

import importlib.util
import os
import secrets
import statistics
import sys
import time

from sage.repl.preparse import preparse_file
import sage.all as sage_all


def load_sweep():
    path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'sweep_all_checks.py')
    spec = importlib.util.spec_from_file_location('sweep_all_checks_for_bench', path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def run_once(sweep, path, guarded, sage_base):
    """検算を 1 回走らせ、(経過秒, assert 件数) を返す。"""
    recorder = sweep.AssertionRecorder(secrets.token_hex(16))
    base = dict(sage_base)
    base['__name__'] = '__sweep__'
    base['__file__'] = path
    if guarded:
        ns = recorder.install(base)
    else:
        ns = base
        ns.update(recorder.installed)

    def scoped_load(*names, **_kw):
        for name in names:
            exec(sweep.instrumented_code(name, preparse_file, recorder.token), ns)

    ns['load'] = scoped_load
    code = sweep.instrumented_code(path, preparse_file, recorder.token)

    cwd = os.getcwd()
    os.chdir(os.path.dirname(path))
    started = time.time()
    try:
        exec(code, ns)
    finally:
        os.chdir(cwd)
    elapsed = time.time() - started
    ok, reason = recorder.verdict(ns)
    if not ok:
        raise SystemExit('検算の記録の経路が保たれなかった: {}'.format(reason))
    return elapsed, recorder.hits.get(os.path.realpath(path), 0)


def main():
    if len(sys.argv) < 2:
        raise SystemExit(__doc__)
    path = os.path.realpath(sys.argv[1])
    repeats = int(sys.argv[2]) if len(sys.argv) > 2 else 1
    sweep = load_sweep()
    sage_base = {k: v for k, v in vars(sage_all).items() if not k.startswith('__')}

    results = {'GuardedNamespace': [], 'plain dict': []}
    counts = {}
    modes = (('GuardedNamespace', True), ('plain dict', False))

    # Sage 側の遅延初期化や OS のファイルキャッシュを片方だけが受けないよう、両方を一度ずつ
    # 計測外で走らせる。その後は各組で順序を反転し、常に片方だけが先になる偏りも除く。
    for label, guarded in modes:
        _elapsed, hits = run_once(sweep, path, guarded, sage_base)
        counts[label] = hits
    for _ in range(repeats):
        for ordered_modes in (modes, tuple(reversed(modes))):
            for label, guarded in ordered_modes:
                elapsed, hits = run_once(sweep, path, guarded, sage_base)
                if counts[label] != hits:
                    raise SystemExit('同じ検算で assert 件数が揺れた: {} と {}'.format(
                        counts[label], hits))
                results[label].append(elapsed)

    if counts['GuardedNamespace'] != counts['plain dict']:
        raise SystemExit('守りの有無で assert 件数が違う: {}'.format(counts))

    medians = {label: statistics.median(times) for label, times in results.items()}
    base = medians['plain dict']
    print('{}  assert {} 回  両方を1回ずつ暖機し、各 {} 回の中央値'.format(
        os.path.relpath(path, sweep.check_root()), counts['plain dict'], 2 * repeats))
    for label in ('plain dict', 'GuardedNamespace'):
        print('  {:<18} {:8.2f} s  ({:.3f} 倍)'.format(
            label, medians[label], medians[label] / base))


if __name__ == '__main__':
    main()

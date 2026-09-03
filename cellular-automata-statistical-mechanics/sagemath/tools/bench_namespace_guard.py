"""名前空間の守りが、検算の実行時間へ与える費用を切り分けて測る。

掃引 sweep_all_checks.py は、記録用の名前が実行の途中で束ね直されるのを拒むため、
検算を GuardedNamespace（dict の派生）の上で exec する。検算は module 水準の script
なので、その大域代入はすべて STORE_GLOBAL であり、dict の派生に対しては Python 水準の
__setitem__ を通る。すなわち守りの費用は assert の回数ではなく**大域代入の回数**に比例する。

このベンチマークは、代入だけを行う module 水準のコードを三つの名前空間で走らせ、
その比を測る。検算そのものは走らせないので、Sage も検算ファイルも要らない。

  plain dict          — 記録用の名前を置くだけで守らない（守りを外した場合の下限）
  dict の素の派生     — __setitem__ を上書きしない派生（派生であること自体の費用）
  GuardedNamespace    — 現行の守り

使い方: python3 sagemath/tools/bench_namespace_guard.py [代入の回数]
"""

import importlib.util
import os
import secrets
import sys
import time


def load_sweep():
    path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'sweep_all_checks.py')
    spec = importlib.util.spec_from_file_location('sweep_all_checks_for_bench', path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class PlainSubclass(dict):
    """__setitem__ を上書きしない dict の派生。派生であること自体の費用を測るための対照。"""


def module_level_stores(count):
    # 検算と同じく module 水準の script。ループ変数も含め、代入はすべて STORE_GLOBAL になる。
    return compile(
        'total = 0\n'
        'for i in range({}):\n'
        '    tmp = i + 1\n'
        '    total = total + tmp\n'.format(count),
        '<bench>', 'exec', dont_inherit=True, optimize=0)


def timed(code, namespace):
    started = time.time()
    exec(code, namespace)
    return time.time() - started


def main():
    count = int(sys.argv[1]) if len(sys.argv) > 1 else 3000000
    sweep = load_sweep()
    code = module_level_stores(count)

    recorder = sweep.AssertionRecorder(secrets.token_hex(16))
    cases = [
        ('plain dict', lambda: dict(recorder.installed)),
        ('dict の素の派生', lambda: PlainSubclass(recorder.installed)),
        ('GuardedNamespace', lambda: recorder.install({})),
    ]

    # 一度目は import や分岐予測の暖機を含むので、二度測って速い方を採る。
    results = {}
    for name, make in cases:
        results[name] = min(timed(code, make()), timed(code, make()))

    base = results['plain dict']
    print('module 水準の代入 {} 回（1 周あたり 3 回の STORE_GLOBAL）'.format(count))
    for name, _ in cases:
        print('  {:<20} {:.3f} s  ({:.2f} 倍)'.format(name, results[name], results[name] / base))


if __name__ == '__main__':
    main()

#!/usr/bin/env python3
"""検算の読み込み連鎖が「構成だけを読む」形になっているかを検査する。

背景。以前は各 check.sage が上流の check.sage を読んでいたので、下流の検算を一本
走らせるだけで先行する全ての検算の assertion が再実行された。弧署名の検算では
その読み込みだけで 13 分かかり、自動ループの tick が 2700 秒の上限で打ち切られた
（実測 2026-09-05、終了コード 124）。いまは各ディレクトリを

    construction.sage  再利用する厳密構成（関数の外に assert と print を置かない）
    check.sage         観測の出力と assertion（自分の construction.sage だけを読む）

に分け、下流は construction.sage だけを読む。この道具はその形が保たれているかを見る。
**assertion を減らしていないこと**（連鎖の各ディレクトリに check.sage が残っていること）も
ここで併せて見る。日次監査はその check.sage を全数で回す。

    python3 sagemath/tools/verify-construction-separation.py <根> <対象の check.sage>

根は load() のパスが基準にするディレクトリ（プロジェクト直下）。
問題があれば行ごとに理由を出力して終了コード 1 を返す。
"""
import ast
import os
import re
import sys


def loads_of(path):
    with open(path, encoding="utf-8") as handle:
        return re.findall(r'load\("([^"]+)"\)', handle.read())


def toplevel_check_lines(path):
    """関数の外にある assert と print の行番号。構成側にあってはならないもの。"""
    with open(path, encoding="utf-8") as handle:
        tree = ast.parse(handle.read())
    found = []

    def walk(node):
        for child in ast.iter_child_nodes(node):
            if isinstance(child, (ast.FunctionDef, ast.AsyncFunctionDef, ast.ClassDef)):
                continue
            if isinstance(child, ast.Assert):
                found.append(child.lineno)
            if (isinstance(child, ast.Call) and isinstance(child.func, ast.Name)
                    and child.func.id == "print"):
                found.append(child.lineno)
            walk(child)

    walk(tree)
    return sorted(found)


def load_closure(target):
    chain, stack = [], [target]
    while stack:
        path = stack.pop()
        if path in chain:
            continue
        chain.append(path)
        stack.extend(loads_of(path))
    return chain


def verify(root, target):
    os.chdir(root)
    if not os.path.exists(target):
        return ["対象の検算が無い: " + target]

    problems = []
    chain = load_closure(target)
    constructions = [p for p in chain if p.endswith("/construction.sage")]
    checks = [p for p in chain if p.endswith("/check.sage")]

    for extra in checks:
        if extra != target:
            problems.append("対象検算が上流の検算そのものを読んでいる: " + extra)
    if not constructions:
        problems.append("対象検算が上流の構成を一つも読んでいない（連鎖が切れている）")

    for path in constructions:
        lines = toplevel_check_lines(path)
        if lines:
            problems.append("構成に assertion／観測の出力が残っている: %s の %s 行目"
                            % (path, ", ".join(str(n) for n in lines)))

    for path in constructions:
        directory = os.path.dirname(path)
        own_check = os.path.join(directory, "check.sage")
        if not os.path.exists(own_check):
            problems.append("構成に対応する検算が無い（assertion が消えている）: " + own_check)
            continue
        if path not in loads_of(own_check):
            problems.append("検算が自分の構成を読んでいない: " + own_check)
        for dep in loads_of(own_check):
            if dep.endswith("/check.sage"):
                problems.append("検算が上流の検算を読んでいる: %s -> %s" % (own_check, dep))

    print("読み込み連鎖: 構成 %d 本、検算 %d 本" % (len(constructions), len(checks)))
    return problems


def main():
    if len(sys.argv) != 3:
        print(__doc__)
        return 2
    problems = verify(sys.argv[1], sys.argv[2])
    for problem in problems:
        print("NG: " + problem)
    return 1 if problems else 0


if __name__ == "__main__":
    sys.exit(main())

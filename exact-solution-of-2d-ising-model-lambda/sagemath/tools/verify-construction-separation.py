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


def _mutated_names(tree):
    """前の値へ足し込む形で書き換えられる名前（累算器）。"""
    names = set()
    for node in ast.walk(tree):
        if isinstance(node, ast.AugAssign):
            for target in ast.walk(node.target):
                if isinstance(target, ast.Name):
                    names.add(target.id)
        elif (isinstance(node, ast.Attribute) and isinstance(node.value, ast.Name)
              and node.attr in ("append", "update", "add", "setdefault", "extend")):
            names.add(node.value.id)
        elif isinstance(node, ast.Subscript) and isinstance(node.ctx, ast.Store):
            base = node.value
            while isinstance(base, ast.Subscript):
                base = base.value
            if isinstance(base, ast.Name):
                names.add(base.id)
    return names


def _plain_assigned(tree):
    """トップレベルの単純な代入で初期化される名前。"""
    names = set()
    for st in tree.body:
        if (isinstance(st, ast.Assign) and len(st.targets) == 1
                and isinstance(st.targets[0], ast.Name)):
            names.add(st.targets[0].id)
    return names


def double_counted_accumulators(construction_path, check_path):
    """構成でも check でも足し込まれるのに、check 側で初期化し直していない累算器。

    構成へ移した文にもとから assert が付いていると、その文は原文のまま check.sage へも
    置く（assertion を減らさないため）。このとき初期化が構成側にしかないと、構成での
    実行ぶんへ check がもう一度足し込み、件数の assert が落ちる
    （実測 2026-09-05: comparisons が 2,436 ではなく 4,872 になった）。
    """
    with open(construction_path, encoding="utf-8") as handle:
        construction = ast.parse(handle.read())
    with open(check_path, encoding="utf-8") as handle:
        check = ast.parse(handle.read())
    return sorted(
        _mutated_names(check)
        & _mutated_names(construction)
        & _plain_assigned(construction)
        - _plain_assigned(check)
    )


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
        doubled = double_counted_accumulators(path, own_check)
        if doubled:
            problems.append("check 側で初期化し直していない累算器がある（二重に足し込む）: %s の %s"
                            % (own_check, "、".join(doubled)))

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

#!/usr/bin/env bash
# lean/README.md と lean/docs/*.md が書く `.lean` のパスと `Ising2D.` の名前が、いまの Lean に実在するかを確かめる。
# 終了コード 0 なら OK。実在しないものがあれば、その行を列挙して 1 で終わる。
#
# 使い方:
#   cd exact-solution-of-2d-ising-model/lean && ./scripts/check-docs-references.sh
#
# 検査すること:
#   1. 本文に書かれた `.lean` のパスがすべて実在する。パスは lean/ 起点・Ising2D/ 起点・
#      mathlib（.lake/packages/mathlib）起点のどれか、またはいずれかの実在ファイルのパスの末尾として読む。
#      mathlib のパスは .lake が無ければ検査しない（lake exe cache get の後に検査される）。
#   2. `Ising2D.` で始まる名前がすべて、完全な名前で実在する。実在とは、Ising2D/ で宣言された定義・定理、
#      構造体の欄・コンストラクタ、名前空間、モジュール（Ising2D/X/Y.lean の Ising2D.X.Y）のどれかであること。
#      削除・改名の経緯を書いた段落（「削除」「以前」「かつて」「旧」を含む段落）は、消えた名前を書くのが正しいので除く。
#      段落は空行で区切り、表の行と箇条書きの項目はそれぞれ 1 つの段落とする。
#      `Ising2D.foo_*` は名前のまとまりとして読み、その接頭辞を持つ名前が 1 つでもあればよい。
# 検査しないこと: `.lean` 以外のパス、表に書かれた人手証明のラベル。
set -euo pipefail

cd "$(dirname "$0")/.."

python3 -I - <<'EOF'
import glob, os, re, sys

docs = ['README.md'] + sorted(glob.glob('docs/*.md'))
lean_files = sorted(glob.glob('Ising2D/**/*.lean', recursive=True)) + ['Ising2D.lean']
basenames = {os.path.basename(p) for p in lean_files}
mathlib = '.lake/packages/mathlib'
has_mathlib = os.path.isdir(mathlib)

ident = r"[A-Za-z_α-ωΑ-Ω][A-Za-z0-9_'!?₀-₟α-ωΑ-Ω]*"
decl = re.compile(r'^\s*(?:@\[[^\]]*\]\s*)?(?:private\s+|protected\s+|noncomputable\s+|nonrec\s+|partial\s+|unsafe\s+)*'
                  r'(theorem|lemma|def|abbrev|structure|class|instance|inductive)\s+(' + ident + r'(?:\.' + ident + r')*)')
field = re.compile(r'^\s+(' + ident + r'(?:\s+' + ident + r')*)\s*:')
ctor = re.compile(r'^\s*\|\s*(' + ident + r')')

known = set()
for f in lean_files:
    known.add(f[:-len('.lean')].replace('/', '.'))
    stack = []
    open_struct = None  # 本体を読んでいる構造体・帰納型の完全な名前
    for line in open(f, encoding='utf-8'):
        m = re.match(r'^\s*namespace\s+(\S+)', line)
        if m:
            stack.append(m.group(1))
            open_struct = None
            continue
        m = re.match(r'^\s*end\s+(\S+)', line)
        if m and stack and stack[-1] == m.group(1):
            stack.pop()
            open_struct = None
            continue
        m = decl.match(line)
        if m:
            full = '.'.join(stack + [m.group(2)])
            known.add(full)
            open_struct = full if m.group(1) in ('structure', 'class', 'inductive') else None
            if open_struct:
                known.add(full + '.mk')
            continue
        if open_struct:
            if line.strip() == '' or not line[:1].isspace() and not line.startswith('|'):
                if line.strip() != '' and not line.lstrip().startswith('--'):
                    open_struct = None
                continue
            m = ctor.match(line)
            if m:
                known.add(open_struct + '.' + m.group(1))
                continue
            m = field.match(line)
            if m and not line.lstrip().startswith(('--', '/-')):
                for name in m.group(1).split():
                    known.add(open_struct + '.' + name)
# 名前空間（宣言の完全な名前の接頭辞）
for name in list(known):
    parts = name.split('.')
    for k in range(1, len(parts)):
        known.add('.'.join(parts[:k]))

path_re = re.compile(r'[A-Za-z0-9_./\-]+\.lean')
name_re = re.compile(r"(?<![A-Za-z0-9_/.])(Ising2D\.[A-Za-z0-9_'!?.₀-₟α-ωΑ-Ω]+)(\*?)")
history = re.compile(r'削除|以前|かつて|旧')
item_start = re.compile(r'^\s*(?:[-*+]|\d+\.)\s|^\s*\|')

def path_ok(raw):
    p = raw
    while p.startswith('./'):
        p = p[2:]
    if p.startswith('lean/'):
        p = p[len('lean/'):]
    if p.startswith('.lake/'):
        return (not has_mathlib) or os.path.exists(p)
    if p.startswith('Mathlib/'):
        return (not has_mathlib) or os.path.exists(os.path.join(mathlib, p))
    if os.path.exists(p) or os.path.exists('Ising2D/' + p):
        return True
    if '/' not in p:
        return p in basenames
    return any(f.endswith('/' + p) for f in lean_files)

def paragraph_flags(lines):
    # 各行が属する段落が経緯を書いているか。表の行と箇条書きの項目は、それぞれ新しい段落を始める。
    flags = [False] * len(lines)
    start = None
    def close(end):
        if start is not None:
            h = any(history.search(lines[i]) for i in range(start, end))
            for i in range(start, end):
                flags[i] = h
    for i, line in enumerate(lines):
        if line.strip() == '':
            close(i)
            start = None
        elif item_start.match(line) or start is None:
            close(i)
            start = i
    close(len(lines))
    return flags

bad = []
for d in docs:
    lines = open(d, encoding='utf-8').read().splitlines()
    for ln, (line, is_history) in enumerate(zip(lines, paragraph_flags(lines)), 1):
        for p in path_re.findall(line):
            if (p.startswith('Part0') or '/Part0' in p) and is_history:
                continue
            if not path_ok(p):
                bad.append(f'{d}:{ln}: 実在しないパス {p}')
        if is_history:
            continue
        for m in name_re.finditer(line):
            n, star = m.group(1), m.group(2)
            quoted = m.start() > 0 and line[m.start() - 1] == "'"
            n = n.rstrip('.')
            if n.endswith('.lean'):
                continue
            if star:
                # `Ising2D.foo_*` は名前のまとまり。その接頭辞を持つ名前が 1 つでもあればよい。
                ok = any(k.startswith(n) and k != n for k in known)
            else:
                # `'Ising2D.foo'` の閉じの引用符（#print axioms の出力）は名前に含めない。
                ok = n in known or (quoted and n.endswith("'") and n[:-1] in known)
            if not ok:
                bad.append(f'{d}:{ln}: 実在しない名前 {n}{star}')

if bad:
    print('\n'.join(bad))
    print(f'NG: {len(bad)} 件')
    sys.exit(1)
print('OK: lean/README.md と lean/docs/ が書く .lean のパスと Ising2D. の名前はすべて実在する')
EOF

#!/usr/bin/env bash
# lean/README.md と lean/docs/*.md が書く `.lean` のパスと `Ising2D.` の名前が、いまの Lean に実在するかと、
# Ising2D/ の全ファイルが文書の表か見出しに出るかと、表の人手証明のラベルが人手証明に実在するかを確かめる。
# 終了コード 0 なら OK。実在しないものがあれば、その行を列挙して 1 で終わる。
#
# 使い方:
#   cd exact-solution-of-2d-ising-model/lean && ./scripts/check-docs-references.sh
#
# 検査すること:
#   1. 本文に書かれた `.lean` のパスがすべて実在する。パスは lean/ 起点・Ising2D/ 起点・
#      mathlib（.lake/packages/mathlib）起点のどれか、またはいずれかの実在ファイルのパスの末尾として読む。
#      mathlib のパスは .lake/packages/mathlib/Mathlib が無ければ検査しない（lake exe cache get の後に検査される）。
#   2. `Ising2D.` で始まる名前がすべて、完全な名前で実在する。実在とは、Ising2D/ で宣言された定義・定理、
#      構造体の欄・コンストラクタ、名前空間、モジュール（Ising2D/X/Y.lean の Ising2D.X.Y）のどれかであること。
#      削除・改名の経緯を書いた段落（「削除」「以前」「かつて」「旧」を含む段落）は、消えた名前を書くのが正しいので除く。
#      段落は空行で区切り、表の行と箇条書きの項目はそれぞれ 1 つの段落とする。
#      `Ising2D.foo_*` は名前のまとまりとして読み、その接頭辞を持つ名前が 1 つでもあればよい。
#   3. Ising2D/ の下の `.lean` ファイルがすべて、どれかの文書の表の行か見出しに、経緯を書いた段落の外で
#      ファイル名で出る。ファイル名は Ising2D/ 起点のパスの末尾として読み、その末尾で 1 つのファイルに決まるものだけを数える
#      （`Foo.lean` と書けば、`Foo.lean` という名前のファイルが 1 つしか無いときだけ数える）。
#      コードブロック（``` で囲んだ範囲）の中の行は数えない。表の行は、どの列にファイル名が出ても数えるので、
#      その行がそのファイルの主張を書いているかまでは確かめない。
#   4. 表の人手証明の列（見出しに「人手」「原文」「ラベル」を含み「記号」を含まない列）に `` ` `` で囲んで書いた、
#      `_` を含む名前（`<…>` で囲んだものは中身）がすべて、人手証明に実在する。名前とは、英字か漢字・仮名で始まり、
#      英数字・`_`・`-`・漢字・仮名だけから成るものである（ギリシャ文字・空白・`/`・`^` などを含むものは式やパスとして除く）。
#      列は `` ` `` の外の `|` だけで区切る。実在とは次のどれかであること。
#      - 本文（../structured-latex/content/）のブロックの labels か id にある。
#      - 参照用ノート（../structured-latex/notes/）の文に、退避した記録「labels: …」か「ブロック <id>」として出て、
#        そのノートのファイル名が、同じ表の行か、表の前の文に出る。表の前の文とは、直前の見出しか直前の表の終わりの
#        どちらか後のほうから、表の見出し行までの、コードブロックの外の行である。
#      Lean の名前は `Ising2D.` を付けて書く（`.` を含むので、この検査ではなく検査 2 が見る）。
# 検査しないこと: `.lean` 以外のパス、表の人手証明の列の外に書かれた人手証明のラベル、`_` を含まないラベル（いまの本文には無い）。
#   なお、表の最初の行の次が区切り行でないもの（見出しの行を持たない表。GitHub でも表として表示されない）は不合格にする。
set -euo pipefail

cd "$(dirname "$0")/.."

python3 -I - <<'EOF'
import glob, os, re, sys

docs = ['README.md'] + sorted(glob.glob('docs/*.md'))
lean_files = sorted(glob.glob('Ising2D/**/*.lean', recursive=True)) + ['Ising2D.lean']
basenames = {os.path.basename(p) for p in lean_files}
mathlib = '.lake/packages/mathlib'
has_mathlib = os.path.isdir(os.path.join(mathlib, 'Mathlib'))

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

# Ising2D/ 起点のパスの末尾（ディレクトリの区切りで切ったもの）から、それで決まるファイルへの対応。
# 2 つ以上のファイルの末尾になるものは、どのファイルも指さない。
suffix_owner = {}
for f in lean_files:
    if not f.startswith('Ising2D/'):
        continue
    parts = f[len('Ising2D/'):].split('/')
    for k in range(len(parts)):
        suf = '/'.join(parts[k:])
        suffix_owner[suf] = None if suf in suffix_owner else f
listed = set()

bad = []
for d in docs:
    lines = open(d, encoding='utf-8').read().splitlines()
    in_code = False
    for ln, (line, is_history) in enumerate(zip(lines, paragraph_flags(lines)), 1):
        if line.lstrip().startswith('```'):
            in_code = not in_code
        if not in_code and not is_history and line.lstrip().startswith(('|', '#')):
            for p in path_re.findall(line):
                q = p
                while q.startswith('./'):
                    q = q[2:]
                for prefix in ('lean/', 'Ising2D/'):
                    if q.startswith(prefix):
                        q = q[len(prefix):]
                owner = suffix_owner.get(q)
                if owner:
                    listed.add(owner)
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

# 検査 4: 表の人手証明の列のラベル
sl = '../structured-latex'
human_names = set()
for f in glob.glob(sl + '/content/*.ts'):
    t = open(f, encoding='utf-8').read()
    for m in re.finditer(r'\blabels:\s*\[([^\]]*)\]', t):
        human_names |= set(re.findall(r'"([^"]+)"', m.group(1)))
    human_names |= set(re.findall(r'\bid:\s*"([^"]+)"', t))
retired = {}  # 退避した名前 → それを記録した参照用ノートのファイル名
for f in glob.glob(sl + '/notes/*.ts'):
    t = open(f, encoding='utf-8').read()
    found = set(re.findall(r'ブロック\s*([A-Za-z0-9_]+)', t))
    for m in re.finditer(r'labels:\s*([^。）\n"]+)', t):
        found |= {x.strip() for x in re.split(r'[,、]', m.group(1)) if x.strip()}
    for x in found:
        retired.setdefault(x, set()).add(os.path.basename(f))
code_span = re.compile(r'`([^`]*)`')
label_shape = re.compile(r'^[A-Za-z\u3040-\u30ff\u4e00-\u9fff][A-Za-z0-9_\-\u3040-\u30ff\u4e00-\u9fff]*$')

def split_cells(row):
    # `` ` `` の外の `|` だけで区切る（`|γ_2|^2` のような式の中の `|` で列をずらさない）
    cells, cur, in_tick = [], '', False
    for ch in row.strip().strip('|'):
        if ch == '`':
            in_tick = not in_tick
        if ch == '|' and not in_tick:
            cells.append(cur.strip())
            cur = ''
        else:
            cur += ch
    cells.append(cur.strip())
    return cells

def label_names(cell):
    for raw in code_span.findall(cell):
        t = raw[1:-1] if raw.startswith('<') and raw.endswith('>') else raw
        if '_' in t and label_shape.match(t):
            yield t
for d in docs:
    lines = open(d, encoding='utf-8').read().splitlines()
    cols = None
    lead = ''  # 表の前の文（直前の見出しか直前の表の終わりから、コードブロックの外の行）
    in_code = False
    for ln, line in enumerate(lines, 1):
        fence = line.lstrip().startswith('```')
        if fence:
            in_code = not in_code
        if fence or in_code or not line.startswith('|'):
            if cols is not None:
                lead = ''
            cols = None
            if fence or in_code:
                continue
            if line.startswith('#'):
                lead = ''
            lead += line + '\n'
            continue
        cells = split_cells(line)
        if cols is None:
            nxt = lines[ln] if ln < len(lines) else ''
            if not re.match(r'^\|[\s:|-]+\|?\s*$', nxt) or '-' not in nxt:
                bad.append(f'{d}:{ln}: 表の最初の行の次が区切り行でない（見出し行の無い表。表の途中に引用ブロックなどを挟まない）')
            cols = [k for k, c in enumerate(cells) if re.search('人手|原文|ラベル', c) and '記号' not in c]
            continue
        if set(cells[0]) <= set('-: '):
            continue
        for k in cols:
            if k >= len(cells):
                continue
            for t in label_names(cells[k]):
                if t in human_names:
                    continue
                if any(nb in line or nb in lead for nb in retired.get(t, ())):
                    continue
                where = '、'.join(sorted(retired.get(t, ())))
                hint = f'（参照用ノート {where} に退避の記録があるが、そのファイル名が行にも表の前の文にも無い）' if where else ''
                bad.append(f'{d}:{ln}: 人手証明に実在しないラベル {t}{hint}')

for f in lean_files:
    if f.startswith('Ising2D/') and f not in listed:
        bad.append(f'{f}: どの文書の表の行にも見出しにもファイル名で出ない')

if bad:
    print('\n'.join(bad))
    print(f'NG: {len(bad)} 件')
    sys.exit(1)
print('OK: lean/README.md と lean/docs/ が書く .lean のパスと Ising2D. の名前と表の人手証明のラベルはすべて実在し、Ising2D/ の全ファイルが表か見出しに出る')
EOF

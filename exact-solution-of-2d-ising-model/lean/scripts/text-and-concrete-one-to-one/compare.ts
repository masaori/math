// 本文のブロックと具体版の宣言を突き合わせ、一対一でない箇所を一行ずつ標準出力へ書く。check.sh から呼ばれる。
//
// 使い方: node compare.ts <Dependencies.lean の書き出し lean.tsv> <本文の content ディレクトリ> <件数の書き出し先>
//
// 本文の側（structured-latex/content/*.ts）:
//   - 数えるブロックは定義・主張・定理（kind が definition・claim・theorem）である。ブロックの名前はラベルの最初のものとする。
//   - ブロックが根拠として引くブロックは、証明（proof）と主張（statement）の中の参照（ref ノード）と、文字列の中の \blkref{…} の
//     宛先である。主張の中の参照も数えるのは、主張が仮定や記号の範囲として引く主張も、具体版の証明が使うからである。
//     比べるのは引かれたブロックのうち主張と定理だけで、定義は比べない（主張どうしの依存を比べる）。
//   - runbook の「証明の後の注で触れるだけの参照は根拠に数えない」について: 本文の書式は証明と注を分ける構造を持たないので、
//     証明の中の参照は全て数える（2026-11-21 の本文で、証明の後の「なお、…」の段落が引くのは定義だけで、結果に影響しない）。
// Lean の側（lean.tsv）:
//   - 具体版の宣言が対応するブロックは、docstring の先頭の太字の中にバッククォートで書いた語のうち、最初に現れる
//     「本文のラベルか、ラベルの形の語（下線で区切った三つ以上の語。山括弧 <…> や &lt;…&gt; で囲んだものは外して読む）」である。
//     太字はほかのブロックの名前も出す（「`A` の Step 3 が引く `B`」）ので、対応先は最初の一つだけにする。
//     ラベルの形なのに本文に無い語が最初に現れた宣言は、UNKNOWN_LABEL_IN_DOCSTRING の行に出し、どのブロックにも対応させず、たどらない。
//     下線が一つの語（`Y_m` など）は記号と見分けられないのでラベルの形に数えない。そのため二語の古いラベルが太字の先頭にあると読み飛ばす。
//   - 一つのブロックに対応する具体版の宣言が二つ以上あるときは（Step ごとの宣言、特殊化した宣言）、全てから依存をたどった和で比べる。
//     主の宣言を一つに決める書き方は、本文に Lean の対応先の欄を足す行（状態台帳）で入れる。
//   - 主張・定理のブロック B について、B に対応する具体版の宣言から証明の依存をたどる。たどった宣言が
//       ・B 以外のブロックに対応する具体版の宣言なら、そのブロックを Lean の証明が使うブロックに数え、その先はたどらない。
//       ・B 以外のブロックに対応する、具体版でない宣言（必要十分版・導出）なら、使ったことに数えず、たどらない。
//       ・B に対応する宣言か、どのブロックにも対応しない具体版の定理（証明の中の補題）なら、その証明の中へ進む。
//       ・それ以外（定義、必要十分版・導出・RoutesNotAdopted の宣言でどのブロックにも対応しないもの）は、たどらない。
//     したがって、本文が引く主張と同じ内容を証明の中の補題として作り直したものは、その主張を使ったことにならない。
//     必要十分版や導出の定理を特殊化しただけの具体版は、本文が引く主張を使わないことになる。
//
// 書き出す行（タブ区切り）:
//   NO_CONCRETE_DECLARATION  <ブロック>            対応する具体版の宣言が無い定義・主張・定理
//   UNKNOWN_LABEL_IN_DOCSTRING  <具体版の宣言>  <語>  docstring の先頭の太字が、本文に無いラベルを指す具体版の宣言
//   CITED_ONLY_IN_TEXT       <ブロック>  <引くブロック>  本文の証明か主張が引くのに、具体版の証明が使わない主張・定理
//   USED_ONLY_IN_LEAN        <ブロック>  <使うブロック>  具体版の証明が使うのに、本文の証明も主張も引かない主張・定理
// 後の二つは、具体版の宣言を持つ主張・定理のブロックについてだけ出す。
import { readFileSync, readdirSync, writeFileSync } from "node:fs";
import { join, resolve } from "node:path";

const [leanTsv, contentDir, countsPath] = process.argv.slice(2);
if (!leanTsv || !contentDir || !countsPath) {
  console.error("使い方: node compare.ts <lean.tsv> <content ディレクトリ> <件数の書き出し先>");
  process.exit(2);
}

type TextBlock = { name: string; kind: string; labels: string[]; cites: Set<string> };

const countedKinds = new Set(["definition", "claim", "theorem"]);
const claimKinds = new Set(["claim", "theorem"]);

// --- 本文 ---------------------------------------------------------------------

/** 証明の木から、参照の宛先と \blkref の宛先を集める。 */
function collectRefs(node: unknown, out: Set<string>): void {
  if (typeof node === "string") {
    for (const m of node.matchAll(/\\blkref\{([^}]+)\}/g)) out.add(m[1]);
    return;
  }
  if (Array.isArray(node)) {
    for (const x of node) collectRefs(x, out);
    return;
  }
  if (node !== null && typeof node === "object") {
    const o = node as Record<string, unknown>;
    if (o.type === "ref" && typeof o.target === "string") out.add(o.target);
    for (const v of Object.values(o)) collectRefs(v, out);
  }
}

const blocks: TextBlock[] = [];
const blockOfLabel = new Map<string, TextBlock>();
const seenIds = new Set<string>();
for (const f of readdirSync(contentDir).filter((f) => f.endsWith(".ts")).sort()) {
  const mod = await import(resolve(join(contentDir, f)));
  for (const v of Object.values(mod)) {
    if (!Array.isArray(v)) continue;
    for (const b of v as Array<{ id?: string; labels?: string[]; kind?: string; proof?: unknown }>) {
      if (!b || typeof b !== "object" || !Array.isArray(b.labels) || b.labels.length === 0) continue;
      if (!countedKinds.has(b.kind ?? "")) continue;
      // 同じブロックを二つ以上の書き出しの名前で持つモジュールがあっても、一度だけ数える。
      if (seenIds.has(b.id ?? "")) continue;
      seenIds.add(b.id ?? "");
      const cites = new Set<string>();
      collectRefs(b.proof ?? [], cites);
      collectRefs((b as { statement?: unknown }).statement ?? [], cites);
      const tb: TextBlock = { name: b.labels[0], kind: b.kind!, labels: [...b.labels], cites };
      blocks.push(tb);
      for (const l of b.labels) blockOfLabel.set(l, tb);
    }
  }
}

// --- Lean ---------------------------------------------------------------------

type Decl = { name: string; theorem: boolean; concrete: boolean; labeled: boolean; blocks: Set<TextBlock>; uses: string[] };
const labelShaped = /^[A-Za-z][A-Za-z0-9]*(_[A-Za-z0-9]+){2,}$/;
const unknownLabels: string[] = [];
const decls = new Map<string, Decl>();
const pendingUses: Array<[string, string]> = [];
for (const line of readFileSync(leanTsv, "utf8").split("\n")) {
  if (!line) continue;
  const cols = line.split("\t");
  if (cols[0] === "DECL") {
    const [, name, , kind, concrete, bold = ""] = cols;
    if (decls.has(name)) {
      console.error(`NG: 同じ名前の宣言が二つある（private の宣言の名前が重なった）: ${name}`);
      process.exit(2);
    }
    const bs = new Set<TextBlock>();
    let labeled = false;
    for (const m of bold.matchAll(/`([^`]+)`/g)) {
      const w = m[1].trim().replace(/^&lt;(.*)&gt;$/, "$1").replace(/^<(.*)>$/, "$1");
      const b = blockOfLabel.get(w);
      if (b) {
        bs.add(b);
        labeled = true;
        break;
      }
      if (labelShaped.test(w)) {
        labeled = true;
        if (concrete === "1") unknownLabels.push(`UNKNOWN_LABEL_IN_DOCSTRING\t${name}\t${w}`);
        break;
      }
    }
    decls.set(name, { name, theorem: kind === "theorem", concrete: concrete === "1", labeled, blocks: bs, uses: [] });
  } else if (cols[0] === "USES") {
    pendingUses.push([cols[1], cols[2]]);
  } else {
    console.error(`NG: 読めない行: ${line}`);
    process.exit(2);
  }
}
for (const [a, b] of pendingUses) decls.get(a)?.uses.push(b);

const concreteOf = new Map<TextBlock, Decl[]>();
for (const d of decls.values()) {
  if (!d.concrete) continue;
  for (const b of d.blocks) concreteOf.set(b, [...(concreteOf.get(b) ?? []), d]);
}

/** ブロック B に対応する具体版の宣言の証明がたどって使う、B 以外のブロック。 */
function usedBlocks(b: TextBlock, starts: Decl[]): Set<TextBlock> {
  const used = new Set<TextBlock>();
  const seen = new Set<string>();
  const stack = [...starts];
  while (stack.length > 0) {
    const d = stack.pop()!;
    if (seen.has(d.name)) continue;
    seen.add(d.name);
    for (const un of d.uses) {
      const u = decls.get(un);
      if (!u) continue;
      if (!u.concrete) continue;
      let enter = !u.labeled;
      for (const c of u.blocks) {
        if (c === b) enter = true;
        else used.add(c);
      }
      if (enter && u.theorem) stack.push(u);
    }
  }
  return used;
}

// --- 突き合わせ ---------------------------------------------------------------

const rows: string[] = [...unknownLabels];
let withConcrete = 0;
let compared = 0;
let matched = 0;
for (const b of blocks) {
  const starts = concreteOf.get(b) ?? [];
  if (starts.length === 0) {
    rows.push(`NO_CONCRETE_DECLARATION\t${b.name}`);
    continue;
  }
  withConcrete++;
  if (!claimKinds.has(b.kind)) continue;
  compared++;
  const cited = new Set<string>();
  for (const l of b.cites) {
    const c = blockOfLabel.get(l);
    if (c && c !== b && claimKinds.has(c.kind)) cited.add(c.name);
  }
  const used = new Set<string>();
  for (const c of usedBlocks(b, starts)) if (claimKinds.has(c.kind)) used.add(c.name);
  let same = true;
  for (const c of cited) if (!used.has(c)) { rows.push(`CITED_ONLY_IN_TEXT\t${b.name}\t${c}`); same = false; }
  for (const c of used) if (!cited.has(c)) { rows.push(`USED_ONLY_IN_LEAN\t${b.name}\t${c}`); same = false; }
  if (same) matched++;
}

for (const r of rows.sort()) console.log(r);
writeFileSync(
  countsPath,
  [
    `本文の定義・主張・定理のブロック\t${blocks.length}`,
    `具体版の宣言を持つブロック\t${withConcrete}`,
    `比べた主張・定理\t${compared}`,
    `引く主張と使う主張が一致する主張・定理\t${matched}`,
  ].join("\n") + "\n",
);

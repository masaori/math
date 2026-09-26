// 数式中の指数関数を e^{…} ではなく \exp(…) で書かせるための書き換え器と検査器。
//
//   node tools/codemod-e-power-to-exp.ts          # content/ と notes/ を書き換える
//   node tools/codemod-e-power-to-exp.ts --check  # 書き換え対象が残っていれば非零で終わる
//
// 対象は文字列リテラルとテンプレートリテラルの中身だけで、conversion の記録（経緯の文字列）は
// 書き換えない。e の直前が「\ に続く英字の並び」なら LaTeX コマンドの一部なので対象外とする。
import { readdirSync, readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";

const root = new URL("..", import.meta.url).pathname;
const dirs = ["content", "notes"];

type Hit = { file: string; line: number; text: string };

function isLetter(c: string | undefined): boolean {
  return c !== undefined && /[A-Za-z]/.test(c);
}

function startsExpCommand(s: string, i: number): boolean {
  if (s[i] !== "e" || s[i + 1] !== "^") return false;
  let k = i - 1;
  while (k >= 0 && isLetter(s[k])) k--;
  return !(k >= 0 && s[k] === "\\" && k < i);
}

// 文字列の中身（エスケープ前の LaTeX）を書き換える。bs は LaTeX の \ 1 個を表す綴り。
function rewriteLatex(s: string, bs: string): { out: string; count: number } {
  let out = "";
  let count = 0;
  let i = 0;
  while (i < s.length) {
    if (!startsExpCommand(s, i)) {
      out += s[i];
      i++;
      continue;
    }
    let j = i + 2;
    let arg: string;
    if (s[j] === "{") {
      let depth = 1;
      let k = j + 1;
      while (k < s.length && depth > 0) {
        if (s[k] === "{") depth++;
        else if (s[k] === "}") depth--;
        k++;
      }
      if (depth !== 0) throw new Error(`波括弧が閉じていない: ${s.slice(i, i + 40)}`);
      arg = s.slice(j + 1, k - 1);
      j = k;
    } else if (s.startsWith(bs, j) && isLetter(s[j + bs.length])) {
      let k = j + bs.length;
      while (isLetter(s[k])) k++;
      arg = s.slice(j, k);
      j = k;
    } else {
      arg = s[j] ?? "";
      j++;
    }
    const inner = rewriteLatex(arg, bs);
    out += `${bs}exp(${inner.out})`;
    count += 1 + inner.count;
    i = j;
  }
  return { out, count };
}

function processFile(src: string, file: string, hits: Hit[]): string {
  let out = "";
  let i = 0;
  let braceDepth = 0;
  let skipUntilDepth: number | null = null;
  let pendingConversion = false;
  const lineOf = (pos: number) => src.slice(0, pos).split("\n").length;
  while (i < src.length) {
    const c = src[i];
    if (c === "/" && src[i + 1] === "/") {
      const e = src.indexOf("\n", i);
      const end = e < 0 ? src.length : e;
      out += src.slice(i, end);
      i = end;
      continue;
    }
    if (c === "/" && src[i + 1] === "*") {
      const end = src.indexOf("*/", i) + 2;
      out += src.slice(i, end);
      i = end;
      continue;
    }
    if (c === '"' || c === "'" || c === "`") {
      let k = i + 1;
      while (k < src.length && src[k] !== c) {
        if (src[k] === "\\") k++;
        k++;
      }
      const body = src.slice(i + 1, k);
      const raw = c === "`" && src.slice(Math.max(0, i - 10), i).endsWith("String.raw");
      if (skipUntilDepth === null) {
        const { out: rewritten, count } = rewriteLatex(body, raw ? "\\" : "\\\\");
        if (count > 0) hits.push({ file, line: lineOf(i), text: body.slice(0, 80) });
        out += c + rewritten + c;
      } else {
        out += c + body + c;
      }
      i = k + 1;
      continue;
    }
    if (src.startsWith("conversion:", i) && !isLetter(src[i - 1])) pendingConversion = true;
    if (c === "{") {
      braceDepth++;
      if (pendingConversion && skipUntilDepth === null) {
        skipUntilDepth = braceDepth;
        pendingConversion = false;
      }
    } else if (c === "}") {
      if (skipUntilDepth !== null && braceDepth === skipUntilDepth) skipUntilDepth = null;
      braceDepth--;
    }
    out += c;
    i++;
  }
  return out;
}

const check = process.argv.includes("--check");
const hits: Hit[] = [];
for (const d of dirs) {
  for (const name of readdirSync(join(root, d)).filter((n) => n.endsWith(".ts")).sort()) {
    const path = join(root, d, name);
    const src = readFileSync(path, "utf8");
    const out = processFile(src, `${d}/${name}`, hits);
    if (!check && out !== src) writeFileSync(path, out);
  }
}
if (check) {
  for (const h of hits) console.error(`${h.file}:${h.line}: e^… が残っている: ${h.text}`);
  if (hits.length > 0) {
    console.error(`指数関数は \\exp(…) で書く。node tools/codemod-e-power-to-exp.ts で書き換えられる（${hits.length} 箇所）`);
    process.exit(1);
  }
  console.log("e^… の形の指数関数は残っていない");
} else {
  console.log(`${hits.length} 個の文字列を書き換えた`);
}

/**
 * TeX 文字列と日本語散文から「照合に使える単位」を取り出す共通処理。
 *
 * **何のためにあるか**: 「根拠 report にあった仮定・例外・添字が、本文へ移す段で落ちる」型の
 * 事故が 3 回起きている（cycle 18 命題 N の例外集合／cycle 20 桁定理の暗黙の仮定 $A_1\equiv0$／
 * cycle 21 命題 R (R1) の係数の添字）。**いずれも根拠 report 側は正しく、本文だけが壊れていた。**
 * したがって「report の該当箇所」と「本文ブロック」を機械的に突き合わせる必要があり、
 * そのための最小単位を切り出すのがこのモジュールである。
 *
 * ここでやらないこと（できないことを明示する）:
 *   - TeX の構文解析はしない。字句の水準で切るだけである。数式の**意味**は見ない。
 *   - 文の意味は見ない。散文からは語を取り出すだけで、否定・条件・限定は読まない。
 */

/** 数式アトム: 記号 1 つと、それに直接ついた添字・肩の飾りをまとめたもの。 */
export type Atom = string;

/** TeX の字句。`kind` は照合の粒度を選ぶために持つ。 */
export type Token = { kind: "macro" | "letter" | "digits" | "op" | "brace" | "script"; text: string };

/**
 * 照合で無視する構造マクロ。**記号ではなく組版の指示**なので、
 * これが日英や report と本文で違っても数学は変わらない。
 */
const STRUCTURAL_MACROS = new Set([
  "\\begin", "\\end", "\\left", "\\right", "\\big", "\\Big", "\\bigl", "\\bigr",
  "\\Bigl", "\\Bigr", "\\bigg", "\\Bigg", "\\biggl", "\\biggr", "\\quad", "\\qquad",
  "\\displaystyle", "\\textstyle", "\\ ", "\\,", "\\;", "\\!", "\\\\", "\\notag", "\\tag",
]);

/** 中身が地の文であるマクロ（＝翻訳の対象）。 */
export const TEXT_MACROS = ["\\text", "\\textbf", "\\textit", "\\textrm", "\\mbox"] as const;

/** TeX を字句へ切る。`\text{...}` の中身は 1 つの `text` 字句として畳む前に呼ぶ側で処理する。 */
export function tokenize(tex: string): Token[] {
  const tokens: Token[] = [];
  let i = 0;
  while (i < tex.length) {
    const c = tex[i]!;
    if (/\s/.test(c)) { i += 1; continue; }
    if (c === "\\") {
      const m = /^\\[a-zA-Z]+/.exec(tex.slice(i));
      if (m !== null) { tokens.push({ kind: "macro", text: m[0] }); i += m[0].length; continue; }
      tokens.push({ kind: "macro", text: tex.slice(i, i + 2) });
      i += 2;
      continue;
    }
    if (/[a-zA-Z]/.test(c)) { tokens.push({ kind: "letter", text: c }); i += 1; continue; }
    if (/[0-9]/.test(c)) {
      const m = /^[0-9]+/.exec(tex.slice(i))!;
      tokens.push({ kind: "digits", text: m[0] });
      i += m[0].length;
      continue;
    }
    if (c === "{" || c === "}") { tokens.push({ kind: "brace", text: c }); i += 1; continue; }
    if (c === "_" || c === "^") { tokens.push({ kind: "script", text: c }); i += 1; continue; }
    tokens.push({ kind: "op", text: c });
    i += 1;
  }
  return tokens;
}

/**
 * 数式アトムの多重集合を返す。
 *
 * アトム＝「基底記号 ＋ 直後に続く `_{...}` / `^{...}` の飾り」。
 * $\mu$ と $\mu_\gamma$ と $\mu_{c+\ell\gamma}$ を**別物として区別する**のが目的である
 * （cycle 21 の事故はここが潰れて起きた）。
 */
export function atomsOf(tex: string): Atom[] {
  const tokens = tokenize(stripTextMacroBodies(tex));
  const atoms: Atom[] = [];
  let i = 0;
  while (i < tokens.length) {
    const t = tokens[i]!;
    if ((t.kind !== "macro" && t.kind !== "letter") || STRUCTURAL_MACROS.has(t.text)) { i += 1; continue; }
    let atom = t.text;
    let j = i + 1;
    // 直後に続く飾りを、順序に依らず（`_`→`^` でも `^`→`_` でも）同じ形へ畳む。
    const decorations: string[] = [];
    while (j < tokens.length && tokens[j]!.kind === "script") {
      const script = tokens[j]!.text;
      const [group, next] = readGroup(tokens, j + 1);
      if (group === undefined) break;
      decorations.push(script + "{" + group + "}");
      j = next;
    }
    atom += decorations.sort().join("");
    atoms.push(atom);
    i = j;
  }
  return atoms;
}

/** `{...}` か単一字句を読み、その中身の文字列と次の位置を返す。 */
function readGroup(tokens: readonly Token[], start: number): [string | undefined, number] {
  const first = tokens[start];
  if (first === undefined) return [undefined, start];
  if (first.text !== "{") return [first.text, start + 1];
  let depth = 0;
  const parts: string[] = [];
  let i = start;
  for (; i < tokens.length; i += 1) {
    const t = tokens[i]!;
    if (t.text === "{") { depth += 1; if (depth === 1) continue; }
    if (t.text === "}") { depth -= 1; if (depth === 0) { i += 1; break; } }
    parts.push(t.text);
  }
  return [parts.join(""), i];
}

/**
 * `\text{...}` 系の**中身だけ**を取り除く（`@` へ置き換えるのではなく消す）。
 * 中身は地の文であって数式ではないので、記号の照合からは外す。
 */
export function stripTextMacroBodies(tex: string): string {
  let out = tex;
  for (const macro of TEXT_MACROS) {
    let index = out.indexOf(macro + "{");
    while (index >= 0) {
      const open = index + macro.length;
      const close = matchBrace(out, open);
      if (close < 0) break;
      out = out.slice(0, index) + " " + out.slice(close + 1);
      index = out.indexOf(macro + "{");
    }
  }
  return out;
}

/**
 * `\text{...}` 系の中身を `@` 1 文字へ置き換える（位置は保つ）。
 * 「地の文だけを英訳し、記号は 1 文字も変えていない」ことの検査に使う。
 */
export function maskTextMacroBodies(tex: string): string {
  let out = tex;
  for (const macro of TEXT_MACROS) {
    let index = out.indexOf(macro + "{");
    while (index >= 0) {
      const open = index + macro.length;
      const close = matchBrace(out, open);
      if (close < 0) break;
      out = out.slice(0, index) + "\\TEXTBODY{@}" + out.slice(close + 1);
      index = out.indexOf(macro + "{");
    }
  }
  return out;
}

function matchBrace(s: string, openIndex: number): number {
  if (s[openIndex] !== "{") return -1;
  let depth = 0;
  for (let i = openIndex; i < s.length; i += 1) {
    if (s[i] === "{") depth += 1;
    else if (s[i] === "}") { depth -= 1; if (depth === 0) return i; }
  }
  return -1;
}

/** 空白の入れ方だけを揃える（記号は書き換えない）。 */
export const normalizeSpaces = (tex: string): string => tex.replaceAll(/\s+/g, " ").trim();

/**
 * 数式として意味を持つ字句だけを残した多重集合。
 * 括弧・句読点・添字記号は落とす（翻訳で語順が変わると位置も句読点も動くため）。
 */
export function meaningfulTokens(tex: string): string[] {
  return tokenize(stripTextMacroBodies(tex))
    .filter((t) => (t.kind === "macro" && !STRUCTURAL_MACROS.has(t.text)) ||
      t.kind === "letter" || t.kind === "digits" ||
      (t.kind === "op" && !",.;:()[]".includes(t.text)))
    .map((t) => t.text);
}

/** 多重集合として等しいか。 */
export function sameMultiset(a: readonly string[], b: readonly string[]): boolean {
  if (a.length !== b.length) return false;
  const count = new Map<string, number>();
  for (const x of a) count.set(x, (count.get(x) ?? 0) + 1);
  for (const x of b) {
    const n = count.get(x);
    if (n === undefined || n === 0) return false;
    count.set(x, n - 1);
  }
  return true;
}

/**
 * 日本語の散文から**専門語らしい語**を取り出す。
 *
 * 漢字・カタカナの連なり 2 文字以上を語とみなし、汎用語（下記）を落とす。
 * 形態素解析はしない（辞書を持ち込まない）。したがって語の切り出しは粗く、
 * **「この語が本文に出てこない」ことは疑いの根拠であって、誤りの証明ではない**。
 */
export function proseTerms(text: string): string[] {
  const found = text.match(/[一-鿿々゠-ヿー]{2,}/g) ?? [];
  return [...new Set(found.filter((w) => !GENERIC_TERMS.has(w)))];
}

/** 落とす汎用語。数学的な内容を持たない語だけをここへ置く。 */
const GENERIC_TERMS = new Set([
  "以下", "以上", "以外", "場合", "使用", "利用", "確認", "検証", "結果", "方法", "内容",
  "部分", "全体", "今回", "今後", "上記", "下記", "同様", "同じ", "自分", "本文", "本節", "最後", "最初",
  "本項", "本稿", "参照", "注意", "説明", "記述", "記号", "定義", "命題", "定理", "補題",
  "証明", "系統", "系列", "問題", "対象", "必要", "十分", "可能", "不能", "実際", "一般",
  "特に", "とくに", "ただし", "および", "または", "したがって", "すなわち", "そのため",
  "ここで", "これら", "それら", "この", "その", "ある", "する", "なる", "よる", "もの",
  "こと", "ため", "とき", "まで", "から", "より", "ように", "ことに", "ことが", "ものと",
]);

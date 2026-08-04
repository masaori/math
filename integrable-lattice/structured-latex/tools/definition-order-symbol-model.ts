/**
 * **記号の初出の全数走査**（検査 O の台帳の拾い方に漏れがあるかを、別の拾い方で測るための道具）。
 *
 * ## なぜ別の拾い方が要るのか
 *
 * 検査 O（`definition-order-model.ts`）は**台帳に載せた語だけ**を追う。台帳は本文を読んで
 * 「定義の言い回し」から人が拾って作ったものなので、**その言い回しを使っていない定義は
 * 候補にすら上がらない**。台帳の網羅性が検査の強さの上限である以上、
 * 上限そのものが妥当かは台帳と独立した拾い方でしか測れない。
 *
 * そこでここでは語ではなく**記号**を見る。本文の数式ノードに現れる記号を全部集め、
 * 各記号の初出ブロックと、その記号が定義されているブロックを突き合わせる。
 *
 * ## 記号をどう数えるか
 *
 * 単位は `tex-atoms.ts` のアトム（基底記号 ＋ 直後の添字・肩）である。
 * $a_L$ と $a^{\mathrm{red}}_L$ は別の記号として数える（実際に別のものを指している）。
 *
 * ## 定義の位置をどう決めるか（機械で決まる形に絞る）
 *
 * **`:=` の左辺に立った位置を定義とみなす。** この論文は定義を `:=` で書く
 * （本文の数式ノードに 119 箇所ある）。左辺が $\Phi_L(\beta)$ のように引数を伴う場合は、
 * 末尾の括弧の組を落としてから左辺の最後のアトムを取る。
 *
 * この判定は**定義の言い回し（散文）を一切見ない**。だから台帳と独立であり、
 * 台帳の漏れを測る道具になる。逆に、散文だけで定義される記号（「〜を $\kappa_n$ と書く」）は
 * この拾い方では定義の位置が付かない。**どちらの拾い方も単独では網羅しない**——
 * それが分かることがこの走査の目的である。
 *
 * ## 何を見ないか
 *
 * - 散文中の**語**の初出は見ない（「voltage」「型 II」のような語は記号ではない）。
 *   語の順序は検査 O の担当であり、この走査はそれを置き換えない。
 * - 記号の**意味**は見ない。同じ字面が別の意味で使われていても区別できない。
 * - `:=` を持たない記号については、定義の位置が本論文にあるのかどうか自体を判定しない。
 */

import { atomsOf } from "./tex-atoms.ts";

/** 走査対象のブロック 1 つ分（文書順に並べたもの）。 */
export type SweptBlock = {
  readonly index: number;
  readonly id: string;
  readonly kind: string;
  /** そのブロックに現れる数式ノードの TeX（題・主張・証明の順）。 */
  readonly texts: readonly string[];
};

/** 記号 1 つ分の走査結果。 */
export type SymbolTrace = {
  readonly atom: string;
  /** 初めて現れたブロック。 */
  readonly firstAt: SweptBlock;
  /** `:=` の左辺に立った最初のブロック（無ければ undefined）。 */
  readonly definedAt?: SweptBlock;
  /** 現れたブロック数。 */
  readonly occurrences: number;
};

/** 末尾の括弧の組（引数）を落とす。$\Phi_L(\beta)$ → $\Phi_L$。 */
const dropTrailingArgument = (tex: string): string => {
  let out = tex.trimEnd();
  for (;;) {
    if (!out.endsWith(")")) return out;
    let depth = 0;
    let open = -1;
    for (let i = out.length - 1; i >= 0; i -= 1) {
      const c = out[i];
      if (c === ")") depth += 1;
      else if (c === "(") {
        depth -= 1;
        if (depth === 0) {
          open = i;
          break;
        }
      }
    }
    if (open <= 0) return out;
    out = out.slice(0, open).replace(/\\(bigl|Bigl|biggl|Biggl|left)$/, "").trimEnd();
  }
};

/**
 * `:=` の左辺に立ったアトムを全部返す。
 * 1 つの数式に複数の定義が並ぶことがある（$a_L:=\dots,\quad a^{\mathrm{red}}_L:=\dots$）ので、
 * 各 `:=` について、直前の `:=` から今回までを左辺の候補とみなす。
 */
export const definedAtomsIn = (tex: string): string[] => {
  const out: string[] = [];
  const parts = tex.split(":=");
  for (let i = 0; i + 1 < parts.length; i += 1) {
    const atoms = atomsOf(dropTrailingArgument(parts[i]!));
    const last = atoms[atoms.length - 1];
    if (last !== undefined) out.push(last);
  }
  return out;
};

/** 文書順に走査して、記号ごとの初出と定義位置を返す。 */
export const traceSymbols = (blocks: readonly SweptBlock[]): SymbolTrace[] => {
  const firstAt = new Map<string, SweptBlock>();
  const definedAt = new Map<string, SweptBlock>();
  const occurrences = new Map<string, number>();

  for (const block of blocks) {
    const seenHere = new Set<string>();
    for (const tex of block.texts) {
      for (const atom of atomsOf(tex)) seenHere.add(atom);
      for (const atom of definedAtomsIn(tex)) {
        if (!definedAt.has(atom)) definedAt.set(atom, block);
      }
    }
    for (const atom of seenHere) {
      if (!firstAt.has(atom)) firstAt.set(atom, block);
      occurrences.set(atom, (occurrences.get(atom) ?? 0) + 1);
    }
  }

  const traces: SymbolTrace[] = [];
  for (const [atom, first] of firstAt) {
    traces.push({
      atom,
      firstAt: first,
      definedAt: definedAt.get(atom),
      occurrences: occurrences.get(atom) ?? 0,
    });
  }
  traces.sort((a, b) => a.firstAt.index - b.firstAt.index || a.atom.localeCompare(b.atom));
  return traces;
};

/** 初出が定義より前にある記号。 */
export const usedBeforeDefinition = (traces: readonly SymbolTrace[]): SymbolTrace[] =>
  traces.filter((t) => t.definedAt !== undefined && t.firstAt.index < t.definedAt.index);

/**
 * 台帳の字面と記号を突き合わせるための正規化。
 * 波括弧と空白だけを落とす（$\kappa_{n}$ と $\kappa_n$ を同じものとして扱う）。
 */
export const normalizeFace = (face: string): string => face.replaceAll(/[{}\s]/g, "");

/**
 * その記号が台帳の字面のどれかに覆われているか。
 *
 * **一致は正規化した上での完全一致で見る。** 部分文字列で見ると、台帳の
 * $a^{\mathrm{red}}_L$ が裸の $a$ を覆っていることになってしまい、覆えていないものを
 * 覆っていると数える（実際に一度そう数えて、覆う件数が 19 件に膨らんだ）。
 */
export const coveredByLedger = (atom: string, faces: readonly string[]): boolean => {
  const a = normalizeFace(atom);
  if (a === "") return false;
  return faces.some((face) => normalizeFace(face) === a);
};

/**
 * 裸の 1 記号か（$p$・$\rho$ のように飾りを持たないもの）。
 *
 * この論文はこれらを**局所的な束縛変数として章ごとに使い回す**。したがって
 * 「初出が `:=` の位置より前」が出ても、それは論文全体の記法の順序の問題ではなく
 * 別の場所の別の変数である場合が多い。走査の結果を読むときの仕分けに使う。
 */
export const isBareSymbol = (atom: string): boolean => /^(?:[a-zA-Z]|\\[a-zA-Z]+)$/.test(atom);

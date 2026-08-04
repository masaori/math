/**
 * **検査 O（定義の登場順序）の型と判定**。
 *
 * ## なぜこの検査が要るのか
 *
 * 2026-08-03、ユーザーが生成後の日本語版 PDF を読んで指摘した:
 *
 * > 序論の第 1 章から Λ が定義されないまま使われていて読みづらい。
 * > 定義の登場順序が、依存関係をトポロジカルにソートした状態を厳密に保つこと。
 * > 「後で定義する」と断って先に使うのは、この要求を満たさない。見出しにも同じ規則を適用する。
 *
 * 実測したところ、指摘のとおりだった（当時の値）。
 *
 * | 語 | 初出 | 定義 |
 * |---|---|---|
 * | 整数スペクトル曲線 | 第 1 章の見出し（0 番目のブロック） | 5 番目のブロック |
 * | $\Lambda$ | 1 番目（位置づけ） | 2 番目 |
 * | Massieu 自由エントロピー | 1 番目（位置づけ） | 7 番目 |
 * | 決定可能 | 第 1 章の見出し | 2 番目 |
 *
 * ## 何を見るか
 *
 * **本論文が自分で定義する語・記号**について、次の 2 つを見る。
 *
 * 1. **初出が定義より前でないこと。** 文書順（ファイルの並び × ブロックの並び、
 *    ブロックの中では 題 → 主張 → 証明）で走査し、宣言した字面が最初に現れる位置が、
 *    その語を定義するブロックより前なら違反。
 * 2. **定義そのものが、依存する語より後にあること。** $A$ の定義が $B$ を使うなら、
 *    $B$ の定義は $A$ の定義より前になければならない（依存関係のトポロジカル順序）。
 *    同じブロックが複数の語をまとめて定義する場合（「整数スペクトル曲線と周期点数」）は、
 *    ブロックの中の順序までは見ない。
 *
 * **見出しも対象である。** 見出しは本文より先に読まれるので、
 * 章の中で定義する語を見出しに書くことはできない。
 *
 * ## 何を見ないか（範囲を正直に書く）
 *
 * **本論文が定義しない標準的な語彙は対象外である**（素点、Newton 多角形、Lehmer 問題、
 * $\mathbb{R}$、$\mathbb{Z}$ 等）。これらは読者が外から持ってくる語であり、
 * 本論文の中に「定義の位置」が無いので、順序を論じる対象にならない。
 * どこまでを「標準」とみなすかは人の判断であり、**この検査はその判断を検証できない**。
 * 台帳に載っていない語は黙って素通りする——だから**台帳の網羅性がこの検査の強さの上限**である。
 */

/** 追跡する語・記号 1 つ分の宣言。 */
export type TermDeclaration = {
  /** 読者が読む字面（本文に現れる形）。この字面の初出を探す。 */
  readonly token: string;
  /** 同じ語の別の字面（記号と綴り、送り仮名の違い）。初出はこれらも含めて最も早いものを取る。 */
  readonly aliases?: readonly string[];
  /** この語を定義しているブロックのラベル。 */
  readonly definedIn: string;
  /** その定義が前提とする語（`token` で指す）。 */
  readonly dependsOn: readonly string[];
  /** なぜこの語を追跡するか、どこまでを定義とみなすか。 */
  readonly note?: string;
};

/** 文書順に並べたブロック 1 つ分の見え方。 */
export type OrderedBlock = {
  readonly index: number;
  readonly id: string;
  readonly kind: string;
  readonly labels: readonly string[];
  /** 題（見出しを含む）。本文より先に読まれるので別に持つ。 */
  readonly title: string;
  /** 題 ＋ 主張 ＋ 証明を連結したもの。 */
  readonly text: string;
};

export type OrderViolation =
  | {
      readonly kind: "定義より前に使われている";
      readonly token: string;
      readonly usedAt: OrderedBlock;
      readonly usedIn: "title" | "body";
      readonly definedAt: OrderedBlock;
    }
  | {
      readonly kind: "依存する語より前に定義されている";
      readonly token: string;
      readonly dependency: string;
      readonly definedAt: OrderedBlock;
      readonly dependencyDefinedAt: OrderedBlock;
    }
  | {
      readonly kind: "台帳が指す定義ブロックが本文に無い";
      readonly token: string;
      readonly label: string;
    }
  | {
      readonly kind: "台帳が指す依存語が台帳に無い";
      readonly token: string;
      readonly dependency: string;
    };

const facesOf = (term: TermDeclaration): readonly string[] => [term.token, ...(term.aliases ?? [])];

export const violationsIn = (
  terms: readonly TermDeclaration[],
  blocks: readonly OrderedBlock[],
): OrderViolation[] => {
  const out: OrderViolation[] = [];
  const byLabel = new Map<string, OrderedBlock>();
  for (const block of blocks) for (const label of block.labels) byLabel.set(label, block);
  const byToken = new Map(terms.map((term) => [term.token, term] as const));

  const definitionOf = new Map<string, OrderedBlock>();
  for (const term of terms) {
    const block = byLabel.get(term.definedIn);
    if (block === undefined) {
      out.push({ kind: "台帳が指す定義ブロックが本文に無い", token: term.token, label: term.definedIn });
      continue;
    }
    definitionOf.set(term.token, block);
  }

  for (const term of terms) {
    const definedAt = definitionOf.get(term.token);
    if (definedAt === undefined) continue;

    // 1. 初出が定義より前でないこと。題と本文を分けて見る（題のほうが先に読まれる）。
    for (const block of blocks) {
      if (block.index >= definedAt.index) break;
      const faces = facesOf(term);
      const inTitle = faces.some((face) => block.title.includes(face));
      const inBody = faces.some((face) => block.text.includes(face));
      if (!inTitle && !inBody) continue;
      out.push({
        kind: "定義より前に使われている",
        token: term.token,
        usedAt: block,
        usedIn: inTitle ? "title" : "body",
        definedAt,
      });
      break; // 最初の 1 件だけ挙げる（同じ語で何度も挙げても直し方は変わらない）
    }

    // 2. 依存する語の定義が、この語の定義より前にあること。
    for (const dependency of term.dependsOn) {
      if (!byToken.has(dependency)) {
        out.push({ kind: "台帳が指す依存語が台帳に無い", token: term.token, dependency });
        continue;
      }
      const dependencyDefinedAt = definitionOf.get(dependency);
      if (dependencyDefinedAt === undefined) continue;
      // 同じブロックの中で複数の語をまとめて定義することはある
      // （「整数スペクトル曲線と周期点数」の定義がそう）。その場合は順序を論じない。
      if (dependencyDefinedAt.index <= definedAt.index) continue;
      out.push({
        kind: "依存する語より前に定義されている",
        token: term.token,
        dependency,
        definedAt,
        dependencyDefinedAt,
      });
    }
  }
  return out;
};

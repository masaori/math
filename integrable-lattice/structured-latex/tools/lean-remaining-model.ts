/**
 * **残り一覧の照合（`lean/` の一覧と検査 F の台帳）の型と台帳**。
 *
 * ## なぜこれが要るのか（cycle 32 が見つけた穴）
 *
 * `lean/` の各ファイルは冒頭に「形式化しなかったもの」の一覧を自分で書いている。
 * 検査 F の台帳（`formalization-coverage.ts`）も「残り」を書いている。
 * **この 2 つがずれていても、これまで誰も気づかなかった。**
 *
 * cycle 32 の実測で、実際に 2 件ずれていた——
 * 命題 Q は Lean 側が 3 件を挙げているのに台帳は 1 件しか写しておらず、命題 R も同じ形だった。
 * **検査 F は台帳と本文の食い違いは見るが、台帳と `lean/` の記述の食い違いは見ていない。**
 * その穴をここで塞ぐ。
 *
 * ## 形の分類は機械が、判断は台帳が持つ
 *
 * 箇条書きが何件あるかは機械が数える。**その 1 件が「まだ残っている項目」なのか、
 * 「もう書いた項目」なのか、「調査ログへの参照」でしかないのかは人の判断**なので台帳が持つ。
 * この分け方は検査 O（極値の規約）・検査 Λ（記号）と同じ形である。
 *
 * ## 機械が確かめること
 *
 * 1. **残り一覧の節を持つ `lean/` のファイルが、1 つ残らずこの台帳にあること。**
 *    黙って新しいファイルを足して一覧を書き散らす道を塞ぐ。
 * 2. **台帳の項目数が、実際の箇条書きの数と一致すること。**
 *    ここが cycle 32 の事故（Lean 側 3 件・台帳 1 件）を捕まえる。
 * 3. **各項目の `leanFragment` が、対応する箇条書きに実在すること。**
 *    Lean 側の文言が書き換わったら台帳が腐るので、腐りが赤くなる。
 * 4. **`未形式化` の項目は、`ledgerFragment` が検査 F の台帳の当該エントリに実在すること。**
 *    ここが本題——**台帳が `lean/` より少なく書いていたら赤くなる。**
 * 5. **`未形式化` の項目を持つファイルに対応するエントリが `完了` でないこと。**
 *    残りがあるのに完了と書く道を塞ぐ。
 *
 * ## 機械が確かめられないこと（正直に書く）
 *
 * - **その箇条書きの分類（未形式化か・形式化済みか・参照だけか）は人の判断である。**
 *   `参照だけ` と書けば `ledgerFragment` を要求されないので、**そこは逃げ道になりうる。**
 *   逃げ道を狭めるため、分類の内訳を毎回件数で印字する。
 * - **`ledgerFragment` が台帳に在ることは確かめられるが、それが同じ事柄を指しているかは
 *   確かめられない。** 検査の強さの上限は、台帳の書き手が選んだ語の妥当性である
 *   （検査 O・検査 F の限界と同じ形）。
 * - 台帳と `lean/` の**両方が同じだけ古い**場合は、一致したまま静かに通る。
 */

export type LeanRemainingKind = "未形式化" | "形式化済み" | "参照だけ";

export type LeanRemainingItem =
  | {
      /** その箇条書きに実在すべき文字列（実在を機械が確かめる）。 */
      readonly leanFragment: string;
      readonly kind: "未形式化";
      /** 検査 F の台帳の当該エントリに実在すべき文字列。**未形式化では型で必須**。 */
      readonly ledgerFragment: string;
    }
  | { readonly leanFragment: string; readonly kind: "形式化済み" | "参照だけ" };

export type LeanRemainingFile = {
  /** `lean/IntegrableLattice/` からの相対ファイル名。 */
  readonly file: string;
  /**
   * 節の見出し（`## ` の後ろ）。**宣言と実物が違えば赤くなる**ので、
   * 見出しを書き換えて検査から逃げる道が塞がる。
   */
  readonly heading: string;
  /** 箇条書きと同じ順序で並べる。件数の一致を機械が見る。 */
  readonly items: readonly LeanRemainingItem[];
};

/**
 * 初期値は cycle 33 step 1 完了時点の実測（`lean/` の 13 ファイル・箇条書き 28 件）。
 * 分類は 1 件ずつ Lean 側の本文を読んで付けた。
 */
export const LEAN_REMAINING_LEDGER: readonly LeanRemainingFile[] = [
  {
    file: "BouquetClosedForm.lean",
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "の独立計算（Matrix-Tree 定理）",
        kind: "未形式化",
        ledgerFragment: "matrix-tree",
      },
      { leanFragment: "定理 X の付値計算そのもの", kind: "未形式化", ledgerFragment: "付値" },
    ],
  },
  {
    file: "CoefficientsDE.lean",
    heading: "形式化しなかったもの（mathlib の欠落か配線か）",
    items: [],
  },
  {
    file: "Cycle24Corrections.lean",
    heading: "形式化しなかったもの",
    items: [
      { leanFragment: "系 Q7 の $r=2$ そのもの", kind: "未形式化", ledgerFragment: "系 Q7" },
      { leanFragment: "欠落調査は", kind: "参照だけ" },
    ],
  },
  {
    file: "Cycle25Corrections.lean",
    heading: "形式化しなかったもの",
    items: [
      { leanFragment: "定理 G2 の 1", kind: "未形式化", ledgerFragment: "定理 G2 の 1" },
      { leanFragment: "系 Q7 の $r=2$", kind: "未形式化", ledgerFragment: "系 Q7" },
      { leanFragment: "そのもの（voltage グラフのラプラシアン行列式）", kind: "未形式化", ledgerFragment: "matrix-tree" },
    ],
  },
  {
    file: "CyclotomicValuationQ4a.lean",
    heading: "形式化しなかったもの",
    items: [
      { leanFragment: "が素元であること自体は mathlib", kind: "参照だけ" },
      { leanFragment: "は `PropQLaurentLift.lean`", kind: "参照だけ" },
    ],
  },
  {
    file: "DigitBranchRecursion.lean",
    heading: "形式化しなかったもの（mathlib の欠落か配線か）",
    items: [
      {
        leanFragment: "指数の $(1+x)^\\gamma$",
        kind: "未形式化",
        ledgerFragment: "指数の $(1+x)^\\gamma$",
      },
      {
        leanFragment: "についての帰納法そのもの",
        kind: "未形式化",
        ledgerFragment: "の帰納法",
      },
    ],
  },
  {
    file: "DigitTheorem.lean",
    heading: "形式化しなかったもの",
    items: [{ leanFragment: "命題 J2′ の", kind: "未形式化", ledgerFragment: "命題 J2′" }],
  },
  {
    file: "DropAssumptionBStar.lean",
    heading: "形式化した残りの段（cycle 33 step 1 で 2 件とも書いた）",
    items: [
      { leanFragment: "補題 Q0", kind: "形式化済み" },
      { leanFragment: "補題 Q4a", kind: "形式化済み" },
      { leanFragment: "補題 Q1′", kind: "形式化済み" },
    ],
  },
  {
    file: "EllTwoClosedForm.lean",
    heading: "形式化しなかったもの（理由）",
    items: [
      { leanFragment: "の**導出**", kind: "未形式化", ledgerFragment: "導出" },
      { leanFragment: "matrix-tree 定理が要り", kind: "未形式化", ledgerFragment: "matrix-tree" },
    ],
  },
  {
    file: "GeneralTowerClosedForm.lean",
    heading: "形式化しなかったもの（mathlib の欠落か配線か）",
    items: [
      { leanFragment: "定理 G2 の 1", kind: "未形式化", ledgerFragment: "定理 G2 の 1" },
      { leanFragment: "定理 G2 の 3", kind: "未形式化", ledgerFragment: "定理 G2 の 3" },
      { leanFragment: "非依存性", kind: "未形式化", ledgerFragment: "非依存性" },
      { leanFragment: "Matrix–Tree 定理", kind: "未形式化", ledgerFragment: "matrix-tree" },
    ],
  },
  {
    file: "KirchhoffCounting.lean",
    heading: "形式化しなかったもの",
    items: [
      {
        leanFragment: "でないことと「全域木であること」の同値",
        kind: "未形式化",
        ledgerFragment: "全域木",
      },
      { leanFragment: "指標分解", kind: "未形式化", ledgerFragment: "指標分解" },
    ],
  },
  {
    file: "PropQLaurentLift.lean",
    heading: "形式化しなかったもの",
    items: [
      { leanFragment: "の分解 $(1.2)$ そのもの", kind: "参照だけ" },
      { leanFragment: "が一意分解環であること", kind: "参照だけ" },
    ],
  },
  {
    file: "SInfinityDecision.lean",
    heading: "形式化しなかったもの（mathlib の欠落か配線か）",
    items: [
      { leanFragment: "補題 W2 の (iv)", kind: "未形式化", ledgerFragment: "補題 W2" },
      { leanFragment: "定理 W4 の", kind: "未形式化", ledgerFragment: "定理 W4" },
      { leanFragment: "系 W7", kind: "未形式化", ledgerFragment: "系 W7" },
    ],
  },
  {
    file: "TowerTypeCoefficients.lean",
    heading: "形式化しなかったもの（なぜ足りないのか）",
    items: [
      { leanFragment: "定理 J7 の主張そのもの", kind: "未形式化", ledgerFragment: "定理 J7" },
      { leanFragment: "の係数を「読み取る」段の一般形", kind: "未形式化", ledgerFragment: "読み取る" },
    ],
  },
];

/** 節の見出しと箇条書きを取り出す。箇条書きは行頭 `* ` で始まる塊とする。 */
export function parseRemainingSection(
  source: string,
): { heading: string; bullets: string[] } | null {
  const match =
    /^## (形式化しなかったもの[^\n]*|形式化した残りの段[^\n]*)$([\s\S]*?)(?=^-\/$|^## )/m.exec(
      source,
    );
  if (!match) return null;
  const body = match[2]!;
  const bullets = [...body.matchAll(/^\* ([\s\S]+?)(?=^\* |\s*$)/gm)].map((m) =>
    m[1]!.replace(/\s+/g, " ").trim(),
  );
  return { heading: match[1]!, bullets };
}

export type LeanRemainingAuditInput = {
  readonly entry: LeanRemainingFile;
  readonly section: { heading: string; bullets: string[] };
  /** そのファイルに対応する台帳エントリ（本文の紐づけ経由で導いたもの）。 */
  readonly linked: readonly { block: string; text: string; state: string }[];
};

/**
 * 1 ファイル分の判定。IO を持たないので検出テストからそのまま呼べる。
 * 返すのは違反の一覧と分類の内訳。
 */
export function auditLeanRemaining(input: LeanRemainingAuditInput): {
  violations: string[];
  counts: Record<LeanRemainingKind, number>;
  unlinked: number;
} {
  const { entry, section, linked } = input;
  const violations: string[] = [];
  const counts: Record<LeanRemainingKind, number> = { 未形式化: 0, 形式化済み: 0, 参照だけ: 0 };
  let unlinked = 0;
  if (section.heading !== entry.heading) {
    violations.push(
      `[見出しが宣言と違う] ${entry.file} — 台帳「${entry.heading}」/ 実物「${section.heading}」`,
    );
  }
  if (section.bullets.length !== entry.items.length) {
    violations.push(
      `[項目数が合わない] ${entry.file} — 台帳 ${entry.items.length} 件 / 実物 ${section.bullets.length} 件` +
        `（cycle 32 の事故はこの形だった: Lean 側 3 件・台帳 1 件）`,
    );
    return { violations, counts, unlinked };
  }
  entry.items.forEach((item, index) => {
    counts[item.kind] += 1;
    const bullet = section.bullets[index]!;
    if (!bullet.includes(item.leanFragment.replace(/\s+/g, " "))) {
      violations.push(
        `[宣言が Lean 側に実在しない] ${entry.file} #${index + 1} — 「${item.leanFragment}」が箇条書きに無い`,
      );
    }
    if (item.kind !== "未形式化") return;
    if (linked.length === 0) {
      unlinked += 1;
      return;
    }
    if (!linked.some((l) => l.text.includes(item.ledgerFragment))) {
      violations.push(
        `[台帳が lean/ より少なく書いている] ${entry.file} #${index + 1} — ` +
          `「${item.ledgerFragment}」が ${linked.map((l) => l.block).join(" / ")} の欄に無い`,
      );
    }
    for (const l of linked) {
      if (l.state === "完了") {
        violations.push(`[残りがあるのに完了] ${l.block} — ${entry.file} が未形式化の項目を挙げている`);
      }
    }
  });
  return { violations, counts, unlinked };
}

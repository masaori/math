/**
 * **検査 E（ノードをまたぐ強調）の型と判定**。
 *
 * ## なぜこの検査が要るのか（3 サイクル連続の再発を検査にする）
 *
 * 本文の地の文は強調を `**…**` と書く。生成器 `build-latex.ts` の `applyBold` は
 * **地の文 1 ノードずつ**に正規表現を掛けるので、`**` が数式ノードをまたいで開き閉じすると
 * どちらのノードでも閉じず、`**` が生のまま残る。生成器はそれを見つけて生成を落とす。
 *
 * **落ちるのは英語ロケールだけである。** `tools/editions.ts` が
 * 日本語版を `bold: false`、英語版を `bold: true` と宣言しており、`applyBold` は
 * `bold` が偽なら**何もせずに返す**（`if (!edition.bold) return value;`）。
 * すなわち**同じ書き方が日本語版では静かに通り、英語版でだけ落ちる**。
 *
 * この非対称が、次の再発を 3 サイクル連続で起こした:
 *
 * | いつ | どこ |
 * |---|---|
 * | cycle 24 step 4 | 英語ロケールで数式ノードをまたぐ強調。PDF 生成が落ちた |
 * | cycle 25 step 4a | 同上（`cycle25_ops_reflect_five_proofs.md` の誤り記録） |
 * | cycle 25 step 4b | 同上（`cycle25_ops_reflect_mu_and_q_series.md` が最重の誤りとして記録） |
 *
 * cycle 25 step 4b の記録が構造をそのまま言い当てている——
 * **「日本語版では同じ形が通るため、『原文で通っている形をそのまま訳す』手順を取ると必ず踏む」**。
 * 手順の注意書きでは止まらない。**原文の側を赤くするしかない。**
 *
 * ## この検査が変えること
 *
 * 違反として落とすのは**強調を変換するロケール**（`editions.ts` が `bold: true` と宣言する版。
 * 現在は英語）である。それは生成器が実際に落とす条件と同じであり、
 * この検査が生成器より厳しくも緩くもならないことを保証する。
 *
 * **変えたのは「いつ落ちるか」と「何を一緒に見せるか」の 2 点である。**
 *
 * 1. **早い段で落ちる。** 従来これが露見するのは `npm run check` の `verify:no-notes:en`
 *    （`.tex` 生成）で、ロケールの読み込みと文書全体の組み立てを経たあとだった。
 *    ここは `validate` の直後に置く。
 * 2. **原文側の危険量を毎回数えて出す。** 原文ロケール（日本語）は `bold: false` なので
 *    ノードをまたぐ強調が**合法**であり、実測 298 件ある。
 *    **その 298 件は「そのまま訳すと英語版で落ちる形」の在庫である。**
 *    件数を毎回印字するので、「原文では通っている」を理由に訳し写す手が、
 *    在庫の存在を見ないまま動くことがなくなる。
 *
 * ## 限界（正直に書く）
 *
 * - 見るのは**地の文ノードの中の `**` の対応**だけである。
 *   強調の内容が適切かは見ない。`*`（1 個）の斜体は本文の語彙に無いので対象外。
 * - `applyBold` が実際に触る地の文は `text.value` / `todo.value` / `cite.note` の 3 つで、
 *   この検査もその 3 つだけを見る。生成器が地の文として扱う場所が増えたら、ここも増やすこと
 *   （`ref.label` は `escapeText` を通るだけで `applyBold` を通らないので対象外。
 *   数式 `tex` は地の文ではないので対象外）。
 * - **「閉じている」＝「意図どおり」ではない。** 1 ノードの中で `**a** **b**` と 4 個あれば
 *   この検査は静かだが、書き手の意図が別かもしれない。それは読む側の仕事である。
 * - **原文側の在庫を数えるだけで、直しはしない。** 直すかどうかは下記の別件と絡む判断である。
 *
 * ## この検査を作る過程で見つかった別件（本検査の担当外・未修正）
 *
 * **日本語版の PDF は `**` を素のアスタリスクとして印字している。** `bold: false` は
 * 「変換しない」であって「落とす」ではないので、`applyBold` は値をそのまま返す。
 * 実測: 生成物 `build/document.tex` に `**` が **410 箇所**あり、たとえば
 * 「（\*\*対数順序群\*\*）」がそのまま組まれる。**50 頁の日本語正本の全体にわたる。**
 * 直すには日本語版も `bold: true` にする必要があり、そうすると上記 298 件が全部落ちるので、
 * **本文 298 箇所の書き換えを伴う**（強調を数式の前後で分ける）。
 * 本文を触るのは別の step の担当であり、かつ正本 PDF の見た目を変える判断なので、
 * ここでは**記録するに留める**。
 */

/** 地の文 1 つ分の出所（どのロケール・どのブロック・どのフィールドか）。 */
export type ProseSite = {
  readonly locale: string;
  readonly blockId: string;
  readonly file: string;
  /** `applyBold` が触る地の文の種類。 */
  readonly field: "text" | "todo" | "cite.note";
  readonly value: string;
};

export type EmphasisViolation = {
  readonly site: ProseSite;
  /** そのノードの中の `**` の個数（奇数なら閉じていない）。 */
  readonly markerCount: number;
  readonly sample: string;
};

/**
 * 1 ノードの中で `**` が閉じているか。
 *
 * 判定は生成器 `applyBold` と**同じ手順**で行う——先に `**…**` を貪欲でなく取り除き、
 * 残りに `**` があれば閉じていない。個数の偶奇だけを見ると
 * `**a**b**` のような形（3 個。閉じていない）を見落とすことはないが、
 * 逆に生成器が実際に落ちる条件からずれる可能性があるので、生成器と同じ消し方に揃える。
 */
export const unclosedEmphasis = (value: string): boolean =>
  value.replace(/\*\*(.+?)\*\*/gs, "").includes("**");

export const countMarkers = (value: string): number => (value.match(/\*\*/g) ?? []).length;

export const violationsIn = (sites: readonly ProseSite[]): EmphasisViolation[] =>
  sites
    .filter((site) => unclosedEmphasis(site.value))
    .map((site) => ({
      site,
      markerCount: countMarkers(site.value),
      sample: site.value.length > 90 ? `${site.value.slice(0, 90)}…` : site.value,
    }));

/**
 * **検査 E（本文に強調指定を書かない）の型と判定**。
 *
 * ## 方針（2026-08-03 ユーザーの価値判断として確定）
 *
 * **本文では強調（太字）を使わない。** 地の文に `**…**` を書かない。
 * 意味は文の構成と語の選択で担わせ、装飾に持たせない。
 *
 * この方針は、cycle 27 step 3 が計測して管理役へ上げた判断点への回答である。
 * 判断点は「日本語版の正本 PDF が `**` を素のアスタリスクとして印字している
 * （623 対・413 行・50 頁の全体）のをどうするか」で、選べる形は
 * 太字にする／強調指定ごと外す／現状のまま の 3 つだった。**外す**が選ばれた。
 *
 * ## なぜ検査にするのか
 *
 * cycle 24–26 の 3 サイクルにわたり、強調は**繰り返し事故の種**だった。
 *
 * | いつ | 何が起きたか |
 * |---|---|
 * | cycle 24 step 4 | 英語ロケールで強調が数式ノードをまたぎ、PDF 生成が落ちた |
 * | cycle 25 step 4a・4b | 同じ形の再発（step 4b は最重の誤りとして記録） |
 * | cycle 26 step 3 | 検査にした。その同じサイクルの step 6 で実際に落ちた（4 回目） |
 * | cycle 26 step 3 | 副産物として、日本語版が `**` を素のまま印字していることが判明 |
 *
 * 強調を使わないと決めた以上、**書かれたら止まる形にしておく**（記録では止まらないことが
 * 3 サイクルで実証されている）。それがこの検査である。
 *
 * ## 何を見るか
 *
 * 全ロケールの地の文（生成器が組む `text` / `todo` / `cite.note`、およびブロックの題）に
 * `**` が **1 つでも**あれば違反にする。**ロケールに依存しない**——
 * 日本語版が `bold: false`（変換せず素のアスタリスクを出す）、
 * 英語版が `bold: true`（`\textbf` へ変換する）という非対称は、
 * 「強調を書かない」なら初めから問題にならない。
 *
 * ## 限界（正直に書く）
 *
 * - 見るのは `**` だけである。`\textbf{}` を数式ノードへ直接書けばこの検査は素通りする
 *   （本文に 0 件であることを実測している。数式の中の `\mathbf` は記号の書体であって
 *   強調ではないので対象外）。
 * - **「装飾に意味を持たせていないか」は機械で確かめられない。** 強調を外したときに
 *   意味が落ちる箇所は人が読んで書き換える必要がある。この検査は再発を止めるだけである。
 * - 参照用ノート（`notes/`）は最終成果物に載らないので対象外。
 */

/** 地の文 1 つ分の出所（どのロケール・どのブロック・どのフィールドか）。 */
export type ProseSite = {
  readonly locale: string;
  readonly blockId: string;
  readonly file: string;
  /** 生成器が地の文として組む種類。 */
  readonly field: "text" | "todo" | "cite.note";
  readonly value: string;
};

export type EmphasisViolation = {
  readonly site: ProseSite;
  /** そのノードの中の `**` の個数。 */
  readonly markerCount: number;
  readonly sample: string;
};

/** 強調指定が書かれているか（対応が取れているかは問わない。書いてあれば違反）。 */
export const hasEmphasisMarkup = (value: string): boolean => value.includes("**");

export const countMarkers = (value: string): number => (value.match(/\*\*/g) ?? []).length;

export const violationsIn = (sites: readonly ProseSite[]): EmphasisViolation[] =>
  sites
    .filter((site) => hasEmphasisMarkup(site.value))
    .map((site) => ({
      site,
      markerCount: countMarkers(site.value),
      sample: site.value.length > 90 ? `${site.value.slice(0, 90)}…` : site.value,
    }));

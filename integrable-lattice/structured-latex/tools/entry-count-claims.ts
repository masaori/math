/**
 * **台帳の中の「エントリを数える主張」を機械が数え直す**（検査 F の第 4 部）。
 *
 * ## なぜこれがあるか（実際に 3 回起きた事故）
 *
 * cycle 35 と cycle 36 で、**同じ形の事故が 3 件**見つかった。いずれも
 * **後から欄へ書き足したときに、その欄を要約している数や文を直していない**という形である。
 *
 * 1. cycle 34 の欄が「命題 R の残りは 1 つ」と書いていたが、同じサイクルの後の step が
 *    同じ段落へ 2 件書き足しており、実際は 4 件だった（cycle 35 着手時の実測で判明）。
 * 2. 台帳が「matrix-tree を残りの理由に挙げている本文の主張は 3 件」と書いていたが、
 *    その後 2 つの欄へ書き足されており、実際は 5 件だった（cycle 35 step 3 の実測で判明）。
 * 3. 台帳が「命題 W\* の残りは 1 件」と 5 サイクル書き続けていたが、
 *    その 1 件を埋めても下流が塞がったままだった（cycle 36 step 1 の実測で判明）。
 *
 * **3 件とも、人が書いた要約が、後からの書き足しに追随しなかったものである。**
 *
 * ## 何が機械で見られて、何が見られないか（実測で切り分けた）
 *
 * 3 件を並べると、**機械が数え直せるのは 2 番だけ**である。理由は数の出どころにある。
 *
 * - 2 番は「**台帳のエントリのうち、ある語に触れているものの数**」である。
 *   これは台帳そのものから数え直せる。**ここを本 file が塞ぐ。**
 * - 1 番・3 番は「**ある欄の散文の中に列挙されている項目の数**」である。
 *   散文の中の列挙には構造が無いので、機械は数えられない。
 *   （`lean-remaining-model` は `lean/` 側の箇条書きを構造として持っているが、
 *   それは「Lean ファイルが挙げている残り」であって「台帳のエントリが挙げている残り」とは
 *   粒度が違う。突き合わせても同じ数にならないので、この用途には使えない。）
 *
 * したがって**塞げるのは 3 件のうち 1 件だけ**である。狭めたのであって塞いだのではない。
 *
 * ## 形は機械が、判断は台帳が持つ
 *
 * どの語を数えるか、その数がどの欄のどの言い回しに現れるかは**人の判断**なので台帳が持つ。
 * 数え直しと突き合わせは機械がやる。この分け方は検査 O・検査 Λ・射程の主張と同じである。
 *
 * ## 機械が確かめること
 *
 * 1. 登録された語について、**対象の台帳のうちその語に触れているエントリの数**を数え直す。
 * 2. その数を持っている欄の散文に、`phrase` + 数え直した数 + 単位 がそのまま在ること。
 *    **書き足して数が変われば、直さない限り赤くなる。**
 *
 * ## 機械が確かめられないこと（正直に書く）
 *
 * - **散文の中の列挙を数える主張は対象外である**（上記 1 番・3 番）。そこは人の読みのままである。
 * - **登録の網羅性は測れない。** 登録されていない数の主張は、これまでどおり素通りする
 *   （射程の主張が持っている限界と同じ形）。
 * - 語に触れていることは数えられるが、**その語がその欄で「残りの理由」として使われているか**は
 *   確かめられない（言及と根拠を区別しない）。
 */

export type EntryCountClaim = {
  /** 数える語（表記ゆれをすべて挙げる。どれかに当たれば触れているとみなす）。 */
  readonly terms: readonly string[];
  /** どちらの台帳のエントリを数えるか。 */
  readonly counts: "本文の台帳" | "外部定理の台帳";
  /** その数を書いている欄（本文ブロックの id、または外部定理の名前）。 */
  readonly holder: string;
  /** 欄の散文で数の直前に来る文字列。これに数と単位を続けた文字列の実在を見る。 */
  readonly phrase: string;
  /** 単位（「件」など）。 */
  readonly unit: string;
  /** なぜこの数を機械に見せるか（人の言葉。機械は読まない）。 */
  readonly why: string;
};

/**
 * 初期値は cycle 36 step 2 完了時点の実測。
 * **1 件しかないのは、機械が数え直せる形の主張が現に 1 件しか無いためである**
 * （上の「何が機械で見られて、何が見られないか」を見よ）。
 */
export const ENTRY_COUNT_CLAIMS: readonly EntryCountClaim[] = [
  {
    terms: ["matrix-tree", "Matrix–Tree", "Matrix-Tree"],
    counts: "本文の台帳",
    holder: "Kirchhoff の matrix-tree 定理（グラフの全域木を数える定理）",
    phrase: "実測は ",
    unit: "件",
    why:
      "cycle 35 step 3 で実際に古くなっていた数である。" +
      "cycle 33・34 が 3 件と書いたあと、cycle 34 の照合が 2 つの欄へ matrix-tree を書き足したのに、" +
      "3 という数のほうを誰も測り直さなかった。ここを機械が数え直す。",
  },
];

export type EntryCountAuditInput = {
  readonly claim: EntryCountClaim;
  /** 数える対象の台帳（エントリ 1 件ぶんの散文を並べたもの）。 */
  readonly countedTexts: readonly string[];
  /** 数を書いている欄の散文（欄が見つからなければ `null`）。 */
  readonly holderText: string | null;
};

export type EntryCountViolation = { readonly kind: string; readonly detail: string };

export type EntryCountAuditResult = {
  readonly violations: readonly EntryCountViolation[];
  /** 数え直した件数。 */
  readonly counted: number;
};

/** 1 件ぶんの判定。IO を持たないので検出テストからそのまま呼べる。 */
export function auditEntryCountClaim(input: EntryCountAuditInput): EntryCountAuditResult {
  const { claim, countedTexts, holderText } = input;
  const hits = (text: string) => claim.terms.some((term) => text.includes(term));
  const counted = countedTexts.filter(hits).length;
  const violations: EntryCountViolation[] = [];

  if (holderText === null) {
    violations.push({
      kind: "数を書いている欄が見つからない",
      detail: `${claim.holder} が台帳に無い（改名・削除で浮いた）`,
    });
    return { violations, counted };
  }

  const expected = `${claim.phrase}${counted} ${claim.unit}`;
  if (!holderText.includes(expected)) {
    violations.push({
      kind: "要約の数が数え直しと合わない",
      detail:
        `${claim.holder} の欄に「${expected}」が無い` +
        `（数え直した件数は ${counted} 件。欄を書き足したなら要約の数も直すこと）`,
    });
  }
  return { violations, counted };
}

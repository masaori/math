/**
 * **不在の根拠が、主張を実際に支えているかを見る**（検査 F の第 3 部）。
 *
 * ## なぜこれがあるか
 *
 * cycle 30 step 3 で「台帳が『無い』と書くならその場で実在確認の根拠を残す」規律を入れた。
 * その step 自身が限界を書いている——
 *
 * > 規律が要求するのは「**根拠が書かれていること**」であって、
 * > 根拠が主張を実際に支えているかは機械が確かめない。
 *
 * これが cycle 30 総括の「cycle 31 の焦点」3 点目である。ここで一段進める。
 * **ログのパスが書いてあることだけでなく、そのログの中の数字が不在を示していることまで見る。**
 *
 * ## 実在確認ログの形
 *
 * `lean/scripts/mathlib-gap-survey*.sh` は概念ごとに 3 段で引き、次の形で書き出す。
 *
 * ```
 * === (a) 全域木を数える定理 ===
 * --- (1) 連結語の内容 grep: 'matrixTree'
 * files=0
 * --- (2) 語幹の case-insensitive 内容 grep: 'matrix tree'
 * files=0
 * --- (3) 語幹の case-insensitive ファイル名検索: 'matrix tree'
 * files=0
 * ```
 *
 * **スクリプト自身の規約は「(2)(3) がともに 0 のときにだけ『無い』と書く」である。**
 * ここではその規約をそのまま検査に使う。
 *
 * ## 判定（台帳のエントリごとに 4 通り）
 *
 * - **数字が支えている** — エントリの本文が鉤括弧で挙げている語のどれかが、
 *   引いているログの概念（連結語または語幹）と一致し、その概念の (2)(3) がともに 0 である。
 *   **機械が根拠を再確認できた、と言えるのはこれだけである。**
 * - **宣言の直読が支えている** — 上が無い代わりに、エントリが宣言行を直読したと書いており、
 *   かつ引いているログに直読の節が実在する。
 * - **数字は不在を示していない（射程の主張）** — ログは引いているが、
 *   語の件数が 0 にならない。**これは嘘とは限らない**——「無い」ではなく
 *   「在るが射程が足りない」（1 変数しか無い／整除の鎖が無い／断片しか無い）型の主張は、
 *   語の件数では支えられないからである。実測でもここに残った 3 件はすべてその型で、
 *   うち 2 件は台帳の本文が自分でそう書いている。
 * - **ログを引いていない（本文の実測値だけ）** — 日付・mathlib のコミット・走査ファイル数は
 *   書いてあるが、ログが残っていない。機械は数字を再確認できない。
 *
 * ## 違反にするもの / しないもの（判断と理由）
 *
 * **違反にするのは 1 つだけである**——ログを引いているのに、そのログが
 * 概念の走査結果も宣言の直読も記録していない場合（引用が飾りになっている）。
 * これは主張の型に依らず誤りである。
 *
 * 後ろ 2 つの型を違反にしなかったのは、**そうすると正直に射程を書いているエントリほど
 * 赤くなる逆向きの規律になる**からである。代わりに **4 つの内訳を毎回数で出す**。
 * 機械が再確認できている割合が下がれば、それが数として見える。
 *
 * ## 機械が確かめられないこと（正直に書く）
 *
 * - **その検索語が、その数学的主張にとって正しい語かは判定できない。**
 *   `matrixTree` が 0 件であることは確かめられるが、
 *   「matrix-tree 定理を探すのに `matrixTree` を引くのが妥当か」は人の判断である。
 *   **この検査の強さの上限は、台帳の書き手が選んだ語の妥当性である。**
 * - **直読の節が、当の主張について直読しているかは見ていない。** 節の実在までである。
 */

/** 実在確認ログの 1 概念。 */
export type SurveyConcept = {
  /** 節の見出し（人が読む名前）。 */
  readonly label: string;
  /** (1) で引いた連結語。 */
  readonly joined?: string;
  /** (2)(3) で引いた語幹。 */
  readonly stem?: string;
  /** 3 段それぞれの件数。 */
  readonly counts: readonly number[];
};

export type SurveyLog = {
  readonly path: string;
  readonly concepts: readonly SurveyConcept[];
  /** 宣言行を直読した節があるか。 */
  readonly hasDeclarationReading: boolean;
};

const SECTION = /\n=== (.+?) ===\n([\s\S]*?)(?=\n=== |$)/g;
const JOINED = /\(1\)[^:]*: '([^']+)'/;
const STEM = /\(2\)[^:]*: '([^']+)'/;
const FILES = /files=(\d+)/g;
/** 直読の節の見出しに現れる語（走査ではなく宣言を読んだことを示す）。 */
const DECLARATION_SECTION = /(宣言行で直読|宣言で読む|名指しの実在確認|守備範囲)/;

export const parseSurveyLog = (path: string, source: string): SurveyLog => {
  const concepts: SurveyConcept[] = [];
  let hasDeclarationReading = false;
  for (const [, label, body] of source.matchAll(SECTION)) {
    if (DECLARATION_SECTION.test(label ?? "")) hasDeclarationReading = true;
    const counts = [...(body ?? "").matchAll(FILES)].map((hit) => Number(hit[1]));
    if (counts.length < 2) continue;
    concepts.push({
      label: (label ?? "").trim(),
      joined: JOINED.exec(body ?? "")?.[1],
      stem: STEM.exec(body ?? "")?.[1],
      counts,
    });
  }
  return { path, concepts, hasDeclarationReading };
};

/** スクリプト自身の規約: (2)(3) がともに 0 のときにだけ「無い」と書いてよい。 */
export const showsAbsence = (concept: SurveyConcept): boolean =>
  concept.counts.length >= 3 && concept.counts[1] === 0 && concept.counts[2] === 0;

export type SupportKind =
  | "数字が支えている"
  | "宣言の直読が支えている"
  | "数字は不在を示していない（射程の主張）"
  | "ログを引いていない（本文の実測値だけ）";

export type EntrySupport = {
  readonly block: string;
  readonly kind: SupportKind;
  /** 数字で支えたときに、どの概念が支えたか。 */
  readonly supportingConcept?: string;
};

export type SupportAudit = {
  readonly violations: readonly string[];
  readonly entries: readonly EntrySupport[];
  readonly counts: Readonly<Record<SupportKind, number>>;
};

/** 台帳の本文が鉤括弧（`` ` ``）で挙げている語。検索語はこの形で書かれている。 */
const BACKTICKED = /`([^`]+)`/g;
/** 宣言行を直読したと書いているか。 */
const CLAIMS_DECLARATION_READING = /(宣言行|直読)/;

const normalise = (value: string): string => value.trim().toLowerCase();

export const auditAbsenceEvidenceSupport = (input: {
  /** 不在を主張しているエントリだけを渡す（判定は ledger-absence-model が済ませている）。 */
  readonly entries: readonly { readonly block: string; readonly text: string; readonly logPaths: readonly string[] }[];
  readonly logs: readonly SurveyLog[];
}): SupportAudit => {
  const violations: string[] = [];
  const entries: EntrySupport[] = [];
  const counts: Record<SupportKind, number> = {
    数字が支えている: 0,
    宣言の直読が支えている: 0,
    "数字は不在を示していない（射程の主張）": 0,
    "ログを引いていない（本文の実測値だけ）": 0,
  };
  const byPath = new Map(input.logs.map((log) => [log.path, log] as const));

  for (const entry of input.entries) {
    const tokens = new Set(
      [...entry.text.matchAll(BACKTICKED)].map((hit) => normalise(hit[1] ?? "")),
    );
    const cited = entry.logPaths.map((path) => byPath.get(path)).filter((log) => log !== undefined);

    let supportingConcept: string | undefined;
    for (const log of cited) {
      for (const concept of log.concepts) {
        if (!showsAbsence(concept)) continue;
        const names = [concept.joined, concept.stem]
          .filter((name): name is string => name !== undefined)
          .map(normalise);
        if (!names.some((name) => tokens.has(name))) continue;
        supportingConcept = `${log.path} の「${concept.label}」（${concept.counts.join("/")}）`;
        break;
      }
      if (supportingConcept !== undefined) break;
    }

    if (supportingConcept !== undefined) {
      counts.数字が支えている += 1;
      entries.push({ block: entry.block, kind: "数字が支えている", supportingConcept });
      continue;
    }

    const readsDeclaration =
      CLAIMS_DECLARATION_READING.test(entry.text) &&
      cited.some((log) => log.hasDeclarationReading);
    if (readsDeclaration) {
      counts.宣言の直読が支えている += 1;
      entries.push({ block: entry.block, kind: "宣言の直読が支えている" });
      continue;
    }

    // ここから先は「機械が数字で支えられなかった」ものである。**嘘とは限らない。**
    // 実際、残った 3 件はいずれも「無い」ではなく「在るが射程が足りない」型の主張であり、
    // うち 2 件は台帳の本文がその旨を自分で書いている。したがって違反にはせず、
    // **機械が再確認できた割合を数として出す**（それがこの検査の成果である）。
    if (entry.logPaths.length === 0) {
      counts["ログを引いていない（本文の実測値だけ）"] += 1;
      entries.push({ block: entry.block, kind: "ログを引いていない（本文の実測値だけ）" });
      continue;
    }

    // ログを引いているのに、そのログが概念を 1 つも記録していないなら、引用が飾りである。
    // これだけは違反にする（引いた先に中身が無いことは、主張の型に依らず誤りである）。
    if (cited.length === 0 || cited.every((log) => log.concepts.length === 0 && !log.hasDeclarationReading)) {
      violations.push(
        `[引いているログに中身が無い] ${entry.block} — ` +
          `${entry.logPaths.join("・")} を根拠に挙げているが、` +
          `そのログは概念の走査結果も宣言の直読も記録していない（引用が飾りになっている）。`,
      );
    }

    counts["数字は不在を示していない（射程の主張）"] += 1;
    entries.push({ block: entry.block, kind: "数字は不在を示していない（射程の主張）" });
  }

  return { violations, entries, counts };
};

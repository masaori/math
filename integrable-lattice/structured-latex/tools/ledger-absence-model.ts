/**
 * **台帳の「無い」に実在確認の根拠が付いているかを見る模型**（検査 F の中で回す）。
 *
 * ## なぜ要るか（一次情報）
 *
 * `docs/tasks/auto-loop-state.md` の cycle 29 総括は、**壁の名前を一次情報より先に書く誤りが
 * 4 サイクル連続している**と記録し、「台帳に『無い』『持っていない』と書くときは、
 * その場で実在確認のログを残す規律にできないか」を cycle 30 の焦点に挙げた。
 * 実在確認そのものは `lean/scripts/mathlib-gap-survey*.sh` が行い、結果を `lean/logs/*.log` へ残す。
 * ここで見るのは、**台帳の側がその結果へ結びついているか**である。
 *
 * ## 何を「不在の主張」とみなすか（拾い方は実データから決めた）
 *
 * 台帳 `formalization-coverage.ts` の `note` / `remaining` / `reason` を走査し、
 * 下の {@link ABSENCE_MARKERS} を含む箇所を不在の主張として拾う。漢字の「無い」系と
 * 走査結果の「0 件」に限っており、平仮名の「ない」は採らない。
 * 理由は実データにある——平仮名の「ない」は台帳に 22 箇所あるが、その大半は
 * 「要らなかった」「使わない」「証明しない」「書いていない」であり、素材の不在とは関係しない。
 *
 * **採らなかった語もここに残す。**
 *
 * - **「存在しない」** — 実データでは「閉形式が存在しないことの主張そのもの」
 *   （命題 C″ の (4)）で使われている。これは数学の非存在定理であって素材の不在ではない。
 *   拾うと、証明済みの成果に実在確認のログを要求することになる。
 * - **「欠落」** — 実データでは「mathlib の欠落は…ではなく…である」「配線の欠落ではなく
 *   素材の欠落である」の形で、不在の主張の**言い換え**として現れる。
 *   語そのものは向きを持たないので、拾っても不在の主張の位置を指せない。
 *
 * ## 拾ったうえで除くもの（実データに現に在る誤検出）
 *
 * **過去の判定を引用して否定している箇所**を除く。台帳には
 * 「**step 1 の仕分けが「素材が無い」と判定したのは誤りだった**」のように、
 * 鉤括弧で過去の判定を引いてすぐ否定する書き方が 3 エントリに 4 箇所ある。
 * これは不在の主張ではなく、その撤回である。除かないと、
 * 「壁は無かった」と書き直したエントリほど実在確認のログを要求されることになり、向きが逆になる。
 * 判定は形で行う——鉤括弧の直後 30 文字以内に「誤り」「覆っ」「撤回」があるものだけを除く。
 *
 * ## 根拠として認めるもの
 *
 * 1. **実在確認ログのパス** `lean/logs/*.log`。
 * 2. **走査の実測値**、すなわち 日付・mathlib のコミット・走査ファイル数の 3 つが揃っていること。
 *
 * `lean/README.md の欠落調査` のような**文書への指し示しは根拠として認めない。**
 * 指し示された先が現在どの mathlib を見た結果なのかを、機械が辿れないからである
 * （現に台帳の 1 エントリがこの形だった）。
 *
 * ## 粒度（弱いところなので明示する）
 *
 * **主張は箇所ごとに拾うが、根拠はエントリ単位で見る。** すなわち、あるエントリが
 * 不在の主張を 1 つ以上含むなら、そのエントリのどこかに根拠が 1 つ以上あればよい。
 * 箇所ごとに根拠を要求しないのは、台帳の文が
 * 「主張の文で括弧を開き、2 文あとで閉じる」形で根拠を書いているためで、
 * 文で切ると根拠と主張が別々の断片へ落ちる（実データで確認した）。
 * 代償として、**同じエントリ内の別の主張が、無関係なログで通ってしまう。**
 * これはこの模型が保証しないことである。
 *
 * ## そのほか保証しないこと
 *
 * - **根拠の中身が主張に合っているかは見ない。** ログが実在し、どの mathlib を見たかが
 *   記録されていることまでしか確かめない。挙げたログがその概念を走っているかは人が見る。
 * - **ログのパスは ASCII の名前しか拾わない**（`lean/logs/` の実在するログはすべて ASCII）。
 * - **走査の実測値は 3 要素が同じエントリに在ることしか見ない。** その日付・コミット・
 *   ファイル数が同じ走査のものかどうかは確かめられない。
 */

/** 不在の主張として拾う語。実データを読んで決めた（doc 参照）。 */
export const ABSENCE_MARKERS: readonly string[] = [
  "無い",
  "無く",
  "無し",
  "持っていない",
  "該当なし",
  "0 件",
];

/** 鉤括弧の直後にこれらがあれば、その引用は撤回されている（不在の主張ではない）。 */
const RETRACTION_WORDS = /誤り|覆っ|撤回/;

/** 鉤括弧の直後を何文字まで見るか。 */
const RETRACTION_WINDOW = 30;

/** 根拠として認める実在確認ログのパス。 */
const LOG_PATH = /lean\/logs\/[A-Za-z0-9._-]+\.log/g;

/** 走査の実測値の 3 要素。3 つ揃ってはじめて根拠と認める。 */
const MEASUREMENT = {
  日付: /\d{4}-\d{2}-\d{2}/,
  コミット: /[0-9a-f]{8,40}/,
  走査ファイル数: /\d{3,}\s*ファイル/,
} as const;

export type AbsenceClaim = {
  /** 拾った語。 */
  readonly marker: string;
  /** エントリ本文の中での位置。 */
  readonly index: number;
  /** 前後を切り出した字面（報告用）。 */
  readonly context: string;
};

export type LedgerText = {
  readonly block: string;
  /** `note` / `remaining` / `reason` のいずれか（エントリが持っているもの）。 */
  readonly text: string;
};

export type EntryAudit = {
  readonly block: string;
  readonly claims: readonly AbsenceClaim[];
  /** 撤回として除いた箇所の数（黙って捨てないので数を出す）。 */
  readonly retracted: number;
  readonly logPaths: readonly string[];
  /** 走査の実測値のうち揃っている要素の名前。 */
  readonly measurement: readonly string[];
  readonly hasEvidence: boolean;
};

export type LogAudit = {
  readonly path: string;
  readonly exists: boolean;
  /** ログが記録している mathlib のコミット。ログに記録が無ければ `undefined`。 */
  readonly recordedCommit: string | undefined;
  /** 現在の mathlib と違うか。 */
  readonly stale: boolean;
};

export type AbsenceAuditInput = {
  readonly entries: readonly LedgerText[];
  /** ログが実在するか。 */
  readonly logExists: (path: string) => boolean;
  /** ログが記録している mathlib のコミット（記録が無ければ `undefined`）。 */
  readonly logCommit: (path: string) => string | undefined;
  /** `lean/lake-manifest.json` が指す現在の mathlib のコミット。 */
  readonly currentMathlibCommit: string | undefined;
};

export type AbsenceAudit = {
  readonly entries: readonly EntryAudit[];
  readonly logs: readonly LogAudit[];
  readonly violations: readonly string[];
};

const CONTEXT_BEFORE = 26;
const CONTEXT_AFTER = 18;

/** 鉤括弧のうち、直後で否定されているものの範囲。 */
const retractedSpans = (text: string): readonly (readonly [number, number])[] => {
  const spans: (readonly [number, number])[] = [];
  for (const quote of text.matchAll(/「[^「」]*」/g)) {
    const start = quote.index ?? 0;
    const end = start + quote[0].length;
    if (RETRACTION_WORDS.test(text.slice(end, end + RETRACTION_WINDOW))) spans.push([start, end]);
  }
  return spans;
};

/** 不在の主張を拾う。撤回された引用の中にあるものは拾わない。 */
export const findAbsenceClaims = (
  text: string,
): { readonly claims: readonly AbsenceClaim[]; readonly retracted: number } => {
  const spans = retractedSpans(text);
  const claims: AbsenceClaim[] = [];
  let retracted = 0;
  const pattern = new RegExp(ABSENCE_MARKERS.join("|"), "g");
  for (const hit of text.matchAll(pattern)) {
    const index = hit.index ?? 0;
    if (spans.some(([from, to]) => index >= from && index < to)) {
      retracted += 1;
      continue;
    }
    claims.push({
      marker: hit[0],
      index,
      context: text.slice(Math.max(0, index - CONTEXT_BEFORE), index + hit[0].length + CONTEXT_AFTER),
    });
  }
  return { claims, retracted };
};

/** 根拠を取り出す。ログのパスと、走査の実測値のうち揃っている要素。 */
export const findEvidence = (
  text: string,
): { readonly logPaths: readonly string[]; readonly measurement: readonly string[] } => {
  const logPaths = [...new Set([...text.matchAll(LOG_PATH)].map((hit) => hit[0]))];
  const measurement = Object.entries(MEASUREMENT)
    .filter(([, pattern]) => pattern.test(text))
    .map(([name]) => name);
  return { logPaths, measurement };
};

export const auditLedgerAbsence = (input: AbsenceAuditInput): AbsenceAudit => {
  const { entries, logExists, logCommit, currentMathlibCommit } = input;
  const violations: string[] = [];
  const entryAudits: EntryAudit[] = [];
  const logAudits = new Map<string, LogAudit>();

  for (const entry of entries) {
    const { claims, retracted } = findAbsenceClaims(entry.text);
    const { logPaths, measurement } = findEvidence(entry.text);
    const hasMeasurement = measurement.length === Object.keys(MEASUREMENT).length;
    const hasEvidence = logPaths.length > 0 || hasMeasurement;
    entryAudits.push({ block: entry.block, claims, retracted, logPaths, measurement, hasEvidence });

    if (claims.length > 0 && !hasEvidence) {
      const missing = Object.keys(MEASUREMENT).filter((name) => !measurement.includes(name));
      violations.push(
        `[不在の主張に根拠が無い] ${entry.block} — ` +
          `不在の主張 ${claims.length} 件（${claims.map((claim) => claim.marker).join("・")}）に対し、` +
          `実在確認ログのパス（lean/logs/*.log）も走査の実測値も無い` +
          `（実測値として足りないもの: ${missing.join("・")}）。` +
          `一次情報を見ずに壁の名前を書かないための規律である`,
      );
    }

    for (const path of logPaths) {
      if (logAudits.has(path)) continue;
      const exists = logExists(path);
      const recordedCommit = exists ? logCommit(path) : undefined;
      logAudits.set(path, {
        path,
        exists,
        recordedCommit,
        stale:
          recordedCommit !== undefined &&
          currentMathlibCommit !== undefined &&
          recordedCommit !== currentMathlibCommit,
      });
      if (!exists) {
        violations.push(
          `[根拠のログが実在しない] ${entry.block} — ${path}（消えたか、改名されたか、書かれていない）`,
        );
        continue;
      }
      if (recordedCommit === undefined) {
        violations.push(
          `[根拠のログが mathlib のコミットを記録していない] ${entry.block} — ${path}。` +
            `どの mathlib を見た結果なのかが分からないログは、根拠として辿れない`,
        );
      }
    }
  }

  if (currentMathlibCommit === undefined) {
    violations.push(
      "[現在の mathlib のコミットが読めない] lean/lake-manifest.json から mathlib の rev を取れない。" +
        "根拠のログが古いかどうかを判定できない",
    );
  }

  return { entries: entryAudits, logs: [...logAudits.values()], violations };
};

/**
 * **ログの mathlib が現在の mathlib と違うことを、なぜ違反にしないか。**
 *
 * mathlib はこちらの都合と無関係に進む。コミットの不一致を違反にすると、
 * mathlib を上げた瞬間に**根拠つきのエントリが全件同時に赤くなる**。
 * 赤を消すには走査をやり直すしかないが、走査には mathlib を展開した `lean/` が要る一方、
 * `npm run check` は mathlib 不在でも通ることを前提に組んである。
 * 通せない検査は、いずれ「落ちているのが普通」になって効かなくなる。
 *
 * そこで**件数として毎回印字する**。古いログを黙って根拠にし続けられないようにするのが目的なので、
 * 見えていれば足りる。違反にするのはこちらの手の内にあるもの——
 * **ログが実在しないこと**と、**ログがコミットを記録していないこと**——に限る。
 */
export const STALENESS_POLICY =
  "ログの mathlib が現在と違っても違反にしない（件数を印字する）。mathlib はこちらと無関係に進むため、" +
  "違反にすると mathlib を上げた瞬間に全件赤くなり、mathlib 不在でも通る前提の npm run check で消せなくなる。";

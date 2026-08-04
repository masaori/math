/**
 * **外部定理の振り分けを検査する側の型と純粋関数**。
 *
 * 台帳は `external-theorem-coverage.ts`、基準の正本は `docs/external-theorem-criterion.md`。
 * ここに置くのは判定だけで、ファイルの読み書きはしない（検出テストから直接呼べるようにするため。
 * `ledger-absence-model.ts` と同じ形にしてある）。
 *
 * ## 何を違反にするか（なぜその粒度かも書く）
 *
 * 1. **引いている箇所（`citedIn`）が空である。** どのブロックが引いているかを書かずに種別だけ
 *    宣言すると、振り分けの当否を誰も確かめられない。空を許さない。
 * 2. **引いている箇所が本文に実在しない。** 改名・削除で浮いたら赤くする。
 *    台帳が本文から静かに乖離する道を塞ぐ。
 * 3. **`自分で証明する` が宣言した Lean の定理名が実在しない。**
 *    形式化に着手したと言うなら読者が辿れる先が要る（検査 F の本体と同じ要求）。
 *
 * ## 違反にしないと決めたこと（判断と理由）
 *
 * - **種別そのものの当否は見ない。** ある引用が「証明の根拠」なのか「位置づけ」なのかは
 *   本文を読んで決める人の判断である。機械が代われる形にできなかった。
 *   代わりに、`R 脱出として隔離する` と `対象外` には根拠の記述を**型で必須**にしてある
 *   （書き忘れは型検査で落ちるので、この関数まで来ない）。
 * - **`mathlib から引く` に Lean の定理名を要求しない。** mathlib の宣言名は
 *   `lean/` に無いので、実在検査の対象にできない。代わりに `presence`（どこに在るか）を型で必須にした。
 */

export type ExternalKindName =
  | "自分で証明する"
  | "mathlib から引く"
  | "R 脱出として隔離する"
  | "対象外";

export type ExternalOwnState = "完了" | "部分的" | "未着手";

/** 検査に要る最小限だけを取り出した形（台帳の全フィールドは要らない）。 */
export type ExternalLedgerRow = {
  readonly name: string;
  readonly kind: ExternalKindName;
  readonly citedIn: readonly string[];
  /** `自分で証明する` のときだけ意味がある。 */
  readonly leanNames?: readonly string[];
  /** `自分で証明する` のときだけ意味がある。 */
  readonly state?: ExternalOwnState;
};

export type ExternalAudit = {
  readonly violations: readonly string[];
  /** 種別ごとの件数。 */
  readonly counts: Readonly<Record<ExternalKindName, number>>;
  /** `自分で証明する` のうち、着手しているもの（`完了` または `部分的`）の件数。 */
  readonly startedOwnProofs: number;
  /** `自分で証明する` のうち `完了` の件数。**残りの件数はここから決まる。** */
  readonly doneOwnProofs: number;
};

export const auditExternalTheorems = (input: {
  readonly entries: readonly ExternalLedgerRow[];
  /** 本文にそのブロック id が実在するか。 */
  readonly blockExists: (id: string) => boolean;
  /** `lean/` にその定理名が実在するか。 */
  readonly leanDeclExists: (name: string) => boolean;
}): ExternalAudit => {
  const violations: string[] = [];
  const counts: Record<ExternalKindName, number> = {
    "自分で証明する": 0,
    "mathlib から引く": 0,
    "R 脱出として隔離する": 0,
    対象外: 0,
  };
  let startedOwnProofs = 0;
  let doneOwnProofs = 0;

  for (const entry of input.entries) {
    counts[entry.kind] += 1;

    if (entry.citedIn.length === 0) {
      violations.push(
        `[引いている箇所が空] ${entry.name} — どのブロックが引いているかを書くこと` +
          `（書かなければ振り分けの当否を誰も確かめられない）`,
      );
    }
    for (const block of entry.citedIn) {
      if (input.blockExists(block)) continue;
      violations.push(
        `[引いている箇所が本文に無い] ${entry.name} — ${block}（改名・削除で浮いた）`,
      );
    }

    if (entry.kind !== "自分で証明する") continue;
    const names = entry.leanNames ?? [];
    const state = entry.state;
    if (state === "完了") doneOwnProofs += 1;
    if (state === "完了" || state === "部分的") startedOwnProofs += 1;

    // 状態と Lean の定理名が食い違う道を塞ぐ（検査 F が本文側の主張に課しているのと同じ形）。
    // これが無いと、定理名を 1 つも持たないまま「完了」と書けてしまう。
    if ((state === "完了" || state === "部分的") && names.length === 0) {
      violations.push(
        `[${state}なのに Lean の定理名が無い（外部定理）] ${entry.name} — ` +
          `${state}と言う以上、読者が辿れる先が要る`,
      );
    }
    if (state === "未着手" && names.length > 0) {
      violations.push(
        `[未着手なのに Lean の定理名がある（外部定理）] ${entry.name} — ` +
          `${names.join(" / ")}（着手しているなら状態を直すこと）`,
      );
    }

    for (const name of names) {
      const short = name.replace(/^IntegrableLattice\./, "");
      if (input.leanDeclExists(short)) continue;
      violations.push(`[Lean に実在しない定理名（外部定理）] ${entry.name} — ${name}`);
    }
  }

  return { violations, counts, startedOwnProofs, doneOwnProofs };
};

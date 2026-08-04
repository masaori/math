/**
 * **外部定理の振り分けの検査が、実際に落ちることの実証**。
 *
 * 検出できるだけでは足りず、**現に台帳が取っている形が違反にならないこと**も要る
 * （誤検出する検査は使われなくなる）。両方向を合成データで通す。
 *
 * 実行: `npm run test:external-theorem`
 */

import { auditExternalTheorems, type ExternalLedgerRow } from "./external-theorem-model.ts";

const 本文にあるブロック = new Set(["paper_062_theorem_T", "paper_031_theorem_lsw"]);
const leanにある定理 = new Set(["lapMatrixOfInc", "det_eulerMatrix_sq"]);

const run = (entries: readonly ExternalLedgerRow[]) =>
  auditExternalTheorems({
    entries,
    blockExists: (id) => 本文にあるブロック.has(id),
    leanDeclExists: (name) => leanにある定理.has(name),
  });

const 健全な行: ExternalLedgerRow = {
  name: "Kirchhoff の matrix-tree 定理",
  kind: "自分で証明する",
  citedIn: ["paper_062_theorem_T"],
  state: "部分的",
  leanNames: ["lapMatrixOfInc"],
};

const cases: readonly {
  readonly name: string;
  readonly entries: readonly ExternalLedgerRow[];
  /** 違反に含まれていてほしい字面（`undefined` なら違反 0 件を期待する）。 */
  readonly expect?: string;
}[] = [
  {
    name: "現に台帳が取っている形（引用箇所も定理名も実在する）は違反にならない",
    entries: [健全な行],
  },
  {
    name: "R 脱出として隔離する・対象外・mathlib から引く も、引用箇所が実在すれば通る",
    entries: [
      { name: "LSW", kind: "R 脱出として隔離する", citedIn: ["paper_031_theorem_lsw"] },
      { name: "Lehmer 問題", kind: "対象外", citedIn: ["paper_031_theorem_lsw"] },
      { name: "Hensel の補題", kind: "mathlib から引く", citedIn: ["paper_062_theorem_T"] },
    ],
  },
  {
    name: "引いている箇所を書いていない",
    entries: [{ ...健全な行, citedIn: [] }],
    expect: "[引いている箇所が空]",
  },
  {
    name: "引いている箇所が本文から消えた（改名・削除で浮いた）",
    entries: [{ ...健全な行, citedIn: ["paper_999_theorem_gone"] }],
    expect: "[引いている箇所が本文に無い]",
  },
  {
    name: "自分で証明すると言って、実在しない定理名を宣言した",
    entries: [{ ...健全な行, leanNames: ["nonexistent_lemma"] }],
    expect: "[Lean に実在しない定理名（外部定理）]",
  },
  {
    name: "名前空間つきで書いても実在すれば通る",
    entries: [{ ...健全な行, leanNames: ["IntegrableLattice.lapMatrixOfInc"] }],
  },
  {
    name: "自分で証明する以外の種別は Lean の定理名を要求されない",
    entries: [{ name: "Cramer の規則", kind: "mathlib から引く", citedIn: ["paper_062_theorem_T"] }],
  },
  // ここから下は cycle 32 step 1 で足した（状態と Lean の定理名が食い違う道を塞ぐため）。
  // これが無いと、定理名を 1 つも持たないまま「完了」と書いて件数だけ減らせてしまう。
  {
    name: "完了と書いてあるのに Lean の定理名が無い",
    entries: [{ ...健全な行, state: "完了", leanNames: [] }],
    expect: "[完了なのに Lean の定理名が無い（外部定理）]",
  },
  {
    name: "部分的と書いてあるのに Lean の定理名が無い",
    entries: [{ ...健全な行, state: "部分的", leanNames: [] }],
    expect: "[部分的なのに Lean の定理名が無い（外部定理）]",
  },
  {
    name: "未着手と書いてあるのに Lean の定理名がある",
    entries: [{ ...健全な行, state: "未着手" }],
    expect: "[未着手なのに Lean の定理名がある（外部定理）]",
  },
  {
    name: "未着手で定理名を持たない形は通る",
    entries: [{ ...健全な行, state: "未着手", leanNames: [] }],
  },
  {
    name: "完了で実在する定理名を持つ形は通る",
    entries: [{ ...健全な行, state: "完了", leanNames: ["lapMatrixOfInc", "det_eulerMatrix_sq"] }],
  },
];

let failed = 0;
for (const testCase of cases) {
  const { violations } = run(testCase.entries);
  const ok =
    testCase.expect === undefined
      ? violations.length === 0
      : violations.some((violation) => violation.includes(testCase.expect!));
  if (!ok) {
    failed += 1;
    console.log(`NG  ${testCase.name}`);
    console.log(`    期待: ${testCase.expect ?? "違反 0 件"}`);
    console.log(`    実際: ${violations.length === 0 ? "違反 0 件" : violations.join(" / ")}`);
  } else {
    console.log(`OK  ${testCase.name}`);
  }
}

// 件数の集計そのものも実証する（残りの件数がここから出るため）。
{
  const { counts, startedOwnProofs, doneOwnProofs } = run([
    健全な行,
    { name: "a", kind: "mathlib から引く", citedIn: ["paper_062_theorem_T"] },
    { name: "b", kind: "R 脱出として隔離する", citedIn: ["paper_031_theorem_lsw"] },
    { name: "c", kind: "対象外", citedIn: ["paper_031_theorem_lsw"] },
    { name: "d", kind: "自分で証明する", citedIn: ["paper_062_theorem_T"], state: "未着手" },
    {
      name: "e",
      kind: "自分で証明する",
      citedIn: ["paper_062_theorem_T"],
      state: "完了",
      leanNames: ["det_eulerMatrix_sq"],
    },
  ]);
  const ok =
    counts["自分で証明する"] === 3 &&
    counts["mathlib から引く"] === 1 &&
    counts["R 脱出として隔離する"] === 1 &&
    counts.対象外 === 1 &&
    startedOwnProofs === 2 &&
    doneOwnProofs === 1;
  if (!ok) {
    failed += 1;
    console.log(`NG  種別ごとの件数と、着手済み・完了の数え方`);
    console.log(
      `    実際: ${JSON.stringify(counts)} / 着手済み ${startedOwnProofs} / 完了 ${doneOwnProofs}`,
    );
  } else {
    console.log(`OK  種別ごとの件数と、着手済み・完了の数え方`);
  }
}

const total = cases.length + 1;
if (failed > 0) {
  console.log(`NG: ${failed} 件が期待どおりでない。`);
  process.exit(1);
}
console.log(`OK: ${total} 件すべて期待どおり。`);

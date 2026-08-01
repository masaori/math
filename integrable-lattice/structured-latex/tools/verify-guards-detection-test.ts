#!/usr/bin/env node
/**
 * **検査 C（証明の欠落）と検査 R（腐ったツール参照）が実際に検出できることの実証。**
 *
 * 「本番で違反 0 件だった」は検査が効いていることの根拠にならない（cycle 22 の教訓）。
 * さらに cycle 24 step 3 §9.1 の教訓——**「赤くなった」で満足すると、どの経路で赤くなったのかを
 * 見落とす**——を踏まえ、**期待する違反の種類まで突き合わせる**。種類が違えば失敗にする。
 *
 * **ファイルは 1 バイトも書き換えない。** 読み込んだ後のメモリ上の値に差分を当てる。
 *
 * 各件について 2 つを確かめる:
 *   1. 壊すと期待どおりの種類の違反が出る。
 *   2. 壊さなければ出ない（偽陽性でない）。
 *
 * 使い方: node tools/verify-guards-detection-test.ts
 */

import { loadContentFiles } from "./content-modules.ts";
import { REFERENCE_ALLOWANCES } from "./reference-rot-allowances.ts";
import {
  PROOF_DEBTS,
  checkProofDebts,
  findMissingProofs,
  proofViewOf,
  type ProofDebt,
  type ProofView,
} from "./proof-debt.ts";
import {
  extractReferences,
  firstSegmentsOfRepo,
  checkAllowances,
  resolveReference,
  type ReferenceAllowance,
  type RotFinding,
} from "./reference-rot-model.ts";

let failures = 0;
let checks = 0;
const report = (name: string, ok: boolean, detail: string): void => {
  checks += 1;
  if (!ok) failures += 1;
  console.log(`  ${ok ? "検出" : "**失敗**"}: ${name}`);
  console.log(`      ${detail}`);
};

// =============================================================================
// 検査 C — 証明の欠落
// =============================================================================

const files = await loadContentFiles();
const views: ProofView[] = files.flatMap(({ file, blocks }) =>
  blocks.map((block) => proofViewOf(block, file)),
);
const byId = new Map(views.map((view) => [view.id, view]));

console.log("検査 C（証明の欠落）の検出テスト\n");

// --- C-1: 証明を持つブロックから証明を落とすと違反になる（全件で確かめる）------------
const withProof = views.filter((view) => view.hasProof);
{
  const baseline = findMissingProofs(views, PROOF_DEBTS).length;
  let detected = 0;
  const missed: string[] = [];
  for (const target of withProof) {
    const broken = views.map((view) =>
      view.id === target.id ? { ...view, hasProof: false, emptyReason: "proof が空配列" } : view,
    );
    const found = findMissingProofs(broken, PROOF_DEBTS);
    if (found.some((f) => f.block === target.id)) detected += 1;
    else missed.push(target.id);
  }
  report(
    "証明を持つブロックから証明を落とす",
    detected === withProof.length && baseline === 0,
    `${detected} / ${withProof.length} ブロックで違反になった` +
      `（壊す前の未宣言の違反は ${baseline} 件）` +
      (missed.length === 0 ? "" : `。挙がらなかった: ${missed.join(", ")}`),
  );
}

// --- C-2: 証明の「中身が無い」形を 3 通り作って、どれも「持たない」と判定されることを見る ---
{
  const cases: { name: string; proof: unknown; expect: string }[] = [
    { name: "proof を空配列にする", proof: [], expect: "proof が空配列" },
    {
      name: "proof を TODO ノードだけにする",
      proof: [{ type: "todo", value: "証明は後で運ぶ" }],
      expect: "proof が TODO ノードを含む",
    },
    {
      name: "proof を空白だけの段落にする",
      proof: [{ type: "paragraph", children: [{ type: "text", value: "   " }] }],
      expect: "proof に中身が無い",
    },
  ];
  const donor = files
    .flatMap(({ file, blocks }) => blocks.map((block) => ({ file, block })))
    .find(({ file, block }) => proofViewOf(block, file).hasProof);
  if (donor === undefined) throw new Error("証明を持つブロックが 1 つも無い（本文の読み込みに失敗している）");
  for (const testCase of cases) {
    const broken = { ...donor.block, proof: testCase.proof } as typeof donor.block;
    const view = proofViewOf(broken, donor.file);
    report(
      testCase.name,
      !view.hasProof && view.emptyReason === testCase.expect,
      view.hasProof
        ? "証明を持っていると判定された（検出できていない）"
        : `「${view.emptyReason}」と判定された（期待: 「${testCase.expect}」）`,
    );
  }
}

// --- C-3: 宣言（既知の未了）を腐らせると赤くなる -------------------------------------
const baseDebt = PROOF_DEBTS.find((d) => d.block === "paper_111_theorem_general_closed_form");
if (baseDebt === undefined) throw new Error("基準にする宣言が見つからない");

type DebtRot = { name: string; debt: ProofDebt; views?: Map<string, ProofView>; expect: string };
const debtRots: DebtRot[] = [
  {
    name: "未了を記録した report の一文を書き換える",
    debt: {
      ...baseDebt,
      grounds: {
        ...baseDebt.grounds,
        recordedIn: { ...baseDebt.grounds.recordedIn, quote: "本章は証明を運びおえている（証明は空ではない）" },
      },
    },
    expect: "未了の記録が見つからない",
  },
  {
    name: "引用は report に実在するが、未了を述べていない文へ貼り替える",
    debt: {
      ...baseDebt,
      grounds: {
        ...baseDebt.grounds,
        recordedIn: { ...baseDebt.grounds.recordedIn, quote: "## 9. 次に必要なこと（申し送り）" },
      },
    },
    expect: "記録が未了を述べていない",
  },
  {
    name: "引用を短くして pin にならなくする",
    debt: {
      ...baseDebt,
      grounds: { ...baseDebt.grounds, recordedIn: { ...baseDebt.grounds.recordedIn, quote: "証明を持たない" } },
    },
    expect: "宣言の指定が短すぎて何も pin していない",
  },
  {
    name: "原本の在処を、転記検査の台帳が挙げていない report にする",
    debt: {
      ...baseDebt,
      grounds: {
        ...baseDebt.grounds,
        origin: { ...baseDebt.grounds.origin, report: "outputs/reports/cycle22_T3_coefficients_d_e.md" },
      },
    },
    expect: "原本の在処が転記検査の台帳と食い違う",
  },
  {
    name: "原本の目印を、report に無いものへ書き換える（原本が改稿された場合）",
    debt: {
      ...baseDebt,
      grounds: {
        ...baseDebt.grounds,
        origin: { ...baseDebt.grounds.origin, proofMarker: "### 5.2 定理 G4（撤回済み）" },
      },
    },
    expect: "原本の目印が見つからない",
  },
  {
    name: "原本の目印は実在するが、その先に証明が無い箇所を指す（原本から証明が消えた場合）",
    debt: {
      ...baseDebt,
      grounds: {
        ...baseDebt.grounds,
        origin: { ...baseDebt.grounds.origin, proofMarker: "## 8. 自分が犯した誤り（隠さず記録する）" },
      },
    },
    expect: "原本にその証明が無い",
  },
  {
    name: "宣言が指すブロックが本文から消える",
    debt: { ...baseDebt, block: "paper_999_theorem_gone" },
    expect: "宣言が指すブロックが本文に無い",
  },
  {
    name: "証明が本文へ入ったのに宣言が残る",
    debt: baseDebt,
    views: new Map(
      [...byId].map(([id, view]) =>
        id === baseDebt.block ? [id, { ...view, hasProof: true, emptyReason: undefined }] : [id, view],
      ),
    ),
    expect: "宣言が余っている（証明が入った）",
  },
  {
    name: "宣言が、証明を要さない種別のブロックを指す",
    debt: { ...baseDebt, block: "paper_011_remark_positioning" },
    expect: "宣言が指すブロックは証明を要さない種別",
  },
];

const debtBaseline = await checkProofDebts(PROOF_DEBTS, byId);
for (const rot of debtRots) {
  const found = await checkProofDebts([rot.debt], rot.views ?? byId);
  const hit = found.find((f) => f.kind === rot.expect);
  const quietBefore = !debtBaseline.some((f) => f.block === rot.debt.block);
  report(
    rot.name,
    hit !== undefined && quietBefore,
    hit === undefined
      ? `期待した「${rot.expect}」が出なかった。出たのは: ${found.map((f) => f.kind).join(", ") || "（無し）"}`
      : quietBefore
        ? `「${hit.kind}」で挙げた`
        : `腐らせる前から挙がってしまう（偽陽性）: ${debtBaseline.map((f) => f.kind).join(", ")}`,
  );
}

// =============================================================================
// 検査 R — 腐ったツール参照
// =============================================================================

console.log("\n検査 R（腐ったツール参照）の検出テスト");
console.log("  再現データ: cycle 24 step 2 の腐り（`git show 6756584` が訂正した 12 ファイル分の原文）\n");

const firstSegments = await firstSegmentsOfRepo();

/** 行 1 本を、走査と同じ手順（抽出 → 解決）に掛ける。 */
async function rotOfLine(file: string, lineText: string): Promise<RotFinding[]> {
  const out: RotFinding[] = [];
  for (const { text, kind } of extractReferences(lineText, firstSegments)) {
    const finding = await resolveReference({ file, line: 1, text, kind, lineText });
    if (finding !== undefined) out.push(finding);
  }
  return out;
}

const EN = "structured-latex/locales/en/content";

/**
 * cycle 24 step 2 で腐っていた当時の記述。`git show 6756584` の削除行（`-` 側）から取った。
 * 12 ファイルすべてが「日本語版の正本」を `../../structured-latex/content/<file>` と
 * 指しており（移動後は `../../../content/<file>` が正しい）、11 ファイルが撤去済みの比較器を、
 * 1 ファイルが存在しない npm script を名指ししていた。
 */
const HISTORICAL_ROT: { file: string; line: string; expect: RotFinding["reason"]; label: string }[] = [
  ...[
    "001_intro.ts", "002_setup.ts", "003_archimedean.ts", "004_lambda_finite.ts",
    "005_duality.ts", "005b_theta_infinity.ts", "005c_ell2_family.ts",
    "006_propositions_TVW.ts", "007_asymmetry_scope.ts", "008_theta_padic.ts",
    "009_s_infinity_decision.ts", "009_theta_recursion.ts",
  ].map((name) => ({
    file: `${EN}/${name}`,
    line: ` * **正本は日本語版 \`../../structured-latex/content/${name}\` である。**`,
    expect: "実在しないパス" as const,
    label: `移動で深さがずれた相対パス（${name}）`,
  })),
  {
    file: `${EN}/002_setup.ts`,
    line: " * **数式**は日本語版と完全に同じ文字列を使う（`tools/verify-ja-en-correspondence.ts` が検査する）。",
    expect: "実在しないパス" as const,
    label: "撤去済みの比較器を指すコメント",
  },
  {
    file: `${EN}/001_intro.ts`,
    line: " * （足すまで `npm run verify:correspondence` は欠落として失敗する。それが正しい状態である）。",
    expect: "実在しない npm script" as const,
    label: "存在しない npm script",
  },
];

{
  let detected = 0;
  const missed: string[] = [];
  for (const fixture of HISTORICAL_ROT) {
    const found = await rotOfLine(fixture.file, fixture.line);
    if (found.some((f) => f.reason === fixture.expect)) detected += 1;
    else missed.push(fixture.label);
  }
  report(
    "cycle 24 step 2 の腐りの再現データ（12 ファイル分＋比較器＋npm script）",
    detected === HISTORICAL_ROT.length,
    `${detected} / ${HISTORICAL_ROT.length} 件を検出した` +
      (missed.length === 0 ? "" : `。挙がらなかった: ${missed.join(", ")}`),
  );
}

// --- R-2: 訂正後の記述では挙がらない（偽陽性でない）------------------------------------
{
  const fixed = [
    { file: `${EN}/001_intro.ts`, line: " * **正本は日本語版 `../../../content/001_intro.ts` である。**" },
    {
      file: `${EN}/002_setup.ts`,
      line: " * 日本語版と完全に同じ文字列を使う（`tools/verify-localization.ts` の構造照合が検査する）。",
    },
    { file: `${EN}/001_intro.ts`, line: " * （欠落があれば `npm run verify:localization` が構造照合で落とす）。" },
  ];
  let quiet = 0;
  const noisy: string[] = [];
  for (const { file, line } of fixed) {
    const found = await rotOfLine(file, line);
    if (found.length === 0) quiet += 1;
    else noisy.push(`${line.trim()} → ${found.map((f) => f.text).join(", ")}`);
  }
  report(
    "訂正後の記述では挙がらない（偽陽性でない）",
    quiet === fixed.length,
    `${quiet} / ${fixed.length} 件が静か` + (noisy.length === 0 ? "" : `。挙がった: ${noisy.join(" / ")}`),
  );
}

// --- R-3: 偽陽性を出さないことの確認（正当な書き方を並べる）----------------------------
{
  const benign: { line: string; why: string }[] = [
    { line: " * 分数 `1/2` と `4G/π` は参照ではない", why: "分数" },
    { line: " * arXiv の `math-ph/9904003` と `cond-mat/0510683` は参照ではない", why: "arXiv id" },
    { line: " * 外部の `zbmath.org/static/msc2020.pdf` はリポジトリ内のパスではない", why: "外部ホスト" },
    { line: " * 集合の指示 `content/*.ts` は展開しない", why: "glob" },
    { line: " * 地の文の sagemath/Lean 投下可 は参照ではない", why: "バッククォート外" },
    { line: "  return `${mode}:${node.tex}`;", why: "テンプレート文字列の埋め込み式" },
    { line: " * 正本は `../../../content/001_intro.ts` である", why: "実在する相対パス" },
    { line: " * `npm run check` を通すこと", why: "実在する npm script" },
    { line: " * `pnpm install` を実行する", why: "pnpm 自身のサブコマンド" },
  ];
  let quiet = 0;
  const noisy: string[] = [];
  for (const { line, why } of benign) {
    const found = await rotOfLine(`${EN}/001_intro.ts`, line);
    if (found.length === 0) quiet += 1;
    else noisy.push(`${why}: ${found.map((f) => f.text).join(", ")}`);
  }
  report(
    "正当な書き方 9 通りで偽陽性を出さない",
    quiet === benign.length,
    `${quiet} / ${benign.length} 件が静か` + (noisy.length === 0 ? "" : `。挙がった: ${noisy.join(" / ")}`),
  );
}

// --- R-4: 免除を腐らせると赤くなる ----------------------------------------------------
console.log("");
const pick = (predicate: (a: ReferenceAllowance) => boolean): ReferenceAllowance => {
  const found = REFERENCE_ALLOWANCES.find(predicate);
  if (found === undefined) throw new Error("基準にする免除が見つからない");
  return found;
};
const historical = pick((a) => a.grounds.type === "historical");
const generated = pick((a) => a.grounds.type === "generated");
const other = pick((a) => a.grounds.type === "otherProject");
const scoped = pick((a) => a.grounds.type === "outOfScope");

const allowanceRots: { name: string; allowance: ReferenceAllowance; expect: string }[] = [
  {
    name: "「過去の状態として書かれている」の目印が、そのファイルから消える",
    allowance: { ...historical, grounds: { type: "historical", marker: "この文はもうファイルに無い" } },
    expect: "根拠の目印が同じファイルに無い",
  },
  {
    name: "「過去の状態として書かれている」の目印が短すぎる",
    allowance: { ...historical, grounds: { type: "historical", marker: "以前は" } },
    expect: "根拠の指定が短すぎて何も pin していない",
  },
  {
    name: "生成物を作るスクリプトが改名される",
    allowance: { ...generated, grounds: { type: "generated", producedBy: "build:tex:fr" } },
    expect: "生成物を作るスクリプトが無い",
  },
  {
    name: "別プロジェクトのファイルが向こうで消える",
    allowance: { ...other, grounds: { type: "otherProject", project: "integrable-lattice" } },
    expect: "別プロジェクトにもそのファイルが無い",
  },
  {
    name: "「本当に腐っている」の記録が消える",
    allowance: {
      ...scoped,
      grounds: {
        type: "outOfScope",
        ownedBy: "だれか",
        recordedIn: { report: "outputs/reports/cycle25_ops_guard_missing_proof_and_rotten_refs.md", marker: "この見出しは report に無い" },
      },
    },
    expect: "記録が見つからない",
  },
  {
    name: "免除が指す参照が、そのファイルからもう消えている",
    allowance: { ...historical, reference: "tools/this-was-never-written.ts" },
    expect: "宣言が余っている（その参照がもう書かれていない）",
  },
  {
    name: "免除が指す参照が実在するようになった",
    allowance: { ...historical, file: "structured-latex/tools/build-latex.ts", reference: "tools/editions.ts" },
    expect: "宣言が余っている（その参照が解決するようになった）",
  },
  {
    name: "免除が指すファイルそのものが消える",
    allowance: { ...historical, file: "structured-latex/tools/gone.ts" },
    expect: "宣言が指すファイルが読めない",
  },
];

const allowanceBaseline = await checkAllowances(REFERENCE_ALLOWANCES);
for (const rot of allowanceRots) {
  const found = await checkAllowances([rot.allowance]);
  const hit = found.find((f) => f.kind === rot.expect);
  report(
    rot.name,
    hit !== undefined && allowanceBaseline.length === 0,
    hit === undefined
      ? `期待した「${rot.expect}」が出なかった。出たのは: ${found.map((f) => f.kind).join(", ") || "（無し）"}`
      : allowanceBaseline.length === 0
        ? `「${hit.kind}」で挙げた`
        : `腐らせる前から免除に違反がある（偽陽性）: ${allowanceBaseline.map((f) => f.kind).join(", ")}`,
  );
}

console.log(`\n${checks - failures} / ${checks} 件で検出を実証した（検査 C ${13} 件 + 検査 R ${11} 件）。`);
if (failures > 0) process.exit(1);

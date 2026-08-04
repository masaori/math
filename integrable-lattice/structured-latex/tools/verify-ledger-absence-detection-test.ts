#!/usr/bin/env node
/**
 * **台帳の「無い」の根拠の検査が、実際に赤くなることを合成データで確かめる。**
 *
 * 検出できることと誤検出しないことは別なので、両方を持つ。
 * 中心は 1 件——**根拠を書かずに不在を主張したら赤くなること**である。
 * 残りは、その周りで静かに通ってしまう道（文書への指し示しだけ／実測値が欠ける／
 * ログが消えている／ログがどの mathlib を見たか書いていない）と、
 * 実データに現に在る誤検出の形（撤回された引用・数学の非存在定理）を押さえる。
 *
 * 本体は `npm run test:formalization`（検査 F の自己検査）から呼ばれる。段は増やしていない。
 * 単体で走らせるなら `node tools/verify-ledger-absence-detection-test.ts`。
 */

import { auditLedgerAbsence, type AbsenceAuditInput } from "./ledger-absence-model.ts";

const CURRENT = "520045ab14e26149ee970e2e617ca04b09bde5d6";
const OLD = "0123456789abcdef0123456789abcdef01234567";
const EXISTING_LOG = "lean/logs/mathlib-gap-survey-fixture.log";
const MISSING_LOG = "lean/logs/mathlib-gap-survey-removed.log";

/** 既定の環境: 固定のログ 1 本だけが実在し、現在のコミットを記録している。 */
const base = (text: string, overrides: Partial<AbsenceAuditInput> = {}): AbsenceAuditInput => ({
  entries: [{ block: "fixture_block", text }],
  logExists: (path) => path === EXISTING_LOG,
  logCommit: () => CURRENT,
  currentMathlibCommit: CURRENT,
  ...overrides,
});

type Case = {
  readonly name: string;
  readonly input: AbsenceAuditInput;
  /** 違反に含まれていてほしい字面（`undefined` なら違反 0 件を期待する）。 */
  readonly expect?: string;
  /** 追加で確かめること（違反の有無では表せないもの）。 */
  readonly also?: (audit: ReturnType<typeof auditLedgerAbsence>) => string | undefined;
};

export const LEDGER_ABSENCE_CASES: readonly Case[] = [
  {
    name: "根拠を書かずに不在を主張している（この検査の主題）",
    input: base("この段に要る素材は mathlib に無い。自前で書くことになる。"),
    expect: "[不在の主張に根拠が無い]",
  },
  {
    name: "根拠が文書への指し示しだけ（現に台帳が取っていた形）",
    input: base("matrix-tree 定理が mathlib に無い（`kirchhoff` 0 件。lean/README.md の欠落調査）。"),
    expect: "[不在の主張に根拠が無い]",
  },
  {
    name: "走査結果の 0 件だけを書いて、いつ何を見たかを書いていない",
    input: base("`CuocoMonsky` は 3 段すべて 0 件だった。"),
    expect: "[不在の主張に根拠が無い]",
  },
  {
    name: "実在確認ログのパスがある（通る）",
    input: base(`素材が無い（実測、${EXISTING_LOG}）。`),
  },
  {
    name: "走査の実測値が 3 つ揃っている（通る）",
    input: base("素材が無い（2026-08-04 実測。mathlib `520045ab14` の 8264 ファイルを 3 段で引いた）。"),
  },
  {
    name: "実測値が 2 つしかない（走査ファイル数が無い）",
    input: base("素材が無い（2026-08-04 実測。mathlib `520045ab14` を 3 段で引いた）。"),
    expect: "走査ファイル数",
  },
  {
    name: "根拠に挙げたログが実在しない",
    input: base(`素材が無い（${MISSING_LOG}）。`),
    expect: "[根拠のログが実在しない]",
  },
  {
    name: "ログがどの mathlib を見たかを記録していない",
    input: base(`素材が無い（${EXISTING_LOG}）。`, { logCommit: () => undefined }),
    expect: "[根拠のログが mathlib のコミットを記録していない]",
  },
  {
    name: "ログが古い mathlib のもの（違反にはしないが古いと数える）",
    input: base(`素材が無い（${EXISTING_LOG}）。`, { logCommit: () => OLD }),
    also: (audit) => {
      const stale = audit.logs.filter((log) => log.stale).length;
      return stale === 1 ? undefined : `古いログが ${stale} 件（1 件を期待）`;
    },
  },
  {
    name: "現在の mathlib のコミットが読めない",
    input: base(`素材が無い（${EXISTING_LOG}）。`, { currentMathlibCommit: undefined }),
    expect: "[現在の mathlib のコミットが読めない]",
  },
  {
    name: "過去の判定を引用して否定している（誤検出しない）",
    input: base("**step 1 の仕分けが「素材が無い」と判定したのは誤りだった。** 適合基底の係数で書ける。"),
    also: (audit) => (audit.entries[0]!.retracted === 1 ? undefined : "撤回として除いた数が 1 件でない"),
  },
  {
    name: "数学の非存在定理は不在の主張ではない（誤検出しない）",
    input: base("閉形式が存在しないことの主張そのものを形式化した。"),
  },
  {
    name: "平仮名の「ない」は拾わない（誤検出しない）",
    input: base("反復多項式環の型は要らなかった。等号は一般に偽なので形式化対象ではない。"),
  },
  {
    name: "不在の主張が 1 つも無いエントリには根拠を要求しない",
    input: base("命題 A (1)(2)(3)。(4) は計算可能性の主張であって命題ではないので対象外。"),
  },
];

/** 期待どおりでなかった件数を返す。 */
export const runLedgerAbsenceCases = (): number => {
  console.log("");
  console.log("台帳の「無い」の根拠の検出テスト（根拠を書かずに不在を主張したら赤くなるか）");
  let failed = 0;
  for (const item of LEDGER_ABSENCE_CASES) {
    const audit = auditLedgerAbsence(item.input);
    const { violations } = audit;
    const extra = item.also?.(audit);
    if (extra !== undefined) {
      failed += 1;
      console.log(`  NG（追加の確認が合わない）: ${item.name} — ${extra}`);
      continue;
    }
    if (item.expect === undefined) {
      if (violations.length === 0) {
        console.log(`  OK（誤検出なし）: ${item.name}`);
      } else {
        failed += 1;
        console.log(`  NG（誤検出）: ${item.name} — ${violations.join(" / ")}`);
      }
      continue;
    }
    if (violations.some((violation) => violation.includes(item.expect!))) {
      console.log(`  OK（検出）: ${item.name}`);
    } else {
      failed += 1;
      console.log(`  NG（検出されなかった）: ${item.name} — 期待した字面「${item.expect}」`);
      for (const violation of violations) console.log(`      出た違反: ${violation}`);
    }
  }
  return failed;
};

if (process.argv[1] !== undefined && process.argv[1].endsWith("verify-ledger-absence-detection-test.ts")) {
  const failed = runLedgerAbsenceCases();
  console.log("");
  if (failed > 0) {
    console.log(`NG: ${failed} 件が期待どおりでない。`);
    process.exit(1);
  }
  console.log(`OK: ${LEDGER_ABSENCE_CASES.length} 件すべて期待どおり。`);
}

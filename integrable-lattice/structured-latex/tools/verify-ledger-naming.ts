/**
 * **散文の名指しと残りの勘定の突き合わせの検査**（cycle 45 step 1 で新設。検査 J）。
 *
 * 台帳と判定は `ledger-naming-model.ts`。ここは検査 F の台帳を読んで当てるだけである。
 */
import { FORMALIZATION_COVERAGE } from "./formalization-coverage.ts";
import { NAMING_DISPOSITIONS, auditNamingCoverage } from "./ledger-naming-model.ts";

const entries = FORMALIZATION_COVERAGE.flatMap((e) => {
  // **完了の欄の散文も読む**（cycle 46 step 1）。
  // cycle 45 の形は 部分的 と 未着手 しか読んでいなかったので、
  // **欄が完了になった瞬間に、その散文が名指ししている事柄が検査の外へ出ていた。**
  // 完了の欄には残り項目が無いので、名指しの文はすべて処分の宣言を要求されることになる。
  const prose =
    e.state === "部分的" ? e.remaining : e.state === "未着手" ? e.reason : e.note;
  if (prose === undefined) return [];
  const remainingItems = e.state === "部分的" ? e.remainingItems : undefined;
  const openParts =
    e.state === "部分的"
      ? (e.partStates ?? []).filter((p) => p.state !== "済み").map((p) => p.part)
      : undefined;
  return [{ block: e.block, prose, remainingItems, openParts }];
});

const result = auditNamingCoverage({ entries, dispositions: NAMING_DISPOSITIONS });

console.log("");
console.log("散文の名指しと残りの勘定の突き合わせ（cycle 45 step 1 で追加。検査 J）");
console.log(
  `  散文を持つ欄 ${entries.length} 件 / **未形式化を名指している文 ${result.named} 件** / ` +
    `残り項目・残っている部に当たる ${result.autoCovered} 件 / ` +
    `処分を宣言しているもの ${result.dispositioned} 件` +
    `（残り ${result.byKind["残り"]} / 済み ${result.byKind["済み"]} / 対象外 ${result.byKind["対象外"]}）/ ` +
    `違反 ${result.violations.length} 件`,
);
console.log(
  "  **なぜこれを測るか**: 検査 F が見ているのは「残り項目が散文に在ること」だけで、" +
    "**その逆向き——散文が未形式化と言っている事柄が残り項目に在ること——は誰も見ていなかった。** " +
    "cycle 44 step 1 で、cycle 29 以来名指しされていた事柄が 1 度も数えられていなかったことが分かったので、" +
    "逆向きを機械で見る。**測るだけで終わらせず検査にした。**",
);
console.log(
  "  限界: **目印の語に当たらない言い方で名指されたら拾えない**（語の一覧は実測で作ったものである）。" +
    "**処分の判断は人の読みである**——機械が見るのは、判断が書かれていることと、" +
    "書かれた判断が腐っていないことだけで、`済み` と書いたものが本当に済んでいるかは見ていない。",
);

if (result.violations.length > 0) {
  console.log("");
  console.log(`違反 ${result.violations.length} 件`);
  for (const violation of result.violations) console.log(`    ${violation}`);
  console.error(`違反 ${result.violations.length} 件。`);
  process.exit(1);
}
console.log("");
console.log("違反 0 件。");

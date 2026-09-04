/**
 * 各節が宣言する「入力・出力・主定理」が、節の中身に裏付けられているかを検査する。
 *
 * `content-modules.ts` は主定理ラベルが節の中に在ることだけを見ており、それが**主張なのか**、
 * **その節の中身から導かれているのか**は一度も見ていない。したがって定義や注記を主定理として
 * 宣言しても、節内の何にも依存しない主張を主定理として宣言しても、検査は通ってしまう。
 * 「節の設計と入力・出力・主定理の明示」は成果整理の一層そのものなので、宣言が空文になる形を止める。
 *
 * 検査する性質は次の四つである。
 *   - 節が入力・出力・主定理の文を空でない形で持つ。
 *   - 節が主定理ラベルを一つ以上持つ。
 *   - 主定理ラベルの所有ブロックが主張（claim / theorem）である。
 *   - 主定理ラベルの所有ブロックが、同じ節の中の別ブロックへ少なくとも一つ依存する。
 *     節の中身が主定理を支えていることを、参照依存の一次情報で要求する。
 */
import { collectRefTargets, isGeneratedOrganizationBlock, loadContentFiles } from "./content-modules.ts";
import { documentOrganization } from "./document-organization.ts";

/** 主定理として宣言してよいブロック種別。定義・注記は主張ではないので含めない。 */
const STATEMENT_KINDS = new Set(["claim", "theorem"]);

const files = await loadContentFiles();

const labelOwner = new Map<string, string>();
for (const file of files) {
  for (const block of file.blocks) {
    if (block.kind === "heading") continue;
    for (const label of block.labels) labelOwner.set(label, block.id);
  }
}

const violations: string[] = [];
let checkedSections = 0;
let checkedMainLabels = 0;

for (const chapter of documentOrganization) {
  for (const section of chapter.sections) {
    checkedSections += 1;
    const where = `${chapter.id}/${section.id}`;
    for (const [name, text] of [
      ["入力", section.input],
      ["出力", section.output],
      ["主定理", section.main],
    ] as const) {
      if (text.trim().length === 0) violations.push(`節の${name}の文が空: ${where}`);
    }
    // mainLabels は as const で長さが literal 型になるため、比較が never へ潰れないよう広げてから見る。
    const mainLabels: readonly string[] = section.mainLabels;
    if (mainLabels.length === 0) {
      violations.push(`節が主定理ラベルを一つも宣言していない: ${where}`);
      continue;
    }

    const file = files.find((candidate) => candidate.file === `organization/${chapter.id}/${section.id}`);
    if (file === undefined) {
      violations.push(`節に対応する出版ファイルが無い: ${where}`);
      continue;
    }
    const sectionBlocks = file.blocks.filter(
      (block) => block.kind !== "heading" && !isGeneratedOrganizationBlock(block.id),
    );
    const sectionIds = new Set(sectionBlocks.map((block) => block.id));
    const byId = new Map(sectionBlocks.map((block) => [block.id, block]));

    for (const mainLabel of mainLabels) {
      checkedMainLabels += 1;
      const ownerId = labelOwner.get(mainLabel);
      // 節内に在ることは content-modules.ts が既に落とすが、ここでも防御的に確認する。
      const block = ownerId === undefined ? undefined : byId.get(ownerId);
      if (block === undefined) {
        violations.push(`主定理ラベルの所有ブロックが節内に無い: ${where} -> ${mainLabel}`);
        continue;
      }
      if (!STATEMENT_KINDS.has(block.kind)) {
        violations.push(
          `主定理として主張でないブロックを宣言している: ${where} -> ${mainLabel}（${block.kind}: ${block.id}）`,
        );
      }
      const targets = new Set<string>();
      collectRefTargets(block, targets);
      const intraSection = [...targets]
        .map((label) => labelOwner.get(label))
        .filter((owner) => owner !== undefined && owner !== block.id && sectionIds.has(owner));
      if (intraSection.length === 0) {
        violations.push(
          `主定理が同じ節の中の何にも依存していない: ${where} -> ${mainLabel}（${block.id}）`,
        );
      }
    }
  }
}

if (violations.length > 0) {
  console.error("節の入力・出力・主定理の宣言に違反がある:");
  for (const line of violations) console.error(`  ${line}`);
  process.exit(1);
}
console.log(
  `節の入力・出力・主定理の検査 OK（節 ${checkedSections} 件、主定理ラベル ${checkedMainLabels} 件、` +
    "空の宣言 0 件、主張でない主定理 0 件、節内依存を持たない主定理 0 件）",
);

/**
 * 各節が「依存上のまとまり」になっているかを、節内の参照依存グラフから検査する。
 *
 * `verify-section-main-statements.ts` は、宣言された主定理が主張であり節内の何かへ依存することまでを見る。
 * しかしそれは**節の一部**が主定理を支えていることしか言わない。節が独立した結果の束になっていても通る。
 * 成果整理の層「節の設計と入力・出力・主定理の明示」は、節を依存上のまとまりから設計することを要求するので、
 * ここでは節の中身の側から見る。
 *
 * 検査する性質は次の一つである。
 *   - 節内の参照依存グラフ（向きを落とした連結成分）のうち、主張（claim / theorem）を含む成分は、
 *     その節が宣言する主定理ラベルの所有ブロックを少なくとも一つ含む。
 *
 * 定義・注記だけからなる成分は補助項目として許す（主張でないものを主定理に宣言することは
 * `verify-section-main-statements.ts` が禁じており、両者を同時に満たす形が存在しないため）。
 *
 * 未解消の成分は下の台帳へ member id ごと固定する。台帳は成果整理の残作業そのものであり、
 * 新しい違反は一件でも失敗する（いま在る形をそのまま残すことだけを許す）。
 */
import { collectRefTargets, loadContentFiles } from "./content-modules.ts";
import { documentOrganization } from "./document-organization.ts";

const STATEMENT_KINDS = new Set(["claim", "theorem"]);

/**
 * 主張を含むのに主定理を宣言していない既知の成分。キーは「節 id ＋ タブ ＋ 成分の member id を
 * 昇順で改行連結したもの」。成分の中身が一つでも変われば鍵が外れて失敗する。
 */
const KNOWN_UNDECLARED_COMPONENTS: readonly string[] = [
  "local_representation_and_composition\tlocality_restricts_cycle_type_claim_stage_global_maps_count",
  "conjugacy_and_locality_classification\tconjugacy_class_code_image_bijection_claim_binary_ca_specialization\nglobal_map_iteration_claim_binary_ca_specialization\niterate_monoid_conjugacy_numerical_profile_counterexample_ca_specialization\nreversible_global_map_cycle_type_claim_binary_ca_partition_realization",
  "conjugacy_and_locality_classification\tself_neighborhood_reversible_map_group_claim_binary_bijection\nself_neighborhood_reversible_map_group_claim_classification\nself_neighborhood_reversible_map_group_claim_composition\nself_neighborhood_reversible_map_group_claim_cycle_type\nself_neighborhood_reversible_map_group_claim_group\nself_neighborhood_reversible_map_group_claim_pointwise_form\nself_neighborhood_reversible_map_group_claim_reversible_pointwise_bijective\nself_neighborhood_reversible_map_group_definition_stage",
];

const files = await loadContentFiles();

const labelOwner = new Map<string, string>();
for (const file of files) {
  for (const block of file.blocks) {
    if (block.kind === "heading") continue;
    for (const label of block.labels) labelOwner.set(label, block.id);
  }
}

const violations: string[] = [];
const seenKnown = new Set<string>();
let checkedSections = 0;
let checkedComponents = 0;

for (const chapter of documentOrganization) {
  for (const section of chapter.sections) {
    checkedSections += 1;
    const where = `${chapter.id}/${section.id}`;
    const file = files.find((candidate) => candidate.file === `organization/${chapter.id}/${section.id}`);
    if (file === undefined) {
      violations.push(`節に対応する出版ファイルが無い: ${where}`);
      continue;
    }
    const blocks = file.blocks.filter(
      (block) => block.kind !== "heading" && !block.id.startsWith("organization_"),
    );
    const byId = new Map(blocks.map((block) => [block.id, block]));
    const neighbors = new Map<string, Set<string>>();
    for (const block of blocks) neighbors.set(block.id, new Set<string>());
    for (const block of blocks) {
      const targets = new Set<string>();
      collectRefTargets(block, targets);
      for (const label of targets) {
        const owner = labelOwner.get(label);
        if (owner === undefined || owner === block.id || !byId.has(owner)) continue;
        neighbors.get(block.id)!.add(owner);
        neighbors.get(owner)!.add(block.id);
      }
    }

    const mainOwners = new Set(
      (section.mainLabels as readonly string[])
        .map((label) => labelOwner.get(label))
        .filter((owner): owner is string => owner !== undefined && byId.has(owner)),
    );

    const visited = new Set<string>();
    for (const block of blocks) {
      if (visited.has(block.id)) continue;
      const members: string[] = [];
      const stack = [block.id];
      visited.add(block.id);
      while (stack.length > 0) {
        const current = stack.pop()!;
        members.push(current);
        for (const next of neighbors.get(current)!) {
          if (visited.has(next)) continue;
          visited.add(next);
          stack.push(next);
        }
      }
      checkedComponents += 1;
      const hasStatement = members.some((id) => STATEMENT_KINDS.has(byId.get(id)!.kind));
      if (!hasStatement) continue;
      if (members.some((id) => mainOwners.has(id))) continue;
      const key = `${section.id}\t${[...members].sort().join("\n")}`;
      if (KNOWN_UNDECLARED_COMPONENTS.includes(key)) {
        seenKnown.add(key);
        continue;
      }
      violations.push(
        `主張を含む依存成分が節の主定理を含まない: ${where}（${members.length} 件: ${[...members].sort().join(", ")}）`,
      );
    }
  }
}

for (const key of KNOWN_UNDECLARED_COMPONENTS) {
  if (!seenKnown.has(key)) {
    violations.push(`台帳に残骸がある（成分が消えたか形が変わった）: ${key.split("\t")[0]}`);
  }
}

if (violations.length > 0) {
  console.error("節の依存成分と主定理の対応に違反がある:");
  for (const line of violations) console.error(`  ${line}`);
  process.exit(1);
}
console.log(
  `節の依存成分の検査 OK（節 ${checkedSections} 件、依存成分 ${checkedComponents} 件、` +
    `新規の未宣言成分 0 件、台帳に残る未解消成分 ${KNOWN_UNDECLARED_COMPONENTS.length} 件）`,
);

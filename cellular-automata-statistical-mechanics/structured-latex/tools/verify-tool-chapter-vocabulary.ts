/**
 * 「数学的道具立て」章に 2 値セルオートマトン固有の語が混入していないかを字句で検査する。
 *
 * content-modules.ts の検査は参照依存だけを見るため、CA 固有の語を直接書いたブロックが
 * 数学的道具側に置かれていても通ってしまう。分類境界のレビューを人手の一巡で終わらせず、
 * 以後の追加でも自動的に効かせるためにここで語彙側から検査する。
 *
 * 除外語は「CA を仮定せずに定義済みである語」に限る。増やすときは、その語が
 * 有限集合・写像・関係だけで定義されていることを本文で確認してから足すこと。
 */
import { collectRefTargets, loadContentFiles } from "./content-modules.ts";

const CA_TERMS = [
  "セルオートマトン",
  "セル",
  "局所規則",
  "局所表現",
  "真理値表",
  "大域写像",
  "時間発展",
  "時刻",
  "配位",
  "一点反転",
  "伝播",
  "イベント",
  "状態集合",
  "2 値",
  "二値",
];

/** CA を仮定せずに定義された語。字句検査の前に取り除く。 */
const NEUTRAL_PHRASES = [
  "近傍割り当て", // 有限集合上の集合値写像として定義しており、CA の近傍を仮定しない
  "周期の伝播", // 有限自己写像の周期が反復で保たれることを指し、空間的伝播ではない
];


/**
 * 識別子側の CA 由来語。block id と label は出版本文に出ないが、整理前のファイル名を
 * 引き継いでいるため「章の分類を id から読むと誤読する」状態が残っている。
 * 本文（散文・数式）の語彙検査とは独立の軸なので、ここで別に検査する。
 */
const CA_IDENTIFIER_TERMS = [
  "automaton",
  "cellular",
  "cell_",
  "_cell",
  "binary",
  "truth_table",
  "global_map",
  "configuration",
  "flip",
  "time_",
  "_time",
  "propagation",
  "event",
  "state_set",
  "local_",
];

/**
 * 上の語を含んだまま数学的道具立て章に残っている既知の識別子（2026-08-29 時点の 53 件）。
 * いずれも指している対象は有限集合・有限自己写像・有限関係だけで定義されており、
 * 本文の語彙検査（CA_TERMS）は 0 件で通っている。すなわち分類は正しく、名前だけが
 * 整理前の履歴を引きずっている。**新たな増加だけを失敗させる**のがこの表の目的である。
 *
 * キーは「所有ブロック id + タブ + `id:` または `label:` 付きの識別子」である。
 * 識別子だけをキーにすると、既知の label を数学的道具立て章の別のブロックへ移し替えても
 * 検査を通ってしまい、許可の粒度が実際の検査対象より粗くなる（block id 単位で許可していた
 * ときと同じ穴）。所有ブロックまで含めることで、許可はいま在る 1 個所だけに固定される。
 *
 * 減らす方向の改名は歓迎で、消えた分はこの表からも消すこと（未使用エントリも失敗させる）。
 */
const KNOWN_CA_IDENTIFIERS_IN_TOOL_CHAPTER = new Set([
  "neighborhood_assignment_intersection_minimal_counterexample_definition_two_cell_witnesses\tid:neighborhood_assignment_intersection_minimal_counterexample_definition_two_cell_witnesses",
  "neighborhood_assignment_intersection_minimal_counterexample_definition_two_cell_witnesses\tlabel:def_two_cell_intersection_nondistributivity_witnesses",
  "time_expansion_dependency_definition_finite_stage\tid:time_expansion_dependency_definition_finite_stage",
  "neighborhood_assignment_intersection_minimal_counterexample_claim_two_cell_failures\tid:neighborhood_assignment_intersection_minimal_counterexample_claim_two_cell_failures",
  "neighborhood_assignment_intersection_minimal_counterexample_claim_two_cell_failures\tlabel:claim_two_cell_composition_intersection_nondistributivity",
  "neighborhood_assignment_intersection_minimal_counterexample_theorem_minimal_size\tlabel:theorem_minimal_cell_count_for_composition_intersection_nondistributivity",
  "self_transpose_composition_closure_definition_two_cell_witness\tid:self_transpose_composition_closure_definition_two_cell_witness",
  "self_transpose_neighborhood_assignment_count_definition_unordered_cell_pairs\tid:self_transpose_neighborhood_assignment_count_definition_unordered_cell_pairs",
  "self_transpose_neighborhood_assignment_count_definition_unordered_cell_pairs\tlabel:def_unordered_cell_pairs",
  "self_transpose_neighborhood_assignment_count_claim_unordered_pair_count\tlabel:claim_unordered_cell_pair_count",
  "time_expansion_dependency_definition_time_interval\tid:time_expansion_dependency_definition_time_interval",
  "time_expansion_dependency_definition_time_interval\tlabel:def_time_interval",
  "global_map_iteration_definition_finite_self_map\tid:global_map_iteration_definition_finite_self_map",
  "global_map_iteration_definition_iterate\tid:global_map_iteration_definition_iterate",
  "global_map_iteration_definition_iterate\tlabel:def_global_map_iterate",
  "global_map_iteration_definition_orbit\tid:global_map_iteration_definition_orbit",
  "global_map_iteration_claim_orbit_finite\tid:global_map_iteration_claim_orbit_finite",
  "global_map_iteration_claim_orbit_collision\tid:global_map_iteration_claim_orbit_collision",
  "global_map_iteration_claim_shift_invariance\tid:global_map_iteration_claim_shift_invariance",
  "global_map_iteration_claim_eventual_periodicity\tid:global_map_iteration_claim_eventual_periodicity",
  "global_map_iteration_claim_eventual_periodicity\tlabel:claim_eventual_periodicity",
  "global_map_iteration_claim_collision_finite_decidability\tid:global_map_iteration_claim_collision_finite_decidability",
  "global_map_iteration_remark_not_claimed\tid:global_map_iteration_remark_not_claimed",
  "iterate_monoid_idempotents_claim_collision_period\tlabel:claim_iterate_collision_gives_eventual_period",
  "iterate_monoid_minimal_period_claim_propagation\tid:iterate_monoid_minimal_period_claim_propagation",
  "iterate_monoid_stable_fiber_dynamics_claim_commutation\tlabel:claim_iterate_monoid_cycle_idempotent_commutes_with_global_map",
  "iterate_monoid_stable_fiber_rooted_tree_claim_multiple_propagation\tid:iterate_monoid_stable_fiber_rooted_tree_claim_multiple_propagation",
  "iterate_monoid_stable_image_claim_restricted_bijection\tlabel:claim_iterate_monoid_global_map_bijective_on_stable_image",
  "reversibility_finite_decidability_definition_injective_surjective\tlabel:def_global_map_injective_surjective",
  "reversibility_finite_decidability_claim_injective_iff_surjective\tlabel:claim_global_map_injective_iff_surjective",
  "reversibility_finite_decidability_claim_injective_iff_all_periodic\tlabel:claim_global_map_injective_iff_all_periodic",
  "reversibility_finite_decidability_claim_finite_decidability\tlabel:claim_global_map_injectivity_finite_decidability",
  "conjugacy_class_code_image_bijection_definition_all_global_maps\tid:conjugacy_class_code_image_bijection_definition_all_global_maps",
  "conjugacy_class_code_image_bijection_definition_all_global_maps\tlabel:def_conjugacy_class_all_global_maps",
  "reversible_global_map_cycle_type_definition_reversible_maps\tid:reversible_global_map_cycle_type_definition_reversible_maps",
  "reversible_global_map_cycle_type_definition_reversible_maps\tlabel:def_reversible_global_maps",
  "reversible_global_map_cycle_type_claim_all_periodic\tid:reversible_global_map_cycle_type_claim_all_periodic",
  "reversible_global_map_cycle_type_claim_all_periodic\tlabel:claim_reversible_all_configurations_periodic",
  "reversible_global_map_cycle_type_claim_orbit_card\tid:reversible_global_map_cycle_type_claim_orbit_card",
  "reversible_global_map_cycle_type_definition_cycle_type\tid:reversible_global_map_cycle_type_definition_cycle_type",
  "reversible_global_map_cycle_type_claim_orbits_partition_configurations\tid:reversible_global_map_cycle_type_claim_orbits_partition_configurations",
  "reversible_global_map_cycle_type_claim_orbits_partition_configurations\tlabel:claim_reversible_orbits_partition_configurations",
  "reversible_global_map_cycle_type_claim_sum\tid:reversible_global_map_cycle_type_claim_sum",
  "reversible_global_map_cycle_type_claim_conjugacy_invariance\tid:reversible_global_map_cycle_type_claim_conjugacy_invariance",
  "reversible_global_map_cycle_type_claim_completeness\tid:reversible_global_map_cycle_type_claim_completeness",
  "reversible_global_map_cycle_type_definition_partitions\tid:reversible_global_map_cycle_type_definition_partitions",
  "reversible_global_map_cycle_type_definition_partitions\tlabel:def_configuration_count_partitions",
  "reversible_global_map_cycle_type_claim_partitions_finite\tid:reversible_global_map_cycle_type_claim_partitions_finite",
  "reversible_global_map_cycle_type_claim_partitions_finite\tlabel:claim_configuration_count_partitions_finite",
  "reversible_global_map_cycle_type_claim_partition_realization\tid:reversible_global_map_cycle_type_claim_partition_realization",
  "reversible_global_map_cycle_type_definition_conjugacy_classes\tid:reversible_global_map_cycle_type_definition_conjugacy_classes",
  "reversible_global_map_cycle_type_definition_conjugacy_classes\tlabel:def_reversible_global_map_conjugacy_classes",
  "reversible_global_map_cycle_type_claim_quotient_bijection\tid:reversible_global_map_cycle_type_claim_quotient_bijection",
]);

const TOOL_CHAPTER_PREFIX = "organization/mathematical_tools/";
const CA_CHAPTER_PREFIX = "organization/binary_cellular_automaton_semantics/";

function collectText(node: unknown, out: string[]): void {
  if (typeof node === "string") {
    out.push(node);
    return;
  }
  if (node === null || typeof node !== "object") return;
  if (Array.isArray(node)) {
    for (const item of node) collectText(item, out);
    return;
  }
  for (const value of Object.values(node as Record<string, unknown>)) collectText(value, out);
}

function caTermsIn(block: unknown): string[] {
  const parts: string[] = [];
  collectText(block, parts);
  let text = parts.join(" ");
  for (const phrase of NEUTRAL_PHRASES) text = text.split(phrase).join(" ");
  return CA_TERMS.filter((term) => text.includes(term));
}

const files = await loadContentFiles();

/** ラベル → 所有ブロック id。CA 章側の根拠を参照経由でも認めるために引く。 */
const labelOwner = new Map<string, string>();
for (const file of files) {
  for (const block of file.blocks) {
    if (block.kind === "heading") continue;
    for (const label of block.labels) labelOwner.set(label, block.id);
  }
}

const caBlockIds = new Set<string>();
for (const file of files) {
  if (!file.file.startsWith(CA_CHAPTER_PREFIX)) continue;
  for (const block of file.blocks) {
    if (block.kind === "heading" || block.id.startsWith("organization_")) continue;
    caBlockIds.add(block.id);
  }
}

const violations: string[] = [];
for (const file of files) {
  const inTools = file.file.startsWith(TOOL_CHAPTER_PREFIX);
  const inCa = file.file.startsWith(CA_CHAPTER_PREFIX);
  if (!inTools && !inCa) continue;
  for (const block of file.blocks) {
    if (block.kind === "heading" || block.id.startsWith("organization_")) continue;
    const hits = caTermsIn(block);
    if (inTools && hits.length > 0) {
      violations.push(`数学的道具立て章に CA 固有語がある: ${block.id}（${hits.join("、")}）`);
      continue;
    }
    if (!inCa || hits.length > 0) continue;
    // CA 章にあるのに CA 固有語を持たないなら、CA 章のブロックを参照していることを根拠に要求する。
    const targets = new Set<string>();
    collectRefTargets(block, targets);
    const grounded = [...targets].some((label) => {
      const owner = labelOwner.get(label);
      return owner !== undefined && caBlockIds.has(owner) && owner !== block.id;
    });
    if (!grounded) {
      violations.push(`CA 章にあるが CA 固有語も CA 章への参照も持たない: ${block.id}`);
    }
  }
}


/** 識別子側の検査。本文の語彙とは独立に、機械識別子へ CA 語が新たに入るのを止める。 */
const identifierViolations: string[] = [];
const usedKnownIdentifiers = new Set<string>();
for (const file of files) {
  if (!file.file.startsWith(TOOL_CHAPTER_PREFIX)) continue;
  for (const block of file.blocks) {
    if (block.kind === "heading" || block.id.startsWith("organization_")) continue;
    const identifiers = [
      { key: `id:${block.id}`, value: block.id },
      ...block.labels.map((label) => ({ key: `label:${label}`, value: label })),
    ].map((identifier) => ({ ...identifier, allowKey: `${block.id}\t${identifier.key}` }));
    for (const identifier of identifiers) {
      const hits = CA_IDENTIFIER_TERMS.filter((term) => identifier.value.includes(term));
      if (hits.length === 0) continue;
      if (KNOWN_CA_IDENTIFIERS_IN_TOOL_CHAPTER.has(identifier.allowKey)) {
        usedKnownIdentifiers.add(identifier.allowKey);
        continue;
      }
      identifierViolations.push(
        `数学的道具立て章の識別子に CA 由来語が新たに入った: ${identifier.key}` +
          `（所有ブロック ${block.id}、${hits.join("、")}）`,
      );
    }
  }
}
for (const known of KNOWN_CA_IDENTIFIERS_IN_TOOL_CHAPTER) {
  if (!usedKnownIdentifiers.has(known)) {
    const [owner, identifier] = known.split("\t");
    identifierViolations.push(
      `既知の識別子表に残骸がある（改名済みか、章または所有ブロックが変わった）: ${identifier}（所有ブロック ${owner}）`,
    );
  }
}
violations.push(...identifierViolations);

if (violations.length > 0) {
  console.error("章の意味境界に違反がある:");
  for (const line of violations) console.error(`  ${line}`);
  process.exit(1);
}
console.log(
  `章の意味境界の語彙検査 OK（本文の CA 固有語 ${CA_TERMS.length} 件、CA 章 ${caBlockIds.size} 件、` +
    `数学的道具立て章に残る CA 由来識別子 ${KNOWN_CA_IDENTIFIERS_IN_TOOL_CHAPTER.size} 件を固定）`,
);

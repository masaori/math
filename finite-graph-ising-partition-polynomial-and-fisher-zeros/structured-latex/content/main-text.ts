import {
  compileDocumentStructure,
  defineBlocks,
  defineDocumentStructure,
  defineSection,
  paragraph,
  type ProjectMeta,
} from "../schema.ts";

import {
  selectFiniteGraphBlockByLabel,
  type FiniteGraphBlockWithLabel,
  type FiniteGraphLabel,
} from "../source/elements.ts";

export {
  flatFiniteGraphTheory,
  hyperbolicFiniteGraphConnection,
  selectFiniteGraphBlockByLabel,
  selectFiniteGraphBlockByLabelAndId,
  selectFiniteGraphBlocksByLabel,
} from "../source/elements.ts";

type FocusMember<R extends "primary" | "supporting", L extends FiniteGraphLabel> = {
  readonly role: R;
  readonly element: {
    readonly kind: "elementGroup";
    readonly id: `${R}_${L}`;
    readonly focus: FiniteGraphBlockWithLabel<L>;
  };
};

const primary = <const L extends FiniteGraphLabel>(label: L): FocusMember<"primary", L> => {
  const focus = selectFiniteGraphBlockByLabel(label);
  return {
    role: "primary",
    element: { kind: "elementGroup", id: `primary_${label}`, focus },
  };
};

const supporting = <const L extends FiniteGraphLabel>(label: L): FocusMember<"supporting", L> => {
  const focus = selectFiniteGraphBlockByLabel(label);
  return {
    role: "supporting",
    element: { kind: "elementGroup", id: `supporting_${label}`, focus },
  };
};

const guideBlock = <const I extends string>(id: I, input: string, output: string) => ({
    id: `${id}_guide`,
    kind: "remark" as const,
    title: { text: "この節の入出力" },
    labels: [] as const,
    habitat: "none" as const,
    statement: [paragraph<FiniteGraphLabel>([`入力: ${input}。出力: ${output}。`])],
}) as const;

const sectionGuides = defineBlocks([
  guideBlock("finite_graph_input", "二つの辺端ラベルと有限な頂点集合・辺集合", "ループを持たず多重辺を許す有限グラフ"),
  guideBlock("even_edge_subsets", "有限グラフ、その辺部分集合、独立な不定元 u,v", "各頂点で偶次数となる辺部分集合とその二変数多項式"),
  guideBlock("spin_configurations", "有限グラフと二つの形式的スピンラベル", "スピン配位と一頂点反転"),
  guideBlock("partition_polynomial", "有限グラフ上のスピン配位と形式的不定元 x", "破れ辺数の多重度、分配多項式、その係数表示と偶数性"),
  guideBlock("minus_one", "Ising 分配多項式と頂点に接続する辺数の偶奇", "−1 における評価と一次因子による同値条件"),
  guideBlock("degree_and_cut", "破れ辺数と頂点二分割", "分配多項式の次数の組合せ論的意味"),
  guideBlock("fisher_zero_coefficients", "正の両端係数を持つ Ising 分配多項式", "零点族と逆数族の基本対称式および Newton 漸化式"),
  guideBlock("full_cut_characterization", "有限グラフと係数対称性または多項式逆数対称性", "全辺を横切る頂点二分割の二つの特徴付け"),
  guideBlock("full_cut_fisher_zeros", "全辺を横切る頂点二分割と Fisher 零点", "零点重複度の逆数対称性とその積・奇偶帰結"),
  guideBlock("shifted_fisher_zero_products", "一つまたは二つの代数的評価点と分配多項式", "零点差積の係数比、二評価点での商、有理評価点での特殊化"),
  guideBlock("shifted_fisher_zero_reciprocal_sums", "Fisher 零点でない代数的評価点と分配多項式の係数", "零点差の逆一・二・三乗和と係数表示"),
  guideBlock("positive_rational_order", "正の有理数と辺を持つ有限グラフの Ising 分配多項式", "厳密単調性、単射性、狭義・弱順序の反映"),
  guideBlock("positive_rational_configuration_count", "正の有理評価と全スピン配位数", "等号、厳密下側、厳密上側の評価点による特徴付け"),
  guideBlock("formal_high_temperature_expansion", "有限グラフ、独立な不定元 u,v、スピン配位、偶部分グラフ多項式", "整数係数二変数多項式としての有限和恒等式"),
]);

export const mathematicalToolkitChapter = defineSection({
  kind: "section",
  id: "mathematical_toolkit_heading",
  labels: [],
  title: { text: "数学的道具立て" },
  children: [
    {
      role: "subsection",
      element: {
        kind: "section",
        id: "finite_graph_input_heading",
        labels: [],
        title: { text: "有限グラフの入力" },
        children: [
          { role: "exposition", element: sectionGuides[0] },
          supporting("def_edge_endpoint_label_set"),
          primary("def_finite_graph_input"),
        ],
      },
    },
    {
      role: "subsection",
      element: {
        kind: "section",
        id: "even_edge_subsets_heading",
        labels: [],
        title: { text: "辺部分集合の偶奇と多項式" },
        children: [
          { role: "exposition", element: sectionGuides[1] },
          supporting("def_mod_two_boundary_parity"),
          primary("def_even_edge_subset"),
          primary("def_even_subgraph_polynomial"),
        ],
      },
    },
  ],
});

export const finiteGraphIsingSemanticsChapter = defineSection({
  kind: "section",
  id: "finite_graph_ising_semantics_heading",
  labels: [],
  title: { text: "有限グラフ上の Ising 模型・分配多項式と Fisher 零点" },
  children: [
    {
      role: "subsection",
      element: {
        kind: "section",
        id: "spin_configurations_heading",
        labels: [],
        title: { text: "スピンと配位" },
        children: [
          { role: "exposition", element: sectionGuides[2] },
          supporting("def_spin_label_set"), supporting("def_spin_integer_realization"),
          supporting("def_spin_label_reversal"), supporting("claim_spin_reversal_integer_realization"),
          primary("def_spin_configuration_set"), supporting("def_single_vertex_spin_flip"),
          primary("claim_single_vertex_spin_flip_involution"),
        ],
      },
    },
    {
      role: "subsection",
      element: {
        kind: "section",
        id: "partition_polynomial_heading",
        labels: [],
        title: { text: "破れ辺と Ising 分配多項式" },
        children: [
          { role: "exposition", element: sectionGuides[3] },
          supporting("def_broken_edge_set"), supporting("def_broken_edge_multiplicity"),
          primary("def_ising_partition_polynomial"), primary("claim_partition_polynomial_coefficient_expansion"),
          primary("theorem_partition_polynomial_coefficient_evenness"), supporting("claim_partition_polynomial_value_at_one"),
        ],
      },
    },
    {
      role: "subsection",
      element: {
        kind: "section",
        id: "minus_one_heading",
        labels: [],
        title: { text: "特別値 −1 と奇接続辺数" },
        children: [
          { role: "exposition", element: sectionGuides[4] },
          supporting("theorem_odd_incident_edge_count_root_minus_one"),
          supporting("theorem_even_incident_edge_counts_evaluation_minus_one"),
          primary("theorem_root_minus_one_characterizes_odd_incident_edge_count"),
          supporting("theorem_linear_factor_characterizes_odd_incident_edge_count"),
          supporting("theorem_even_linear_factor_characterizes_odd_incident_edge_count"),
        ],
      },
    },
    {
      role: "subsection",
      element: {
        kind: "section",
        id: "degree_and_cut_heading",
        labels: [],
        title: { text: "次数とカット" },
        children: [
          { role: "exposition", element: sectionGuides[5] },
          supporting("theorem_partition_polynomial_degree_maximum_broken_edge_count"),
          primary("theorem_partition_polynomial_degree_maximum_cut_size"),
        ],
      },
    },
    {
      role: "subsection",
      element: {
        kind: "section",
        id: "fisher_zero_coefficients_heading",
        labels: [],
        title: { text: "Fisher 零点の対称式と係数" },
        children: [
          { role: "exposition", element: sectionGuides[6] },
          supporting("theorem_fisher_zero_product_coefficient_ratio"), supporting("theorem_fisher_zeros_nonzero"),
          supporting("theorem_fisher_zero_reciprocal_sum_coefficient_ratio"), supporting("theorem_fisher_zero_sum_coefficient_ratio"),
          primary("theorem_fisher_zero_elementary_symmetric_coefficient_ratio"),
          primary("theorem_fisher_zero_power_sum_newton_recurrence"),
          supporting("theorem_fisher_zero_square_sum_coefficient_ratio"), supporting("theorem_fisher_zero_cube_sum_coefficient_ratio"),
          supporting("theorem_fisher_zero_fourth_power_sum_coefficient_ratio"),
          primary("theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio"),
          primary("theorem_reciprocal_fisher_zero_power_sum_newton_recurrence"),
          supporting("theorem_reciprocal_fisher_zero_square_sum_coefficient_ratio"),
          supporting("theorem_reciprocal_fisher_zero_cube_sum_coefficient_ratio"),
          supporting("theorem_reciprocal_fisher_zero_fourth_power_sum_coefficient_ratio"),
        ],
      },
    },
    {
      role: "subsection",
      element: {
        kind: "section",
        id: "full_cut_characterization_heading",
        labels: [],
        title: { text: "全辺を横切る二分割の特徴付け" },
        children: [
          { role: "exposition", element: sectionGuides[7] },
          supporting("theorem_full_cut_coefficient_symmetry"),
          primary("theorem_coefficient_symmetry_characterizes_full_cut"),
          supporting("theorem_full_cut_positive_rational_evaluation_reciprocity"),
          primary("theorem_partition_polynomial_reciprocity_characterizes_full_cut"),
        ],
      },
    },
    {
      role: "subsection",
      element: {
        kind: "section",
        id: "full_cut_fisher_zeros_heading",
        labels: [],
        title: { text: "全辺二分割と Fisher 零点の逆数対称性" },
        children: [
          { role: "exposition", element: sectionGuides[8] },
          primary("theorem_full_cut_fisher_zero_reciprocal_multiplicity"),
          supporting("theorem_full_cut_fisher_zero_product"), supporting("theorem_full_cut_fisher_zero_minus_one_multiplicity_parity"),
          supporting("theorem_full_cut_fisher_zero_product_away_from_minus_one"),
          supporting("theorem_full_cut_fisher_zero_support_parity_characterization"),
          supporting("theorem_full_cut_distinct_fisher_zero_product"),
          supporting("theorem_full_cut_distinct_fisher_zero_product_support_parity"),
        ],
      },
    },
    {
      role: "subsection",
      element: {
        kind: "section",
        id: "shifted_fisher_zero_products_heading",
        labels: [],
        title: { text: "評価点における Fisher 零点差積" },
        children: [
          { role: "exposition", element: sectionGuides[9] },
          supporting("theorem_fisher_zero_shifted_product_configuration_count"),
          primary("theorem_fisher_zero_algebraic_shifted_product_coefficient_ratio"),
          primary("theorem_fisher_zero_algebraic_shifted_product_evaluation_quotient"),
          supporting("theorem_fisher_zero_rational_shifted_product_coefficient_ratio"),
          supporting("theorem_no_positive_rational_root"),
          supporting("theorem_fisher_zero_positive_rational_shifted_product_coefficient_ratio"),
        ],
      },
    },
    {
      role: "subsection",
      element: {
        kind: "section",
        id: "shifted_fisher_zero_reciprocal_sums_heading",
        labels: [],
        title: { text: "評価点における Fisher 零点差の逆数冪和" },
        children: [
          { role: "exposition", element: sectionGuides[10] },
          primary("def_fisher_zero_algebraic_shifted_reciprocal_sum"),
          primary("theorem_fisher_zero_algebraic_shifted_reciprocal_sum_coefficient_ratio"),
          primary("theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio"),
          primary("theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio"),
        ],
      },
    },
    {
      role: "subsection",
      element: {
        kind: "section",
        id: "positive_rational_order_heading",
        labels: [],
        title: { text: "正の有理評価の単調性と順序反映" },
        children: [
          { role: "exposition", element: sectionGuides[11] },
          supporting("theorem_partition_polynomial_positive_rational_evaluation_monotonicity"),
          primary("theorem_partition_polynomial_positive_rational_evaluation_strict_monotonicity"),
          supporting("theorem_partition_polynomial_positive_rational_evaluation_injectivity"),
          supporting("theorem_partition_polynomial_positive_rational_evaluation_order_reflection"),
          supporting("theorem_partition_polynomial_positive_rational_evaluation_weak_order_reflection"),
        ],
      },
    },
    {
      role: "subsection",
      element: {
        kind: "section",
        id: "positive_rational_configuration_count_heading",
        labels: [],
        title: { text: "正の有理評価と全配位数の比較" },
        children: [
          { role: "exposition", element: sectionGuides[12] },
          supporting("theorem_partition_polynomial_positive_rational_evaluation_at_most_configuration_count"),
          supporting("theorem_partition_polynomial_positive_rational_evaluation_at_least_configuration_count"),
          primary("theorem_partition_polynomial_positive_rational_evaluation_equal_configuration_count"),
          primary("theorem_partition_polynomial_positive_rational_evaluation_strictly_below_configuration_count"),
          primary("theorem_partition_polynomial_positive_rational_evaluation_strictly_above_configuration_count"),
          supporting("theorem_no_linear_factor_x_minus_one"),
        ],
      },
    },
    {
      role: "subsection",
      element: {
        kind: "section",
        id: "formal_high_temperature_expansion_heading",
        labels: [],
        title: { text: "形式的高温展開" },
        children: [
          { role: "exposition", element: sectionGuides[13] },
          supporting("def_edge_spin_sign"), primary("def_formal_edge_weight_sum"),
          primary("theorem_formal_high_temperature_expansion"),
        ],
      },
    },
  ],
});

export const finiteGraphChapters = [mathematicalToolkitChapter, finiteGraphIsingSemanticsChapter] as const;
export const finiteGraphDocumentStructure = defineDocumentStructure({
  kind: "documentStructure",
  sections: finiteGraphChapters,
});

const compiled = compileDocumentStructure<FiniteGraphLabel, ProjectMeta>(finiteGraphDocumentStructure);
if (!compiled.success) throw new Error(`有限グラフ本文の正規構造をコンパイルできない: ${JSON.stringify(compiled.error)}`);

export const finiteGraphTheory = compiled.data.blocks;

export default finiteGraphChapters;

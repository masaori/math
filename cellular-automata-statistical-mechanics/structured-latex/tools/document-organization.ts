/**
 * 出版物の最終章立ての正本。
 *
 * content/ のファイル名と各ファイル先頭の旧見出しは、証明を追加してきた履歴を表すだけである。
 * 出版時には全本文ブロックをここでいったんフラットにし、二章へ分類してから依存順に並べ直す。
 */

export type OrganizationSection = {
  id: string;
  title: string;
  input: string;
  output: string;
  main: string;
  mainLabels: readonly string[];
};

export type OrganizationChapter = {
  id: string;
  title: string;
  sections: readonly OrganizationSection[];
};

export const documentOrganization = [
  {
    id: "mathematical_tools",
    title: "数学的道具立て",
    sections: [
      {
        id: "neighborhood_assignment_algebra",
        title: "近傍割り当ての合成・順序・束演算",
        input: "有限集合、有限集合上の二項関係、集合値写像を入力とする。",
        output: "合成モノイド、包含順序、点ごとの和と積、冪等元、可逆元、中心を有限決定可能な形で得る。",
        main: "主定理は、近傍割り当て全体が有限モノイドをなし、点ごとの包含と和を伴う有限順序代数になることである。",
        mainLabels: [
          "claim_finite_neighborhood_assignments_form_monoid",
          "claim_finite_neighborhood_assignments_form_ordered_monoid",
          "claim_finite_neighborhood_assignments_form_idempotent_semiring",
        ],
      },
      {
        id: "neighborhood_assignment_symmetry_and_action",
        title: "近傍割り当ての転置・対称性・部分集合への作用",
        input: "合成・和・積を備えた有限近傍割り当てを入力とする。",
        output: "転置対合、自己転置性、部分集合の合併作用とその像を有限表として得る。",
        main: "主定理は、近傍割り当てと合併保存写像が一対一に対応し、転置が合成順序を反転することである。",
        mainLabels: [
          "claim_union_preserving_map_representation_unique",
          "claim_neighborhood_assignment_transpose_reverses_composition",
        ],
      },
      {
        id: "reachability_and_finite_orders",
        title: "近傍割り当ての到達関係と有限半順序",
        input: "有限近傍割り当ての合成・和・転置と、有限集合上の部分順序を入力とする。",
        output: "反射推移閉包、相互到達成分、商半順序、有限半順序の実現と被覆関係による生成を得る。",
        main: "主定理は、相互到達成分の商が有限半順序をなし、逆に任意の有限半順序がこの商として実現できることである。",
        mainLabels: [
          "claim_neighborhood_mutual_reachability_component_order_is_partial_order",
          "claim_partial_order_quotient_realization_order",
        ],
      },
      {
        id: "finite_relation_reachability_and_transitive_closure",
        title: "有限関係の到達関係と推移閉包",
        input: "有限集合、その上の一段二項関係、自然数の有限初期区間を入力とする。",
        output: "有限長の道、到達関係、反射的到達関係と、到達関係が推移的かつ一段関係を最小に含むことを得る。",
        main: "主定理は、到達関係が一段関係の推移閉包であること、すなわち推移的であり、一段関係を含む推移的関係のうち最小であることである。",
        mainLabels: [
          "claim_reachability_transitive",
          "claim_reachability_minimal",
        ],
      },
      {
        id: "finite_poset_convex_subsets_and_antichains",
        title: "有限半順序の凸部分集合と反鎖",
        input: "有限集合上の部分順序を入力とする。",
        output: "順序凸部分集合、下方集合、上方集合、非比較関係、反鎖と、それらの凸性・有限性・交叉の閉性を得る。",
        main: "主定理は、下方集合・上方集合・反鎖がいずれも順序凸であり、順序凸部分集合の交叉が順序凸であることである。",
        mainLabels: [
          "claim_order_convex_intersection",
          "claim_antichain_order_convex",
          "claim_down_set_order_convex",
          "claim_up_set_order_convex",
        ],
      },
      {
        id: "finite_poset_interval_finiteness",
        title: "有限半順序の局所有限性",
        input: "有限集合と、その上の部分順序を入力とする。",
        output: "順序区間が有限であるという局所有限性を得る。",
        main: "主張は、有限集合上の任意の部分順序が局所有限であることである。",
        mainLabels: ["claim_finite_partial_order_locally_finite"],
      },
      {
        id: "finite_self_map_dynamics",
        title: "有限自己写像の軌道と安定構造",
        input: "有限集合と、その集合から自身への写像だけを入力とする。",
        output: "最終周期、反復モノイド、安定像・安定ファイバー・根付き木までの有限決定可能な構造を得る。",
        main: "主定理は、軌道が最終的に周期化し、反復モノイドが過渡部と有限巡回群へ分解されることである。",
        mainLabels: [
          "claim_finite_self_map_repeating_tail",
          "claim_iterate_monoid_transient_cycle_partition_cardinality",
          "claim_iterate_monoid_cycle_part_is_cyclic_of_order_min_period",
        ],
      },
      {
        id: "finite_self_map_conjugacy",
        title: "有限自己写像の共役分類",
        input: "有限自己写像の軌道・安定根付き木と、有限集合上の全単射を入力とする。",
        output: "共役不変量、再帰的前像木符号、置換の巡回型による完全分類を得る。",
        main: "主定理は、再帰的前像木符号が有限自己写像の共役を完全に分類し、可逆な場合は巡回型が完全不変量になることである。",
        mainLabels: [
          "claim_recursive_preimage_tree_code_complete_invariant",
          "claim_reversible_cycle_type_completeness",
        ],
      },
    ],
  },
  {
    id: "binary_cellular_automaton_semantics",
    title: "2 値セルオートマトンのセマンティクスを持つもの",
    sections: [
      {
        id: "binary_local_rules_and_essential_dependency",
        title: "2 元状態の局所規則と本質的依存",
        input: "構造を入れない 2 元状態集合と有限局所真理値表を入力とする。",
        output: "一点反転、本質的依存台、冗長近傍に依らない最小の依存情報を得る。",
        main: "主定理は、本質的依存が一点反転検査と同値であり、有限真理値表から決定できることである。",
        mainLabels: ["claim_flip_test_equivalence", "claim_support_finite_decidability"],
      },
      {
        id: "time_expansion_and_dependency_order",
        title: "時間展開・依存順序・有限伝播",
        input: "有限舞台上の 2 値局所規則と本質的依存台を入力とする。",
        output: "有限時間のイベント、一段依存、到達順序、有限伝播境界とその部分構造を得る。",
        main: "主定理は、一段依存の推移閉包が反対称になり、依存元が有限伝播球に収まることである。因果集合との比較では、得られた順序が局所有限である範囲と、時刻を保存しない順序同型までを明示する。",
        mainLabels: ["claim_reachability_partial_order", "claim_finite_propagation_boundary", "claim_event_order_locally_finite"],
      },
      {
        id: "finite_stage_global_maps",
        title: "有限舞台上の大域写像の列挙と可逆部分",
        input: "有限舞台と、各セルの有限局所真理値表を入力とする。",
        output: "局所規則族から得られる大域写像全体、その元数、可逆な大域写像全体を得る。",
        main: "主張は、局所規則族から大域写像への対応が単射であり、大域写像全体の元数が局所規則の個数の積になることである。",
        mainLabels: ["claim_stage_global_maps_count"],
      },
      {
        id: "local_representation_and_composition",
        title: "局所表現・逆写像・大域写像の合成",
        input: "本質的依存台、有限大域写像の可逆性、近傍割り当ての合成を入力とする。",
        output: "局所規則で表せる必要十分条件、逆写像の最小近傍、合成写像の依存上界と非閉性反例を得る。",
        main: "主定理は、局所表現可能性が依存台の包含と同値であり、大域写像の合成が合成近傍上で表せることである。",
        mainLabels: [
          "claim_representable_implies_support_subset",
          "claim_support_subset_implies_representable",
          "claim_global_map_composition_representable_on_composed_neighborhood",
        ],
      },
      {
        id: "full_neighborhood_realization",
        title: "全近傍 2 値セルオートマトンによる有限自己写像の実現",
        input: "有限舞台、2 値の状態集合、有限自己写像の共役分類と巡回型を入力とする。",
        output: "有限舞台上の 2 値セルオートマトンが定める有限自己写像と、各セルの近傍を舞台全体に取ったときに実現できる大域写像の範囲を得る。",
        main: "全近傍 2 値セルオートマトンの大域写像が配位空間上の全ての自己写像を実現することを土台にし、主張はその帰結として、配位空間の元数の任意の分割が可逆な大域写像の巡回型として実現すること、および同じ数値プロファイルをもつ非共役な二つの自己写像が三セルの 2 値セルオートマトンとして実現することである。",
        mainLabels: [
          "claim_binary_ca_reversible_cycle_type_realizes_every_partition",
          "claim_iterate_monoid_conjugacy_numerical_profile_counterexample_ca_specialization",
        ],
      },
      {
        id: "self_neighborhood_reversible_maps",
        title: "自己近傍舞台の可逆大域写像の分類と合成",
        input: "有限舞台、各セルが自分自身だけを見る近傍割り当て、2 元状態集合と有限局所真理値表を入力とする。",
        output: "大域写像の点ごとの表現、反転集合による可逆写像の分類、合成群と巡回型を得る。",
        main: "主定理は、可逆大域写像が反転集合と全単射に対応し、合成について舞台の冪集合と同じ元数の有限可換群をなし、恒等写像以外は固定点を持たない対合になることである。",
        mainLabels: [
          "claim_self_neighborhood_reversible_maps_classified_by_flip_sets",
          "claim_self_neighborhood_reversible_maps_finite_commutative_group",
          "claim_self_neighborhood_reversible_map_cycle_types_general",
        ],
      },
      {
        id: "conjugacy_and_locality_classification",
        title: "共役分類と局所性による制限",
        input: "有限自己写像の共役分類と、2 値 CA の局所表現を入力とする。",
        output: "CA 大域写像を有限自己写像論へ接続し、局所性が実現可能な巡回型へ課す制限を得る。",
        main: "主定理は、2 値 CA の局所性が有限置換として可能な巡回型を真に制限しうることである。",
        mainLabels: [
          "claim_locality_restricts_cycle_type",
        ],
      },
    ],
  },
] as const satisfies readonly OrganizationChapter[];

/**
 * verify-label-correspondence.ts の検査から外す本文のラベルと、その理由。
 *
 * 一覧に載せたラベルについても、検査は次を確かめる（一覧が古くなったら落ちる）。
 *   withoutDeclaration: ラベルが本文に在り、具体版のファイルのどれかの字面に現れ、具体版の docstring には現れないこと。
 *   withoutNecSuf:      ラベルが本文の主張か定理で、具体版の docstring に現れ、必要十分版の宣言も導出版の宣言も無いこと。
 */

export type Exception = { reason: string; labels: readonly string[] };

/** 具体版に宣言を置かない定義。既存の記号に名前を付けるだけか、各宣言の前提（引数）になる。 */
export const withoutDeclaration: readonly Exception[] = [
  {
    reason:
      "既存の宣言（D.space.Cl・D.space.basis・行列環・Φ・Ψ、ℂ の - と -1）に名前を付けるだけなので宣言を置かない" +
      "（Isomorphism/OddDimensional/OddExtension.lean の冒頭の対応表と「表し方」）",
    labels: [
      "def_setting_of_odd_dimensional_corollary",
      "def_additive_inverse_in_complex_numbers",
      "def_minus_one_in_complex_numbers",
    ],
  },
  {
    reason:
      "一般の偶数次元の非退化な二次空間 (Y, Q) は、各宣言の前提 QY・hdim・hQ（引数）になる" +
      "（Isomorphism/GeneralEvenDimensional/IsometryToSplitSpace.lean の冒頭の対応表）",
    labels: ["def_general_even_dimensional_nondegenerate_quadratic_space"],
  },
];

/** 必要十分版と導出版を置かない主張。具体版だけで、必要十分版はそれを引くか仮定に置く。 */
export const withoutNecSuf: readonly Exception[] = [
  {
    reason:
      "主張が ℂ を含まない（番号付け・部分集合・ℕ と ℤ の計算だけの主張）ので、必要十分版は具体版と同じ宣言を引く",
    labels: [
      "claim_numbering_of_initial_segment_from_zero",
      "claim_base_n_numbering_is_numbering_of_maps",
      "claim_binary_numbering_is_numbering_of_power_set",
      "claim_number_of_pairs_of_subsets_is_at_least_one",
      "claim_numbering_of_pairs_of_subsets_is_numbering",
      "claim_two_element_set_is_finite_set",
      "claim_membership_in_reversed_subset",
      "claim_reversal_of_subsets_is_involution",
      "claim_numbering_with_first_site_as_highest_digit_is_numbering_of_power_set",
      "claim_tuple_of_membership_indices_of_positions_of_two_is_original",
      "claim_ordered_sum_of_integers_splits_off_first_term",
      "claim_ordered_sum_of_integers_is_unchanged_by_shifting_index",
      "claim_ordered_sums_of_integers_with_equal_terms_are_equal",
      "claim_number_of_membership_tuple_of_reversed_subset_without_top_element",
      "claim_number_of_membership_tuple_of_reversed_subset_with_top_element",
      "claim_number_of_membership_tuple_after_numbering_with_first_site_as_highest_digit",
      "claim_number_of_tuple_with_first_site_as_highest_digit_is_bijection",
      "claim_count_below_index_after_adding_one_element",
      "claim_count_below_index_vanishes_without_smaller_elements",
    ],
  },
  {
    reason:
      "ℂ についての事実で、必要十分版では係数 K についての仮定（1 + 1 ≠ 0、i · i = -1）になるので、" +
      "必要十分版と導出版の宣言を置かない（Isomorphism/GeneralEvenDimensional/OrthogonalBasisFromNecSuf.lean・" +
      "OrthonormalBasisFromNecSuf.lean の冒頭）",
    labels: ["claim_one_plus_one_is_nonzero_in_complex_numbers", "claim_imaginary_unit_squares_to_minus_one"],
  },
];

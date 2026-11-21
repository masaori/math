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
      "def_clifford_algebra_of_split_space_in_odd_corollary",
      "def_basis_of_split_space_in_odd_corollary",
      "def_matrix_algebra_in_odd_corollary",
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
      "ℂ についての事実で、必要十分版では係数 K についての仮定（1 + 1 ≠ 0、i · i = -1）になるので、" +
      "必要十分版と導出版の宣言を置かない（Isomorphism/GeneralEvenDimensional/OrthogonalBasisFromNecSuf.lean・" +
      "OrthonormalBasisFromNecSuf.lean の冒頭）",
    labels: ["claim_one_plus_one_is_nonzero_in_complex_numbers", "claim_imaginary_unit_squares_to_minus_one"],
  },
];

# 章 010「偶セクターへの射影と転送行列」の形式化

対象: `structured-latex/content/010_transfer_matrix_bridge.ts`。

この章は、全スピン反転行列 `ε` の固有値 `+1` の固有空間 `𝓕^{(+)}` への射影子 `P^{(+)} = (I + ε)/2` と
その性質、`(V_1^{(+)})^{1/2}` と偶セクターの転送行列 `V^{(+)} = (V_1^{(+)})^{1/2}V_2(V_1^{(+)})^{1/2}` の定義、
`ε` と `P^{(+)}` が `V_1, V_2, V_1^{(+)}, (V_1^{(+)})^{1/2}` と可換であることを述べる。

**`(−)` セクターの退避（2026-09-26）**: 人手の本文は `(+)` セクターだけで述べる形になり、
`P^{(-)}`, `V_1^{(-)}` を使う主張（`sector_replacement_of_V1`, `sector_replacement_pow`,
`partition_function_sector_decomposition`。以前この章の結論だった
`Z = tr(P^{(+)}(V^{(+)})^{N_row}) + tr(P^{(-)}(V^{(-)})^{N_row})`）と 004 章の
`def_odd_eigenvectors_of_epsilon` / `odd_eigenspace_is_complex_subspace` は参照用ノート
`structured-latex/notes/minus_sector_not_adopted.ts` へ移った。対応する Lean
（`Part010/Claim011_SectorReplacement.lean`, `Part010/Claim012_SectorDecomposition.lean`,
`Part004/OddEigenvectors.lean`, `NecSuf/NegatedVectorsSubmodule.lean`）は形式化の記録として残し、
ビルドは通し続ける（下の表の「ノート」の行）。本文の主張の Lean はこれらに依存しない。
境界項の符号を引数に持つ一般形（`H1 M η`, `V1pm`, `V1pmHalf`, `epsProj M η` ほか）は補助として残し、
本文のラベルに対応する `(+)` の定義・主張はその特殊化と定義から一致する。

`V_1, V_2` は 001 章 `def_transfer_matrix` の成分定義（`Ising2D.V1`, `Ising2D.V2`、
`Part001/DefinitionTransferMatrix.lean`）ただ 1 つであり、そのパウリ行列表示は 004 章の主張
（`first_transfer_matrix_pauli_form` / `second_transfer_matrix_pauli_form`）である。
以前この章にあった成分定義とパウリ表示の突き合わせ（旧 `V1_component_equals_pauli` /
`V2_component_equals_pauli`）、その前提（`def_config_basis_iso`, `sigma_z_diagonal_action`,
`exp_of_diagonal_matrix`, `two_by_two_transfer_identity`）、分配関数の定義と表式は、人手の本文に
合わせて `Part001/`・`Part004/` へ移した。一覧は `lean/README.md` の
「転送行列 `V_1, V_2` の唯一の定義とパウリ行列表示（章 001・004）」節にある。

---

## 1. 形式化した定理の一覧

| Lean の名前 | 内容 | 人手証明のラベル |
| --- | --- | --- |
| `Ising2D.evenEigenvectors` | **`M≥1` で `𝓕⁽⁺⁾={f∈ℂ^{2^M} \mid εf=f}`** を具体的な行列の数ベクトル作用で定める集合 | `def_even_eigenvectors_of_epsilon` |
| `Ising2D.evenEigenspace` / `evenEigenspace_carrier` | `𝓕^{(+)}` を台集合とする `ℂ`-部分線型空間 | `even_eigenspace_is_complex_subspace` / `def_eigenspaces_of_epsilon` |
| `Ising2D.Y_mul_Z_next_mulVec_mem_sector` / `V1JordanWigner_generator_mulVec_mem_sector` / `V1fixed_generator_mulVec_mem_sector` | **`W` と二つの生成子が固有空間を保つこと**（固有値 `η` の一般形） | `V1_restriction_to_eigenspaces` Step 3 |
| `Ising2D.H1JordanWigner_mulVec_eq_H1` / `V1_generators_mulVec_eq` | **`ηsign=-η` のときの固有ベクトル上の生成子一致**（一般形） | 同 Step 4 |
| `Ising2D.V1_generators_pow_mulVec_eq` / `V1_generator_partialSums_mulVec_eq` / `V1_mulVec_eq_V1pm` | **ベクトル作用の冪を直接帰納し、有限部分和と指数級数の極限を一致させる**（`M>=2`、一般形） | 同 Step 5, 6 |
| `Ising2D.V1_restriction_to_eigenspaces` | **`f ∈ 𝓕^{(+)}` なら `V_1 f = V_1^{(+)} f`**（一般形の `η = 1`。`Part004/ClaimV1RestrictionToEigenspaces.lean`） | `V1_restriction_to_eigenspaces` |
| `Ising2D.instInvertibleTwoTensorPow` | `Mat(2^M,ℂ)` で `2` が可逆 | `def_epsilon_projectors`（`/2` の意味づけ） |
| `Ising2D.epsProjPlus` / `epsProjPlus_eq_epsProj` | **`P^{(+)} = (I + ε)/2`**（一般形 `epsProj M η` の `η = 1`） | `def_epsilon_projectors` |
| `Ising2D.epsilon_sq` | `ε² = I` | `epsilon_square_and_eigenvalues` |
| `Ising2D.epsProjPlus_sq` | `(P^{(+)})² = P^{(+)}` | `epsilon_projector_properties` (1) |
| `Ising2D.epsProjPlus_mulVec_mem` / `epsProjPlus_mulVec_eq_self` / `epsilon_projector_properties_image` | `im P^{(+)} = 𝓕^{(+)}`（2 つの包含と集合の等式） | 同 (2) |
| `Ising2D.V1plusHalf` / `V1plusHalfUnits` | `(V_1^{(+)})^{1/2} := exp((i/2)K_1H_1^{(+)})`（`Part010/DefinitionV1PlusSquareRoot.lean`） | `def_V1_plus_square_root` |
| `Ising2D.V1_plus_square_root_property` | `((V_1^{(+)})^{1/2})^2 = V_1^{(+)}` | `V1_plus_square_root_property` |
| `Ising2D.VPlusOfTransfer` | `V^{(+)} := (V_1^{(+)})^{1/2}V_2(V_1^{(+)})^{1/2}`（`V_2` は `def_transfer_matrix` の `V_2`） | `def_V_plus` |
| `Ising2D.epsilon_eq_siteProd` | `ε = σ^x ⊠ ⋯ ⊠ σ^x` | `epsilon_commutes_with_transfer_matrices` Step 1 |
| `Ising2D.epsilon_commute_sigmaX` | `ε σ^x_k = σ^x_k ε` | 同 Step 1 |
| `Ising2D.epsilon_anticomm_sigmaZ` / `..._sigmaY` | `ε σ^{z,y}_k = -σ^{z,y}_k ε` | 同 Step 1 |
| `Ising2D.epsilon_anticomm_Z` / `..._Y` | `ε Z_m = -Z_m ε`, `ε Y_m = -Y_m ε` | 同 Step 4 |
| `Ising2D.epsilon_commute_V1` / `epsilon_commute_V1PauliForm` | **`ε V_1 = V_1 ε`**（前者が `def_transfer_matrix` の `V_1`、後者が右辺の式 `exp(K_1D)`） | 同 Step 3 |
| `Ising2D.epsilon_commute_V2` / `epsilon_commute_V2PauliForm` / `epsilon_commute_V2H2Form` | **`ε V_2 = V_2 ε`**（前者が `def_transfer_matrix` の `V_2`、後の 2 本が右辺の式） | 同 Step 2 |
| `Ising2D.epsilon_commute_H1plus` | `ε H_1^{(+)} = H_1^{(+)} ε`（`epsilon_commute_H1` は一般形） | 同 Step 4 |
| `Ising2D.epsilon_commute_V1plus` / `epsilon_commute_V1plusHalf` | **`ε V_1^{(+)} = V_1^{(+)}ε`, `ε (V_1^{(+)})^{1/2} = ⋯`**（`epsilon_commute_V1pm` / `..._V1pmHalf` は一般形） | 同 Step 4 |
| `Ising2D.commute_epsProjPlus_of_commute_epsilon` / `commute_V1_epsProjPlus` / `commute_V2_epsProjPlus` / `commute_V1plus_epsProjPlus` / `commute_V1plusHalf_epsProjPlus` | `P^{(+)}` と `V_1, V_2, V_1^{(+)}, (V_1^{(+)})^{1/2}` の可換性（`commute_*_epsProj` は一般形） | `epsilon_projectors_commute_with_transfer_matrices` |
| `Ising2D.epsProj_mul_epsProj_neg` / `epsProj_add_epsProj_neg` | `P^{(+)}P^{(-)} = 0`, `P^{(+)} + P^{(-)} = I` | ノート（旧 `epsilon_projector_properties` (1)(2)） |
| `Ising2D.RestrictsOnSector` / `V1_restrictsOnSector_of_opposite_sign` / `V1_restrictsOnEvenSector` / `V1_restrictsOnOddSector` | 符号つきのセクターごとの制限 | ノート（`sector_replacement_of_V1` の前提） |
| `Ising2D.sector_replacement_of_V1` | `V_1 P^{(±)} = V_1^{(±)} P^{(±)}` | ノート `sector_replacement_of_V1` |
| `Ising2D.sector_replacement_pow` | `(V_1V_2)^n P^{(±)} = (V_1^{(±)}V_2)^n P^{(±)}` | ノート `sector_replacement_pow` |
| `Ising2D.Vsym` / `Vsym_neg_one_eq_VPlusOfTransfer` | `V^{(±)} = (V_1^{(±)})^{1/2} V_2 (V_1^{(±)})^{1/2}`（`ηsign = -1` で本文の `VPlusOfTransfer`） | ノート `partition_function_sector_decomposition` の主張中の定義 |
| `Ising2D.trace_eq_sector_sum` / `trace_epsProj_sym_pow` / `trace_epsProj_sym_pow_eq_plain` | Step 1・Step 3・Step 2 と 3 の合成 | ノート `partition_function_sector_decomposition` |
| `Ising2D.partition_function_sector_decomposition` | `Z = tr(P^{(+)}(V^{(+)})^{N_row}) + tr(P^{(-)}(V^{(-)})^{N_row})` | ノート `partition_function_sector_decomposition` |

必要十分版（`Ising2D/NecSuf/`）:

| Lean の名前 | 内容 |
| --- | --- |
| `Ising2D.NecSuf.prod_entry_eq_zero_of_ne` / `prod_entry_eq_ite` | 因子が全部「対角」なら積も対角 |
| `Ising2D.NecSuf.map_exp_of_continuous` | 連続な環準同型は `exp` と可換 |
| `Ising2D.NecSuf.invProj` / `invProj_sq` / `invProj_mul_invProj_neg` / `invProj_add_invProj_neg` / `commute_invProj` | 対合から作る射影子とその性質 |
| `Ising2D.NecSuf.pow_mul_proj` | 冪等元上での因子の置き換え |
| `Ising2D.NecSuf.mul_pow_conj_left` | `B (BVB)^n = (BBV)^n B` |
| `Ising2D.NecSuf.cycSucc` / `openW` / `openW_snoc` | 巡回後者と「開いた道」の重み |
| `Ising2D.NecSuf.pow_succ_apply_eq_sum` | `(A^{n+1})_{ij}` は道の重みの総和 |
| `Ising2D.NecSuf.trace_pow_succ` | `tr(A^{n+1})` は閉じた道の重みの総和 |

---

## 2. 2 本立ての対応表と「必要十分版で判明した本質」

| 人手証明のラベル | 具体版 | 必要十分版 | 必要十分版で分かったこと |
| --- | --- | --- | --- |
| `epsilon_projector_properties` (1)（とノートの `P^{(+)}P^{(-)} = 0`・`P^{(+)} + P^{(-)} = I`） | `Ising2D.epsProjPlus_sq`（一般形 `epsProj_sq` 経由）/ `epsProj_mul_epsProj_neg` / `epsProj_add_epsProj_neg`（**必要十分版の系として導出済み**） | `Ising2D.NecSuf.invProj_sq` ほか（`NecSuf/Projector.lean`） | 効いているのは **`ε² = I` と `2` が可逆であること**だけ。`ε` が Jordan–Wigner 文字列の積であることも、行列であることも、環が可換であることも効いていない |
| `epsilon_projectors_commute_with_transfer_matrices` | `Ising2D.commute_epsProjPlus_of_commute_epsilon`（**必要十分版の系**） | `Ising2D.NecSuf.commute_invProj` | 「`ε` と可換なら `P^{(+)}` とも可換」に効いているのはスカラー作用と加法の両立則だけ |
| ノート `sector_replacement_pow` | `Ising2D.sector_replacement_pow`（**必要十分版の系**） | `Ising2D.NecSuf.pow_mul_proj` | 効いているのは「`P` が冪等」「`P` が `V_1, V_2, V_1^{(±)}` と可換」「`V_1P = V_1^{(±)}P`」の 3 点だけ。**`P` が `(I±ε)/2` の形であることすら使わない**。すなわち「偶奇セクター」という言葉のうちこの段で使われている情報は冪等元と可換性だけである |
| ノート `partition_function_sector_decomposition` Step 3 | `Ising2D.trace_epsProj_sym_pow` | `Ising2D.NecSuf.mul_pow_conj_left` | 対称形 `(BV_2B)^n` の解消は**結合法則だけ**（原文の「結合法則で括り直すだけ」が文字どおり正しい）。トレース側で追加に要るのは巡回性と `P` と `B` の可換性のみで、`B` が `exp` であることは効いていない |

必要十分版を置かなかった主張とその理由: 本章の主張は上の表のとおり必要十分版を持つか、その系である。
004 章へ移した主張（`first_transfer_matrix_pauli_form`, `second_transfer_matrix_pauli_form`,
`two_by_two_transfer_identity`, `def_config_basis_iso`, `V1_in_Z_Y_epsilon`, `V2_in_Z_Y`）で
必要十分版を置かなかった理由は、各 Lean ファイルの冒頭コメントと `lean/README.md` の
「転送行列 `V_1, V_2` の唯一の定義とパウリ行列表示（章 001・004）」節に書いた。

---

## 3. 条件と残る同期

| 主張 | 状況 | 記録 |
| --- | --- | --- |
| （ノート）`sector_replacement_of_V1` と、それに依存する `partition_function_sector_decomposition` | **同期済み（形式化の記録）**。`sector_replacement_of_V1` と冪・トレースの補助定理は `M>=2` と `η²=1` を受けて `ηsign=-η` を内部で使い、最終定理も `M>=2` を直接受け取る。下流の `RestrictsOnSector` 仮定は残らない | `docs/tasks/2026-07_lean-ch009-013/001_ch010_sector_replacement_depends_on_unformalized_ch004.md` |
| `V2_in_Z_Y` | **形式化済み**（004 章の主張）。`I_smul_H2_eq_sum_sigmaX` が各サイトの `iZ_mY_m=σ_m^x` を有限和へ持ち上げ、`V2_in_Z_Y` が `def_transfer_matrix` の `V_2` について `second_transfer_matrix_pauli_form` から本文どおりに導く | `Ising2D/Part004/Definition010_H1H2V1V2.lean`・`Ising2D/Part004/ClaimV2InZY.lean` |
| `def_even_eigenvectors_of_epsilon` | **固有値 `+1` の集合定義を同期済み**。`evenEigenvectors` は本文と同じ `M≥1` の下で、`epsilon M *ᵥ f = f` を満たす数ベクトルの集合として定める | `Ising2D/Part004/EvenEigenvectors.lean` |
| `even_eigenspace_is_complex_subspace` | **固有値 `+1` の集合の複素部分線型空間性を同期済み**。本文の零・和・複素スカラー倍に含まれる17段の成分計算を同じ順で `zero_mem_evenEigenvectors`・`add_mem_evenEigenvectors`・`smul_mem_evenEigenvectors` に展開し、同じ集合を台集合とする `evenEigenspace` を構成した。必要十分版は有限添字と可換半環行列だけを仮定して同じ17段を証明し、`evenEigenspace_eq_fixedSubmodule` が具体版との一致を示す | `Ising2D/Part004/EvenEigenvectors.lean`・`Ising2D/NecSuf/FixedVectorsSubmodule.lean` |
| （ノート）`def_odd_eigenvectors_of_epsilon` | **固有値 `-1` の集合定義を同期済み（形式化の記録）**。`oddEigenvectors` は本文と同じ `M≥1` の下で、`epsilon M *ᵥ f = -f` を満たす数ベクトルの集合として定める | `Ising2D/Part004/OddEigenvectors.lean` |
| （ノート）`odd_eigenspace_is_complex_subspace` | **固有値 `-1` の集合の複素部分線型空間性を同期済み（形式化の記録）**。本文の零・和・複素スカラー倍に含まれる20段の成分計算を同じ順で `zero_mem_oddEigenvectors`・`add_mem_oddEigenvectors`・`smul_mem_oddEigenvectors` に展開し、同じ集合を台集合とする `oddEigenspace` を構成した。必要十分版は有限添字と可換環行列だけを仮定して同じ20段を証明し、`oddEigenspace_eq_negatedSubmodule` が具体版との一致を示す | `Ising2D/Part004/OddEigenvectors.lean`・`Ising2D/NecSuf/NegatedVectorsSubmodule.lean` |
| `epsilon_action_eigenvalues_are_signs` | **固有値候補を同期済み**。具体版は本文と同じ `M≥1`、非零数ベクトル `f`、`epsilon M *ᵥ f = lambda • f` の下で、行列作用の結合則、複素線型性、単位行列の作用を成分和から示し、`epsilon_mul_self` から `f=lambda^2f` を得る。非零成分と複素数の零積の法則から `lambda=1` または `lambda=-1` を示す。必要十分版は二回作用で元へ戻る線型写像、非可換でもよい整域、無ねじれ加群に抽象化した。特殊化定理と必要十分性の記録は専用ファイルへ分離した。固有空間の次元公式は対象外である | `Ising2D/Part004/ClaimEpsilonActionEigenvalues.lean`・`Ising2D/NecSuf/InvolutionEigenvalue.lean`・`Ising2D/Part004/ClaimEpsilonActionEigenvaluesFromNecSuf.lean`・`docs/necsuf-involution-eigenvalue.md` |
| `epsilon_projector_properties` (2) の「`im P^{(+)} = 𝓕^{(+)}`」 | **同期済み**。2 つの包含（`epsProjPlus_mulVec_mem` / `epsProjPlus_mulVec_eq_self`）と、像を数ベクトル空間の部分集合として述べた集合の等式（`epsilon_projector_properties_image`）。人手の (2) の証明は `(P^{(+)})^2 = P^{(+)}` を経由して `ε y = y` を示すが、Lean は一般形の行列の等式 `ε P = ηP`（`epsilon_mul_epsProj`）を `η = 1` で作用させる | `Ising2D/Part010/Claim009_EpsilonProjectors.lean` |
| `bridge_000_remark_overview`（この章の内容の説明） | 主張ではなく章の概要なので、定理としては形式化していない | 本ファイル |

### mathlib について調べた結果（一次情報）

* `Matrix.exp_diagonal`（`Mathlib/Analysis/Normed/Algebra/MatrixExponential.lean:84`）が存在するので、
  対角行列の指数関数は自前の級数計算を要しない。
* 一方 `NormedSpace.map_exp`（`Mathlib/Analysis/Normed/Algebra/Exponential.lean:578`）は
  **始域・終域の両方に `NormedRing` を要求する**（同ファイル 504 行目の `variable`）。
  `Matrix ι ι ℂ` の `NormedRing` は `Matrix.Norms.Operator` スコープにしか無く、
  そのノルム由来の位相は行列の既定の位相と定義的に一致しないため、
  「`diagonal` が連続な環準同型だから `exp` と可換」という筋は**そのままでは通らない**
  （`Application type mismatch: … PseudoMetricSpace.toUniformSpace.toTopologicalSpace …`）。
  この事情は `Ising2D/Part004/ClaimExpOfDiagonalMatrix.lean` のコメントに記録した。
  なお `second_transfer_matrix_pauli_form` の「1 因子の `exp` をサイト演算子の `exp` にする」段
  （`Ising2D.exp_smul_sigmaX`）は、`Matrix.Norms.Operator` を証明の中だけで有効にし、
  級数 `NormedSpace.exp_series_hasSum_exp'` を連続線型写像で移して極限の一意性で閉じている
  （`Part004/ClaimV1RestrictionToEigenspaces.lean` の `V1_mulVec_eq_V1pm` と同じ手法）。
* `Commute.exp_left` / `Commute.exp_right`（同 228, 235 行目）は位相環の設定で使えるので、
  「`ε` が指数の肩と可換なら `exp` とも可換」はノルムを経由せずに済む。
* 行列の冪のトレースを「道の総和」へ展開する補題は mathlib に**無い**
  （`Matrix.trace_pow` / `Matrix.pow_apply` を `Mathlib/LinearAlgebra/Matrix/Trace.lean`,
  `Mathlib/Data/Matrix/Mul.lean` で検索したが、`Matrix.pow_apply_nonneg` と
  `SimpleGraph.adjMatrix_pow_apply_eq_card_walk` しか無い）。
  そのため `Ising2D/NecSuf/TracePathSum.lean` として自前で証明した
  （`Fin.consEquiv` / `Fin.snocEquiv` による添字の付け替えを使う）。

---

## 4. 検証

```
cd exact-solution-of-2d-ising-model/lean
lake build            # 成功（警告のみ）
./scripts/check-no-sorry.sh   # exit 0
```

`scripts/check-no-sorry.sh` の `targets` には本章の主要定理を追記済み。
数値検証は `sagemath/check/043_claim_transfer_matrix_bridge/`（5 チェック全 PASS）。

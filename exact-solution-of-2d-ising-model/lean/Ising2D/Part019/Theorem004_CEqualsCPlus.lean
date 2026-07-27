/-
# `c(M) = c_+(M)`（具体版・この章の結論）

正本: `structured-latex/content/019_max_eigenvalue_sector.ts`
（`sector_004_theorem_c_equals_c_plus`、ラベル **`c_equals_c_plus`**）

抽象版は `Ising2D/Abstract/PermSector.lean`（同じラベル）の
`Ising2D.Abstract.rayleighSup_eq_sectorRayleighSup_pos`。本ファイルの主定理はその**系**である。

## 人手証明との対応

| 人手証明 | 本ファイル |
| --- | --- |
| Step 1（`c(M) = max(c_+, c_-) = c_+(M)`） | `c_equals_c_plus` |
| Step 2（`c_+(M) = Λ^{(1/2)}_M` の代入） | `rayleighSup_eq_of_sectorRayleighSup_pos_eq`（**`c_plus_equals_Lambda_half_integer` は未形式化なので仮定として受け取る**） |
| Step 3（上限が偶セクターで達成されること） | `rayleighSup_attained_in_even_sector`（同上の理由で `x_0` の存在を仮定として受け取る） |

## 形式化できなかった部分と、その理由（一次情報）

人手証明 Step 2・Step 3 が引く `c_plus_equals_Lambda_half_integer` は
**章 018（`structured-latex/content/018_even_sector_closing.ts` の 2061 行目でラベル定義）**の
定理であり、本リポジトリの Lean 側には対応する形式化が存在しない
（`lean/Ising2D/` 全体を `c_plus` / `cPlus` / `Lambda_half` で検索しても該当なし。
`Ising2D.LambdaM` は章 012 の自由エネルギーの表式であって `c_+(M)` との等号ではない）。
そのため Step 2・Step 3 は「`c_+(M) = Λ` を仮定すれば `c(M) = Λ`」
「`c_+(M)` を達成する偶セクターの単位ベクトルがあれば、それは `c(M)` を達成する」
という条件つきの形で形式化した。**この章に固有の内容（Step 1）は無条件で証明されている。**

## `ε W = W ε` について

人手証明はこの可換性を `sector_decomposition_of_rayleigh_sup` (1)（章 011）から受け取る。
章 011 の Lean 形式化も可換性を仮定として持っている（`lean/docs/ch011-formalization.md`)。
複素側では `Ising2D.epsilon_commute_V1half` / `epsilon_commute_V2`（章 010）で証明済みだが、
**複素の `V_1, V_2` と実行列 `W` を結ぶ橋渡し（章 009・010 → 章 011）が未形式化**なので、
本ファイルでも実行列としての可換性 `epsilonR M * W = W * epsilonR M` は仮定として受け取る。
-/
import Ising2D.Part019.Theorem003_CMinusLeCPlus

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## Step 1: `c(M) = c_+(M)` -/

/-- **人手証明の定理 `c_equals_c_plus` Step 1** `c(M) = c_+(M)`。

最大固有値（Rayleigh 商の上限）は偶セクターから来る。 -/
theorem c_equals_c_plus {W : Matrix (Conf M) (Conf M) ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : Conf M → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (hpos : ∀ k l, 0 < W k l)
    (hcomm : epsilonR M * W = W * epsilonR M) :
    rayleighSup W = sectorRayleighSup W (epsilonR M) 1 :=
  Abstract.rayleighSup_eq_sectorRayleighSup_pos hW hpsd (fun k l => (hpos k l).le)
    flipConf_involutive hcomm

/-- 章 011 の対称化転送行列 `W = V_1^{1/2} V_2 V_1^{1/2}` への特殊化。 -/
theorem c_equals_c_plus_symTransfer {d : Conf M → ℝ} {V2 : Matrix (Conf M) (Conf M) ℝ}
    (hd : ∀ i, 0 < d i) (hV2symm : V2.IsSymm) (hV2pos : ∀ i j, 0 < V2 i j)
    (hV2pd : ∀ x : Conf M → ℝ, x ≠ 0 → 0 < x ⬝ᵥ V2 *ᵥ x)
    (hcomm : epsilonR M * symTransfer (diagonal d) V2
      = symTransfer (diagonal d) V2 * epsilonR M) :
    rayleighSup (symTransfer (diagonal d) V2)
      = sectorRayleighSup (symTransfer (diagonal d) V2) (epsilonR M) 1 := by
  have hsymm : (symTransfer (diagonal d) V2).IsSymm :=
    symTransfer_isSymm (Matrix.isSymm_diagonal d) hV2symm
  have hpd : ∀ x : Conf M → ℝ, x ≠ 0 → 0 < x ⬝ᵥ symTransfer (diagonal d) V2 *ᵥ x :=
    symTransfer_posDef (Matrix.isSymm_diagonal d) (isUnit_diagonal_of_pos hd) hV2pd
  have hpsd : ∀ x : Conf M → ℝ, 0 ≤ x ⬝ᵥ symTransfer (diagonal d) V2 *ᵥ x := by
    intro x
    rcases eq_or_ne x 0 with rfl | hx
    · simp
    · exact (hpd x hx).le
  exact c_equals_c_plus hsymm hpsd (symTransfer_entry_pos hd hV2pos) hcomm

/-! ## Step 2: 値の代入（`c_plus_equals_Lambda_half_integer` は未形式化なので仮定） -/

/-- **人手証明 Step 2**: `c_+(M) = Λ` なら `c(M) = Λ`。

`Λ` は章 018 の `c_plus_equals_Lambda_half_integer` が与える値
（`Λ^{(1/2)}_M`）を想定しているが、その等号は未形式化なので仮定として受け取る。 -/
theorem rayleighSup_eq_of_sectorRayleighSup_pos_eq {W : Matrix (Conf M) (Conf M) ℝ}
    (hW : W.IsSymm) (hpsd : ∀ x : Conf M → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (hpos : ∀ k l, 0 < W k l)
    (hcomm : epsilonR M * W = W * epsilonR M) {Λ : ℝ}
    (hΛ : sectorRayleighSup W (epsilonR M) 1 = Λ) :
    rayleighSup W = Λ := by
  rw [c_equals_c_plus hW hpsd hpos hcomm, hΛ]

/-! ## Step 3: 上限が偶セクターで達成されること -/

/-- **人手証明 Step 3**: `c_+(M)` を達成する偶セクターの単位ベクトル `x_0` があれば、
それは `c(M)` を達成する。すなわち **`c(M)` の上限は偶セクター `𝓕^{(+)}` の中で達成される**。 -/
theorem rayleighSup_attained_in_even_sector {W : Matrix (Conf M) (Conf M) ℝ}
    (hW : W.IsSymm) (hpsd : ∀ x : Conf M → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (hpos : ∀ k l, 0 < W k l)
    (hcomm : epsilonR M * W = W * epsilonR M) {x₀ : Conf M → ℝ}
    (hx₀ : epsilonR M *ᵥ x₀ = (1 : ℝ) • x₀) (hx₀1 : vecNormSq x₀ = 1)
    (hattain : x₀ ⬝ᵥ W *ᵥ x₀ = sectorRayleighSup W (epsilonR M) 1) :
    x₀ ⬝ᵥ W *ᵥ x₀ = rayleighSup W := by
  rw [hattain, c_equals_c_plus hW hpsd hpos hcomm]

/-- 上の系: 偶セクターで上限が達成されるなら、`𝓡` の上限も達成される
（`c(M) ∈ 𝓡`、すなわち人手証明の「上限 `c(M)` は達成される」）。 -/
theorem rayleighSup_mem_rayleighSet {W : Matrix (Conf M) (Conf M) ℝ}
    (hW : W.IsSymm) (hpsd : ∀ x : Conf M → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (hpos : ∀ k l, 0 < W k l)
    (hcomm : epsilonR M * W = W * epsilonR M) {x₀ : Conf M → ℝ}
    (hx₀ : epsilonR M *ᵥ x₀ = (1 : ℝ) • x₀) (hx₀1 : vecNormSq x₀ = 1)
    (hattain : x₀ ⬝ᵥ W *ᵥ x₀ = sectorRayleighSup W (epsilonR M) 1) :
    rayleighSup W ∈ rayleighSet W :=
  ⟨x₀, hx₀1,
    (rayleighSup_attained_in_even_sector hW hpsd hpos hcomm hx₀ hx₀1 hattain).symm⟩

end Ising2D

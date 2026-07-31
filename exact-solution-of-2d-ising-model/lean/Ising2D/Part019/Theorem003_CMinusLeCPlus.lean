/-
# `c_-(M) ≤ c_+(M)`（具体版）

正本: `structured-latex/content/019_max_eigenvalue_sector.ts`
（`sector_003_theorem_c_minus_le_c_plus`、ラベル **`c_minus_le_c_plus`**）

必要十分版は `Ising2D/NecSuf/PermSector.lean`（同じラベル）の
`Ising2D.NecSuf.sectorRayleighSup_neg_le_pos`。本ファイルの主定理はその**系**である。

## 人手証明との対応

| 人手証明 | 本ファイル |
| --- | --- |
| Step 1（`𝓡_±` が空でなく上に有界、`c_±(M) ∈ ℝ`） | `sectorSet_neg_nonempty_epsilonR` / `sectorSet_pos_nonempty_epsilonR`（章 019 の Claim001）＋ `Ising2D.sectorSet_bddAbove`（章 011） |
| Step 2（各点での比較 `xᵀWx ≤ uᵀWu ≤ c_+(M)`） | `quad_le_sectorRayleighSup_pos` |
| Step 3（上限を取る） | `c_minus_le_c_plus` |

## 必要十分版で分かったこと

人手証明 `epsilon_is_sign_flip_permutation` (2) の「`π` は不動点をもたない」（`M ≥ 2` の仮定）は、
**不等式 `c_-(M) ≤ c_+(M)` そのものには効いていない**。本ファイルの `c_minus_le_c_plus` は
`M` について何も仮定していない。`M ≥ 1` が要るのは「`𝓡_-` が空でない」
（＝ `c_-(M)` が上限として意味をもつ）ことを言う `sectorSet_neg_nonempty_epsilonR` だけである。

また、`W_{kl} > 0` の**狭義**の正値性も不等式には不要である（`0 ≤ W_{kl}` で足りる。
`c_minus_le_c_plus_of_nonneg` 参照）。
-/
import Ising2D.Part019.Claim002_AbsVectorEvenSector
import Ising2D.Part011.Definition001_SymmetrizedTransferMatrix

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## Step 1: `c_±(M)` が実数として定まること -/

/-- 人手証明 Step 1: `𝓡_±` は上に有界（章 011 の `sectorSet_bddAbove` の言い換え）。 -/
theorem sectorSet_bddAbove_epsilonR {W : Matrix (Conf M) (Conf M) ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : Conf M → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (s : ℝ) :
    BddAbove (sectorSet W (epsilonR M) s) :=
  sectorSet_bddAbove hW hpsd (epsilonR M) s

/-- 人手証明 Step 1 のまとめ: `𝓡_-` は空でなく上に有界（`M ≥ 1` が要る）。 -/
theorem sectorSet_neg_nonempty_bddAbove (hM : 0 < M) {W : Matrix (Conf M) (Conf M) ℝ}
    (hW : W.IsSymm) (hpsd : ∀ x : Conf M → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) :
    (sectorSet W (epsilonR M) (-1 : ℝ)).Nonempty ∧
      BddAbove (sectorSet W (epsilonR M) (-1 : ℝ)) :=
  ⟨sectorSet_neg_nonempty_epsilonR hM W, sectorSet_bddAbove_epsilonR hW hpsd _⟩

/-- 人手証明 Step 1 のまとめ: `𝓡_+` は空でなく上に有界。 -/
theorem sectorSet_pos_nonempty_bddAbove {W : Matrix (Conf M) (Conf M) ℝ}
    (hW : W.IsSymm) (hpsd : ∀ x : Conf M → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) :
    (sectorSet W (epsilonR M) (1 : ℝ)).Nonempty ∧
      BddAbove (sectorSet W (epsilonR M) (1 : ℝ)) :=
  ⟨sectorSet_pos_nonempty_epsilonR W, sectorSet_bddAbove_epsilonR hW hpsd _⟩

/-! ## Step 2: 各点での比較 -/

/-- **人手証明 Step 2** `x ∈ 𝓕^{(-)}, ‖x‖ = 1 ⇒ xᵀWx ≤ c_+(M)`。 -/
theorem quad_le_sectorRayleighSup_pos {W : Matrix (Conf M) (Conf M) ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : Conf M → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (hpos : ∀ k l, 0 < W k l)
    {x : Conf M → ℝ} (hx : epsilonR M *ᵥ x = (-1 : ℝ) • x) (hx1 : vecNormSq x = 1) :
    x ⬝ᵥ W *ᵥ x ≤ sectorRayleighSup W (epsilonR M) 1 := by
  obtain ⟨u, hu, hu1, hle⟩ := exists_even_sector_unit_ge hpos hx hx1
  exact le_trans hle
    (le_csSup (sectorSet_bddAbove_epsilonR hW hpsd _) ⟨u, hu, hu1, rfl⟩)

/-! ## Step 3: 上限を取る -/

/-- **人手証明の定理 `c_minus_le_c_plus`** `c_-(M) ≤ c_+(M)`。 -/
theorem c_minus_le_c_plus {W : Matrix (Conf M) (Conf M) ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : Conf M → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (hpos : ∀ k l, 0 < W k l) :
    sectorRayleighSup W (epsilonR M) (-1 : ℝ) ≤ sectorRayleighSup W (epsilonR M) 1 :=
  NecSuf.sectorRayleighSup_neg_le_pos hW hpsd (fun k l => (hpos k l).le)
    flipConf_involutive

/-- 上の非負版（必要十分版で分かった、本当に効いている仮定）。 -/
theorem c_minus_le_c_plus_of_nonneg {W : Matrix (Conf M) (Conf M) ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : Conf M → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (hnn : ∀ k l, 0 ≤ W k l) :
    sectorRayleighSup W (epsilonR M) (-1 : ℝ) ≤ sectorRayleighSup W (epsilonR M) 1 :=
  NecSuf.sectorRayleighSup_neg_le_pos hW hpsd hnn flipConf_involutive

/-! ## 章 011 の `W = V_1^{1/2} V_2 V_1^{1/2}` への特殊化 -/

/-- 成分がすべて正の対角行列は可逆。 -/
theorem isUnit_diagonal_of_pos {d : Conf M → ℝ} (hd : ∀ i, 0 < d i) :
    IsUnit (diagonal d) := by
  rw [Matrix.isUnit_iff_isUnit_det, Matrix.det_diagonal]
  exact isUnit_iff_ne_zero.mpr (Finset.prod_pos fun i _ => hd i).ne'

/-- **章 011 の対称化転送行列 `W = V_1^{1/2} V_2 V_1^{1/2}` に対する `c_-(M) ≤ c_+(M)`。**

`V_1^{1/2}` が成分の正な対角行列（章 011 の `diagExp`）で、`V_2` が実対称正定値かつ
成分がすべて正であれば、`W` は人手証明 `c_minus_le_c_plus` の仮定
（実対称・半正定値・成分がすべて正）をすべて満たす。 -/
theorem c_minus_le_c_plus_symTransfer {d : Conf M → ℝ} {V2 : Matrix (Conf M) (Conf M) ℝ}
    (hd : ∀ i, 0 < d i) (hV2symm : V2.IsSymm) (hV2pos : ∀ i j, 0 < V2 i j)
    (hV2pd : ∀ x : Conf M → ℝ, x ≠ 0 → 0 < x ⬝ᵥ V2 *ᵥ x) :
    sectorRayleighSup (symTransfer (diagonal d) V2) (epsilonR M) (-1 : ℝ)
      ≤ sectorRayleighSup (symTransfer (diagonal d) V2) (epsilonR M) 1 := by
  have hsymm : (symTransfer (diagonal d) V2).IsSymm :=
    symTransfer_isSymm (Matrix.isSymm_diagonal d) hV2symm
  have hpd : ∀ x : Conf M → ℝ, x ≠ 0 → 0 < x ⬝ᵥ symTransfer (diagonal d) V2 *ᵥ x :=
    symTransfer_posDef (Matrix.isSymm_diagonal d) (isUnit_diagonal_of_pos hd) hV2pd
  have hpsd : ∀ x : Conf M → ℝ, 0 ≤ x ⬝ᵥ symTransfer (diagonal d) V2 *ᵥ x := by
    intro x
    rcases eq_or_ne x 0 with rfl | hx
    · simp
    · exact (hpd x hx).le
  exact c_minus_le_c_plus hsymm hpsd (symTransfer_entry_pos hd hV2pos)

end Ising2D

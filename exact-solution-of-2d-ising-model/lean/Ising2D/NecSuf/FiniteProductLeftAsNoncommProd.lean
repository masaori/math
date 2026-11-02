/-
# 左から掛ける有限積を `Finset.noncommProd` で書く（必要十分版）

具体版: `Ising2D/EigenvalueProblem/EigenvaluesOfVPlus/ClaimCheckJointEigenspace.lean` の `CheckFermiSetup.Qproj_eq_finProdLeft`
（人手 `check_joint_eigenspace_decomposition` の `Q̌_ε = ∏_{μ=1}^{M_col} R_μ^{(ε_μ)}`。有限積は `def_finite_product_of_matrices`（`r → M_col`）による）。

人手の `Q̌_ε` は `def_finite_product_of_matrices` の左から掛ける積である。Lean の `Qproj`（`NecSuf.projOn`）は、
因子が互いに可換であることを引数に取る mathlib の `Finset.noncommProd` で定めてある。
`finProdLeft_eq_noncommProd_image` は二つが等しいことを述べる。人手の証明の行ではなく、Lean の二つの定義をつなぐ等式である。
Lean の `j : Fin (r + 1)`（人手の添字 `j + 1`）を因子の添字の型 `ι` へ送る写像を `e` とする（`e` の像が `noncommProd` の添字集合になる）。

| 等式の段 | 使うもの |
| --- | --- |
| `r = 0`（因子 1 つ） | `finProdLeft_zero`（`def_finite_product_of_matrices` の `∏_{j=1}^{1} A_j := A_1`）、`noncommProd_singleton`、像が 1 点であること |
| `r → r + 1` | `finProdLeft_succ`（`∏_{j=1}^{r+2} A_j := (∏_{j=1}^{r+1} A_j) A_{r+2}`）、帰納法の仮定、`noncommProd_insert_of_notMem'`（末尾に 1 因子を足す）、`image_univ_fin_succ` |

## 何が効いているか / 効いていないか

- `R` はモノイドである。`Finset.noncommProd` の定義がモノイドを要る。等式の証明では、因子が 1 つの段の `noncommProd_singleton` が
  単位元（`mul_one`）を使い、末尾に 1 因子を足す段の `noncommProd_insert_of_notMem'` が結合則を使う（どちらも mathlib の補題の中で使われる）。
- 因子が互いに可換であること（`hf`）は、`noncommProd` を定めるのに要るうえ、末尾に 1 因子を足す段でも効く。mathlib の `noncommProd` は
  因子を左から順に掛ける形で畳み込むので、足す因子を右の末尾へ置くには、その因子とほかの因子の可換性が要る
  （`noncommProd_insert_of_notMem'` の中の `Multiset.noncommProd_cons'`）。
- 添字の写像 `e` の単射性は、末尾の因子の添字 `e (r + 1)` が残りの添字の像に入らないこと（`noncommProd_insert_of_notMem'` の仮定）に要る。
  単射でないと、`noncommProd` は重なった添字の因子を 1 回しか掛けないので等式が崩れる。
-/
import Mathlib.Data.Finset.NoncommProd
import Mathlib.Data.Fintype.Basic
import Ising2D.NecSuf.FiniteProductLeft

namespace Ising2D.NecSuf

open Finset

/-- `{0, …, r + 1}` の像は、末尾 `r + 1` の像と `{0, …, r}` の像の和集合である。 -/
theorem image_univ_fin_succ {ι : Type*} [DecidableEq ι] {r : ℕ} (e : Fin (r + 2) → ι) :
    (univ : Finset (Fin (r + 2))).image e
      = insert (e (Fin.last (r + 1)))
          ((univ : Finset (Fin (r + 1))).image (fun j => e (Fin.castSucc j))) := by
  ext x
  simp only [mem_image, mem_univ, true_and, mem_insert]
  constructor
  · rintro ⟨j, rfl⟩
    cases j using Fin.lastCases with
    | last => exact Or.inl rfl
    | cast j => exact Or.inr ⟨j, rfl⟩
  · rintro (rfl | ⟨j, rfl⟩)
    · exact ⟨_, rfl⟩
    · exact ⟨_, rfl⟩

/-- **左から掛ける有限積 `finProdLeft` と `Finset.noncommProd` は等しい**（互いに可換な因子、単射な添字の写像）。 -/
theorem finProdLeft_eq_noncommProd_image {R ι : Type*} [Monoid R] [DecidableEq ι] (f : ι → R)
    (hf : ∀ i j, Commute (f i) (f j)) :
    ∀ (r : ℕ) (e : Fin (r + 1) → ι), Function.Injective e →
      finProdLeft r (fun j => f (e j))
        = ((univ : Finset (Fin (r + 1))).image e).noncommProd f (fun i _ j _ _ => hf i j)
  | 0, e, _ =>
    calc finProdLeft 0 (fun j => f (e j))
        = f (e 0) := finProdLeft_zero _                                  -- 有限積の定義（因子 1 つ）
      _ = ({e 0} : Finset ι).noncommProd f (fun i _ j _ _ => hf i j) :=
          (noncommProd_singleton _ _).symm                              -- 1 点の上の `noncommProd`
      _ = ((univ : Finset (Fin 1)).image e).noncommProd f (fun i _ j _ _ => hf i j) :=
          noncommProd_congr (by rw [univ_unique, image_singleton]; rfl) (fun _ _ => rfl) _
                                                                         -- `{0}` の像は `{e 0}`
  | r + 1, e, he => by
    have hnot : e (Fin.last (r + 1))
        ∉ (univ : Finset (Fin (r + 1))).image (fun j => e (Fin.castSucc j)) := by
      simp only [mem_image, mem_univ, true_and, not_exists]
      intro j hj
      exact (Fin.castSucc_lt_last j).ne (he hj)
    calc finProdLeft (r + 1) (fun j => f (e j))
        = finProdLeft r (fun j => f (e (Fin.castSucc j))) * f (e (Fin.last (r + 1))) :=
          finProdLeft_succ r _                                           -- 有限積の定義（末尾の因子を右から掛ける）
      _ = ((univ : Finset (Fin (r + 1))).image (fun j => e (Fin.castSucc j))).noncommProd f
              (fun i _ j _ _ => hf i j) * f (e (Fin.last (r + 1))) := by
          rw [finProdLeft_eq_noncommProd_image f hf r (fun j => e (Fin.castSucc j))
            (he.comp (Fin.castSucc_injective _))]                        -- 帰納法の仮定
      _ = (insert (e (Fin.last (r + 1)))
              ((univ : Finset (Fin (r + 1))).image (fun j => e (Fin.castSucc j)))).noncommProd f
              (fun i _ j _ _ => hf i j) :=
          (noncommProd_insert_of_notMem' _ _ _ _ hnot).symm               -- 末尾に 1 因子を足す
      _ = ((univ : Finset (Fin (r + 2))).image e).noncommProd f (fun i _ j _ _ => hf i j) :=
          noncommProd_congr (image_univ_fin_succ e).symm (fun _ _ => rfl) _
                                                                         -- 添字集合の分け方

end Ising2D.NecSuf

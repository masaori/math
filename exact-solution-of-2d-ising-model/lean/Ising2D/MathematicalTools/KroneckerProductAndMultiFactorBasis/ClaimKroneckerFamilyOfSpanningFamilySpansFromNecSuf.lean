/-
# `<kronecker_family_of_spanning_family_spans>` の具体版を必要十分版から導く

対応する人手証明:
`structured-latex/content/002_linear_space_general.ts` の `kronecker_family_of_spanning_family_spans`

必要十分版は `Ising2D/NecSuf/MultilinearImageOfSpanningFamilySpans.lean`。具体版は
`ClaimKroneckerFamilyOfSpanningFamilySpans.lean` の `kronecker_family_of_spanning_family_spans` で、
本ファイルは同じ結論を、必要十分版を `f := siteProd M`（クロネッカー積）、`V := Mat(2, ℂ)`、`ι := Fin 4`、
`κ := Conf M × Conf M`、`y (I, J) := (E_{i_1j_1}, …, E_{i_Mj_M})` に特殊化して得る（README 4 節の要件 4）。

必要十分版へ渡す具体的な部分は次の 2 つである。
1. `hb`: `b_1, …, b_4` が `Mat(2, ℂ)` を張ること（具体版と同じ仮定）。
2. `hf`: `Mat(2^M, ℂ)` の元が `E_{I,J}`（`siteProd M` の値）の線型結合で書けること。`tensor_basis` (1) の展開
   `matrix_eq_sum_E` と、`E_{I,J}` が行列単位のクロネッカー積であること（`E_eq_siteProd_single`）から得る。
-/
import Ising2D.NecSuf.MultilinearImageOfSpanningFamilySpans
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerFamilyOfSpanningFamilySpans

namespace Ising2D

variable {M : ℕ}

/-- `Mat(2^M, ℂ)` の元は `E_{I,J} = E_{i_1j_1} ⊠ ⋯ ⊠ E_{i_Mj_M}` の線型結合で書ける
（`tensor_basis` (1) の展開と `E_eq_siteProd_single`）。 -/
theorem eq_sum_siteProd_single (X : TensorPow M) :
    ∃ c : Conf M × Conf M → ℂ,
      X = ∑ IJ, c IJ • siteProd M (fun k => Matrix.single (IJ.1 k) (IJ.2 k) (1 : ℂ)) := by
  refine ⟨fun IJ => X IJ.1 IJ.2, ?_⟩
  conv_lhs => rw [matrix_eq_sum_E M X]
  exact Finset.sum_congr rfl fun IJ _ => by rw [E_eq_siteProd_single]

/-- **`<kronecker_family_of_spanning_family_spans>` を必要十分版から導出した形**（具体版と同じ型）。 -/
theorem kronecker_family_of_spanning_family_spans_of_necSuf (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ)
    (hb : ∀ A : Matrix (Fin 2) (Fin 2) ℂ, ∃ c : Fin 4 → ℂ, A = ∑ a, c a • b a) (X : TensorPow M) :
    ∃ d : (Fin M → Fin 4) → ℂ, X = ∑ p, d p • siteProd M (fun k => b (p k)) := by
  have hf : ∀ w : TensorPow M, ∃ c : Conf M × Conf M → ℂ,
      w = ∑ t, c t • siteProd M ((fun (IJ : Conf M × Conf M) (k : Fin M) =>
        Matrix.single (IJ.1 k) (IJ.2 k) (1 : ℂ)) t) :=
    eq_sum_siteProd_single
  have h := NecSuf.mem_familyCombinations_of_spanning (R := ℂ) (V := Matrix (Fin 2) (Fin 2) ℂ)
    (W := TensorPow M) (n := M) (ι := Fin 4) (κ := Conf M × Conf M) (siteProd M) b hb
    (fun IJ k => Matrix.single (IJ.1 k) (IJ.2 k) (1 : ℂ)) hf X
  obtain ⟨d, hd⟩ := h
  exact ⟨d, hd⟩

/-- 上を「族は全体を張る」の形で述べたもの（`<Z_Y_generate_algebra>` の必要十分版からの導出が使う）。 -/
theorem span_kroneckerFamily_eq_top_of_necSuf (b : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ)
    (hb : ∀ A : Matrix (Fin 2) (Fin 2) ℂ, ∃ c : Fin 4 → ℂ, A = ∑ a, c a • b a) :
    Submodule.span ℂ (Set.range fun p : Fin M → Fin 4 => siteProd M (fun k => b (p k))) = ⊤ := by
  refine eq_top_iff.2 fun X _ => ?_
  obtain ⟨d, hd⟩ := kronecker_family_of_spanning_family_spans_of_necSuf b hb X
  rw [hd]
  exact Submodule.sum_mem _ fun p _ => Submodule.smul_mem _ _ (Submodule.subset_span ⟨p, rfl⟩)

end Ising2D

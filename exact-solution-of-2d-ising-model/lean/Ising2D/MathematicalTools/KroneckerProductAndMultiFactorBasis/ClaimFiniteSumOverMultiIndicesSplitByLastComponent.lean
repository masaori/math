/-
# 多重添字の集合の上の有限和を、最後の成分で分ける（具体版）

正本: `structured-latex/content/002_linear_space_general.ts`
（`linear_space_general_000_claim_finite_sum_over_multi_indices_split_by_last_component`、
ラベル **`finite_sum_over_multi_indices_split_by_last_component`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備 `ν(K,t) = 2(ν(K) − 1) + t` の 6 行 | 証明の中の `kronecker_numbering_snoc` の `calc` の 6 段 |
| 準備 `ν^{-1}(2(k−1)+t) = (ν^{-1}(k),t)` の `ν((ν^{-1}(k),t)) = 2(k−1)+t` の 2 行 | 証明の `σ₂` の定義と `hσ₂`（`kronecker_numbering_snoc` と `hσ`） |
| 同じく「`ν(I) = 2(k−1)+t` を満たす `I` はただ一つ」 | 一致の補題 `finset_sum_conf_complex_eq_finite_sum_over_multi_indices` の中の `ν` の単射性（`σ₂` 自体は一意性を使わない） |
| 本体 1 行目の `𝓘_{M+1}` の `ν` の値域（`def_kronecker` の `ν` が `{1,…,2^{M+1}}` へ写ること） | `hord₂`。人手は `def_kronecker` の Step 2 を引くだけだが、Lean は値域を `Fin.snoc_init_self` による分解と準備から示し直す（人手に無い段） |
| 本体の 9 行 | `finite_sum_over_multi_indices_split_by_last_component` の `calc` の 9 段 |

- 主張の型には `Fin.snoc` と `ℤ` の数字 `2` を出さない（本文が定めていない記号なので）。人手の `a(K,t)` を `b K t` とし、
  「`I` の成分が `(K,t)` のとおりなら `a(I) = b K t`」を成分の添字の像で述べた仮定 `hab` を置く。証明の中で `(K,t)` を `Fin.snoc K t` に取る（`hsnoc`）。
- 人手の `M ∈ ℤ_{≥1}` は Lean の `M + 1` で、人手の `𝓘_M`・`𝓘_{M+1}` は Lean の `Conf (M + 1)`・`Conf (M + 2)` である。
  人手の `(K,t)`（`K ∈ 𝓘_M`、`t ∈ {1,2}`）は Lean の `Fin.snoc K t` で、人手の `t` は Lean の `t : Fin 2` を写像 `finIndexToZZ 2` で送った値である。
- 人手の `ν^{-1}`（`def_inverse_of_kronecker_numbering`）は Lean では `exists_inverse_of_kronecker_numbering` が与える
  `σ : Fin n → Conf (M + 1)`（`ν(σ(k)) = finIndexToZZ n k`）である。`𝓘_{M+1}` の `ν^{-1}` は、人手の準備が
  「`(ν^{-1}(k),t)` の `ν` の値は `2(k−1)+t` だから、それが `ν^{-1}(2(k−1)+t)` である」と決めるとおり、
  Lean では `σ₂(2k+t) := Fin.snoc (σ k) t`（0 始まりの添字）と置き、`ν(σ₂(j)) = finIndexToZZ (2n) j`（`hσ₂`）を準備の式から示す。
  `def_finite_sum_of_complex_numbers_over_multi_indices` の一致の補題は、`ν(σ(k)) = k` を満たす任意の `σ` について述べてあるので、
  この `σ₂` に当てられる（`ν` は単射なので、`ν(σ(k)) = k` を満たす `σ` は一つしかない）。
- 人手の `2^{M+1} = 2·2^M` の行は、Lean では `𝓘_{M+1}` の添字の個数を初めから `2 * n` と置くので、定義として成り立つ（`rfl`）。
  人手の `2k − 1 = 2(k−1)+1`・`2k = 2(k−1)+2` の行も、Lean の添字 `⟨2k, _⟩`・`⟨2k+1, _⟩` では同じく `rfl` である。
- 準備の `ν(K,t)` の鎖のうち、「和の最後の項を分ける」段は `Fin.sum_univ_castSucc`、「共通の因子 2 をくくり出す」段は `Finset.mul_sum` で読む。
  本文は `ℤ` の有限和を定めるブロックを持たず、`def_kronecker` の証明も `ν` の和を名前で扱うので、その書き方に合わせた
  （`ℤ` の有限和の定義と、その最後の項の分割・定数倍の主張を本文に立てることは状態台帳の行「有限和と有限集合の記号」の残り）。

必要十分版は置かない。`ν` による添字の付け替えという具体的な主張であり、取り払える構造が無い。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionFiniteSumOverMultiIndices
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimFiniteSumOfComplexNumbersInConsecutivePairs
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatMultDistributesOverSum
import Mathlib.Data.Fin.Tuple.Basic

namespace Ising2D

/-- **`finite_sum_over_multi_indices_split_by_last_component`**:
`Σ_{I∈𝓘_{M+1}} a(I) = Σ_{t=1}^{2} Σ_{K∈𝓘_M} a(K,t)`（人手の `M` は Lean の `M + 1`）。
人手の `a(K,t)` は Lean の `b K t` で、仮定 `hab` は「`I` の成分が人手の `(K,t) = (t_1,…,t_M,t)` のとおりなら `a(I) = b K t`」を、
成分の添字の像（`finIndexToZZ`）で述べる（主張の型に `Fin.snoc` を出さないため）。 -/
theorem finite_sum_over_multi_indices_split_by_last_component (M : ℕ) (a : Conf (M + 2) → ℂ)
    (b : Conf (M + 1) → Fin 2 → ℂ)
    (hab : ∀ (I : Conf (M + 2)) (K : Conf (M + 1)) (t : Fin 2),
      (∀ (m : Fin (M + 2)) (m' : Fin (M + 1)), finIndexToZZ (M + 2) m = finIndexToZZ (M + 1) m' → I m = K m') →
      (∀ m : Fin (M + 2), finIndexToZZ (M + 2) m = inclusionNNtoZZ (M + 2) → I m = t) → a I = b K t) :
    ∑ I, a I = ∑ t : Fin 2, ∑ K : Conf (M + 1), b K t := by
  -- 人手の `(K,t)` は Lean の `Fin.snoc K t`: 成分の条件を満たすので `a(K,t) = b K t`
  have hsnoc : ∀ (K : Conf (M + 1)) (t : Fin 2), a (Fin.snoc K t) = b K t := by
    intro K t
    refine hab _ K t (fun m m' h => ?_) (fun m h => ?_)
    · have hm : m = Fin.castSucc m' := (finIndexToZZ_bijective_onto_index_set (M + 2)).1 _ _ h
      rw [hm, Fin.snoc_castSucc]
    · have hm : m = Fin.last (M + 1) :=
        Fin.ext (by have := (finIndexToZZ_eq_iff_val_add_one_eq (M + 2) m).1 h; simp only [Fin.val_last]; omega)
      rw [hm, Fin.snoc_last]
  -- 準備: `K ∈ 𝓘_M`・`t ∈ {1,2}` について `ν(K,t) = 2(ν(K) − 1) + t`（人手の `t` は `finIndexToZZ 2 t`）
  have kronecker_numbering_snoc : ∀ (K : Conf (M + 1)) (t : Fin 2),
      kroneckerNumbering (Fin.snoc K t : Conf (M + 2)) = 2 * (kroneckerNumbering K - 1) + finIndexToZZ 2 t := by
    intro K t
    have hexp : ∀ m : Fin (M + 1), M + 2 - 1 - (Fin.castSucc m : ℕ) = (M + 1 - 1 - (m : ℕ)) + 1 := fun m => by
      have := m.isLt; simp only [Fin.val_castSucc]; omega
    exact
      calc kroneckerNumbering (Fin.snoc K t : Conf (M + 2))
        = 1 + ∑ m : Fin (M + 2), ((((Fin.snoc K t : Conf (M + 2)) m : Fin 2) : ℕ) : ℤ)
            * 2 ^ (M + 2 - 1 - (m : ℕ)) := rfl                                  -- `def_kronecker` の `ν`（`M → M+1`）
      _ = 1 + ((∑ m : Fin (M + 1), (((K m : Fin 2) : ℕ) : ℤ) * 2 ^ (M + 2 - 1 - (Fin.castSucc m : ℕ)))
            + (((t : Fin 2) : ℕ) : ℤ) * 2 ^ (M + 2 - 1 - (M + 1))) := by
          rw [Fin.sum_univ_castSucc]
          simp only [Fin.snoc_castSucc, Fin.snoc_last, Fin.val_last]            -- 和の最後の項 `k = M+1` を分ける
      _ = 1 + ((∑ m : Fin (M + 1), (((K m : Fin 2) : ℕ) : ℤ) * (2 ^ (M + 1 - 1 - (m : ℕ)) * 2))
            + (((t : Fin 2) : ℕ) : ℤ) * 1) := by
          simp only [hexp, pow_succ, show M + 2 - 1 - (M + 1) = 0 by omega, pow_zero]
                                                                                -- `def_power_of_integer` の `a^{m+1} := a^m a` と `a^0 := 1`
      _ = 1 + 2 * (∑ m : Fin (M + 1), (((K m : Fin 2) : ℕ) : ℤ) * 2 ^ (M + 1 - 1 - (m : ℕ)))
            + (((t : Fin 2) : ℕ) : ℤ) := by
          rw [Finset.mul_sum, Finset.sum_congr rfl fun m _ =>
            (show (((K m : Fin 2) : ℕ) : ℤ) * (2 ^ (M + 1 - 1 - (m : ℕ)) * 2)
                = 2 * ((((K m : Fin 2) : ℕ) : ℤ) * 2 ^ (M + 1 - 1 - (m : ℕ))) by ring), mul_one, add_assoc]
                                                                                -- 和の各項から共通の因子 `2` をくくり出す（`ℤ` の結合律・可換律・分配律を各項へ）と `(t-1)·1 = t-1`
      _ = 1 + 2 * (kroneckerNumbering K - 1) + (((t : Fin 2) : ℕ) : ℤ) := by
          rw [kroneckerNumbering, add_sub_cancel_left]                         -- `def_kronecker` の `ν`
      _ = 2 * (kroneckerNumbering K - 1) + finIndexToZZ 2 t := by
          simp only [finIndexToZZ, inclusionNNtoZZ_eq_natCast]
          ring                                                                  -- `ℤ` の加法の結合律と交換律（人手の `t` は `finIndexToZZ 2 t`）
  -- `𝓘_M` の `ν^{-1}`（`def_inverse_of_kronecker_numbering`）
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering (M + 1)
  -- `𝓘_{M+1}` の `ν^{-1}`: `ν^{-1}(2(k−1)+t) = (ν^{-1}(k),t)`（0 始まりの添字で `σ₂(2k+t) = Fin.snoc (σ k) t`）
  let σ₂ : Fin (2 * n) → Conf (M + 2) := fun j =>
    Fin.snoc (σ ⟨(j : ℕ) / 2, by omega⟩) ⟨(j : ℕ) % 2, by omega⟩
  have hσ₂ : ∀ j, kroneckerNumbering (σ₂ j) = finIndexToZZ (2 * n) j := by
    intro j
    rw [kronecker_numbering_snoc, hσ]                                          -- 準備と `ν(ν^{-1}(k)) = k`
    simp only [finIndexToZZ, inclusionNNtoZZ_eq_natCast]
    omega
  have hord₂ : ∀ I : Conf (M + 2), ∃ j : Fin (2 * n), kroneckerNumbering I = finIndexToZZ (2 * n) j := by
    intro I
    obtain ⟨k, hk⟩ := hord (Fin.init I)
    refine ⟨⟨2 * k + (I (Fin.last (M + 1)) : ℕ), by have := (I (Fin.last (M + 1))).isLt; omega⟩, ?_⟩
    rw [← Fin.snoc_init_self I, kronecker_numbering_snoc, hk]                 -- `I = (init I, 最後の成分)` と準備
    simp only [finIndexToZZ, inclusionNNtoZZ_eq_natCast, Fin.snoc_init_self]
    push_cast
    ring
  have hpair : ∀ (k : Fin n) (t : Fin 2) (j : Fin (2 * n)), (j : ℕ) = 2 * k + t → σ₂ j = Fin.snoc (σ k) t := by
    intro k t j hj
    have h1 : (⟨(j : ℕ) / 2, by omega⟩ : Fin n) = k := Fin.ext (by simp only; omega)
    have h2 : (⟨(j : ℕ) % 2, by omega⟩ : Fin 2) = t := Fin.ext (by simp only; omega)
    simp only [σ₂, h1, h2]
  have hsumM := finset_sum_conf_complex_eq_finite_sum_over_multi_indices (M + 1) n hord σ hσ
  calc ∑ I, a I
      = ∑ j : Fin (2 * n), a (σ₂ j) :=
        finset_sum_conf_complex_eq_finite_sum_over_multi_indices (M + 2) (2 * n) hord₂ σ₂ hσ₂ a
                                                                              -- `def_finite_sum_of_complex_numbers_over_multi_indices`（`M → M+1`）
    _ = ∑ j : Fin (2 * n), a (σ₂ j) := rfl                                    -- `2^{M+1} = 2·2^M`（添字の個数を `2 * n` と置いた）
    _ = ∑ k : Fin n, (a (σ₂ ⟨2 * k, by omega⟩) + a (σ₂ ⟨2 * k + 1, by omega⟩)) :=
        finite_sum_of_complex_numbers_in_consecutive_pairs n (fun j => a (σ₂ j)) _ _
          (fun k => by simp only [finIndexToZZ, inclusionNNtoZZ_eq_natCast]; push_cast; ring)
          (fun k => by simp only [finIndexToZZ, inclusionNNtoZZ_eq_natCast]; push_cast; ring)
                                                                              -- `finite_sum_of_complex_numbers_in_consecutive_pairs`
    _ = ∑ k : Fin n, (a (σ₂ ⟨2 * k + 0, by omega⟩) + a (σ₂ ⟨2 * k + 1, by omega⟩)) := rfl
                                                                              -- `2k − 1 = 2(k−1)+1`、`2k = 2(k−1)+2`
    _ = ∑ k : Fin n, (a (Fin.snoc (σ k) 0) + a (Fin.snoc (σ k) 1)) :=
        Finset.sum_congr rfl fun k _ => by
          rw [hpair k 0 _ rfl, hpair k 1 _ rfl]                               -- 準備 `ν^{-1}(2(k−1)+t) = (ν^{-1}(k),t)`
    _ = (∑ k : Fin n, a (Fin.snoc (σ k) 0)) + ∑ k : Fin n, a (Fin.snoc (σ k) 1) :=
        finite_sum_of_complex_sums n _ _                                      -- `finite_sum_of_complex_sums`
    _ = (∑ K : Conf (M + 1), a (Fin.snoc K 0)) + ∑ K : Conf (M + 1), a (Fin.snoc K 1) := by
        rw [hsumM (fun K => a (Fin.snoc K 0)), hsumM (fun K => a (Fin.snoc K 1))]
                                                                              -- `def_finite_sum_of_complex_numbers_over_multi_indices` を右辺から左辺へ 2 か所
    _ = (∑ s : Fin 1, ∑ K : Conf (M + 1), a (Fin.snoc K (Fin.castSucc s)))
          + ∑ K : Conf (M + 1), a (Fin.snoc K (Fin.last 1)) := by
        rw [finset_sum_fin_complex_eq_finite_sum_of_complex_numbers.2.1 _ 0 rfl]; rfl
                                                                              -- `Σ_{j=1}^{1} z_j := z_1` を右辺から左辺へ
    _ = ∑ t : Fin 2, ∑ K : Conf (M + 1), a (Fin.snoc K t) :=
        (finset_sum_fin_complex_eq_finite_sum_of_complex_numbers.2.2 1 le_rfl
          (fun t => ∑ K : Conf (M + 1), a (Fin.snoc K t)) (fun s => ∑ K : Conf (M + 1), a (Fin.snoc K (Fin.castSucc s)))
          (fun i j h => by
            rw [show j = Fin.castSucc i from ((finIndexToZZ_bijective_onto_index_set (1 + 1)).1 (Fin.castSucc i) j h).symm])
          (Fin.last 1) rfl).symm                                              -- 帰納の式（`m → 1`）を右辺から左辺へ
    _ = ∑ t : Fin 2, ∑ K : Conf (M + 1), b K t :=
        Finset.sum_congr rfl fun t _ => Finset.sum_congr rfl fun K _ => hsnoc K t
                                                                              -- 人手の `a(K,t)` は `b K t`（主張の仮定）

end Ising2D

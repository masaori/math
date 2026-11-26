/-
# 複素数の偶数個の有限和は、隣り合う二項の和の有限和に等しい（具体版）

正本: `structured-latex/content/002_linear_space_general.ts`
（`linear_space_general_000_claim_finite_sum_of_complex_numbers_in_consecutive_pairs`、
ラベル **`finite_sum_of_complex_numbers_in_consecutive_pairs`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `n = 0` の 2 行（空の和の式を左辺と右辺へ） | `finite_sum_of_complex_numbers_in_consecutive_pairs` の証明の `hall` の `zero` の節の `calc` の 2 段 |
| `n = 1` の 3 行（帰納の式 `m → 1`、`Σ_{j=1}^{1} z_j := z_1`、同じ式を右辺から左辺へ） | 同じく `hsucc` の `zero` の節の `calc` の 3 段 |
| `n → n+1` の 7 行（`ℤ` の分配律、帰納の式 `m → 2n+1`・`m → 2n`、成分ごとの和と ℝ の加法の結合律、帰納法の仮定、`ℤ` の分配律、帰納の式 `m → n`） | 同じく `hsucc` の `succ` の節の `calc` の 7 段 |

- 人手の添字 `j ∈ {1,…,2n}` は Lean の `j : Fin (2 * n)` を写像 `finIndexToZZ` で送った値で、人手の `z_{2k-1}`・`z_{2k}`（`k ∈ {1,…,n}`）は
  Lean の `k : Fin n` について `z ⟨2k, _⟩`・`z ⟨2k+1, _⟩` である（Lean の添字は 0 始まりで、人手の `k` は `k.val + 1`）。
- 人手の `n ∈ ℤ_{≥1}` の帰納法は、Lean では `n + 1` 個の組（`Fin (2 * (n + 1))` の上の和）について `n` の帰納法で書く（証明の中の `hsucc`）。
- 主張の型には `Fin` の元の構成（`Fin.mk`・`Fin.castSucc`・`Fin.last`）と `ℤ` の数字 `2` を出さない（本文が定めていない記号なので）。
  人手の `z_{2k-1}`・`z_{2k}` は、像の添字の条件で定まる `p k`・`q k` として述べ、証明の中で `⟨2k, _⟩`・`⟨2k+1, _⟩` へ移す（`hpk`・`hqk`）。
- `def_finite_sum_of_complex_numbers` の三つの式は、`finset_sum_fin_complex_eq_finite_sum_of_complex_numbers` の三つの式から引く
  （帰納の式は、`Fin (m + 1)` の最後の元 `Fin.last m` と、`Fin m` の元 `i` を値を変えずに送った `Fin.castSucc i` で当てる。証明の中の `hstep`）。
- 人手の `ℤ` の分配律の行（`2(n+1) = 2n + 2` など）は、Lean では添字の型と値の等号が定義として成り立つので `rfl` である。

必要十分版は置かない。和の結合律と、左から足す和の帰納の式だけを使う添字の付け替えで、取り払える構造が無い
（人手の主張そのものが添字の並びについての主張である）。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionFiniteSumOverIndexSet

namespace Ising2D

/-- **`finite_sum_of_complex_numbers_in_consecutive_pairs`**: `Σ_{j=1}^{2n} z_j = Σ_{k=1}^{n} (z_{2k-1} + z_{2k})`。
人手の `z_{2k-1}`・`z_{2k}` の添字は、Lean の `k : Fin n` について `p k`・`q k : Fin (2 * n)` で、
その像が `finIndexToZZ (2 * n) (p k) + 1 = finIndexToZZ n k + finIndexToZZ n k`・`finIndexToZZ (2 * n) (q k) = finIndexToZZ n k + finIndexToZZ n k`
（人手の `2k - 1`・`2k`。`ℤ` の数字 `2` を主張に出さないよう `k + k` と書く）で定まるものとして述べる。 -/
theorem finite_sum_of_complex_numbers_in_consecutive_pairs (n : ℕ) (z : Fin (2 * n) → ℂ) (p q : Fin n → Fin (2 * n))
    (hp : ∀ k, finIndexToZZ (2 * n) (p k) + 1 = finIndexToZZ n k + finIndexToZZ n k)
    (hq : ∀ k, finIndexToZZ (2 * n) (q k) = finIndexToZZ n k + finIndexToZZ n k) :
    ∑ j, z j = ∑ k, (z (p k) + z (q k)) := by
  -- `def_finite_sum_of_complex_numbers` の帰納の式（`m ≥ 1`）を、`Fin (m + 1)` の最後の元と `Fin.castSucc` で当てた形
  have hstep : ∀ (m : ℕ), 1 ≤ m → ∀ (z : Fin (m + 1) → ℂ),
      ∑ j, z j = (∑ i : Fin m, z (Fin.castSucc i)) + z (Fin.last m) := by
    intro m hm z
    refine finset_sum_fin_complex_eq_finite_sum_of_complex_numbers.2.2 m hm z (fun i => z (Fin.castSucc i))
      (fun i j h => ?_) (Fin.last m) ((finIndexToZZ_eq_iff_val_add_one_eq (m + 1) _).2 (by simp))
    -- 像の添字が等しい `Fin m` の元 `i` と `Fin (m + 1)` の元 `j` は、`j = Fin.castSucc i`（`finIndexToZZ` の単射）
    have hj : Fin.castSucc i = j := (finIndexToZZ_bijective_onto_index_set (m + 1)).1 _ _ h
    rw [hj]
  -- `n ∈ ℤ_{≥1}` の帰納法（Lean の `n + 1` 組）
  have hsucc : ∀ (n : ℕ) (z : Fin (2 * (n + 1)) → ℂ),
      ∑ j, z j = ∑ k : Fin (n + 1), (z ⟨2 * k, by omega⟩ + z ⟨2 * k + 1, by omega⟩) := by
    intro n
    induction n with
    | zero =>
      intro z
      exact
        calc ∑ j : Fin 2, z j
            = (∑ i : Fin 1, z (Fin.castSucc i)) + z (Fin.last 1) :=
              hstep 1 le_rfl z              -- 帰納の式（`m → 1`）
          _ = z 0 + z 1 := by
              rw [finset_sum_fin_complex_eq_finite_sum_of_complex_numbers.2.1 _ 0 rfl]; rfl
                                                                                  -- `Σ_{j=1}^{1} z_j := z_1`
          _ = ∑ k : Fin 1, (z ⟨2 * k, by omega⟩ + z ⟨2 * k + 1, by omega⟩) :=
              (finset_sum_fin_complex_eq_finite_sum_of_complex_numbers.2.1
                (fun k : Fin 1 => z ⟨2 * k, by omega⟩ + z ⟨2 * k + 1, by omega⟩) 0 rfl).symm
                                                                                  -- 同じ式を右辺から左辺へ（`k = 1` の項は `z_1 + z_2`）
    | succ n ih =>
      intro z
      exact
        calc ∑ j : Fin (2 * (n + 2)), z j
            = ∑ j : Fin (2 * (n + 1) + 1 + 1), z j := rfl                         -- `ℤ` の分配律 `2(n+1) = 2n + 2`
          _ = (∑ j : Fin (2 * (n + 1) + 1), z (Fin.castSucc j)) + z (Fin.last _) :=
              hstep _ (by omega) z          -- 帰納の式（`m → 2n+1`）
          _ = ((∑ j : Fin (2 * (n + 1)), z (Fin.castSucc (Fin.castSucc j)))
                + z (Fin.castSucc (Fin.last _))) + z (Fin.last _) := by
              exact congrArg (· + z (Fin.last _))
                (hstep (2 * (n + 1)) (by omega) (fun j => z (Fin.castSucc j)))
                                                                                  -- 帰納の式（`m → 2n`）
          _ = (∑ j : Fin (2 * (n + 1)), z (Fin.castSucc (Fin.castSucc j)))
                + (z (Fin.castSucc (Fin.last _)) + z (Fin.last _)) :=
                Complex.ext (add_assoc _ _ _) (add_assoc _ _ _)                 -- `definition_of_cc` の和は成分ごと、`ℝ` の加法の結合律を二つの成分へ
          _ = (∑ k : Fin (n + 1), (z ⟨2 * k, by omega⟩ + z ⟨2 * k + 1, by omega⟩))
                + (z (Fin.castSucc (Fin.last _)) + z (Fin.last _)) := by
              rw [ih
                (fun j => z (Fin.castSucc (Fin.castSucc j)))]; rfl                -- 帰納法の仮定
          _ = (∑ k : Fin (n + 1), (z ⟨2 * k, by omega⟩ + z ⟨2 * k + 1, by omega⟩))
                + (z ⟨2 * (n + 1), by omega⟩ + z ⟨2 * (n + 1) + 1, by omega⟩) := rfl
                                                                                  -- `ℤ` の分配律 `2(n+1) - 1 = 2n + 1`、`2(n+1) = 2n + 2`
          _ = ∑ k : Fin (n + 2), (z ⟨2 * k, by omega⟩ + z ⟨2 * k + 1, by omega⟩) :=
              (hstep (n + 1) (by omega)
                (fun k : Fin (n + 2) => z ⟨2 * k, by omega⟩ + z ⟨2 * k + 1, by omega⟩)).symm
                                                                                  -- 帰納の式（`m → n`）を右辺から左辺へ
  -- `n = 0` の 2 行と `n ≥ 1`
  have hall : ∀ (n : ℕ) (z : Fin (2 * n) → ℂ),
      ∑ j, z j = ∑ k : Fin n, (z ⟨2 * k, by omega⟩ + z ⟨2 * k + 1, by omega⟩) := by
    intro n z
    cases n with
    | zero =>
      exact
        calc ∑ j : Fin (2 * 0), z j
            = 0 := finset_sum_fin_complex_eq_finite_sum_of_complex_numbers.1 z  -- `Σ_{j=1}^{0} z_j := 0_ℂ`
          _ = ∑ k : Fin 0, (z ⟨2 * k, by omega⟩ + z ⟨2 * k + 1, by omega⟩) :=
              (finset_sum_fin_complex_eq_finite_sum_of_complex_numbers.1 _).symm -- 同じ式を右辺から左辺へ
    | succ n => exact hsucc n z
  -- 人手の添字 `2k - 1`・`2k` の元は、Lean の `⟨2k, _⟩`・`⟨2k+1, _⟩` である（`finIndexToZZ` の単射）
  have hpk : ∀ k, p k = ⟨2 * k, by omega⟩ := fun k =>
    (finIndexToZZ_bijective_onto_index_set (2 * n)).1 _ _ (by
      have := hp k
      simp only [finIndexToZZ, inclusionNNtoZZ_eq_natCast] at this ⊢
      push_cast
      omega)
  have hqk : ∀ k, q k = ⟨2 * k + 1, by omega⟩ := fun k =>
    (finIndexToZZ_bijective_onto_index_set (2 * n)).1 _ _ (by
      have := hq k
      simp only [finIndexToZZ, inclusionNNtoZZ_eq_natCast] at this ⊢
      push_cast
      omega)
  rw [hall n z]
  exact Finset.sum_congr rfl fun k _ => by rw [hpk k, hqk k]

end Ising2D

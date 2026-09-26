/-
# 1 行ぶんのスピン配置の番号付けは全単射

対応する人手証明（正本は `structured-latex/content/001_partition_function_2d_ising.ts`）:

* `partition_function_2d_ising_claim_row_configuration_numbering_bijective`
  （ラベル **`row_configuration_numbering_bijective`**）

主張: `ord` の値はすべて `{1,…,2^{M_col}}` に属し、`ord : 𝔐 → {1,…,2^{M_col}}` は全単射。

## 人手証明との対応

人手証明の `b_m(μ) := (1-μ(m))/2` は Lean の `spinBit (μ m)`、人手の指数 `M_col - m` は
Lean の `M - 1 - m`（`m : Fin M` は人手の `m - 1`）である。

* 準備（`∑_{t=0}^{n-1} 2^t = 2^n - 1` を `n` の帰納法で）→ `geom_sum_two`。
* 中間目標「値域」→ `rowConfigOrd_mem_Icc`。
  添字の置き換え `t := M_col - m` は `Fin.revPerm` による付け替え（`sum_two_pow_rev`）。
* 中間目標「単射性」→ `rowConfigOrd_sub_pos_of_first_diff`（最小の相異なる桁 `k` で
  `b_k(μ) = 1, b_k(μ') = 0` の場合）と `rowConfigOrd_injective`（入れ替えと最小の `k` の取得）。
  残りの和の評価 `∑_{l=k+1}^{M_col} 2^{M_col-l} = 2^{M_col-k} - 1` は `tail_sum_two_pow`
  （添字の置き換え `t := M_col - l` は `Finset.sum_Ico_reflect`）。
* 中間目標「全単射性」→ `row_configuration_numbering_bijective`。
  `|𝔐| = 2^{M_col}` と、元数の等しい有限集合の間の単射は全射であることを使う。

必要十分版は置かない。整数の 2 進展開の一意性という具体的な主張であり、取り払える構造が無い。
-/
import Ising2D.Part001.DefinitionRowConfigurationNumbering
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Order.Interval.Finset.Nat
import Mathlib.Data.Int.Interval
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Tactic.Ring

namespace Ising2D

variable {M : ℕ}

/-- 人手証明の準備: `∑_{t=0}^{n-1} 2^t = 2^n - 1`（`n` の帰納法）。 -/
theorem geom_sum_two (n : ℕ) : ∑ t ∈ Finset.range n, (2 : ℤ) ^ t = 2 ^ n - 1 := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Finset.sum_range_succ, ih, pow_succ]
    ring

/-- 添字の置き換え `t := M_col - m`: `∑_{m=1}^{M_col} 2^{M_col-m} = ∑_{t=0}^{M_col-1} 2^t`。 -/
theorem sum_two_pow_rev (M : ℕ) :
    ∑ m : Fin M, (2 : ℤ) ^ (M - 1 - (m : ℕ)) = ∑ t ∈ Finset.range M, (2 : ℤ) ^ t := by
  rw [← Fin.sum_univ_eq_sum_range (fun t => (2 : ℤ) ^ t) M]
  refine Fintype.sum_equiv Fin.revPerm _ _ (fun m => ?_)
  simp only [Fin.revPerm_apply, Fin.val_rev]
  have := m.isLt
  congr 1
  omega

/-- **人手の中間目標「値域」**: `1 ≤ ord(μ) ≤ 2^{M_col}`。 -/
theorem rowConfigOrd_mem_Icc (μ : SpinConf M) :
    rowConfigOrd μ ∈ Set.Icc (1 : ℤ) (2 ^ M) := by
  have hlow : 0 ≤ ∑ m : Fin M, spinBit (μ m) * 2 ^ (M - 1 - (m : ℕ)) :=
    Finset.sum_nonneg fun m _ => mul_nonneg (spinBit_nonneg _) (by positivity)
  have hup : ∑ m : Fin M, spinBit (μ m) * 2 ^ (M - 1 - (m : ℕ)) ≤ 2 ^ M - 1 :=
    calc ∑ m : Fin M, spinBit (μ m) * 2 ^ (M - 1 - (m : ℕ))
        ≤ ∑ m : Fin M, (2 : ℤ) ^ (M - 1 - (m : ℕ)) :=
          Finset.sum_le_sum fun m _ => by
            have := spinBit_le_one (μ m)
            have : (0 : ℤ) < 2 ^ (M - 1 - (m : ℕ)) := by positivity
            nlinarith
      _ = ∑ t ∈ Finset.range M, (2 : ℤ) ^ t := sum_two_pow_rev M
      _ = 2 ^ M - 1 := geom_sum_two M
  rw [rowConfigOrd]
  exact ⟨by linarith, by linarith⟩

/-- 残りの和の評価に使う等式: `∑_{l=k+1}^{M_col} 2^{M_col-l} = 2^{M_col-k} - 1`
（Lean の添字では `k < l` の項の和）。 -/
theorem tail_sum_two_pow (k : Fin M) :
    ∑ l : Fin M, (if (k : ℕ) < l then (2 : ℤ) ^ (M - 1 - (l : ℕ)) else 0)
      = 2 ^ (M - 1 - (k : ℕ)) - 1 := by
  have hM : 1 ≤ M := k.pos
  rw [Fin.sum_univ_eq_sum_range
      (fun l : ℕ => if (k : ℕ) < l then (2 : ℤ) ^ (M - 1 - l) else 0) M,
    ← Finset.sum_filter]
  have hfilter : (Finset.range M).filter (fun l => (k : ℕ) < l) = Finset.Ico ((k : ℕ) + 1) M := by
    ext l; simp only [Finset.mem_filter, Finset.mem_range, Finset.mem_Ico]; omega
  rw [hfilter, Finset.sum_Ico_reflect (fun t => (2 : ℤ) ^ t) ((k : ℕ) + 1) (by omega : M ≤ M - 1 + 1)]
  have h1 : M - 1 + 1 - M = 0 := by omega
  have h2 : M - 1 + 1 - ((k : ℕ) + 1) = M - 1 - (k : ℕ) := by omega
  rw [h1, h2, ← Finset.range_eq_Ico, geom_sum_two]

/-- **人手の中間目標「単射性」の核心**: `μ(k) ≠ μ'(k)` となる最小の `k` で
`b_k(μ) = 1, b_k(μ') = 0` なら `ord(μ) - ord(μ') > 0`。 -/
theorem rowConfigOrd_sub_pos_of_first_diff {μ μ' : SpinConf M} (k : Fin M)
    (hlt : ∀ l : Fin M, l < k → spinBit (μ l) = spinBit (μ' l))
    (hk : spinBit (μ k) = 1) (hk' : spinBit (μ' k) = 0) :
    0 < rowConfigOrd μ - rowConfigOrd μ' := by
  set d : Fin M → ℤ := fun l => spinBit (μ l) - spinBit (μ' l) with hd
  set e : Fin M → ℤ := fun l => 2 ^ (M - 1 - (l : ℕ)) with he
  -- `ord(μ) - ord(μ') = ∑_l (b_l(μ) - b_l(μ')) 2^{M_col-l}`（定義の差を項ごとに取る）
  have hdiff : rowConfigOrd μ - rowConfigOrd μ' = ∑ l : Fin M, d l * e l := by
    rw [rowConfigOrd, rowConfigOrd, add_sub_add_left_eq_sub, ← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun l _ => by simp only [hd, he]; ring
  -- `l < k` の項は `0`、`l = k` の項を分ける（`b_k(μ) - b_k(μ') = 1`）
  have hsplit : ∀ l : Fin M, d l * e l
      = (if l = k then e k else 0) + (if (k : ℕ) < l then d l * e l else 0) := by
    intro l
    rcases lt_trichotomy l k with h | h | h
    · have h0 : d l = 0 := by simp only [hd, hlt l h, sub_self]
      rw [h0, if_neg (ne_of_lt h), if_neg (by exact Nat.not_lt.mpr (le_of_lt h)), zero_mul]
      simp
    · subst h
      have h1 : d l = 1 := by simp only [hd, hk, hk']; norm_num
      rw [if_pos rfl, if_neg (lt_irrefl _), h1, one_mul, add_zero]
    · rw [if_neg (ne_of_gt h), if_pos (show (k : ℕ) < l from h), zero_add]
  have hsum : ∑ l : Fin M, d l * e l
      = e k + ∑ l : Fin M, (if (k : ℕ) < l then d l * e l else 0) := by
    rw [Finset.sum_congr rfl fun l _ => hsplit l, Finset.sum_add_distrib, Finset.sum_ite_eq']
    simp
  -- 残りの和の絶対値は `2^{M_col-k} - 1` 以下
  have hbound : |∑ l : Fin M, (if (k : ℕ) < l then d l * e l else 0)| ≤ e k - 1 := by
    calc |∑ l : Fin M, (if (k : ℕ) < l then d l * e l else 0)|
        ≤ ∑ l : Fin M, |if (k : ℕ) < l then d l * e l else 0| :=
          Finset.abs_sum_le_sum_abs _ _
      _ ≤ ∑ l : Fin M, (if (k : ℕ) < l then e l else 0) := by
          refine Finset.sum_le_sum fun l _ => ?_
          split
          · have hd1 : |d l| ≤ 1 := by
              simp only [hd, abs_le]
              have := spinBit_nonneg (μ l); have := spinBit_le_one (μ l)
              have := spinBit_nonneg (μ' l); have := spinBit_le_one (μ' l)
              constructor <;> linarith
            have hepos : 0 < e l := by simp only [he]; positivity
            rw [abs_mul, abs_of_pos hepos]
            nlinarith [abs_nonneg (d l)]
          · simp
      _ = e k - 1 := tail_sum_two_pow k
  rw [hdiff, hsum]
  have := (abs_le.mp hbound).1
  linarith

/-- `b` は `{-1,1}` の元を決める（`b_m(μ) = 0 ⟺ μ(m) = 1`）。 -/
theorem spinVal_eq_of_spinBit_eq {s t : SpinVal} (h : spinBit s = spinBit t) : s = t := by
  apply Subtype.ext
  rcases s.2 with hs | hs <;> rcases t.2 with ht | ht
  · rw [hs, ht]
  · exfalso; rw [spinBit, spinBit, if_pos hs, if_neg (by rw [ht]; norm_num)] at h; norm_num at h
  · exfalso; rw [spinBit, spinBit, if_neg (by rw [hs]; norm_num), if_pos ht] at h; norm_num at h
  · rw [hs, ht]

/-- **人手の中間目標「単射性」**: `ord` は単射。 -/
theorem rowConfigOrd_injective : Function.Injective (rowConfigOrd (M := M)) := by
  intro μ μ' heq
  by_contra hne
  have hex : ∃ m, μ m ≠ μ' m := by
    by_contra h
    push Not at h
    exact hne (funext h)
  classical
  -- `μ(k) ≠ μ'(k)` となる最小の `k`
  let S : Finset (Fin M) := Finset.univ.filter fun m => μ m ≠ μ' m
  have hS : S.Nonempty := by
    obtain ⟨m, hm⟩ := hex
    exact ⟨m, Finset.mem_filter.mpr ⟨Finset.mem_univ _, hm⟩⟩
  let k := S.min' hS
  have hkS : μ k ≠ μ' k := (Finset.mem_filter.mp (S.min'_mem hS)).2
  have hlt : ∀ l : Fin M, l < k → spinBit (μ l) = spinBit (μ' l) := by
    intro l hl
    by_contra hbl
    have hlS : l ∈ S :=
      Finset.mem_filter.mpr ⟨Finset.mem_univ _, fun h => hbl (by rw [h])⟩
    exact absurd (S.min'_le l hlS) (not_le.mpr hl)
  have hbk : spinBit (μ k) ≠ spinBit (μ' k) := fun h => hkS (spinVal_eq_of_spinBit_eq h)
  -- 必要なら `μ` と `μ'` を入れ替えて `b_k(μ) = 1, b_k(μ') = 0` とする
  have h01 : ∀ s : SpinVal, spinBit s = 0 ∨ spinBit s = 1 := fun s => by
    unfold spinBit; split <;> simp
  rcases h01 (μ k) with h0 | h1
  · have h1' : spinBit (μ' k) = 1 := by
      rcases h01 (μ' k) with h | h
      · exact absurd (h0.trans h.symm) hbk
      · exact h
    have := rowConfigOrd_sub_pos_of_first_diff k (fun l hl => (hlt l hl).symm) h1' h0
    rw [heq, sub_self] at this
    exact lt_irrefl _ this
  · have h0' : spinBit (μ' k) = 0 := by
      rcases h01 (μ' k) with h | h
      · exact h
      · exact absurd (h1.trans h.symm) hbk
    have := rowConfigOrd_sub_pos_of_first_diff k hlt h1 h0'
    rw [heq, sub_self] at this
    exact lt_irrefl _ this

/-- 人手の `|𝔐| = 2^{M_col}`。 -/
theorem card_spinConf (M : ℕ) : Fintype.card (SpinConf M) = 2 ^ M := by
  rw [Fintype.card_fun, card_spinVal, Fintype.card_fin]

/-- **人手 `row_configuration_numbering_bijective`**:
`ord : 𝔐 → {1,…,2^{M_col}}` は全単射。 -/
theorem row_configuration_numbering_bijective :
    Set.BijOn (rowConfigOrd (M := M)) Set.univ (Set.Icc 1 (2 ^ M)) := by
  classical
  refine ⟨fun μ _ => rowConfigOrd_mem_Icc μ, rowConfigOrd_injective.injOn, ?_⟩
  -- 全単射性: 元数の等しい有限集合の間の単射は全射
  have hsub : Finset.univ.image (rowConfigOrd (M := M)) ⊆ Finset.Icc 1 (2 ^ M) := by
    intro x hx
    obtain ⟨μ, -, rfl⟩ := Finset.mem_image.mp hx
    exact Finset.mem_Icc.mpr (rowConfigOrd_mem_Icc μ)
  have hcard : (Finset.Icc (1 : ℤ) (2 ^ M)).card ≤ (Finset.univ.image (rowConfigOrd (M := M))).card := by
    rw [Finset.card_image_of_injective _ rowConfigOrd_injective, Finset.card_univ, card_spinConf,
      Int.card_Icc]
    simp
  have heq := Finset.eq_of_subset_of_card_le hsub hcard
  intro x hx
  have hx' : x ∈ Finset.Icc (1 : ℤ) (2 ^ M) := Finset.mem_Icc.mpr hx
  rw [← heq] at hx'
  obtain ⟨μ, -, hμ⟩ := Finset.mem_image.mp hx'
  exact ⟨μ, Set.mem_univ _, hμ⟩

end Ising2D

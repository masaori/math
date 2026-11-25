/-
# クロネッカー積の番号付け `ν : 𝓘_M → {1,…,2^M}` とその逆写像 `ν^{-1}`（具体版）

正本: `structured-latex/content/002_linear_space_general.ts`
（`linear_space_general_000_definition_kronecker_product`、ラベル **`def_kronecker`** の `ν` とその全単射性の証明、
`linear_space_general_000_definition_inverse_of_kronecker_numbering`、ラベル **`def_inverse_of_kronecker_numbering`**）

## 人手との対応

| 人手 | Lean |
| --- | --- |
| `ν(I) := 1 + Σ_{k=1}^{M} (i_k - 1) 2^{M-k}` | `kroneckerNumbering` |
| `def_kronecker` の証明 Step 1（`#𝓘_M = 2^M` を `M` の帰納法で。`𝓘_{M+1}` の元と組 `(i_{M+1}, I)` の一対一対応による 3 行の鎖。本文は組を `(I, i_{M+1})` と書く） | `exists_inverse_of_kronecker_numbering` の `hcardAll`（対応は名前を付けた写像 `Fin.snocEquiv`。Lean の基底は `M = 0`） |
| 同じく Step 2 の準備（`Σ_{t=0}^{n-1} 2^t = 2^n - 1`） | `geom_sum_two`（添字の置き換え `t := M - k` は `sum_two_pow_rev`） |
| 同じく Step 2（値域 `1 ≤ ν(I) ≤ 2^M`） | `exists_inverse_of_kronecker_numbering` の `hrange` |
| 同じく Step 3 の二つの鎖（最小の相異なる成分 `k` で `i_k = 2, j_k = 1` なら `ν(I) - ν(J) > 0`。残りの和の評価は `tail_sum_two_pow`） | `kronecker_numbering_injective` の `hpos` |
| 同じく Step 3 の単射性（入れ替えと最小の `k` の取得） | `kronecker_numbering_injective` |
| 同じく Step 3 の全単射性（元数の等しい有限集合の間の単射は全射） | `exists_inverse_of_kronecker_numbering` の `hsurj` |
| `def_inverse_of_kronecker_numbering` の `ν^{-1}` | `exists_inverse_of_kronecker_numbering` の `σ` |

- 人手の `𝓘_M = {1,2}^M` は Lean の `Conf M = Fin M → Fin 2` である。人手の成分 `i_k ∈ {1,2}` は Lean の `I (k - 1) : Fin 2` を
  写像 `finIndexToZZ 2` で送った値で、人手の `i_k - 1` は Lean の `((I (k - 1) : ℕ) : ℤ)` である（`finIndexToZZ 2 i = ι_{ℕ→ℤ}(i.val) + 1`）。
  人手の指数 `M - k` は Lean の添字 `m : Fin M`（人手の `k - 1`）で `M - 1 - m` である。
- `ν^{-1}` が在ること（`def_inverse_of_kronecker_numbering`）は、`ν` の値が全て `{1,…,n}` の元の像で、`{1,…,n}` の全ての元の像が `ν` の値であるような
  `n`（すなわち `n = 2^M`）と、`ν(σ(k)) = finIndexToZZ n k` を満たす `σ : Fin n → Conf M` が在ることとして述べる。
  `n` を `2^M` と書かずに条件で定めるのは、主張の型に ℕ・ℤ の冪の記号を持ち込まないためである
  （`DefinitionFiniteSumOverRowConfigurations.lean` の `ord^{-1}` と同じ）。
- `def_kronecker` の証明の Step 1・Step 2・Step 3 の全単射性は、主張の型に冪と区間の記号を出さないよう、
  宣言を立てずに `exists_inverse_of_kronecker_numbering` の証明の中の段として書く。Step 3 の単射性は型に冪が出ないので
  `kronecker_numbering_injective` とし、`ν^{-1}` による和の付け替え（`DefinitionFiniteSumOverMultiIndices.lean`）も使う。
- `1 行ぶんのスピン配置の番号付け ord` の全単射性（`row_configuration_numbering_bijective`）の証明も同じ論法で、
  準備の `geom_sum_two`・`sum_two_pow_rev`・`tail_sum_two_pow` はこのファイルのものを使う（人手は同じ準備を `ord` の証明で書き直している）。

必要十分版は置かない。整数の 2 進展開の一意性という具体的な主張であり、取り払える構造が無い。
-/
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Order.Interval.Finset.Nat
import Mathlib.Data.Int.Interval
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.FinCases
import Ising2D.Basic
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionIndexSetFromOneToN

namespace Ising2D

variable {M : ℕ}

/-- 人手 `def_kronecker` の番号付け `ν(I) := 1 + ∑_{k=1}^{M} (i_k - 1) 2^{M-k}`。
Lean の成分 `I m : Fin 2` は 0 始まりなので人手の `i_m - 1` にあたり、
人手の指数 `M - k` は Lean の添字 `m : Fin M`（人手の `k - 1`）で `M - 1 - m` である。 -/
def kroneckerNumbering (I : Conf M) : ℤ :=
  1 + ∑ m : Fin M, (((I m : Fin 2) : ℕ) : ℤ) * 2 ^ (M - 1 - (m : ℕ))

/-- `def_kronecker` の証明 Step 2 の準備: `∑_{t=0}^{n-1} 2^t = 2^n - 1`（`n` の帰納法）。 -/
theorem geom_sum_two (n : ℕ) : ∑ t ∈ Finset.range n, (2 : ℤ) ^ t = 2 ^ n - 1 := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Finset.sum_range_succ, ih, pow_succ]
    ring

/-- 添字の置き換え `t := M - k`: `∑_{k=1}^{M} 2^{M-k} = ∑_{t=0}^{M-1} 2^t`。 -/
theorem sum_two_pow_rev (M : ℕ) :
    ∑ m : Fin M, (2 : ℤ) ^ (M - 1 - (m : ℕ)) = ∑ t ∈ Finset.range M, (2 : ℤ) ^ t := by
  rw [← Fin.sum_univ_eq_sum_range (fun t => (2 : ℤ) ^ t) M]
  refine Fintype.sum_equiv Fin.revPerm _ _ (fun m => ?_)
  simp only [Fin.revPerm_apply, Fin.val_rev]
  have := m.isLt
  congr 1
  omega

/-- 残りの和の評価に使う等式: `∑_{l=k+1}^{M} 2^{M-l} = 2^{M-k} - 1`
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

/-- **人手 `def_kronecker` の証明 Step 3 の単射性**: `ν(I) = ν(J)` なら `I = J`。
最小の相異なる成分 `k` で `i_k = 2, j_k = 1` なら `ν(I) - ν(J) > 0`（Step 3 の二つの鎖）を示し、必要なら `I` と `J` を入れ替えて使う。 -/
theorem kronecker_numbering_injective :
    ∀ I J : Conf M, kroneckerNumbering I = kroneckerNumbering J → I = J := by
  classical
  -- 人手の `i_k - 1 ∈ {0, 1}`（Lean の成分 `I m : Fin 2` の値）
  have hdig0 : ∀ i : Fin 2, (0 : ℤ) ≤ ((i : ℕ) : ℤ) := fun i => Int.natCast_nonneg _
  have hdig1 : ∀ i : Fin 2, ((i : ℕ) : ℤ) ≤ 1 := fun i => by have := i.isLt; omega
  -- Step 3 の二つの鎖: 最小の相異なる成分 `k` で `i_k = 2, j_k = 1` なら `ν(I) - ν(J) > 0`
  have hpos : ∀ (I J : Conf M) (k : Fin M), (∀ l : Fin M, l < k → I l = J l) →
      I k = 1 → J k = 0 → 0 < kroneckerNumbering I - kroneckerNumbering J := by
    intro I J k hlt hk hk'
    set d : Fin M → ℤ := fun l => (((I l : Fin 2) : ℕ) : ℤ) - (((J l : Fin 2) : ℕ) : ℤ) with hd
    set e : Fin M → ℤ := fun l => 2 ^ (M - 1 - (l : ℕ)) with he
    -- `ν(I) - ν(J) = Σ_l (i_l - j_l) 2^{M-l}`（`ν` の定義、和の差を項ごとに取る）
    have hdiff : kroneckerNumbering I - kroneckerNumbering J = ∑ l : Fin M, d l * e l := by
      rw [kroneckerNumbering, kroneckerNumbering, add_sub_add_left_eq_sub, ← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun l _ => by simp only [hd, he]; ring
    -- `l < k` の項は `0`、`l = k` の項を分ける（`i_k - j_k = 2 - 1 = 1`）
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
    -- 残りの和の絶対値は `2^{M-k} - 1` 以下（`i_l - j_l ∈ {-1, 0, 1}`）
    have hbound : |∑ l : Fin M, (if (k : ℕ) < l then d l * e l else 0)| ≤ e k - 1 := by
      calc |∑ l : Fin M, (if (k : ℕ) < l then d l * e l else 0)|
          ≤ ∑ l : Fin M, |if (k : ℕ) < l then d l * e l else 0| :=
            Finset.abs_sum_le_sum_abs _ _                                     -- 三角不等式
        _ ≤ ∑ l : Fin M, (if (k : ℕ) < l then e l else 0) := by
            refine Finset.sum_le_sum fun l _ => ?_
            split
            · have hd1 : |d l| ≤ 1 := by
                simp only [hd, abs_le]
                have := hdig0 (I l); have := hdig1 (I l)
                have := hdig0 (J l); have := hdig1 (J l)
                constructor <;> linarith
              have hepos : 0 < e l := by simp only [he]; positivity
              rw [abs_mul, abs_of_pos hepos]
              nlinarith [abs_nonneg (d l)]                                    -- 各項で `|i_l - j_l| ≤ 1` かつ `2^{M-l} > 0`
            · simp
        _ = e k - 1 := tail_sum_two_pow k                                     -- 添字の置き換えと Step 2 の準備
    rw [hdiff, hsum]
    have := (abs_le.mp hbound).1
    linarith
  -- 単射性（必要なら `I` と `J` を入れ替え、`i_k ≠ j_k` となる最小の `k` を取る）
  intro I J heq
  by_contra hne
  have hex : ∃ m, I m ≠ J m := by
    by_contra h
    push Not at h
    exact hne (funext h)
  let S : Finset (Fin M) := Finset.univ.filter fun m => I m ≠ J m
  have hS : S.Nonempty := by
    obtain ⟨m, hm⟩ := hex
    exact ⟨m, Finset.mem_filter.mpr ⟨Finset.mem_univ _, hm⟩⟩
  let k := S.min' hS
  have hkS : I k ≠ J k := (Finset.mem_filter.mp (S.min'_mem hS)).2
  have hlt : ∀ l : Fin M, l < k → I l = J l := by
    intro l hl
    by_contra hbl
    have hlS : l ∈ S := Finset.mem_filter.mpr ⟨Finset.mem_univ _, hbl⟩
    exact absurd (S.min'_le l hlS) (not_le.mpr hl)
  have h01 : ∀ i : Fin 2, i = 0 ∨ i = 1 := fun i => by fin_cases i <;> simp
  rcases h01 (I k) with h0 | h1
  · have h1' : J k = 1 := by
      rcases h01 (J k) with h | h
      · exact absurd (h0.trans h.symm) hkS
      · exact h
    have := hpos J I k (fun l hl => (hlt l hl).symm) h1' h0
    rw [heq, sub_self] at this
    exact lt_irrefl _ this
  · have h0' : J k = 0 := by
      rcases h01 (J k) with h | h
      · exact h
      · exact absurd (h1.trans h.symm) hkS
    have := hpos I J k hlt h1 h0'
    rw [heq, sub_self] at this
    exact lt_irrefl _ this

/-- **`def_inverse_of_kronecker_numbering`**: 人手の `ν^{-1} : {1,…,2^M} → 𝓘_M` は在る。
Lean の添字 `k : Fin n` の像 `finIndexToZZ n k` を人手の添字とし、`n` を `2^M` と書く代わりに
「`ν` の値は全て `{1,…,n}` の元の像であり、`{1,…,n}` の全ての元の像は `ν` の値である」という条件で定める
（主張の型に冪の記号を出さないため。`def_kronecker` の証明の Step 1〜3 から `n = 2^M` に決まる）。
`σ : Fin n → Conf M` が人手の `ν^{-1}` で、`ν(σ(k)) = finIndexToZZ n k` を満たす（`ν` は単射なので一つに決まる）。
証明の前半は `def_kronecker` の証明の Step 1〜3（`ν` が全単射であること）である。 -/
theorem exists_inverse_of_kronecker_numbering (M : ℕ) :
    ∃ (n : ℕ) (σ : Fin n → Conf M),
      (∀ I : Conf M, ∃ k : Fin n, kroneckerNumbering I = finIndexToZZ n k) ∧
        ∀ k, kroneckerNumbering (σ k) = finIndexToZZ n k := by
  classical
  -- 人手の `i_k - 1 ∈ {0, 1}`（Lean の成分 `I m : Fin 2` の値）
  have hdig0 : ∀ i : Fin 2, (0 : ℤ) ≤ ((i : ℕ) : ℤ) := fun i => Int.natCast_nonneg _
  have hdig1 : ∀ i : Fin 2, ((i : ℕ) : ℤ) ≤ 1 := fun i => by have := i.isLt; omega
  -- Step 1: `#𝓘_M = 2^M`（`M` の帰納法。Lean は本文の範囲外の `M = 0`（元は空の組ひとつ）を基底にし、
  -- 本文の基底 `M = 1` は帰納の一段目にあたる）
  have hcardAll : ∀ N : ℕ, Fintype.card (Conf N) = 2 ^ N := by
    intro N
    induction N with
    | zero => simp
    | succ N ih =>
      calc Fintype.card (Conf (N + 1))
          = Fintype.card (Fin 2 × Conf N) :=
            (Fintype.card_congr (Fin.snocEquiv (fun _ => Fin 2))).symm      -- 𝓘_{N+1} の元と `(i_{N+1}, I)` の一対一対応
        _ = Fintype.card (Conf N) * 2 := by
            rw [Fintype.card_prod, Fintype.card_fin, mul_comm]              -- `I` が `#𝓘_N` 通り、`i_{N+1}` が 2 通り
        _ = 2 ^ N * 2 := by rw [ih]                                         -- 帰納法の仮定 `#𝓘_N = 2^N`
        _ = 2 ^ (N + 1) := (pow_succ 2 N).symm                              -- 指数法則 `2^N · 2 = 2^{N+1}`
  have hcard : Fintype.card (Conf M) = 2 ^ M := hcardAll M
  -- Step 2: 値域 `1 ≤ ν(I) ≤ 2^M`
  have hrange : ∀ I : Conf M, 1 ≤ kroneckerNumbering I ∧ kroneckerNumbering I ≤ 2 ^ M := by
    intro I
    have hlow : 0 ≤ ∑ m : Fin M, (((I m : Fin 2) : ℕ) : ℤ) * 2 ^ (M - 1 - (m : ℕ)) :=
      Finset.sum_nonneg fun m _ => mul_nonneg (hdig0 _) (by positivity)
                                                                              -- 各項は `0 ≤ i_k - 1` と `2^{M-k} > 0` の積で非負
    have hup : ∑ m : Fin M, (((I m : Fin 2) : ℕ) : ℤ) * 2 ^ (M - 1 - (m : ℕ)) ≤ 2 ^ M - 1 :=
      calc ∑ m : Fin M, (((I m : Fin 2) : ℕ) : ℤ) * 2 ^ (M - 1 - (m : ℕ))
          ≤ ∑ m : Fin M, (2 : ℤ) ^ (M - 1 - (m : ℕ)) :=
            Finset.sum_le_sum fun m _ => by
              have := hdig1 (I m)
              have : (0 : ℤ) < 2 ^ (M - 1 - (m : ℕ)) := by positivity
              nlinarith                                                       -- 各項で `i_k - 1 ≤ 1` かつ `2^{M-k} > 0`
        _ = ∑ t ∈ Finset.range M, (2 : ℤ) ^ t := sum_two_pow_rev M           -- 添字の置き換え `t := M - k`
        _ = 2 ^ M - 1 := geom_sum_two M                                       -- 上の `Σ_{t=0}^{n-1} 2^t = 2^n - 1` を `n := M` で
    rw [kroneckerNumbering]
    exact ⟨by linarith, by linarith⟩
  -- Step 3: 全単射性（Step 1 より元数が等しい有限集合の間の単射は全射）
  have hsurj : ∀ x : ℤ, 1 ≤ x → x ≤ 2 ^ M → ∃ I : Conf M, kroneckerNumbering I = x := by
    have hsub : Finset.univ.image (kroneckerNumbering (M := M)) ⊆ Finset.Icc 1 (2 ^ M) := by
      intro x hx
      obtain ⟨I, -, rfl⟩ := Finset.mem_image.mp hx
      exact Finset.mem_Icc.mpr (hrange I)
    have hcardle : (Finset.Icc (1 : ℤ) (2 ^ M)).card
        ≤ (Finset.univ.image (kroneckerNumbering (M := M))).card := by
      rw [Finset.card_image_of_injective _ (fun I J h => kronecker_numbering_injective I J h), Finset.card_univ, hcard,
        Int.card_Icc]
      simp
    have heqs := Finset.eq_of_subset_of_card_le hsub hcardle
    intro x hx1 hx2
    have hx' : x ∈ Finset.Icc (1 : ℤ) (2 ^ M) := Finset.mem_Icc.mpr ⟨hx1, hx2⟩
    rw [← heqs] at hx'
    obtain ⟨I, -, hI⟩ := Finset.mem_image.mp hx'
    exact ⟨I, hI⟩
  -- `ν^{-1}`: `n := 2^M` の添字 `k` ごとに `ν(σ(k)) = k` の `σ(k)` を取る
  have hn : inclusionNNtoZZ (2 ^ M) = (2 : ℤ) ^ M := by
    rw [inclusionNNtoZZ_eq_natCast]; push_cast; rfl
  have hord : ∀ I : Conf M, ∃ k : Fin (2 ^ M), kroneckerNumbering I = finIndexToZZ (2 ^ M) k := by
    intro I
    obtain ⟨k, hk⟩ := (finIndexToZZ_bijective_onto_index_set (2 ^ M)).2.2 _ (hrange I).1
      (hn ▸ (hrange I).2)
    exact ⟨k, hk.symm⟩
  have hinv : ∀ k : Fin (2 ^ M), ∃ I : Conf M, kroneckerNumbering I = finIndexToZZ (2 ^ M) k := by
    intro k
    have h := (finIndexToZZ_bijective_onto_index_set (2 ^ M)).2.1 k
    rw [hn] at h
    exact hsurj _ h.1 h.2
  choose σ hσ using hinv
  exact ⟨2 ^ M, σ, hord, hσ⟩

end Ising2D

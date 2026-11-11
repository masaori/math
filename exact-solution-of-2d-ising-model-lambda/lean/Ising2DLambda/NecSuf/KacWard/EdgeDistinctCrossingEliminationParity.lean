/-
「横断消去の帰納法は位相と切断線偶奇と交差形式を保つ」（`claim_edge_distinct_crossing_elimination_parity`）の
必要十分版。具体版 `edge_distinct_crossing_elimination_parity` と同じ手順（横断数についての整礎帰納法、
基底は自分自身の一項の族、帰納段は一回の分割と二本への帰納法の仮定と族の連結）で、格子・辺列・平滑化の
構成を使わない。使うのは次だけである。
- 対象は任意の型 `W`、その上の性質 `good`（具体版では辺の標識が相異なること）。分割の子も `good` で
  あることを仮定に含める（帰納法を子へ適用するために要る）。
- 横断数は `c : W → ℕ`。自然数であることは整礎帰納法にだけ使う。
- 辺の台は任意の型 `E`（等号が決定可能）の有限集合。合併と互いに素性だけを使う。
- 回転数の値は加法可換モノイド `T`。和の分割と並べ替えだけを使う。
- 切断線偶奇は加法可換モノイド `M` の値 `sH`・`sV` を読み取り `read : M → P` で読んだもの（具体版では
  ℕ と二で割った余り）。`read` に要るのは、読みが等しい二つの値に同じ値を足しても読みが等しいこと
  （`hread`。具体版では `Nat.add_mod`）だけである。これが無いと、二本への帰納法の仮定（読みの等式）を
  和の読みへ運べない。
- 横断数の偶奇の値は `AddCommMonoidWithOne` の `R`（具体版では 𝔽₂）。自然数の像と加法だけを使い、
  `1 + 1 = 0` も積も使わない。
- 交差形式 `I` は任意の二変数写像で、互いに素な二つの台の合併に各引数で分配し（`hIunionL`・`hIunionR`）、
  空の台では零である（`hIemptyL`・`hIemptyR`）。空の台の零は、列の合併を空の列から積み上げるために要る
  （加法の消去律が無いので、合併への分配からは従わない）。
- 分割 `hsplit`: `good` で横断数が正なら、`good` な二つの子があり、横断数の和は元より小さく、台は互いに素で
  合併は元の台、回転数の和・切断線偶奇の読みは元と等しく、`c(w) = c(a) + c(b) + 1 + I(C_a, C_b)`（`R`）。
-/
import Mathlib.Algebra.BigOperators.Group.List.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Data.Nat.Cast.Defs
import Mathlib.Tactic.Abel
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.KacWard

variable {W E T M P R : Type*} [DecidableEq E]

/-- 有限集合の列の合併。 -/
def finsetListUnion : List (Finset E) → Finset E
  | [] => ∅
  | C :: Cs => C ∪ finsetListUnion Cs

/-- 列の対ごとの和 `Σ_{i<j} I(C_i, C_j)`。 -/
def finsetListPairSum [AddCommMonoid R] (I : Finset E → Finset E → R) : List (Finset E) → R
  | [] => 0
  | C :: Cs => (Cs.map fun D => I C D).sum + finsetListPairSum I Cs

/-- 二つの列の間の和 `Σ_i Σ_j I(C_i, D_j)`。 -/
def finsetListCrossSum [AddCommMonoid R] (I : Finset E → Finset E → R)
    (Cs Ds : List (Finset E)) : R :=
  (Cs.map fun C => (Ds.map fun D => I C D).sum).sum

theorem finsetListUnion_append (Cs Ds : List (Finset E)) :
    finsetListUnion (Cs ++ Ds) = finsetListUnion Cs ∪ finsetListUnion Ds := by
  induction Cs with
  | nil => simp [finsetListUnion]
  | cons C Cs ih => simp [finsetListUnion, ih, Finset.union_assoc]

theorem subset_finsetListUnion {Cs : List (Finset E)} {C : Finset E} (h : C ∈ Cs) :
    C ⊆ finsetListUnion Cs := by
  induction Cs with
  | nil => simp at h
  | cons D Cs ih =>
    rcases List.mem_cons.mp h with rfl | h
    · exact Finset.subset_union_left
    · exact (ih h).trans Finset.subset_union_right

theorem disjoint_finsetListUnion {C : Finset E} {Ds : List (Finset E)}
    (h : ∀ D ∈ Ds, Disjoint C D) : Disjoint C (finsetListUnion Ds) := by
  induction Ds with
  | nil => simp [finsetListUnion]
  | cons D Ds ih =>
    simp only [finsetListUnion, Finset.disjoint_union_right]
    exact ⟨h D List.mem_cons_self, ih fun D' hD' => h D' (List.mem_cons_of_mem _ hD')⟩

omit [DecidableEq E] in
theorem finsetListPairSum_append [AddCommMonoid R] (I : Finset E → Finset E → R)
    (Cs Ds : List (Finset E)) :
    finsetListPairSum I (Cs ++ Ds) =
      finsetListPairSum I Cs + finsetListPairSum I Ds + finsetListCrossSum I Cs Ds := by
  induction Cs with
  | nil => simp [finsetListPairSum, finsetListCrossSum]
  | cons C Cs ih =>
    simp only [List.cons_append, finsetListPairSum, ih, finsetListCrossSum,
      List.map_append, List.sum_append, List.map_cons, List.sum_cons]
    abel

section Intersection

variable [AddCommMonoid R] (I : Finset E → Finset E → R)

theorem finsetListUnion_left (hIemptyL : ∀ D, I ∅ D = 0)
    (hIunionL : ∀ C₁ C₂ D, Disjoint C₁ C₂ → I (C₁ ∪ C₂) D = I C₁ D + I C₂ D)
    {Cs : List (Finset E)} (hCs : Cs.Pairwise Disjoint) (D : Finset E) :
    I (finsetListUnion Cs) D = (Cs.map fun C => I C D).sum := by
  induction Cs with
  | nil => simp [finsetListUnion, hIemptyL]
  | cons C Cs ih =>
    obtain ⟨hC, hCs'⟩ := List.pairwise_cons.mp hCs
    simp only [finsetListUnion, List.map_cons, List.sum_cons]
    rw [hIunionL _ _ _ (disjoint_finsetListUnion hC), ih hCs']

theorem finsetListUnion_right (hIemptyR : ∀ C, I C ∅ = 0)
    (hIunionR : ∀ C D₁ D₂, Disjoint D₁ D₂ → I C (D₁ ∪ D₂) = I C D₁ + I C D₂)
    (C : Finset E) {Ds : List (Finset E)} (hDs : Ds.Pairwise Disjoint) :
    I C (finsetListUnion Ds) = (Ds.map fun D => I C D).sum := by
  induction Ds with
  | nil => simp [finsetListUnion, hIemptyR]
  | cons D Ds ih =>
    obtain ⟨hD, hDs'⟩ := List.pairwise_cons.mp hDs
    simp only [finsetListUnion, List.map_cons, List.sum_cons]
    rw [hIunionR _ _ _ (disjoint_finsetListUnion hD), ih hDs']

end Intersection

/-- 必要十分版: 分割の公理だけから、横断のない族への分解が本文の四つの量を保つ。 -/
theorem crossing_elimination_family_necSuf [AddCommMonoid T] [AddCommMonoid M]
    [AddCommMonoidWithOne R]
    (good : W → Prop) (supp : W → Finset E) (c : W → ℕ) (t : W → T)
    (sH sV : W → M) (read : M → P) (I : Finset E → Finset E → R)
    (hread : ∀ x x' y : M, read x = read x' → read (x + y) = read (x' + y))
    (hIemptyL : ∀ D, I ∅ D = 0) (hIemptyR : ∀ C, I C ∅ = 0)
    (hIunionL : ∀ C₁ C₂ D, Disjoint C₁ C₂ → I (C₁ ∪ C₂) D = I C₁ D + I C₂ D)
    (hIunionR : ∀ C D₁ D₂, Disjoint D₁ D₂ → I C (D₁ ∪ D₂) = I C D₁ + I C D₂)
    (hsplit : ∀ w, good w → 0 < c w → ∃ a b, good a ∧ good b ∧ c a + c b < c w ∧
      Disjoint (supp a) (supp b) ∧ supp a ∪ supp b = supp w ∧ t a + t b = t w ∧
      read (sH a + sH b) = read (sH w) ∧ read (sV a + sV b) = read (sV w) ∧
      (c w : R) = ((c a + c b + 1 : ℕ) : R) + I (supp a) (supp b))
    (w : W) (hw : good w) :
    ∃ ds : List W, ds ≠ [] ∧ (ds.map supp).Pairwise Disjoint ∧
      finsetListUnion (ds.map supp) = supp w ∧ (∀ d ∈ ds, c d = 0) ∧
      (ds.map t).sum = t w ∧
      (read (ds.map sH).sum, read (ds.map sV).sum) = (read (sH w), read (sV w)) ∧
      (c w : R) = ((ds.length - 1 : ℕ) : R) + finsetListPairSum I (ds.map supp) := by
  -- 読みの等式を和の二つの項へ運ぶ
  have hread2 : ∀ x x' y y' : M, read x = read x' → read y = read y' →
      read (x + y) = read (x' + y') := by
    intro x x' y y' hx hy
    rw [hread x x' y hx, add_comm x' y, add_comm x' y', hread y y' x' hy]
  -- c(w) ∈ ℕ に関する整礎帰納法
  suffices H : ∀ N : ℕ, ∀ w, good w → c w = N → ∃ ds : List W, ds ≠ [] ∧
      (ds.map supp).Pairwise Disjoint ∧ finsetListUnion (ds.map supp) = supp w ∧
      (∀ d ∈ ds, c d = 0) ∧ (ds.map t).sum = t w ∧
      (read (ds.map sH).sum, read (ds.map sV).sum) = (read (sH w), read (sV w)) ∧
      (c w : R) = ((ds.length - 1 : ℕ) : R) + finsetListPairSum I (ds.map supp) from
    H _ w hw rfl
  intro N
  induction N using Nat.strong_induction_on with
  | _ N ih =>
  intro w hw hN
  rcases Nat.eq_zero_or_pos N with h0 | hpos
  · -- 基底: 自分自身の一項の族
    refine ⟨[w], List.cons_ne_nil _ _, List.pairwise_singleton _ _, ?_, ?_, ?_, ?_, ?_⟩
    · simp [finsetListUnion]
    · intro d hd
      rw [List.mem_singleton.mp hd]
      exact hN.trans h0
    · simp
    · simp
    · simp [finsetListPairSum, hN, h0]
  · -- 一回の分割
    obtain ⟨a, b, ha, hb, hdesc, hABdisj, hABunion, hturn, hsHab, hsVab, hcross⟩ :=
      hsplit w hw (hN ▸ hpos)
    -- 二本への帰納法の仮定
    obtain ⟨αs, hαne, hαdisj, hαunion, hαzero, hαturn, hαseam, hαcross⟩ :=
      ih _ (hN ▸ lt_of_le_of_lt (Nat.le_add_right _ _) hdesc) a ha rfl
    obtain ⟨βs, hβne, hβdisj, hβunion, hβzero, hβturn, hβseam, hβcross⟩ :=
      ih _ (hN ▸ lt_of_le_of_lt (Nat.le_add_left _ _) hdesc) b hb rfl
    -- 両族を連結する
    refine ⟨αs ++ βs, by simp [hαne], ?_, ?_, ?_, ?_, ?_, ?_⟩
    · rw [List.map_append, List.pairwise_append]
      refine ⟨hαdisj, hβdisj, fun C hC D hD => ?_⟩
      have hCA : C ⊆ supp a := hαunion ▸ subset_finsetListUnion hC
      have hDB : D ⊆ supp b := hβunion ▸ subset_finsetListUnion hD
      exact Finset.disjoint_of_subset_left hCA (Finset.disjoint_of_subset_right hDB hABdisj)
    · rw [List.map_append, finsetListUnion_append, hαunion, hβunion, hABunion]
    · intro d hd
      rcases List.mem_append.mp hd with h | h
      · exact hαzero d h
      · exact hβzero d h
    · calc ((αs ++ βs).map t).sum = (αs.map t).sum + (βs.map t).sum := by
            rw [List.map_append, List.sum_append]
        _ = t a + t b := by rw [hαturn, hβturn]
        _ = t w := hturn
    · have hαh := congrArg Prod.fst hαseam
      have hαv := congrArg Prod.snd hαseam
      have hβh := congrArg Prod.fst hβseam
      have hβv := congrArg Prod.snd hβseam
      simp only at hαh hαv hβh hβv
      calc (read ((αs ++ βs).map sH).sum, read ((αs ++ βs).map sV).sum)
          = (read ((αs.map sH).sum + (βs.map sH).sum),
              read ((αs.map sV).sum + (βs.map sV).sum)) := by
            rw [List.map_append, List.sum_append, List.map_append, List.sum_append]
        _ = (read (sH a + sH b), read (sV a + sV b)) := by
            rw [hread2 _ _ _ _ hαh hβh, hread2 _ _ _ _ hαv hβv]
        _ = (read (sH w), read (sV w)) := by rw [hsHab, hsVab]
    · have hp : 1 ≤ αs.length := List.length_pos_iff.mpr hαne
      have hq : 1 ≤ βs.length := List.length_pos_iff.mpr hβne
      have hlen : (αs ++ βs).length - 1 = (αs.length - 1) + (βs.length - 1) + 1 := by
        rw [List.length_append]; omega
      have hdist : I (supp a) (supp b) = finsetListCrossSum I (αs.map supp) (βs.map supp) := by
        rw [← hαunion, ← hβunion, finsetListUnion_left I hIemptyL hIunionL hαdisj,
          finsetListCrossSum]
        congr 1
        exact List.map_congr_left fun C _ => finsetListUnion_right I hIemptyR hIunionR C hβdisj
      calc (c w : R) = ((c a + c b + 1 : ℕ) : R) + I (supp a) (supp b) := hcross
        _ = (((αs.length - 1 : ℕ) : R) + finsetListPairSum I (αs.map supp))
              + (((βs.length - 1 : ℕ) : R) + finsetListPairSum I (βs.map supp)) + 1
              + finsetListCrossSum I (αs.map supp) (βs.map supp) := by
            rw [Nat.cast_add, Nat.cast_add, Nat.cast_one, ← hαcross, ← hβcross, hdist]
        _ = (((αs ++ βs).length - 1 : ℕ) : R) + finsetListPairSum I ((αs ++ βs).map supp) := by
            rw [hlen, List.map_append, finsetListPairSum_append, Nat.cast_add, Nat.cast_add,
              Nat.cast_one]
            abel

end Ising2DLambda.NecSuf.KacWard

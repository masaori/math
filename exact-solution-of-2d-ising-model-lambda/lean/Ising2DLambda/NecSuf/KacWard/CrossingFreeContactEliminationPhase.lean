/-
「横断のない閉歩道の回転位相は頂点単純閉路族の位相と交差形式に還元される」
（`claim_crossing_free_contact_elimination_phase`）の必要十分版。具体版 `crossing_free_contact_elimination_phase`
と同じ手順（接触対数についての整礎帰納法、基底は自分自身の一項の族、帰納段は一回の接触点分割と二本への
帰納法の仮定と族の連結）で、格子・辺列・接触点分割の構成を使わない。使うのは次だけである。
- 対象は任意の型 `W`、その上の性質 `good`（具体版では辺の標識が相異なり横断数が零であること）。
  分割の子も `good` であることを仮定に含める（帰納法を子へ適用するために要る）。
- 接触対数は `n : W → ℕ`。自然数であることは整礎帰納法にだけ使い、結論の各子で `n = 0` を返す
  （具体版はこれを通過する頂点の相異へ読み替える）。
- 辺の台・交差形式・切断線偶奇の読みは、横断消去の帰納法の必要十分版
  （`crossing_elimination_family_necSuf`）と同じ仮定で扱う。
- 位相の値は可換モノイド `G`。二本の位相の積を族の積へ並べ替えるために積の可換性を使う。
- 符号は `σ : R → G` で、`R` は `AddCommMonoidWithOne`（具体版では 𝔽₂ と `x ↦ (−1)^{x.val}`）。
  `σ` が加法を積へ移すこと（`hσadd`。帰納法の仮定の二つの符号と分割の符号をまとめる）と、
  `σ 0 = 1`（`hσ0`。基底の一項の族では指数が零になる）だけを使い、`1 + 1 = 0` は使わない。
- 分割 `hsplit`: `good` で接触対数が正なら、`good` な二つの子があり、接触対数の和は元より小さく、台は
  互いに素で合併は元の台、切断線偶奇の読みは元と等しく、`φ(w) = σ(1 + I(C_a, C_b)) · (φ(a) φ(b))`。
-/
import Ising2DLambda.NecSuf.KacWard.EdgeDistinctCrossingEliminationParity
import Mathlib.Algebra.BigOperators.Group.List.Basic

namespace Ising2DLambda.NecSuf.KacWard

variable {W E G M P R : Type*} [DecidableEq E]

/-- 必要十分版: 分割の公理だけから、接触対数が零の族への分解が台・切断線偶奇・位相を保つ。 -/
theorem contact_elimination_family_necSuf [CommMonoid G] [AddCommMonoid M]
    [AddCommMonoidWithOne R]
    (good : W → Prop) (supp : W → Finset E) (n : W → ℕ) (φ : W → G)
    (sH sV : W → M) (read : M → P) (I : Finset E → Finset E → R) (σ : R → G)
    (hσ0 : σ 0 = 1) (hσadd : ∀ x y, σ (x + y) = σ x * σ y)
    (hread : ∀ x x' y : M, read x = read x' → read (x + y) = read (x' + y))
    (hIemptyL : ∀ D, I ∅ D = 0) (hIemptyR : ∀ C, I C ∅ = 0)
    (hIunionL : ∀ C₁ C₂ D, Disjoint C₁ C₂ → I (C₁ ∪ C₂) D = I C₁ D + I C₂ D)
    (hIunionR : ∀ C D₁ D₂, Disjoint D₁ D₂ → I C (D₁ ∪ D₂) = I C D₁ + I C D₂)
    (hsplit : ∀ w, good w → 0 < n w → ∃ a b, good a ∧ good b ∧ n a + n b < n w ∧
      Disjoint (supp a) (supp b) ∧ supp a ∪ supp b = supp w ∧
      read (sH a + sH b) = read (sH w) ∧ read (sV a + sV b) = read (sV w) ∧
      φ w = σ (1 + I (supp a) (supp b)) * (φ a * φ b))
    (w : W) (hw : good w) :
    ∃ ds : List W, ds ≠ [] ∧ (∀ d ∈ ds, good d ∧ n d = 0) ∧ (ds.map supp).Pairwise Disjoint ∧
      finsetListUnion (ds.map supp) = supp w ∧
      (read (ds.map sH).sum, read (ds.map sV).sum) = (read (sH w), read (sV w)) ∧
      φ w = σ (((ds.length - 1 : ℕ) : R) + finsetListPairSum I (ds.map supp)) * (ds.map φ).prod := by
  -- 読みの等式を和の二つの項へ運ぶ
  have hread2 : ∀ x x' y y' : M, read x = read x' → read y = read y' →
      read (x + y) = read (x' + y') := by
    intro x x' y y' hx hy
    rw [hread x x' y hx, add_comm x' y, add_comm x' y', hread y y' x' hy]
  -- n(w) ∈ ℕ に関する整礎帰納法
  suffices H : ∀ N : ℕ, ∀ w, good w → n w = N → ∃ ds : List W, ds ≠ [] ∧
      (∀ d ∈ ds, good d ∧ n d = 0) ∧ (ds.map supp).Pairwise Disjoint ∧
      finsetListUnion (ds.map supp) = supp w ∧
      (read (ds.map sH).sum, read (ds.map sV).sum) = (read (sH w), read (sV w)) ∧
      φ w = σ (((ds.length - 1 : ℕ) : R) + finsetListPairSum I (ds.map supp)) * (ds.map φ).prod from
    H _ w hw rfl
  intro N
  induction N using Nat.strong_induction_on with
  | _ N ih =>
  intro w hw hN
  rcases Nat.eq_zero_or_pos N with h0 | hpos
  · -- 基底: 自分自身の一項の族
    refine ⟨[w], List.cons_ne_nil _ _, ?_, List.pairwise_singleton _ _, ?_, ?_, ?_⟩
    · intro d hd
      rw [List.mem_singleton.mp hd]
      exact ⟨hw, hN.trans h0⟩
    · simp [finsetListUnion]
    · simp
    · simp [finsetListPairSum, hσ0]
  · -- 一回の分割
    obtain ⟨a, b, ha, hb, hdesc, hABdisj, hABunion, hsHab, hsVab, hphase⟩ :=
      hsplit w hw (hN ▸ hpos)
    -- 二本への帰納法の仮定
    obtain ⟨αs, hαne, hαgood, hαdisj, hαunion, hαseam, hαphase⟩ :=
      ih _ (hN ▸ lt_of_le_of_lt (Nat.le_add_right _ _) hdesc) a ha rfl
    obtain ⟨βs, hβne, hβgood, hβdisj, hβunion, hβseam, hβphase⟩ :=
      ih _ (hN ▸ lt_of_le_of_lt (Nat.le_add_left _ _) hdesc) b hb rfl
    -- 両族を連結する
    refine ⟨αs ++ βs, by simp [hαne], ?_, ?_, ?_, ?_, ?_⟩
    · intro d hd
      rcases List.mem_append.mp hd with h | h
      · exact hαgood d h
      · exact hβgood d h
    · rw [List.map_append, List.pairwise_append]
      refine ⟨hαdisj, hβdisj, fun C hC D hD => ?_⟩
      have hCA : C ⊆ supp a := hαunion ▸ subset_finsetListUnion hC
      have hDB : D ⊆ supp b := hβunion ▸ subset_finsetListUnion hD
      exact Finset.disjoint_of_subset_left hCA (Finset.disjoint_of_subset_right hDB hABdisj)
    · rw [List.map_append, finsetListUnion_append, hαunion, hβunion, hABunion]
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
      have hexp : (1 + I (supp a) (supp b))
            + (((αs.length - 1 : ℕ) : R) + finsetListPairSum I (αs.map supp))
            + (((βs.length - 1 : ℕ) : R) + finsetListPairSum I (βs.map supp))
          = (((αs ++ βs).length - 1 : ℕ) : R) + finsetListPairSum I ((αs ++ βs).map supp) := by
        rw [hdist, hlen, List.map_append, finsetListPairSum_append, Nat.cast_add, Nat.cast_add,
          Nat.cast_one]
        abel
      calc φ w = σ (1 + I (supp a) (supp b)) * (φ a * φ b) := hphase
        _ = σ (1 + I (supp a) (supp b))
              * ((σ (((αs.length - 1 : ℕ) : R) + finsetListPairSum I (αs.map supp))
                  * (αs.map φ).prod)
                * (σ (((βs.length - 1 : ℕ) : R) + finsetListPairSum I (βs.map supp))
                  * (βs.map φ).prod)) := by rw [← hαphase, ← hβphase]
        _ = σ ((1 + I (supp a) (supp b))
                + (((αs.length - 1 : ℕ) : R) + finsetListPairSum I (αs.map supp))
                + (((βs.length - 1 : ℕ) : R) + finsetListPairSum I (βs.map supp)))
              * ((αs.map φ).prod * (βs.map φ).prod) := by
            rw [hσadd ((1 + I (supp a) (supp b))
                + (((αs.length - 1 : ℕ) : R) + finsetListPairSum I (αs.map supp))),
              hσadd (1 + I (supp a) (supp b))]
            ac_rfl
        _ = σ ((((αs ++ βs).length - 1 : ℕ) : R) + finsetListPairSum I ((αs ++ βs).map supp))
              * ((αs ++ βs).map φ).prod := by
            rw [hexp]
            simp only [List.map_append, List.prod_append]

end Ising2DLambda.NecSuf.KacWard

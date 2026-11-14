import Mathlib

/-!
`claim_local_pairing_signed_sum` の二つ目の等式のうち、非零の標識付き完全マッチングと
局所対合族の一対一対応の段の必要十分版。

具体版 `Ising2DLambda.KacWard.nonzeroTaggedMatchings_sum_eq_localPairing_sum` と同じ手順
（対合族から項を作る → 選んだ半辺の相手から対合族を読み戻す（単射）→ 項の相手から対合族を作り、
それが項を回復する（全射）→ 有限和の再添字付け）を、次の仮定だけで行う。

* 半辺の型 `H` は、頂点 `V` と方向番号 `F` の組との全単射 `port` を持てばよい。格子・トーラス・
  辺の台は使わない。方向番号の個数が四であることも使わない。
* 項の型 `X` は任意で、各項は半辺の上の写像 `mate x` を持つ。項の集合 `T` の各元について、
  選んだ方向番号の半辺の相手は同じ頂点の選んだ方向番号の半辺で、自身と異なり、相手の相手は自身である。
  具体版ではこれが「非零項の短い対は頂点ごとの対合を与える」に当たる。
* 対合族から作った項 `build κ` は `T` に属し、選んだ半辺の相手として `κ` を回復する。
  逆に `T` の項は、選んだ半辺の相手が一致する対合族から作った項に等しい
  （具体版の「標識付きマッチングの回復」）。
* 値は加法可換モノイド `M`。
-/

namespace Ising2DLambda.NecSuf.KacWard

open Finset

/-- 選んだ点を互いに入れ替え、選ばない点を動かさない局所対合全体。 -/
def localInvolutionChoices {F : Type*} [Fintype F] [DecidableEq F] (S : Finset F) :
    Finset (F → F) :=
  Finset.univ.filter fun κ =>
    (∀ i, i ∉ S → κ i = i) ∧
    (∀ i, i ∈ S → κ i ∈ S ∧ κ i ≠ i) ∧
    (∀ i, κ (κ i) = i)

theorem sum_over_terms_eq_sum_over_local_involutions
    {H V F X M : Type*} [Fintype V] [DecidableEq V] [Fintype F] [DecidableEq F]
    [AddCommMonoid M]
    (port : H ≃ V × F) (S : V → Finset F) (T : Finset X) (mate : X → H → H)
    (build : (κ : V → F → F) →
      κ ∈ Fintype.piFinset (fun v => localInvolutionChoices (S v)) → X)
    (hbuild : ∀ κ hκ, build κ hκ ∈ T)
    (hrecover : ∀ κ hκ v i, i ∈ S v →
      mate (build κ hκ) (port.symm (v, i)) = port.symm (v, κ v i))
    (hmateSource : ∀ x ∈ T, ∀ v i, i ∈ S v → (port (mate x (port.symm (v, i)))).1 = v)
    (hmateSelected : ∀ x ∈ T, ∀ v i, i ∈ S v → (port (mate x (port.symm (v, i)))).2 ∈ S v)
    (hmateNe : ∀ x ∈ T, ∀ v i, i ∈ S v → mate x (port.symm (v, i)) ≠ port.symm (v, i))
    (hmateInvolutive : ∀ x ∈ T, ∀ v i, i ∈ S v →
      mate x (mate x (port.symm (v, i))) = port.symm (v, i))
    (hdetermined : ∀ x ∈ T, ∀ κ hκ,
      (∀ v i, i ∈ S v → mate x (port.symm (v, i)) = port.symm (v, κ v i)) → build κ hκ = x)
    (g : X → M) (f : (V → F → F) → M) (hgf : ∀ κ hκ, g (build κ hκ) = f κ) :
    ∑ x ∈ T, g x = ∑ κ ∈ Fintype.piFinset (fun v => localInvolutionChoices (S v)), f κ := by
  classical
  symm
  apply Finset.sum_bij build hbuild
  · -- 単射: 選んだ半辺の相手から対合族を読み戻す
    intro κ₁ hκ₁ κ₂ hκ₂ heq
    funext v i
    by_cases hi : i ∈ S v
    · have h₁ := hrecover κ₁ hκ₁ v i hi
      rw [heq, hrecover κ₂ hκ₂ v i hi] at h₁
      exact (Prod.mk.inj (port.symm.injective h₁)).2.symm
    · have hv₁ := (Finset.mem_filter.mp (Fintype.mem_piFinset.mp hκ₁ v)).2
      have hv₂ := (Finset.mem_filter.mp (Fintype.mem_piFinset.mp hκ₂ v)).2
      rw [hv₁.1 i hi, hv₂.1 i hi]
  · -- 全射: 項の相手から対合族を作り、それが項を回復する
    intro x hx
    let κ : V → F → F := fun v i =>
      if i ∈ S v then (port (mate x (port.symm (v, i)))).2 else i
    have hkey : ∀ v i, i ∈ S v → port.symm (v, κ v i) = mate x (port.symm (v, i)) := by
      intro v i hi
      rw [Equiv.symm_apply_eq]
      symm
      apply Prod.ext
      · exact hmateSource x hx v i hi
      · simp only [κ, if_pos hi]
    have hsel : ∀ v i, i ∈ S v → κ v i ∈ S v := by
      intro v i hi
      simp only [κ, if_pos hi]
      exact hmateSelected x hx v i hi
    have hκ : κ ∈ Fintype.piFinset (fun v => localInvolutionChoices (S v)) := by
      apply Fintype.mem_piFinset.mpr
      intro v
      refine Finset.mem_filter.mpr ⟨Finset.mem_univ _, ?_, ?_, ?_⟩
      · intro i hi
        simp only [κ, if_neg hi]
      · intro i hi
        refine ⟨hsel v i hi, ?_⟩
        intro heq
        apply hmateNe x hx v i hi
        rw [← hkey v i hi, heq]
      · intro i
        by_cases hi : i ∈ S v
        · have hback : port.symm (v, κ v (κ v i)) = port.symm (v, i) := by
            rw [hkey v _ (hsel v i hi), hkey v i hi, hmateInvolutive x hx v i hi]
          exact (Prod.mk.inj (port.symm.injective hback)).2
        · simp only [κ, if_neg hi]
    exact ⟨κ, hκ, hdetermined x hx κ hκ (fun v i hi => (hkey v i hi).symm)⟩
  · intro κ hκ
    exact (hgf κ hκ).symm

end Ising2DLambda.NecSuf.KacWard

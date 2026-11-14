import Ising2DLambda.NecSuf.KacWard.LocalPairingChoiceCount

/-!
`claim_local_pairing_signed_sum` の一つ目の等式の必要十分版。

具体版 `Ising2DLambda.KacWard.localPairingFamilies_signed_sum_eq_one` と同じ手順
（頂点ごとの計算 → 冪の法則 → 直積への分配 → 乗法単位元）を、次の仮定だけで行う。

* 頂点の集合 `V` は有限集合であればよい。格子の形・トーラス・辺は使わない。
  偶部分グラフであることは、各頂点の選択数が零・二・四のいずれかであることとしてだけ使う。
* 値は可換環 `R`。`-1` を書くために加法の逆元が要り、頂点ごとの和の積を直積上の和へ
  分配する段で乗法の可換性が要る。
-/

namespace Ising2DLambda.NecSuf.KacWard

open Finset

/-- 選択集合が四点全てで、`mate 0 = 2, mate 1 = 3` のときだけ一。 -/
def localPairingCrossingIndicator (S : Finset (Fin 4)) (mate : Fin 4 → Fin 4) : ℕ :=
  if S = Finset.univ ∧ mate 0 = 2 ∧ mate 1 = 3 then 1 else 0

/-- 四点全てを選ぶ局所対合は三つの対集合 `{{0,1},{2,3}}`・`{{0,2},{1,3}}`・`{{0,3},{1,2}}` に限る。 -/
theorem localPairingChoices_univ :
    localPairingChoices Finset.univ = {![1, 0, 3, 2], ![2, 3, 0, 1], ![3, 2, 1, 0]} := by
  decide

theorem localPairing_signed_sum_eq_one {R : Type*} [CommRing R] (S : Finset (Fin 4))
    (hcard : S.card = 0 ∨ S.card = 2 ∨ S.card = 4) :
    ∑ mate ∈ localPairingChoices S, (-1 : R) ^ localPairingCrossingIndicator S mate = 1 := by
  by_cases h4 : S.card = 4
  · have hS : S = Finset.univ := Finset.eq_univ_of_card S (by simpa using h4)
    subst hS
    rw [localPairingChoices_univ]
    rw [Finset.sum_insert (by decide), Finset.sum_insert (by decide), Finset.sum_singleton]
    have h₁ : localPairingCrossingIndicator Finset.univ ![1, 0, 3, 2] = 0 := by decide
    have h₂ : localPairingCrossingIndicator Finset.univ ![2, 3, 0, 1] = 1 := by decide
    have h₃ : localPairingCrossingIndicator Finset.univ ![3, 2, 1, 0] = 0 := by decide
    rw [h₁, h₂, h₃]
    ring
  · have hS : S ≠ Finset.univ := by
      intro hS
      apply h4
      simp [hS]
    have hc : ∀ mate, localPairingCrossingIndicator S mate = 0 := by
      intro mate
      simp [localPairingCrossingIndicator, hS]
    calc
      ∑ mate ∈ localPairingChoices S, (-1 : R) ^ localPairingCrossingIndicator S mate
          = ∑ _mate ∈ localPairingChoices S, (1 : R) := by
            apply Finset.sum_congr rfl
            intro mate _
            simp [hc mate]
      _ = ((localPairingChoices S).card : R) := by simp
      _ = 1 := by
            rw [(localPairingChoices_card S hcard).2 h4]
            norm_num

theorem localPairingFamilies_signed_sum_eq_one {V R : Type*} [Fintype V] [DecidableEq V]
    [CommRing R] (S : V → Finset (Fin 4))
    (hcard : ∀ v, (S v).card = 0 ∨ (S v).card = 2 ∨ (S v).card = 4) :
    ∑ mate ∈ Fintype.piFinset (fun v => localPairingChoices (S v)),
      (-1 : R) ^ (∑ v, localPairingCrossingIndicator (S v) (mate v)) = 1 := by
  calc
    ∑ mate ∈ Fintype.piFinset (fun v => localPairingChoices (S v)),
        (-1 : R) ^ (∑ v, localPairingCrossingIndicator (S v) (mate v))
        = ∑ mate ∈ Fintype.piFinset (fun v => localPairingChoices (S v)),
            ∏ v, (-1 : R) ^ localPairingCrossingIndicator (S v) (mate v) := by
          apply Finset.sum_congr rfl
          intro mate _
          rw [Finset.prod_pow_eq_pow_sum]
    _ = ∏ v, ∑ m ∈ localPairingChoices (S v),
          (-1 : R) ^ localPairingCrossingIndicator (S v) m := by
          rw [Finset.prod_univ_sum]
    _ = ∏ _v : V, (1 : R) := by
          apply Finset.prod_congr rfl
          intro v _
          exact localPairing_signed_sum_eq_one (S v) (hcard v)
    _ = 1 := by simp

end Ising2DLambda.NecSuf.KacWard

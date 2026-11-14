import Ising2DLambda.KacWard.VertexLocalPairingProduct
import Ising2DLambda.KacWard.TaggedMatchingEvenComplement

/-!
`claim_local_pairing_signed_sum`（偶部分グラフ上の局所対合の符号付き和は一である）の
一つ目の等式 `∑_{κ∈𝒞(P)} (-1)^{t_P(κ)} = 1` の具体版。

人手証明との対応:
* `selectedPortNumbers_card_eq_incidence`・`selectedPortNumbers_card_cases`:
  偶部分グラフでは `|S_v(P)|` が零・二・四のいずれかであること
  （`claim_vertex_port_bijection` の全単射で `|S_v(P)|` を端点数へ移す）。
* `localPairing_signed_sum_eq_one`: 頂点ごとの計算
  `∑_{κ_v∈𝒦(S_v(P))} (-1)^{c_v(κ_v)} = 1`。
* `localPairingFamilies_signed_sum_eq_one`: `t_P` の定義と整数の冪の法則、
  `claim_vertex_local_pairing_product` の直積と有限和の分配律、頂点ごとの計算、乗法単位元。
-/

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.FisherZero Ising2DLambda.PartitionPolynomial
  Ising2DLambda.TransferMatrix

/-- `c_v(κ_v)`: 選択集合が四つの方向の全てで、`κ_v(0)=2, κ_v(1)=3` のときだけ一。 -/
def localPairingCrossingIndicator (S : Finset (Fin 4)) (κ : Fin 4 → Fin 4) : ℕ :=
  if S = Finset.univ ∧ κ 0 = 2 ∧ κ 1 = 3 then 1 else 0

/-- `t_P(κ) := ∑_v c_v(κ_v)`。 -/
def localPairingCrossingCount {L : ℕ} [NeZero L] (P : Finset (Edge L))
    (κ : Vertex L → Fin 4 → Fin 4) : ℕ :=
  ∑ v : Vertex L, localPairingCrossingIndicator (selectedPortNumbers P v) (κ v)

/-- `|S_v(P)| = |H_v(P)|`（`claim_vertex_port_bijection` の制限の全単射）であり、
`|H_v(P)|` は頂点 `v` での `P` の端点数に等しい。 -/
theorem selectedPortNumbers_card_eq_incidence {L : ℕ} [NeZero L]
    (P : Finset (Edge L)) (v : Vertex L) :
    (selectedPortNumbers P v).card = edgeSubsetIncidenceCount L P v := by
  classical
  rw [incidence_as_oriented_sum, selectedPortNumbers, Finset.card_image_of_injOn]
  · rw [Finset.card_filter]
    apply Finset.sum_congr rfl
    intro h _
    by_cases h₁ : orientedSource h = v <;> by_cases h₂ : h.1 ∈ P <;> simp [h₁, h₂]
  · intro e he f hf hdir
    have he' := (Finset.mem_filter.mp (Finset.mem_coe.mp he)).2
    have hf' := (Finset.mem_filter.mp (Finset.mem_coe.mp hf)).2
    apply sourceDirection_bijective.1
    exact Prod.ext (he'.1.trans hf'.1.symm) ((ZMod.finEquiv 4).symm.injective hdir)

/-- 偶部分グラフでは各頂点の選択数は零・二・四のいずれかである。 -/
theorem selectedPortNumbers_card_cases {L : ℕ} [NeZero L]
    (P : Finset (Edge L)) (hP : IsEvenEdgeSubset L P) (v : Vertex L) :
    (selectedPortNumbers P v).card = 0 ∨ (selectedPortNumbers P v).card = 2 ∨
      (selectedPortNumbers P v).card = 4 := by
  have hle : (selectedPortNumbers P v).card ≤ 4 := by
    simpa using Finset.card_le_univ (selectedPortNumbers P v)
  have heven : Even (selectedPortNumbers P v).card := by
    rw [selectedPortNumbers_card_eq_incidence]
    exact hP v
  obtain ⟨k, hk⟩ := heven
  omega

/-- 頂点ごとの計算: `|S|=0,2` なら一通りで `c=0`、`|S|=4` なら `1+1-1`。 -/
theorem localPairing_signed_sum_eq_one (S : Finset (Fin 4))
    (hcard : S.card = 0 ∨ S.card = 2 ∨ S.card = 4) :
    ∑ κ ∈ localPairingChoices S, (-1 : ℤ) ^ localPairingCrossingIndicator S κ = 1 := by
  by_cases h4 : S.card = 4
  · -- `|S|=4` なら `S = I` で、三つの対合のうち `{{0,2},{1,3}}` だけが `c=1`。
    have hS : S = Finset.univ := Finset.eq_univ_of_card S (by simpa using h4)
    subst hS
    decide
  · -- `|S|=0,2` なら `S ≠ I` なので `c=0`、選択は一通り。
    have hS : S ≠ Finset.univ := by
      intro hS
      apply h4
      simp [hS]
    have hc : ∀ κ, localPairingCrossingIndicator S κ = 0 := by
      intro κ
      simp [localPairingCrossingIndicator, hS]
    calc
      ∑ κ ∈ localPairingChoices S, (-1 : ℤ) ^ localPairingCrossingIndicator S κ
          = ∑ _κ ∈ localPairingChoices S, (1 : ℤ) := by
            apply Finset.sum_congr rfl
            intro κ _
            simp [hc κ]
      _ = ((localPairingChoices S).card : ℤ) := by simp
      _ = 1 := by
            rw [(localPairingChoices_card S hcard).2 h4]
            norm_num

/-- `claim_local_pairing_signed_sum` の一つ目の等式。 -/
theorem localPairingFamilies_signed_sum_eq_one {L : ℕ} [NeZero L]
    (P : Finset (Edge L)) (hP : IsEvenEdgeSubset L P) :
    ∑ κ ∈ vertexLocalPairingChoices P,
      (-1 : ℤ) ^ localPairingCrossingCount P κ = 1 := by
  classical
  calc
    ∑ κ ∈ vertexLocalPairingChoices P, (-1 : ℤ) ^ localPairingCrossingCount P κ
        = ∑ κ ∈ vertexLocalPairingChoices P, ∏ v : Vertex L,
            (-1 : ℤ) ^ localPairingCrossingIndicator (selectedPortNumbers P v) (κ v) := by
          -- `t_P` の定義と整数の冪の法則
          apply Finset.sum_congr rfl
          intro κ _
          rw [localPairingCrossingCount, Finset.prod_pow_eq_pow_sum]
    _ = ∏ v : Vertex L, ∑ κv ∈ localPairingChoices (selectedPortNumbers P v),
          (-1 : ℤ) ^ localPairingCrossingIndicator (selectedPortNumbers P v) κv := by
          -- `claim_vertex_local_pairing_product` の直積と有限和の分配律
          rw [vertexLocalPairingChoices, Finset.prod_univ_sum]
    _ = ∏ _v : Vertex L, (1 : ℤ) := by
          -- 頂点ごとの計算
          apply Finset.prod_congr rfl
          intro v _
          exact localPairing_signed_sum_eq_one _ (selectedPortNumbers_card_cases P hP v)
    _ = 1 := by
          -- `ℤ` の乗法単位元
          simp

end Ising2DLambda.KacWard

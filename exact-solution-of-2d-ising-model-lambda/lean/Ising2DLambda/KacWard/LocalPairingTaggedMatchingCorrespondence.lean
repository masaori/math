import Ising2DLambda.KacWard.LocalPairingSignedSum
import Ising2DLambda.KacWard.TaggedMatchingTermNonzero

/-!
`claim_local_pairing_signed_sum`（偶部分グラフ上の局所対合の符号付き和は一である）の
二つ目の等式のうち、非零の標識付き完全マッチングと局所対合族の一対一対応の段の具体版。

人手証明の段落「`claim_tagged_matching_local_pairs` により非零項の短い対は頂点ごとの対合を与える。
逆に `claim_local_pairing_matching_construction` と `claim_local_pairing_matching_term_nonzero` は
各対合族から非零項を作り、`claim_local_pairing_matching_complement_recovery` によりその補辺は
固定した `P` に等しい。`claim_tagged_matching_label_recovery` は元の項を回復する。」との対応:

* `portEquiv`・`mem_selectedPortNumbers_iff`: `claim_vertex_port_bijection` の全単射
  （向き付き辺 ↔ 始点と方向番号）で、方向番号 `i ∈ S_v(P)` を向き付き辺へ移す。
* `halfEdgePairing`・`halfEdgePairing_*`: 局所対合族 `κ = (κ_v)_v` を向き付き辺の上の局所対合へ移す。
* `localPairingTaggedMatching`・`localPairingTaggedMatching_mem`: 対合族から非零項を作り、
  補辺が `P` であること（`claim_local_pairing_matching_construction`・
  `claim_local_pairing_matching_term_nonzero`・`claim_local_pairing_matching_complement_recovery`）。
* `localPairingTaggedMatching_injective`: 選んだ半辺の相手から対合族が読み戻せること。
* `nonzeroTaggedMatching_mate_short`・`nonzeroTaggedMatching_localPairing`: 非零項の短い対が頂点ごとの対合を与え
  （`claim_tagged_matching_local_pairs`）、その対合族から作った項が元の項に戻ること
  （`claim_tagged_matching_label_recovery`）。
* `nonzeroTaggedMatchings_sum_eq_localPairing_sum`: 以上の一対一対応による有限和の再添字付け。

`t_P(κ) = t(D,T)` の段と、一つ目の等式との合成は別の段で行う。住処は有限集合で、ℝ / ℂ は現れない。
必要十分版を呼ばない。
-/

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial
  Ising2DLambda.TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 向き付き辺を始点と方向番号 `Fin 4` の組へ送る全単射（`claim_vertex_port_bijection`）。 -/
noncomputable def portEquiv : OrientedEdge L ≃ Vertex L × Fin 4 :=
  (Equiv.ofBijective _ sourceDirection_bijective).trans
    (Equiv.prodCongr (Equiv.refl _) (ZMod.finEquiv 4).symm.toEquiv)

theorem portEquiv_apply (e : OrientedEdge L) :
    portEquiv e = (orientedSource e, (ZMod.finEquiv 4).symm (directionNumber e)) := rfl

/-- 方向番号 `i` が選択方向集合 `S_v(P)` に属することは、始点 `v`・方向番号 `i` の向き付き辺の
    台が `P` に属することと同値である。 -/
theorem mem_selectedPortNumbers_iff (P : Finset (Edge L)) (v : Vertex L) (i : Fin 4) :
    i ∈ selectedPortNumbers P v ↔ (portEquiv.symm (v, i)).1 ∈ P := by
  classical
  have hport : portEquiv (portEquiv.symm (v, i)) = (v, i) := Equiv.apply_symm_apply _ _
  rw [portEquiv_apply] at hport
  constructor
  · intro hi
    obtain ⟨e, he, hdir⟩ := Finset.mem_image.mp hi
    obtain ⟨hsrc, hP⟩ := (Finset.mem_filter.mp he).2
    have heq : e = portEquiv.symm (v, i) := by
      apply portEquiv.injective
      rw [Equiv.apply_symm_apply, portEquiv_apply, hsrc, hdir]
    exact heq ▸ hP
  · intro hP
    apply Finset.mem_image.mpr
    exact ⟨portEquiv.symm (v, i),
      Finset.mem_filter.mpr ⟨Finset.mem_univ _, congrArg Prod.fst hport, hP⟩,
      congrArg Prod.snd hport⟩

/-- 向き付き辺の台が `P` に属することを、その始点の選択方向集合で言い直す。 -/
theorem base_mem_iff_port_selected (P : Finset (Edge L)) (h : OrientedEdge L) :
    h.1 ∈ P ↔ (portEquiv h).2 ∈ selectedPortNumbers P (portEquiv h).1 := by
  rw [mem_selectedPortNumbers_iff, Prod.mk.eta, Equiv.symm_apply_apply]

/-- 局所対合族 `κ` を、向き付き辺の上の写像へ移す: 始点 `v`・方向番号 `i` の辺を、
    始点 `v`・方向番号 `κ_v(i)` の辺へ送る。 -/
noncomputable def halfEdgePairing (κ : Vertex L → Fin 4 → Fin 4)
    (h : OrientedEdge L) : OrientedEdge L :=
  portEquiv.symm ((portEquiv h).1, κ (portEquiv h).1 (portEquiv h).2)

theorem portEquiv_halfEdgePairing (κ : Vertex L → Fin 4 → Fin 4) (h : OrientedEdge L) :
    portEquiv (halfEdgePairing κ h) =
      ((portEquiv h).1, κ (portEquiv h).1 (portEquiv h).2) :=
  Equiv.apply_symm_apply _ _

theorem halfEdgePairing_selected (P : Finset (Edge L)) (κ : Vertex L → Fin 4 → Fin 4)
    (hκ : κ ∈ vertexLocalPairingChoices P) (h : OrientedEdge L) (hh : h.1 ∈ P) :
    (halfEdgePairing κ h).1 ∈ P := by
  classical
  have hv := (Finset.mem_filter.mp ((vertexLocalPairingChoices_mem_iff P κ).mp hκ
    (portEquiv h).1)).2
  rw [base_mem_iff_port_selected, portEquiv_halfEdgePairing]
  exact (hv.2.1 _ ((base_mem_iff_port_selected P h).mp hh)).1

theorem halfEdgePairing_involutive (P : Finset (Edge L)) (κ : Vertex L → Fin 4 → Fin 4)
    (hκ : κ ∈ vertexLocalPairingChoices P) (h : OrientedEdge L) :
    halfEdgePairing κ (halfEdgePairing κ h) = h := by
  classical
  have hv := (Finset.mem_filter.mp ((vertexLocalPairingChoices_mem_iff P κ).mp hκ
    (portEquiv h).1)).2
  apply portEquiv.injective
  rw [portEquiv_halfEdgePairing, portEquiv_halfEdgePairing, hv.2.2]

theorem halfEdgePairing_ne (P : Finset (Edge L)) (κ : Vertex L → Fin 4 → Fin 4)
    (hκ : κ ∈ vertexLocalPairingChoices P) (h : OrientedEdge L) (hh : h.1 ∈ P) :
    halfEdgePairing κ h ≠ h := by
  classical
  have hv := (Finset.mem_filter.mp ((vertexLocalPairingChoices_mem_iff P κ).mp hκ
    (portEquiv h).1)).2
  intro heq
  have hsnd := congrArg (fun e => (portEquiv e).2) heq
  simp only [portEquiv_halfEdgePairing] at hsnd
  exact (hv.2.1 _ ((base_mem_iff_port_selected P h).mp hh)).2 hsnd

theorem halfEdgePairing_source (κ : Vertex L → Fin 4 → Fin 4) (h : OrientedEdge L) :
    orientedSource (halfEdgePairing κ h) = orientedSource h := by
  have h₁ := congrArg Prod.fst (portEquiv_halfEdgePairing κ h)
  rw [portEquiv_apply, portEquiv_apply] at h₁
  exact h₁

/-- 局所対合族 `κ ∈ 𝒞(P)` から作った標識付き完全マッチング `(D, T)`
    （`claim_local_pairing_matching_construction`）。 -/
noncomputable def localPairingTaggedMatching (P : Finset (Edge L))
    (κ : Vertex L → Fin 4 → Fin 4) (hκ : κ ∈ vertexLocalPairingChoices P) :
    PerfectMatching (OrientedEdge L) × Finset (OrientedEdge L × OrientedEdge L) :=
  let D := localPairingMatching P (halfEdgePairing κ)
    (halfEdgePairing_selected P κ hκ) (fun h _ => halfEdgePairing_involutive P κ hκ h)
    (halfEdgePairing_ne P κ hκ)
  (D, localPairingMatchingShortPairs P D)

/-- 補辺が `P` に等しく、項が零でない標識付き完全マッチング全体。 -/
noncomputable def nonzeroTaggedMatchings (z : Qbar) (s : SpinStructure) (P : Finset (Edge L)) :
    Finset (PerfectMatching (OrientedEdge L) × Finset (OrientedEdge L × OrientedEdge L)) := by
  classical
  exact (Finset.univ ×ˢ Finset.univ).filter fun x =>
    x.2 ⊆ matchingOrientedPairs x.1 ∧
      matchingSignPolynomial x.1 *
        ((-1 : Polynomial Qbar) ^ x.2.card *
          (∏ p ∈ matchingOrientedPairs x.1 \ x.2, gaugedLongContribution z s p) *
          (∏ p ∈ x.2, gaugedShortContribution z s p)) ≠ 0 ∧
      taggedComplementEdges x.1 x.2 = P

/-- 対合族から作った項は非零で、補辺は `P` である。 -/
theorem localPairingTaggedMatching_mem (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure)
    (P : Finset (Edge L)) (κ : Vertex L → Fin 4 → Fin 4)
    (hκ : κ ∈ vertexLocalPairingChoices P) :
    localPairingTaggedMatching P κ hκ ∈ nonzeroTaggedMatchings z s P := by
  classical
  have hsource : ∀ h, h.1 ∈ P →
      orientedSource (halfEdgePairing κ h) = orientedSource h :=
    fun h _ => halfEdgePairing_source κ h
  unfold nonzeroTaggedMatchings
  refine Finset.mem_filter.mpr ⟨Finset.mem_product.mpr ⟨Finset.mem_univ _, Finset.mem_univ _⟩,
    ?_, ?_, ?_⟩
  · -- 短い標識の対は、作ったマッチングの昇順対である
    exact (localPairingMatching_label_support P (halfEdgePairing κ) _ _ _ hsource).1
  · -- `claim_local_pairing_matching_term_nonzero`
    exact localPairingMatching_term_nonzero z hz s P (halfEdgePairing κ) _ _ _ hsource
  · -- `claim_local_pairing_matching_complement_recovery`
    exact localPairingMatching_complement_edges P (halfEdgePairing κ) _ _ _ hsource

/-- 作った項の上で、選んだ半辺の相手は対合族が指す半辺である。 -/
theorem localPairingTaggedMatching_mate (P : Finset (Edge L)) (κ : Vertex L → Fin 4 → Fin 4)
    (hκ : κ ∈ vertexLocalPairingChoices P) (v : Vertex L) (i : Fin 4)
    (hi : i ∈ selectedPortNumbers P v) :
    perfectMatchingMate (localPairingTaggedMatching P κ hκ).1 (portEquiv.symm (v, i)) =
      portEquiv.symm (v, κ v i) := by
  have hh : (portEquiv.symm (v, i)).1 ∈ P := (mem_selectedPortNumbers_iff P v i).mp hi
  change perfectMatchingMate (localPairingMatching P (halfEdgePairing κ)
    (halfEdgePairing_selected P κ hκ) (fun h _ => halfEdgePairing_involutive P κ hκ h)
    (halfEdgePairing_ne P κ hκ)) _ = _
  rw [localPairingMatching_recovers_local_mate P (halfEdgePairing κ) _ _ _ _ hh]
  unfold halfEdgePairing
  rw [Equiv.apply_symm_apply]

/-- 対合族は、作った項の選んだ半辺の相手から読み戻せる。 -/
theorem localPairingTaggedMatching_injective (P : Finset (Edge L))
    (κ₁ κ₂ : Vertex L → Fin 4 → Fin 4)
    (hκ₁ : κ₁ ∈ vertexLocalPairingChoices P) (hκ₂ : κ₂ ∈ vertexLocalPairingChoices P)
    (heq : localPairingTaggedMatching P κ₁ hκ₁ = localPairingTaggedMatching P κ₂ hκ₂) :
    κ₁ = κ₂ := by
  classical
  funext v i
  by_cases hi : i ∈ selectedPortNumbers P v
  · have h₁ := localPairingTaggedMatching_mate P κ₁ hκ₁ v i hi
    have h₂ := localPairingTaggedMatching_mate P κ₂ hκ₂ v i hi
    rw [heq, h₂] at h₁
    exact (Prod.mk.inj (portEquiv.symm.injective h₁)).2.symm
  · have hv₁ := (Finset.mem_filter.mp ((vertexLocalPairingChoices_mem_iff P κ₁).mp hκ₁ v)).2
    have hv₂ := (Finset.mem_filter.mp ((vertexLocalPairingChoices_mem_iff P κ₂).mp hκ₂ v)).2
    rw [hv₁.1 i hi, hv₂.1 i hi]

omit [NeZero L] in
/-- 非零項で補辺に乗る半辺は短い標識の対に属し、その相手は対のもう一方である
    （`claim_tagged_matching_local_pairs`）。 -/
theorem nonzeroTaggedMatching_mate_short (z : Qbar) (s : SpinStructure)
    (D : PerfectMatching (OrientedEdge L)) (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (h : OrientedEdge L) (hh : h.1 ∈ taggedComplementEdges D t) :
    (perfectMatchingMate D h).1 ∈ taggedComplementEdges D t ∧
      orientedSource (perfectMatchingMate D h) = orientedSource h := by
  classical
  obtain ⟨hLong, hShort⟩ := taggedMatching_nonzero_term_support z s D t hterm
  obtain ⟨p, ⟨hp, _, hhp⟩, _⟩ :=
    (taggedMatching_local_pair_unique z s D t ht hterm (orientedSource h) h).mp ⟨hh, rfl⟩
  have hpD := Finset.mem_filter.mp (ht hp)
  have hmate₁ : perfectMatchingMate D p.1 = p.2 :=
    perfectMatchingMate_eq_of_pair D p.1 p.2 hpD.2.1.ne' hpD.2.2
  rcases hhp with rfl | rfl
  · rw [hmate₁]
    exact ⟨(complement_iff_short_endpoint D t ht hLong p.2).mpr ⟨p, hp, Or.inr rfl⟩,
      (hShort p hp).1⟩
  · have hmate₂ : perfectMatchingMate D p.2 = p.1 := by
      rw [← hmate₁, perfectMatchingMate_involutive]
    rw [hmate₂]
    exact ⟨(complement_iff_short_endpoint D t ht hLong p.1).mpr ⟨p, hp, Or.inl rfl⟩,
      (hShort p hp).1.symm⟩

/-- 非零項の短い対が与える頂点ごとの対合: 選んだ方向番号 `i` を、その半辺の相手の方向番号へ送る。 -/
noncomputable def matchingLocalPairing (P : Finset (Edge L)) (D : PerfectMatching (OrientedEdge L))
    (v : Vertex L) (i : Fin 4) : Fin 4 := by
  classical
  exact if i ∈ selectedPortNumbers P v then
    (portEquiv (perfectMatchingMate D (portEquiv.symm (v, i)))).2 else i

/-- 非零項 `x` の選んだ半辺の相手が対合族 `κ` の指す半辺に一致すれば、`κ` から作った項は `x` に等しい
    （`claim_tagged_matching_label_recovery`: マッチングと短い標識の両方を回復する）。 -/
theorem localPairingTaggedMatching_eq_of_mate (z : Qbar) (s : SpinStructure) (P : Finset (Edge L))
    (x : PerfectMatching (OrientedEdge L) × Finset (OrientedEdge L × OrientedEdge L))
    (hx : x ∈ nonzeroTaggedMatchings z s P)
    (κ : Vertex L → Fin 4 → Fin 4) (hκ : κ ∈ vertexLocalPairingChoices P)
    (hmate : ∀ v i, i ∈ selectedPortNumbers P v →
      perfectMatchingMate x.1 (portEquiv.symm (v, i)) = portEquiv.symm (v, κ v i)) :
    localPairingTaggedMatching P κ hκ = x := by
  classical
  obtain ⟨D, t⟩ := x
  unfold nonzeroTaggedMatchings at hx
  obtain ⟨_, ht, hterm, hP⟩ := Finset.mem_filter.mp hx
  dsimp only at ht hterm hP hmate
  have hpair : ∀ h, h.1 ∈ taggedComplementEdges D t →
      halfEdgePairing κ h = perfectMatchingMate D h := by
    intro h hh
    have hi := (base_mem_iff_port_selected P h).mp (hP ▸ hh)
    unfold halfEdgePairing
    rw [← hmate _ _ hi, Prod.mk.eta, Equiv.symm_apply_apply]
  subst hP
  have hD : (localPairingTaggedMatching _ κ hκ).1 = D :=
    taggedMatching_recovers_matching z s D t ht hterm _
      (halfEdgePairing_selected _ _ hκ) (fun h _ => halfEdgePairing_involutive _ _ hκ h)
      (halfEdgePairing_ne _ _ hκ) hpair
  apply Prod.ext hD
  change localPairingMatchingShortPairs _ (localPairingTaggedMatching _ κ hκ).1 = t
  rw [hD]
  exact (taggedMatching_recovers_labels z s D t ht hterm).symm

/-- 非零項の短い対は局所対合族を与え、その対合族から作った項は元の項に戻る
    （`claim_tagged_matching_local_pairs`・`claim_tagged_matching_label_recovery`）。 -/
theorem nonzeroTaggedMatching_localPairing (z : Qbar) (s : SpinStructure) (P : Finset (Edge L))
    (x : PerfectMatching (OrientedEdge L) × Finset (OrientedEdge L × OrientedEdge L))
    (hx : x ∈ nonzeroTaggedMatchings z s P) :
    ∃ hκ : matchingLocalPairing P x.1 ∈ vertexLocalPairingChoices P,
      localPairingTaggedMatching P (matchingLocalPairing P x.1) hκ = x := by
  classical
  obtain ⟨D, t⟩ := x
  unfold nonzeroTaggedMatchings at hx
  obtain ⟨_, ht, hterm, hP⟩ := Finset.mem_filter.mp hx
  dsimp only at ht hterm hP
  subst hP
  set P := taggedComplementEdges D t with hPdef
  -- 選んだ方向番号では、対合族が指す半辺はマッチングの相手である
  have hkey : ∀ v i, i ∈ selectedPortNumbers P v →
      portEquiv.symm (v, matchingLocalPairing P D v i) =
        perfectMatchingMate D (portEquiv.symm (v, i)) := by
    intro v i hi
    have hh : (portEquiv.symm (v, i)).1 ∈ P := (mem_selectedPortNumbers_iff P v i).mp hi
    obtain ⟨_, hsrc⟩ := nonzeroTaggedMatching_mate_short z s D t ht hterm _ hh
    rw [Equiv.symm_apply_eq]
    symm
    apply Prod.ext
    · rw [portEquiv_apply, hsrc]
      have h₀ := congrArg Prod.fst (Equiv.apply_symm_apply portEquiv (v, i))
      rw [portEquiv_apply] at h₀
      exact h₀
    · simp only [matchingLocalPairing, if_pos hi]
  have hsel : ∀ v i, i ∈ selectedPortNumbers P v →
      matchingLocalPairing P D v i ∈ selectedPortNumbers P v := by
    intro v i hi
    have hh : (portEquiv.symm (v, i)).1 ∈ P := (mem_selectedPortNumbers_iff P v i).mp hi
    rw [mem_selectedPortNumbers_iff, hkey v i hi]
    exact (nonzeroTaggedMatching_mate_short z s D t ht hterm _ hh).1
  have hκ : matchingLocalPairing P D ∈ vertexLocalPairingChoices P := by
    apply (vertexLocalPairingChoices_mem_iff P _).mpr
    intro v
    refine Finset.mem_filter.mpr ⟨Finset.mem_univ _, ?_, ?_, ?_⟩
    · intro i hi
      simp only [matchingLocalPairing, if_neg hi]
    · intro i hi
      refine ⟨hsel v i hi, ?_⟩
      intro heq
      apply perfectMatchingMate_ne D (portEquiv.symm (v, i))
      rw [← hkey v i hi, heq]
    · intro i
      by_cases hi : i ∈ selectedPortNumbers P v
      · have hback : portEquiv.symm (v, matchingLocalPairing P D v
            (matchingLocalPairing P D v i)) = portEquiv.symm (v, i) := by
          rw [hkey v _ (hsel v i hi), hkey v i hi, perfectMatchingMate_involutive]
        exact (Prod.mk.inj (portEquiv.symm.injective hback)).2
      · simp only [matchingLocalPairing, if_neg hi]
  exact ⟨hκ, localPairingTaggedMatching_eq_of_mate z s P (D, t) hx _ hκ
    (fun v i hi => (hkey v i hi).symm)⟩

/-- 一対一対応による有限和の再添字付け: 補辺が `P` の非零の標識付き完全マッチングにわたる和は、
    局所対合族 `𝒞(P)` にわたる和に等しい。 -/
theorem nonzeroTaggedMatchings_sum_eq_localPairing_sum {M : Type*} [AddCommMonoid M]
    (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) (P : Finset (Edge L))
    (g : PerfectMatching (OrientedEdge L) × Finset (OrientedEdge L × OrientedEdge L) → M)
    (f : (Vertex L → Fin 4 → Fin 4) → M)
    (hgf : ∀ κ hκ, g (localPairingTaggedMatching P κ hκ) = f κ) :
    ∑ x ∈ nonzeroTaggedMatchings z s P, g x = ∑ κ ∈ vertexLocalPairingChoices P, f κ := by
  symm
  apply Finset.sum_bij (fun κ hκ => localPairingTaggedMatching P κ hκ)
  · intro κ hκ
    exact localPairingTaggedMatching_mem z hz s P κ hκ
  · intro κ₁ hκ₁ κ₂ hκ₂ heq
    exact localPairingTaggedMatching_injective P κ₁ κ₂ hκ₁ hκ₂ heq
  · intro x hx
    obtain ⟨hκ, hback⟩ := nonzeroTaggedMatching_localPairing z s P x hx
    exact ⟨_, hκ, hback⟩
  · intro κ hκ
    exact (hgf κ hκ).symm

end Ising2DLambda.KacWard

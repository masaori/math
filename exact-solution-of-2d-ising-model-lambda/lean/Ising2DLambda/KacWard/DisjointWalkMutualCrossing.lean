/-
「辺を共有しない二本の閉歩道の混合横断数は交差形式に等しい」
（`claim_disjoint_walk_mutual_crossing_intersection`）の具体版。
住処は有限集合・ℤ/4ℤ・𝔽₂ で、ℝ / ℂ は現れない。

人手証明との対応:
- 「各頂点の四つの半辺を左・上・右・下と呼ぶ」: 頂点と方向（右 0・下 1・左 2・上 3）から
  半辺を担う辺を返す `halfEdgeEdge` と、その半辺を頂点から出る向きに通る `halfEdgeOutgoing`。
  `halfEdgeOutgoing_iff`・`halfEdgeIncoming_iff` は、半辺が頂点と方向で一つの向き付き辺に
  決まること（辺長一でも辺の標識と方向で区別すること）。
- 「閉歩道が半辺を使うときは入辺と出辺を一つずつ使う」: `passHalfEdgeUse`
  （入辺は方向番号 + 2、出辺は方向番号の半辺）。
- 「二本を通じて辺の標識が相異なるので … 四半辺を使い尽くす」: `passHalfEdges_disjoint`。
- 「両歩道が直進すると … 二半辺の選び方六通りを尽くす」: `passHalfEdgeUse_local_crossing`
  （場合分け）と、直進は方向番号が変わらないことを述べる `stepTurning_eq_zero_iff`。
- 式変形の一行目（各頂点の四半辺の場合分けと有限和）: `closedWalkMutualCrossingNumber_eq_vertexSum`
  と、頂点ごとの半辺の使用回数が台の辺係数であることを述べる `walkHalfEdgeUse_eq_support`・
  `walkHalfEdgeUse_coefficients`。
- 二行目（交差数の定義）: `closedWalkMutualCrossingNumber_eq_intersection` の列の添字の付け替え。
- 三行目（交差数の値）: `closedWalkMutualCrossingNumber_eq_cutParity` が
  `evenEdgeChainIntersection_eq_cutParity` を引く。
- 「各歩道は閉じているので台は偶辺鎖である」: `closedWalkSupport_even`。
-/
import Ising2DLambda.KacWard.ClosedWalkCrossingNumber
import Ising2DLambda.KacWard.EvenEdgeChainIntersectionValue
import Ising2DLambda.KacWard.TargetDirectionBijection
import Ising2DLambda.NecSuf.KacWard.DisjointWalkMutualCrossing

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

/-- 閉歩道の辺の台（通る無向辺の有限集合）。 -/
def closedWalkSupport {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L) : Finset (Edge L) :=
  univ.image fun k => (γ k).1

/-- 混合横断数 `c_mut(γ, η)`。横断の条件は `def_closed_walk_crossing_number` と同じ
`edgeTransverseCrossing`（通過の頂点が等しく、二通過とも一歩の回転数が零で、軸が異なる。
後続辺であることは通過なので常に成り立つ）。 -/
noncomputable def closedWalkMutualCrossingNumber {L m n : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (_hγ : closedNonbacktrackingWalk γ)
    (η : Fin (n + 1) → OrientedEdge L) (_hη : closedNonbacktrackingWalk η) : ℕ := by
  classical
  exact ((univ ×ˢ univ).filter fun p : Fin (m + 1) × Fin (n + 1) =>
    edgeTransverseCrossing (γ p.1) (γ (closedWalkSuccessor p.1))
      (η p.2) (η (closedWalkSuccessor p.2))).card

/-- 通過 `(e, f)` が方向 `d` の半辺を使う回数（𝔽₂）。入辺 `e` は方向番号 + 2、
出辺 `f` は方向番号の半辺を使う。 -/
def passHalfEdgeUse {L : ℕ} (e f : OrientedEdge L) (d : ZMod 4) : ZMod 2 :=
  (if directionNumber e + 2 = d then 1 else 0) + (if directionNumber f = d then 1 else 0)

/-- 頂点 `v` で閉歩道 `γ` の通過が方向 `d` の半辺を使う回数の和（𝔽₂）。 -/
def walkHalfEdgeUse {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (v : Vertex L) (d : ZMod 4) : ZMod 2 :=
  ∑ r, if orientedTarget (γ r) = v then
    passHalfEdgeUse (γ r) (γ (closedWalkSuccessor r)) d else 0

/-- 巡回後続写像は単射である。 -/
theorem closedWalkSuccessor_injective {m : ℕ} :
    Function.Injective (closedWalkSuccessor : Fin (m + 1) → Fin (m + 1)) := by
  intro a b h
  unfold closedWalkSuccessor at h
  apply Fin.ext
  have ha := a.isLt
  have hb := b.isLt
  split_ifs at h with h1 h2 h2
  · have := congrArg Fin.val h
    simp at this
    omega
  · have := congrArg Fin.val h
    simp at this
  · have := congrArg Fin.val h
    simp at this
  · omega

/-- 巡回後続写像の全単射。添字の和の付け替えに使う。 -/
noncomputable def closedWalkSuccessorEquiv (m : ℕ) : Fin (m + 1) ≃ Fin (m + 1) :=
  Equiv.ofBijective closedWalkSuccessor
    (Finite.injective_iff_bijective.mp closedWalkSuccessor_injective)

/-- 通過の頂点は後続辺の始点である。 -/
theorem closedWalk_target_eq_source {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (r : Fin (m + 1)) :
    orientedTarget (γ r) = orientedSource (γ (closedWalkSuccessor r)) :=
  (Finset.mem_filter.mp (closedWalkPass_valid γ hγ r)).2.1

/-- 非後退の後続辺では、一歩の回転数が零であることと方向番号が変わらないことは同値である。 -/
theorem stepTurning_eq_zero_iff {L : ℕ} [NeZero L] (e f : OrientedEdge L)
    (hf : f ∈ nonbacktrackingSuccessors e) :
    stepTurning e f = 0 ↔ directionNumber f = directionNumber e := by
  have hrev : directionNumber f ≠ directionNumber e + 2 := by
    intro h
    have hs : orientedSource f = orientedTarget e := (Finset.mem_filter.mp hf).2.1.symm
    have hr : orientedSource (reversal e) = orientedTarget e := by
      rcases e with ⟨edge, false | true⟩ <;> rfl
    have heq : f = reversal e := sourceDirection_bijective.1
      (Prod.ext (hs.trans hr.symm) (h.trans (directionNumber_reversal e).symm))
    exact (Finset.mem_filter.mp hf).2.2 heq
  have htable : ∀ a b : ZMod 4, b ≠ a + 2 →
      b = a ∨ (b ≠ a ∧ b = a + 1) ∨ (b ≠ a ∧ b ≠ a + 1 ∧ b = a - 1) := by decide
  unfold stepTurning
  rw [if_pos hf]
  rcases htable _ _ hrev with h | ⟨h1, h2⟩ | ⟨h1, h2, h3⟩
  · rw [if_pos h]
    simp [h]
  · rw [if_neg h1, if_pos h2]
    simp [h1]
  · rw [if_neg h1, if_neg h2, if_pos h3]
    simp [h1]

section HalfEdge

variable {L : ℕ} [NeZero L]

/-- 頂点 `v` の方向 `d` の半辺を担う辺。右（0）・下（1）・左（2）・上（3）。 -/
def halfEdgeEdge (v : Vertex L) (d : ZMod 4) : Edge L :=
  if d = 0 then edgeOfRow L false v.1 v.2
  else if d = 1 then edgeOfRow L true v.1 v.2
  else if d = 2 then edgeOfRow L false v.1 (v.2 - 1)
  else edgeOfRow L true (v.1 - 1) v.2

/-- 方向 `d` の半辺を、頂点 `v` から出る向きに通る向き付き辺。 -/
def halfEdgeOutgoing (v : Vertex L) (d : ZMod 4) : OrientedEdge L :=
  (halfEdgeEdge v d, decide (d = 2 ∨ d = 3))

theorem halfEdgeOutgoing_source_direction (v : Vertex L) (d : ZMod 4) :
    orientedSource (halfEdgeOutgoing v d) = v ∧
      directionNumber (halfEdgeOutgoing v d) = d := by
  rcases v with ⟨i, j⟩
  fin_cases d
  · have h := rowColumnIndex_lt L i j
    refine ⟨?_, ?_⟩
    · change boundary0 L (edgeOfRow L false i j) = (i, j)
      exact edgeOfRow_boundary0 L false i j
    · change directionNumber (edgeOfRow L false i j, false) = 0
      simp [directionNumber, edgeOfRow, h]
  · refine ⟨?_, ?_⟩
    · change boundary0 L (edgeOfRow L true i j) = (i, j)
      exact edgeOfRow_boundary0 L true i j
    · change directionNumber (edgeOfRow L true i j, false) = 1
      simp [directionNumber, edgeOfRow]
  · have h := rowColumnIndex_lt L i (j - 1)
    refine ⟨?_, ?_⟩
    · change boundary1 L (edgeOfRow L false i (j - 1)) = (i, j)
      rw [edgeOfRow_boundary1_horizontal]
      simp
    · change directionNumber (edgeOfRow L false i (j - 1), true) = 2
      simp [directionNumber, edgeOfRow, h]
  · refine ⟨?_, ?_⟩
    · change boundary1 L (edgeOfRow L true (i - 1) j) = (i, j)
      rw [edgeOfRow_boundary1_vertical]
      simp
    · change directionNumber (edgeOfRow L true (i - 1) j, true) = 3
      simp [directionNumber, edgeOfRow]

/-- 始点と方向番号が `(v, d)` の向き付き辺は `halfEdgeOutgoing v d` だけである。 -/
theorem halfEdgeOutgoing_iff (o : OrientedEdge L) (v : Vertex L) (d : ZMod 4) :
    (orientedSource o = v ∧ directionNumber o = d) ↔ o = halfEdgeOutgoing v d := by
  have h := halfEdgeOutgoing_source_direction v d
  constructor
  · rintro ⟨hs, hd⟩
    apply sourceDirection_bijective.1
    exact Prod.ext (hs.trans h.1.symm) (hd.trans h.2.symm)
  · rintro rfl
    exact h

/-- 終点が `v` で方向 `d` の半辺から入る向き付き辺は、`halfEdgeOutgoing v d` の反転だけである。 -/
theorem halfEdgeIncoming_iff (o : OrientedEdge L) (v : Vertex L) (d : ZMod 4) :
    (orientedTarget o = v ∧ directionNumber o + 2 = d) ↔
      o = reversal (halfEdgeOutgoing v d) := by
  have h := halfEdgeOutgoing_source_direction v d
  have h4 : ∀ x : ZMod 4, x + 2 + 2 = x := by decide
  constructor
  · rintro ⟨ht, hd⟩
    apply targetDirection_bijective.1
    refine Prod.ext ?_ ?_
    · change orientedTarget o = orientedTarget (reversal (halfEdgeOutgoing v d))
      rw [orientedTarget_reversal, h.1, ht]
    · change directionNumber o = directionNumber (reversal (halfEdgeOutgoing v d))
      rw [directionNumber_reversal, h.2, ← hd, h4]
  · rintro rfl
    refine ⟨by rw [orientedTarget_reversal, h.1], ?_⟩
    rw [directionNumber_reversal, h.2, h4]

/-- 通過が方向 `d` の半辺を使うなら、その半辺を担う辺は歩道の辺である。 -/
theorem pass_halfEdge_mem {m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (r : Fin (m + 1)) (d : ZMod 4)
    (h : directionNumber (γ r) + 2 = d ∨ directionNumber (γ (closedWalkSuccessor r)) = d) :
    ∃ k, (γ k).1 = halfEdgeEdge (orientedTarget (γ r)) d := by
  rcases h with h | h
  · exact ⟨r, congrArg Prod.fst ((halfEdgeIncoming_iff (γ r) _ d).mp ⟨rfl, h⟩)⟩
  · exact ⟨closedWalkSuccessor r, congrArg Prod.fst
      ((halfEdgeOutgoing_iff (γ (closedWalkSuccessor r)) (orientedTarget (γ r)) d).mp
        ⟨(closedWalk_target_eq_source γ hγ r).symm, h⟩)⟩

/-- 辺の標識が二本を通じて相異なるなら、同じ頂点の二通過が使う半辺は交わらない。 -/
theorem passHalfEdges_disjoint {m n : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (η : Fin (n + 1) → OrientedEdge L) (hη : closedNonbacktrackingWalk η)
    (hdisjE : ∀ r s, (γ r).1 ≠ (η s).1)
    (r : Fin (m + 1)) (s : Fin (n + 1)) (hv : orientedTarget (γ r) = orientedTarget (η s)) :
    ∀ d, ¬ ((directionNumber (γ r) + 2 = d ∨ directionNumber (γ (closedWalkSuccessor r)) = d) ∧
      (directionNumber (η s) + 2 = d ∨ directionNumber (η (closedWalkSuccessor s)) = d)) := by
  rintro d ⟨hA, hB⟩
  obtain ⟨k, hk⟩ := pass_halfEdge_mem γ hγ r d hA
  obtain ⟨l, hl⟩ := pass_halfEdge_mem η hη s d hB
  exact hdisjE k l (hk.trans (hv ▸ hl.symm))

omit [NeZero L] in
/-- 同じ頂点の二通過の局所の場合分け（左・上・右・下の四半辺から二つずつ選ぶ六通り）。 -/
theorem passHalfEdgeUse_local_crossing (e f e' f' : OrientedEdge L)
    (hdisj : ∀ d, ¬ ((directionNumber e + 2 = d ∨ directionNumber f = d) ∧
      (directionNumber e' + 2 = d ∨ directionNumber f' = d))) :
    (if directionNumber f = directionNumber e ∧ directionNumber f' = directionNumber e' ∧
        directionAxis (directionNumber e) ≠ directionAxis (directionNumber e')
      then (1 : ZMod 2) else 0) =
      passHalfEdgeUse e f 2 * passHalfEdgeUse e' f' 3 +
        passHalfEdgeUse e f 1 * passHalfEdgeUse e' f' 0 := by
  unfold passHalfEdgeUse directionAxis
  generalize directionNumber e = a at *
  generalize directionNumber f = a' at *
  generalize directionNumber e' = b at *
  generalize directionNumber f' = b' at *
  revert hdisj
  revert a a' b b'
  decide

/-- 横辺の係数の条件を満たす辺は、その行・列の横辺だけである。 -/
theorem horizontal_condition_iff (e : Edge L) (i j : ZMod L) :
    (e.val < L ^ 2 ∧ (edgeRow L e : ZMod L) = i ∧ (edgeColumn L e : ZMod L) = j) ↔
      e = edgeOfRow L false i j := by
  constructor
  · rintro ⟨hval, hi, hj⟩
    obtain ⟨w, rfl⟩ := (edgeEquiv L).surjective e
    rcases w with ⟨i', j'⟩ | ⟨i', j'⟩
    · simp only [edgeEquiv_inl, edgeRow_edgeOfRow, edgeColumn_edgeOfRow,
        ZMod.natCast_zmod_val] at hi hj ⊢
      rw [hi, hj]
    · simp [edgeOfRow] at hval
  · rintro rfl
    refine ⟨by simpa [edgeOfRow] using rowColumnIndex_lt L i j, ?_, ?_⟩
    · rw [edgeRow_edgeOfRow, ZMod.natCast_zmod_val]
    · rw [edgeColumn_edgeOfRow, ZMod.natCast_zmod_val]

/-- 縦辺の係数の条件を満たす辺は、その行・列の縦辺だけである。 -/
theorem vertical_condition_iff (e : Edge L) (i j : ZMod L) :
    (L ^ 2 ≤ e.val ∧ (edgeRow L e : ZMod L) = i ∧ (edgeColumn L e : ZMod L) = j) ↔
      e = edgeOfRow L true i j := by
  constructor
  · rintro ⟨hval, hi, hj⟩
    obtain ⟨w, rfl⟩ := (edgeEquiv L).surjective e
    rcases w with ⟨i', j'⟩ | ⟨i', j'⟩
    · have h := rowColumnIndex_lt L i' j'
      simp [edgeOfRow] at hval
      omega
    · simp only [edgeEquiv_inr, edgeRow_edgeOfRow, edgeColumn_edgeOfRow,
        ZMod.natCast_zmod_val] at hi hj ⊢
      rw [hi, hj]
  · rintro rfl
    refine ⟨by simp [edgeOfRow], ?_, ?_⟩
    · rw [edgeRow_edgeOfRow, ZMod.natCast_zmod_val]
    · rw [edgeColumn_edgeOfRow, ZMod.natCast_zmod_val]

theorem horizontalChainCoefficient_eq_mem (C : Finset (Edge L)) (i j : ZMod L) :
    horizontalChainCoefficient L C i j = if edgeOfRow L false i j ∈ C then 1 else 0 := by
  unfold horizontalChainCoefficient
  simp_rw [horizontal_condition_iff]
  simp

theorem verticalChainCoefficient_eq_mem (C : Finset (Edge L)) (i j : ZMod L) :
    verticalChainCoefficient L C i j = if edgeOfRow L true i j ∈ C then 1 else 0 := by
  unfold verticalChainCoefficient
  simp_rw [vertical_condition_iff]
  simp

/-- 頂点で方向 `d` の半辺を使う回数の和は、その半辺を担う辺が台に属するかの指示子である。 -/
theorem walkHalfEdgeUse_eq_support {m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun k => (γ k).1)
    (v : Vertex L) (d : ZMod 4) :
    walkHalfEdgeUse γ v d = if halfEdgeEdge v d ∈ closedWalkSupport γ then 1 else 0 := by
  have hpair : ∀ (x : Edge L) (c β : Bool),
      ((if (x, c) = (halfEdgeEdge v d, !β) then (1 : ZMod 2) else 0) +
        (if (x, c) = (halfEdgeEdge v d, β) then 1 else 0)) =
        if x = halfEdgeEdge v d then 1 else 0 := by
    intro x c β
    by_cases hx : x = halfEdgeEdge v d
    · subst hx
      cases c <;> cases β <;> simp
    · simp [hx]
  calc
    walkHalfEdgeUse γ v d
        = ∑ r, ((if γ r = reversal (halfEdgeOutgoing v d) then (1 : ZMod 2) else 0) +
            (if γ (closedWalkSuccessor r) = halfEdgeOutgoing v d then 1 else 0)) := by
          refine sum_congr rfl fun r _ => ?_
          have hin := halfEdgeIncoming_iff (γ r) v d
          have hout := halfEdgeOutgoing_iff (γ (closedWalkSuccessor r)) v d
          rw [← closedWalk_target_eq_source γ hγ r] at hout
          unfold passHalfEdgeUse
          by_cases ht : orientedTarget (γ r) = v
          · rw [if_pos ht]
            congr 1
            · exact if_congr (by rw [← hin]; simp [ht]) rfl rfl
            · exact if_congr (by rw [← hout]; simp [ht]) rfl rfl
          · rw [if_neg ht]
            have h1 : γ r ≠ reversal (halfEdgeOutgoing v d) := fun h => ht (hin.mpr h).1
            have h2 : γ (closedWalkSuccessor r) ≠ halfEdgeOutgoing v d :=
              fun h => ht (hout.mpr h).1
            simp [h1, h2]
    _ = ∑ t, ((if γ t = reversal (halfEdgeOutgoing v d) then (1 : ZMod 2) else 0) +
            (if γ t = halfEdgeOutgoing v d then 1 else 0)) := by
          rw [sum_add_distrib, sum_add_distrib]
          congr 1
          exact Equiv.sum_comp (closedWalkSuccessorEquiv m)
            (fun t => if γ t = halfEdgeOutgoing v d then (1 : ZMod 2) else 0)
    _ = ∑ t, (if (γ t).1 = halfEdgeEdge v d then (1 : ZMod 2) else 0) := by
          refine sum_congr rfl fun t _ => ?_
          rcases γ t with ⟨x, c⟩
          exact hpair x c _
    _ = if halfEdgeEdge v d ∈ closedWalkSupport γ then 1 else 0 := by
          by_cases hmem : halfEdgeEdge v d ∈ closedWalkSupport γ
          · rw [if_pos hmem]
            obtain ⟨t0, -, ht0⟩ := Finset.mem_image.mp hmem
            rw [Finset.sum_eq_single t0]
            · simp [ht0]
            · intro t _ htne
              rw [if_neg]
              intro h
              exact htne (hinj (h.trans ht0.symm))
            · simp
          · rw [if_neg hmem]
            apply sum_eq_zero
            intro t _
            rw [if_neg]
            intro h
            exact hmem (Finset.mem_image.mpr ⟨t, mem_univ _, h⟩)

/-- 頂点 `(i, j)` の右・下・左・上の半辺の使用回数は、台の横辺 `(i, j)`・縦辺 `(i, j)`・
横辺 `(i, j - 1)`・縦辺 `(i - 1, j)` の係数である。 -/
theorem walkHalfEdgeUse_coefficients {m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun k => (γ k).1)
    (i j : ZMod L) :
    walkHalfEdgeUse γ (i, j) 0 = horizontalChainCoefficient L (closedWalkSupport γ) i j ∧
      walkHalfEdgeUse γ (i, j) 1 = verticalChainCoefficient L (closedWalkSupport γ) i j ∧
      walkHalfEdgeUse γ (i, j) 2 =
        horizontalChainCoefficient L (closedWalkSupport γ) i (j - 1) ∧
      walkHalfEdgeUse γ (i, j) 3 =
        verticalChainCoefficient L (closedWalkSupport γ) (i - 1) j := by
  simp only [walkHalfEdgeUse_eq_support γ hγ hinj, horizontalChainCoefficient_eq_mem,
    verticalChainCoefficient_eq_mem]
  have h10 : (1 : ZMod 4) ≠ 0 := by decide
  have h20 : (2 : ZMod 4) ≠ 0 := by decide
  have h21 : (2 : ZMod 4) ≠ 1 := by decide
  have h30 : (3 : ZMod 4) ≠ 0 := by decide
  have h31 : (3 : ZMod 4) ≠ 1 := by decide
  have h32 : (3 : ZMod 4) ≠ 2 := by decide
  refine ⟨?_, ?_, ?_, ?_⟩ <;> unfold halfEdgeEdge <;> simp [h10, h20, h21, h30, h31, h32]

omit [NeZero L] in
/-- 一つの通過の四つの半辺の使用回数の和は零である。 -/
theorem passHalfEdgeUse_four (e f : OrientedEdge L) :
    passHalfEdgeUse e f 0 + passHalfEdgeUse e f 2 + passHalfEdgeUse e f 1 +
      passHalfEdgeUse e f 3 = 0 := by
  unfold passHalfEdgeUse
  generalize directionNumber e = a
  generalize directionNumber f = a'
  revert a a'
  decide

/-- 閉歩道の台は各頂点で偶次数である（辺係数の頂点条件）。 -/
theorem closedWalkSupport_even {m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) (hinj : Function.Injective fun k => (γ k).1)
    (i j : ZMod L) :
    horizontalChainCoefficient L (closedWalkSupport γ) i j +
        horizontalChainCoefficient L (closedWalkSupport γ) i (j - 1) +
      verticalChainCoefficient L (closedWalkSupport γ) i j +
        verticalChainCoefficient L (closedWalkSupport γ) (i - 1) j = 0 := by
  obtain ⟨h0, h1, h2, h3⟩ := walkHalfEdgeUse_coefficients γ hγ hinj i j
  rw [← h0, ← h1, ← h2, ← h3]
  unfold walkHalfEdgeUse
  rw [← sum_add_distrib, ← sum_add_distrib, ← sum_add_distrib]
  apply sum_eq_zero
  intro r _
  split_ifs
  · exact passHalfEdgeUse_four _ _
  · simp

/-- 混合横断数を、通過の対ごとの方向番号の条件の指示子の和として書く。 -/
theorem closedWalkMutualCrossingNumber_eq_directionSum {m n : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (η : Fin (n + 1) → OrientedEdge L) (hη : closedNonbacktrackingWalk η) :
    (closedWalkMutualCrossingNumber γ hγ η hη : ZMod 2) =
      ∑ r, ∑ s, if orientedTarget (γ r) = orientedTarget (η s) ∧
          directionNumber (γ (closedWalkSuccessor r)) = directionNumber (γ r) ∧
          directionNumber (η (closedWalkSuccessor s)) = directionNumber (η s) ∧
          directionAxis (directionNumber (γ r)) ≠ directionAxis (directionNumber (η s))
        then (1 : ZMod 2) else 0 := by
  classical
  unfold closedWalkMutualCrossingNumber
  rw [Finset.natCast_card_filter, Finset.sum_product]
  refine sum_congr rfl fun r _ => sum_congr rfl fun s _ => ?_
  refine if_congr ?_ rfl rfl
  have hr : γ (closedWalkSuccessor r) ∈ nonbacktrackingSuccessors (γ r) :=
    closedWalkPass_valid γ hγ r
  have hs : η (closedWalkSuccessor s) ∈ nonbacktrackingSuccessors (η s) :=
    closedWalkPass_valid η hη s
  unfold edgeTransverseCrossing
  dsimp only
  rw [stepTurning_eq_zero_iff _ _ hr, stepTurning_eq_zero_iff _ _ hs]
  constructor
  · rintro ⟨-, -, h1, h2, h3, h4⟩
    exact ⟨h1, h2, h3, h4⟩
  · rintro ⟨h1, h2, h3, h4⟩
    exact ⟨hr, hs, h1, h2, h3, h4⟩

/-- 式変形の一行目: 混合横断数の偶奇は、頂点ごとの局所項「左を `γ`・上を `η`」+
「下を `γ`・右を `η`」の和である。 -/
theorem closedWalkMutualCrossingNumber_eq_vertexSum {m n : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (η : Fin (n + 1) → OrientedEdge L) (hη : closedNonbacktrackingWalk η)
    (hdisjE : ∀ r s, (γ r).1 ≠ (η s).1) :
    (closedWalkMutualCrossingNumber γ hγ η hη : ZMod 2) =
      ∑ v, (walkHalfEdgeUse γ v 2 * walkHalfEdgeUse η v 3 +
        walkHalfEdgeUse γ v 1 * walkHalfEdgeUse η v 0) := by
  rw [closedWalkMutualCrossingNumber_eq_directionSum]
  calc
    (∑ r, ∑ s, if orientedTarget (γ r) = orientedTarget (η s) ∧
          directionNumber (γ (closedWalkSuccessor r)) = directionNumber (γ r) ∧
          directionNumber (η (closedWalkSuccessor s)) = directionNumber (η s) ∧
          directionAxis (directionNumber (γ r)) ≠ directionAxis (directionNumber (η s))
        then (1 : ZMod 2) else 0)
        = ∑ r, ∑ s, if orientedTarget (γ r) = orientedTarget (η s) then
            (passHalfEdgeUse (γ r) (γ (closedWalkSuccessor r)) 2 *
                passHalfEdgeUse (η s) (η (closedWalkSuccessor s)) 3 +
              passHalfEdgeUse (γ r) (γ (closedWalkSuccessor r)) 1 *
                passHalfEdgeUse (η s) (η (closedWalkSuccessor s)) 0) else 0 := by
          refine sum_congr rfl fun r _ => sum_congr rfl fun s _ => ?_
          by_cases hv : orientedTarget (γ r) = orientedTarget (η s)
          · rw [if_pos hv, ← passHalfEdgeUse_local_crossing _ _ _ _
              (passHalfEdges_disjoint γ hγ η hη hdisjE r s hv)]
            simp [hv]
          · simp [hv]
    _ = ∑ r, ∑ s, ∑ v, ((if orientedTarget (γ r) = v then
              passHalfEdgeUse (γ r) (γ (closedWalkSuccessor r)) 2 else 0) *
            (if orientedTarget (η s) = v then
              passHalfEdgeUse (η s) (η (closedWalkSuccessor s)) 3 else 0) +
          (if orientedTarget (γ r) = v then
              passHalfEdgeUse (γ r) (γ (closedWalkSuccessor r)) 1 else 0) *
            (if orientedTarget (η s) = v then
              passHalfEdgeUse (η s) (η (closedWalkSuccessor s)) 0 else 0)) := by
          refine sum_congr rfl fun r _ => sum_congr rfl fun s _ => ?_
          by_cases hv : orientedTarget (γ r) = orientedTarget (η s)
          · rw [if_pos hv, Finset.sum_eq_single (orientedTarget (γ r))]
            · simp [hv]
            · intro v _ hne
              simp [Ne.symm hne]
            · simp
          · rw [if_neg hv]
            symm
            apply sum_eq_zero
            intro v _
            by_cases h1 : orientedTarget (γ r) = v
            · have h2 : orientedTarget (η s) ≠ v := fun h => hv (h1.trans h.symm)
              simp [h2]
            · simp [h1]
    _ = ∑ v, ∑ r, ∑ s, ((if orientedTarget (γ r) = v then
              passHalfEdgeUse (γ r) (γ (closedWalkSuccessor r)) 2 else 0) *
            (if orientedTarget (η s) = v then
              passHalfEdgeUse (η s) (η (closedWalkSuccessor s)) 3 else 0) +
          (if orientedTarget (γ r) = v then
              passHalfEdgeUse (γ r) (γ (closedWalkSuccessor r)) 1 else 0) *
            (if orientedTarget (η s) = v then
              passHalfEdgeUse (η s) (η (closedWalkSuccessor s)) 0 else 0)) :=
          (sum_congr rfl fun r _ => sum_comm).trans sum_comm
    _ = ∑ v, (walkHalfEdgeUse γ v 2 * walkHalfEdgeUse η v 3 +
          walkHalfEdgeUse γ v 1 * walkHalfEdgeUse η v 0) := by
          refine sum_congr rfl fun v _ => ?_
          simp only [walkHalfEdgeUse, sum_mul_sum, ← sum_add_distrib]

/-- 式変形の二行目まで: 混合横断数の偶奇は二つの台の交差数である。 -/
theorem closedWalkMutualCrossingNumber_eq_intersection {m n : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (η : Fin (n + 1) → OrientedEdge L) (hη : closedNonbacktrackingWalk η)
    (hinjγ : Function.Injective fun k => (γ k).1)
    (hinjη : Function.Injective fun k => (η k).1)
    (hdisjE : ∀ r s, (γ r).1 ≠ (η s).1) :
    (closedWalkMutualCrossingNumber γ hγ η hη : ZMod 2) =
      evenEdgeChainIntersection L (closedWalkSupport γ) (closedWalkSupport η) := by
  rw [closedWalkMutualCrossingNumber_eq_vertexSum γ hγ η hη hdisjE]
  set HC := horizontalChainCoefficient L (closedWalkSupport γ)
  set VC := verticalChainCoefficient L (closedWalkSupport γ)
  set HD := horizontalChainCoefficient L (closedWalkSupport η)
  set VD := verticalChainCoefficient L (closedWalkSupport η)
  calc
    (∑ v : Vertex L, (walkHalfEdgeUse γ v 2 * walkHalfEdgeUse η v 3 +
        walkHalfEdgeUse γ v 1 * walkHalfEdgeUse η v 0))
        = ∑ v : ZMod L × ZMod L, (HC v.1 (v.2 - 1) * VD (v.1 - 1) v.2 +
            VC v.1 v.2 * HD v.1 v.2) := by
          refine sum_congr rfl fun v _ => ?_
          rcases v with ⟨i, j⟩
          obtain ⟨-, hγ1, hγ2, -⟩ := walkHalfEdgeUse_coefficients γ hγ hinjγ i j
          obtain ⟨hη0, -, -, hη3⟩ := walkHalfEdgeUse_coefficients η hη hinjη i j
          rw [hγ1, hγ2, hη0, hη3]
    _ = ∑ i : ZMod L, ∑ j : ZMod L, (HC i (j - 1) * VD (i - 1) j + VC i j * HD i j) :=
          Fintype.sum_prod_type _
    _ = ∑ i : ZMod L, ∑ j : ZMod L, (HC i j * VD (i - 1) (j + 1) + VC i j * HD i j) := by
          refine sum_congr rfl fun i _ => ?_
          rw [sum_add_distrib, sum_add_distrib]
          congr 1
          exact Fintype.sum_equiv (Equiv.subRight (1 : ZMod L)) _ _
            (fun j => by simp)
    _ = evenEdgeChainIntersection L (closedWalkSupport γ) (closedWalkSupport η) := rfl

/-- 本文の主張: 混合横断数の偶奇は交差数に等しく、切断線偶奇で `h_C v_D + v_C h_D` になる。 -/
theorem closedWalkMutualCrossingNumber_eq_cutParity {m n : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (η : Fin (n + 1) → OrientedEdge L) (hη : closedNonbacktrackingWalk η)
    (hinjγ : Function.Injective fun k => (γ k).1)
    (hinjη : Function.Injective fun k => (η k).1)
    (hdisjE : ∀ r s, (γ r).1 ≠ (η s).1) :
    (closedWalkMutualCrossingNumber γ hγ η hη : ZMod 2) =
      (∑ i', horizontalChainCoefficient L (closedWalkSupport γ) i' (-1)) *
          (∑ j', verticalChainCoefficient L (closedWalkSupport η) (-1) j') +
        (∑ j', verticalChainCoefficient L (closedWalkSupport γ) (-1) j') *
          (∑ i', horizontalChainCoefficient L (closedWalkSupport η) i' (-1)) := by
  rw [closedWalkMutualCrossingNumber_eq_intersection γ hγ η hη hinjγ hinjη hdisjE]
  exact evenEdgeChainIntersection_eq_cutParity _ _
    (closedWalkSupport_even γ hγ hinjγ) (closedWalkSupport_even η hη hinjη)

/-- 具体版の一行目が必要十分版 `mutualCrossing_parity` の特殊化として得られること。
通過の添字を歩道の添字、頂点を格子頂点、方向を方向番号に取る。 -/
theorem closedWalkMutualCrossingNumber_eq_vertexSum_from_necSuf {m n : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ)
    (η : Fin (n + 1) → OrientedEdge L) (hη : closedNonbacktrackingWalk η)
    (hdisjE : ∀ r s, (γ r).1 ≠ (η s).1) :
    (closedWalkMutualCrossingNumber γ hγ η hη : ZMod 2) =
      ∑ v, (walkHalfEdgeUse γ v 2 * walkHalfEdgeUse η v 3 +
        walkHalfEdgeUse γ v 1 * walkHalfEdgeUse η v 0) := by
  rw [closedWalkMutualCrossingNumber_eq_directionSum]
  exact Ising2DLambda.NecSuf.KacWard.mutualCrossing_parity
    (fun r => orientedTarget (γ r)) (fun s => orientedTarget (η s))
    (fun r => directionNumber (γ r)) (fun r => directionNumber (γ (closedWalkSuccessor r)))
    (fun s => directionNumber (η s)) (fun s => directionNumber (η (closedWalkSuccessor s)))
    (fun r s hv => passHalfEdges_disjoint γ hγ η hη hdisjE r s hv)

end HalfEdge

end Ising2DLambda.KacWard

/-
「スピン単項式の和は偶部分グラフだけで非零になる」の具体版。
人手証明と同じく、辺ごとの積を頂点ごとの冪へ並べ替え、配位全体の和を
各頂点の二値和の積へ分配する。住処は ℕ と ℤ であり、ℝ / ℂ は現れない。

`claim_even_subgraph_spin_sum` との対応:
- `edgeSubsetMonomial_eq_vertexProduct`: 辺ごとの積を頂点ごとの冪へ並べ替える段。
- `Fintype.prod_sum`: 配位和を頂点ごとの二値和の積へ分配する段。
- `sum_spinValue_pow`: 局所和が偶次数で 2、奇次数で 0 になる段。
- 最後の場合分け: 全頂点が偶数なら一定値の積、そうでなければ零因子を含む積になる段。
-/
import Ising2DLambda.FisherZero.LowTemperaturePolynomial
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial

/-- 辺の部分集合 `A` が頂点 `v` に持つ、番号つき端点の個数 `d_A(v)`。 -/
def edgeSubsetIncidenceCount (L : ℕ) (A : Finset (Edge L)) (v : Vertex L) : ℕ :=
  ∑ e ∈ A, ((if boundary0 L e = v then 1 else 0) +
    (if boundary1 L e = v then 1 else 0))

/-- すべての頂点で端点数が偶数であること `Even_L(A)`。 -/
def IsEvenEdgeSubset (L : ℕ) (A : Finset (Edge L)) : Prop :=
  ∀ v : Vertex L, Even (edgeSubsetIncidenceCount L A v)

instance (L : ℕ) [NeZero L] (A : Finset (Edge L)) : Decidable (IsEvenEdgeSubset L A) := by
  unfold IsEvenEdgeSubset
  infer_instance

/-- 偶部分グラフ生成多項式 `P_L(y)`。 -/
noncomputable def evenSubgraphPolynomial (L : ℕ) [NeZero L] : Polynomial ℤ := by
  classical
  exact ∑ A ∈ (univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L),
    Polynomial.X ^ A.card

/-- 辺部分集合 `A` に対応するスピン単項式の全配位和 `S_L(A)`。 -/
def edgeSubsetSpinSum (L : ℕ) [NeZero L] (A : Finset (Edge L)) : ℤ :=
  ∑ σ : Config L, ∏ e ∈ A, (σ (boundary0 L e)).1 * (σ (boundary1 L e)).1

lemma spinValue_pow (s : SpinValue) (n : ℕ) :
    s.1 ^ n = if Even n then 1 else s.1 := by
  rcases s with ⟨s, rfl | rfl⟩
  · simp
  · exact neg_one_pow_eq_ite

lemma sum_spinValue_pow (n : ℕ) :
    ∑ s : SpinValue, s.1 ^ n = if Even n then 2 else 0 := by
  classical
  let oneSpin : SpinValue := ⟨1, Or.inl rfl⟩
  let negSpin : SpinValue := ⟨-1, Or.inr rfl⟩
  have huniv : (univ : Finset SpinValue) = {oneSpin, negSpin} := by
    ext s
    rcases s with ⟨s, rfl | rfl⟩ <;> simp [oneSpin, negSpin]
  change ∑ s ∈ (univ : Finset SpinValue), s.1 ^ n = _
  rw [huniv]
  have hne : oneSpin ≠ negSpin := by
    intro hEq
    have hvalue : (1 : ℤ) = -1 := congrArg Subtype.val hEq
    omega
  have hnotmem : oneSpin ∉ ({negSpin} : Finset SpinValue) := by simpa using hne
  by_cases h : Even n
  · rw [sum_insert hnotmem, sum_singleton]
    simp [oneSpin, negSpin, h, h.neg_one_pow]
  · have hOdd : Odd n := Nat.not_even_iff_odd.mp h
    rw [sum_insert hnotmem, sum_singleton]
    norm_num [oneSpin, negSpin, h, hOdd.neg_one_pow]

lemma edgeSubsetMonomial_eq_vertexProduct (L : ℕ) [NeZero L]
    (A : Finset (Edge L)) (σ : Config L) :
    (∏ e ∈ A, (σ (boundary0 L e)).1 * (σ (boundary1 L e)).1) =
      ∏ v : Vertex L, (σ v).1 ^ edgeSubsetIncidenceCount L A v := by
  classical
  simp only [edgeSubsetIncidenceCount, ← Finset.prod_pow_eq_pow_sum]
  rw [Finset.prod_comm]
  apply Finset.prod_congr rfl
  intro e he
  simp_rw [pow_add]
  rw [Finset.prod_mul_distrib]
  simp

/-- `claim_even_subgraph_spin_sum` の具体版。 -/
theorem evenSubgraph_spinSum (L : ℕ) [NeZero L] (A : Finset (Edge L)) :
    edgeSubsetSpinSum L A = if IsEvenEdgeSubset L A then 2 ^ L ^ 2 else 0 := by
  classical
  rw [edgeSubsetSpinSum]
  simp_rw [edgeSubsetMonomial_eq_vertexProduct L A]
  change (∑ σ : Vertex L → SpinValue,
    ∏ v : Vertex L, (σ v).1 ^ edgeSubsetIncidenceCount L A v) = _
  rw [← Fintype.prod_sum (fun v : Vertex L => fun s : SpinValue =>
    s.1 ^ edgeSubsetIncidenceCount L A v)]
  simp_rw [sum_spinValue_pow]
  by_cases hEven : IsEvenEdgeSubset L A
  · rw [if_pos hEven]
    simp only [IsEvenEdgeSubset] at hEven
    simp_rw [if_pos (hEven _)]
    rw [Finset.prod_const, card_univ, card_vertex]
  · rw [if_neg hEven]
    simp only [IsEvenEdgeSubset] at hEven
    push Not at hEven
    obtain ⟨v, hv⟩ := hEven
    apply Finset.prod_eq_zero (mem_univ v)
    rw [if_neg hv]

end Ising2DLambda.FisherZero

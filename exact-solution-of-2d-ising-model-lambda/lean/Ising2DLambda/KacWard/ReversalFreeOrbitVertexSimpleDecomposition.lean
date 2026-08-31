/-
章「トーラス上の Kac--Ward 行列式」の
「反転対を含まない非後退置換の軌道列は頂点単純な閉路族へ分かれる」
（`claim_reversal_free_orbit_vertex_simple_decomposition`）の具体版。

人手証明と同じく、まず既証の軌道定理と反転対なしの仮定から軌道列の台の辺の
相異なりを得る。次に、台の相異なりを保つ接触点分割を接触対数が零になるまで
累積帰納で繰り返し、台の目録と二つの切断線偶奇を保存する。
-/
import Mathlib.Tactic
import Ising2DLambda.KacWard.ReversalFreeOrbitSupportDistinct
import Ising2DLambda.NecSuf.KacWard.ReversalFreeOrbitVertexSimpleDecomposition

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- `claim_reversal_free_orbit_vertex_simple_decomposition` の具体版。 -/
theorem reversalFreeOrbit_vertexSimpleDecomposition (L : ℕ) [NeZero L]
    (σ : Equiv.Perm (OrientedEdge L))
    (hfree : ∀ f, f ∈ movedOrientedEdges σ → reversal f ∉ movedOrientedEdges σ)
    (e : OrientedEdge L) (he : e ∈ movedOrientedEdges σ)
    {W : Type} (orbit : W) (walkLength : W → ℕ)
    (edgeAt : W → ℕ → Edge L)
    (contactCount : W → ℕ) (baseEdges : W → Multiset (Edge L))
    (horizontalParity verticalParity : W → ℕ)
    (horbitLength : walkLength orbit = minimalReturnTime σ e)
    (horbitEdge : ∀ j, j < walkLength orbit →
      edgeAt orbit j = (((⇑σ)^[j] e).1))
    (split : ∀ γ : W,
      (∀ j k, j < walkLength γ → k < walkLength γ →
        edgeAt γ j = edgeAt γ k → j = k) →
      0 < contactCount γ → ∃ γA γB : W,
        (∀ j k, j < walkLength γA → k < walkLength γA →
          edgeAt γA j = edgeAt γA k → j = k) ∧
        (∀ j k, j < walkLength γB → k < walkLength γB →
          edgeAt γB j = edgeAt γB k → j = k) ∧
        contactCount γA + contactCount γB < contactCount γ ∧
        baseEdges γA + baseEdges γB = baseEdges γ ∧
        (horizontalParity γA + horizontalParity γB) % 2 = horizontalParity γ % 2 ∧
        (verticalParity γA + verticalParity γB) % 2 = verticalParity γ % 2) :
    ∃ family : List W,
      family ≠ [] ∧
      (∀ δ ∈ family,
        (∀ j k, j < walkLength δ → k < walkLength δ →
          edgeAt δ j = edgeAt δ k → j = k) ∧
        contactCount δ = 0) ∧
      (family.map baseEdges).sum = baseEdges orbit ∧
      (family.map horizontalParity).sum % 2 = horizontalParity orbit % 2 ∧
      (family.map verticalParity).sum % 2 = verticalParity orbit % 2 := by
  let edgeSimple : W → Prop := fun γ ↦
    ∀ j k, j < walkLength γ → k < walkLength γ →
      edgeAt γ j = edgeAt γ k → j = k
  have horbitSimple : edgeSimple orbit := by
    intro j k hj hk hbase
    have hjr : j + 1 ≤ minimalReturnTime σ e := by omega
    have hkr : k + 1 ≤ minimalReturnTime σ e := by omega
    have hbase' : (((⇑σ)^[j] e).1) = (((⇑σ)^[k] e).1) := by
      rw [← horbitEdge j hj, ← horbitEdge k hk]
      exact hbase
    have h := reversalFreeOrbitSupportEdges_distinct L σ hfree e he
      (j + 1) (k + 1) (by omega) hjr (by omega) hkr
    simpa using h hbase'
  exact Ising2DLambda.NecSuf.KacWard.invariant_elimination_by_splitting_necSuf
    contactCount baseEdges horizontalParity verticalParity edgeSimple split orbit horbitSimple

end Ising2DLambda.KacWard

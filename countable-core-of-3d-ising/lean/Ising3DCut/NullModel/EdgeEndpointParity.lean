/-
人手証明の主張「辺の両端の座標和の偶奇は異なる」
（ラベル `claim_edge_endpoints_parity`）の具体版。

人手証明の一続きの式とこのファイルの対応:

  `s(∂₁e) = s(∂₀e) + 1`              `coordSum_endpoint1`
  第二端点の偶奇は第一端点の否定       `parity_endpoint1`
  したがって両端の偶奇は異なる         `edge_endpoints_parity_differ`

点は三つの自然数座標と各座標が箱の範囲内である証拠、辺は始点・方向と次の点が
箱内にある証拠として、人手証明と同じ具体度で定義する。一般の二部グラフの定理へは委ねない。

住処: `Fin`、`Nat`、有限集合 `Bool` のみ。ℝ / ℂ は現れない。
-/
import Mathlib.Data.Fin.Basic
import Mathlib.Data.Fintype.Basic
import Mathlib.Data.Nat.Bits
import Mathlib.Tactic.FinCases

namespace Ising3DCut.NullModel

/-- 一辺の長さ `L` の箱の点。 -/
def Site (L : ℕ) := {a : Fin 3 → ℕ // ∀ i, a i < L}

/-- 始点と方向の組で表した辺。`next_lt` は第二端点も箱内にあることを表す。 -/
structure Edge (L : ℕ) where
  start : Site L
  axis : Fin 3
  next_lt : start.1 axis + 1 < L

/-- 第一端点。 -/
def endpoint0 {L : ℕ} (e : Edge L) : Site L := e.start

/-- 第二端点。始点の `axis` 成分だけを 1 増やす。 -/
def endpoint1 {L : ℕ} (e : Edge L) : Site L :=
  ⟨Function.update e.start.1 e.axis (e.start.1 e.axis + 1), by
    intro i
    by_cases hi : i = e.axis
    · subst i
      simp only [Function.update_self]
      exact e.next_lt
    · rw [Function.update_of_ne hi]
      exact e.start.2 i⟩

/-- 三つの座標の和。 -/
def coordSum {L : ℕ} (a : Site L) : ℕ := a.1 0 + a.1 1 + a.1 2

/-- 座標和の偶奇。`false` が偶数、`true` が奇数を表す。 -/
def parity {L : ℕ} (a : Site L) : Bool := Nat.bodd (coordSum a)

/-- 人手証明の式変形。第二端点の座標和は第一端点の座標和より 1 大きい。 -/
lemma coordSum_endpoint1 {L : ℕ} (e : Edge L) :
    coordSum (endpoint1 e) = coordSum (endpoint0 e) + 1 := by
  generalize haxis : e.axis = axis
  fin_cases axis <;>
    simp [coordSum, endpoint1, endpoint0, Function.update, haxis, Nat.add_assoc, Nat.add_comm]
  all_goals omega

/-- 座標和が 1 増えるので、第二端点の偶奇は第一端点の偶奇の否定になる。 -/
lemma parity_endpoint1 {L : ℕ} (e : Edge L) :
    parity (endpoint1 e) = !(parity (endpoint0 e)) := by
  rw [parity, parity, coordSum_endpoint1]
  exact Nat.bodd_succ _

/-- `claim_edge_endpoints_parity` の具体版。 -/
theorem edge_endpoints_parity_differ {L : ℕ} (e : Edge L) :
    parity (endpoint0 e) ≠ parity (endpoint1 e) := by
  rw [parity_endpoint1]
  cases parity (endpoint0 e) <;> decide

end Ising3DCut.NullModel

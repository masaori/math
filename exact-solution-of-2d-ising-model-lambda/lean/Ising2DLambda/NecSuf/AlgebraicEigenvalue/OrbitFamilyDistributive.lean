/-
主張「軌道の部分集合にわたる有限積の分配則」の必要十分版のうち、**和の添字を作る段**。

人手証明は $\prod_{O\in s}\bigl(\sum_{\psi\in\mathfrak{B}_O}g(O,\psi)\bigr)$ を
$\sum_{\alpha\in\mathfrak{A}(s)}\prod_{O\in s}g(O,\alpha(O))$ へ書き直す。右辺の和は
組の全体 `FamilyOn B s` にわたる和なので、これを和の添字にするには
`Fintype (FamilyOn B s)` が要る。ここではそれと、帰納法の一歩で添字を取り替えるための
1 対 1 対応（`Equiv`）を用意する。分配則そのものはこのファイルには無い。

`FamilyOn B s = ∀ i, i ∈ s → B i` は「命題の上の依存関数型」なので、
mathlib の `Pi.fintype` が直接は効かない（前提の型 `i ∈ s` が有限型として扱えない）。
そこで部分型の上の依存関数型 `∀ i : {x // x ∈ s}, B i.1` との 1 対 1 対応を置き、
`Fintype.ofEquiv` で有限性を移す。両向きの往復はいずれも `rfl` で閉じる
（引数の受け渡しを組み替えているだけで、値を作り直していないためである）。

この経路は**添字の型 `ι` が有限であることを要求しない**。要求するのは
`s` が有限集合であること（`Finset` なのでもとから有限）、添字の相等が判定できること、
そして各成分の型が有限であることだけである。

住処: ここに ℝ / ℂ は現れない（現れるのは有限集合 `s : Finset ι` と、
添字ごとの型 `B i` の元だけである）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitFamilyInsert
import Mathlib.Data.Fintype.Pi
import Mathlib.Logic.Equiv.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {ι : Type*} [DecidableEq ι] {B : ι → Type*}

/-- 組の全体 `FamilyOn B s` と、部分型の上の依存関数型との 1 対 1 対応。

`FamilyOn B s` は「元と、それが `s` に属する証明」の 2 つを受け取る形、
右側は「その 2 つを組にした部分型の元」を 1 つ受け取る形であり、
引数の受け渡しが違うだけで同じ対応を表す（往復はどちらも `rfl`）。 -/
def familyOnEquivSubtypePi (B : ι → Type*) (s : Finset ι) :
    FamilyOn B s ≃ ∀ i : {x : ι // x ∈ s}, B i.1 where
  toFun α := fun i => α i.1 i.2
  invFun f := fun i hi => f ⟨i, hi⟩
  left_inv _ := rfl
  right_inv _ := rfl

/-- 組の全体は有限型である。

`ι` が有限であることは要求しない。`s` は `Finset` なのでもとから有限であり、
上の 1 対 1 対応で部分型の上の依存関数型へ移せば `Pi.fintype` が効く。 -/
instance familyOnFintype [∀ i, Fintype (B i)] (s : Finset ι) :
    Fintype (FamilyOn B s) :=
  Fintype.ofEquiv _ (familyOnEquivSubtypePi B s).symm

/-- 人手証明の一歩で和の添字を取り替えるための 1 対 1 対応。

`ins` と `spl` が互いに逆であること（`insertFamily_leftInverse` と
`insertFamily_rightInverse`）をそのまま `Equiv` の 2 つの往復に当てる。
`i₀ ∉ s` を要求するのは第 1 の往復の側だけだが、`Equiv` は両向きを一緒に持つので
ここでは仮定として置く。 -/
def insertFamilyEquiv {s : Finset ι} {i₀ : ι} (hi₀ : i₀ ∉ s) :
    B i₀ × FamilyOn B s ≃ FamilyOn B (insert i₀ s) where
  toFun p := insertFamily i₀ p.1 p.2
  invFun β := splitFamily i₀ β
  left_inv p := by
    -- 第 1 の往復。`spl(ins(x, α)) = (x, α)`。ここで `i₀ ∉ s` が効く。
    simpa using insertFamily_leftInverse hi₀ p.1 p.2
  right_inv β := by
    -- 第 2 の往復。`ins(spl(β)) = β`。こちらは `i₀ ∉ s` を使わない。
    exact insertFamily_rightInverse β

end Ising2DLambda.NecSuf.AlgebraicEigenvalue

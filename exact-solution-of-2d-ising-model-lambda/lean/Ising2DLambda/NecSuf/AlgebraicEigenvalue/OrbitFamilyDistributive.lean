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
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Logic.Equiv.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset

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

/-- 組の全体は、空集合の上ではちょうど 1 元である。

人手証明の出発点（`𝔄(∅)` がちょうど 1 元であること）に当たる。
`i ∈ ∅` を満たす `i` が無いので、組は「値を 1 つも与えない対応」しかない。 -/
instance familyOnEmptyUnique : Unique (FamilyOn B (∅ : Finset ι)) where
  default := fun _ hi => absurd hi (Finset.notMem_empty _)
  uniq _ := funext fun _ => funext fun hi => absurd hi (Finset.notMem_empty _)

variable {R : Type*} [CommSemiring R]

/-- 人手証明の一歩の第 1 の等号と最後の等号に当たる補題。

添字を 1 つ足した組にわたる積は、足した添字での値と、残りの組にわたる積の積である。
`s.attach` にわたる積で書いているのは、成分の値を取り出すのに所属の証明が要るためである。 -/
theorem prod_attach_insertFamily {s : Finset ι} {i₀ : ι} (hi₀ : i₀ ∉ s)
    (g : (i : ι) → B i → R) (x : B i₀) (α : FamilyOn B s) :
    (∏ i ∈ (insert i₀ s).attach, g i.1 (insertFamily i₀ x α i.1 i.2))
      = g i₀ x * ∏ i ∈ s.attach, g i.1 (α i.1 i.2) := by
  classical
  rw [Finset.attach_insert, Finset.prod_insert, Finset.prod_image]
  · congr 1
    · -- 足した添字での値。`ins` の場合分けの前者。
      simp [insertFamily]
    · -- 残りの添字での値。`i ∈ s` なら `i ≠ i₀`（`hi₀` による）ので後者。
      refine Finset.prod_congr rfl ?_
      rintro ⟨i, hi⟩ -
      have hne : i ≠ i₀ := fun h => hi₀ (h ▸ hi)
      simp [insertFamily, dif_neg hne]
  · -- 像を取る写像は単射である（第 1 成分が等しければ部分型の元として等しい）。
    rintro ⟨a, ha⟩ - ⟨b, hb⟩ - h
    have hab : a = b := congrArg Subtype.val h
    exact Subtype.ext hab
  · -- 足した添字は像に入らない（`hi₀` による）。
    intro hmem
    rw [Finset.mem_image] at hmem
    obtain ⟨⟨a, ha⟩, -, h⟩ := hmem
    have hai : a = i₀ := congrArg Subtype.val h
    exact hi₀ (hai ▸ ha)

/-- 人手証明の主張「軌道の部分集合にわたる有限積の分配則」の必要十分版。

`s` の元の個数についての帰納法で示す。出発点は空集合、一歩は
`insertFamilyEquiv` で和の添字を組へ取り替える段である。

値の側に要求するのは可換半環だけである（引き算も、零因子が無いことも使わない）。
添字の型 `ι` が有限であることは要求しない。 -/
theorem prod_sum_eq_sum_prod_family [∀ i, Fintype (B i)]
    (g : (i : ι) → B i → R) (s : Finset ι) :
    (∏ i ∈ s, ∑ x : B i, g i x)
      = ∑ α : FamilyOn B s, ∏ i ∈ s.attach, g i.1 (α i.1 i.2) := by
  classical
  induction s using Finset.induction_on with
  | empty =>
      -- 出発点。両辺とも空積・1 元の和で `1` である。
      simp
  | insert i₀ s hi₀ ih =>
      -- 人手証明の 8 つの等号との対応は具体版のコメントと同じである
      --   （第 1: `Finset.prod_insert`、第 2: `ih`、第 3・第 4: `Fintype.sum_mul_sum`、
      --     第 7: `Equiv.sum_comp`、第 5: `Fintype.sum_prod_type`、
      --     第 6・第 8: `prod_attach_insertFamily`）。
      rw [Finset.prod_insert hi₀, ih, Fintype.sum_mul_sum]
      rw [← Equiv.sum_comp (insertFamilyEquiv (B := B) hi₀)]
      rw [Fintype.sum_prod_type]
      refine Finset.sum_congr rfl ?_
      rintro x -
      refine Finset.sum_congr rfl ?_
      rintro α -
      exact (prod_attach_insertFamily hi₀ g x α).symm

end Ising2DLambda.NecSuf.AlgebraicEigenvalue

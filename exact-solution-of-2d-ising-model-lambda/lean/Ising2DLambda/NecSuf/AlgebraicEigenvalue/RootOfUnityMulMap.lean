/-
主張「1 の冪根を掛ける写像は全単射である」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.RootOfUnityMulMap`）と同じである。
すなわち、掛ける写像を 1 つ置き、2 つの往復（`v` を掛けてから `w`、`w` を掛けてから `v`）が
恒等写像であることを結合則・単位元だけで示し、そこから単射性（往復を 2 度当てる）と
全射性（往復が原像を与える）を出す。

  使っている性質                     なぜ削れないか
  `Monoid M`                         積の結合則と単位元。2 つの往復の各段がこれである。
  `hmul : S が積で閉じている`         掛ける写像が S から S への写像であることに要る。
  `hw : w ∈ S`                       掛ける写像を作る元が S に属することに要る。
  `hv : v ∈ S`                       逆向きの写像を作る元が S に属することに要る。
  `hvw : v * w = 1`                  第 1 の往復そのものである。
  `hwv : w * v = 1`                  第 2 の往復そのものである。

削れたもの: 加法・零元・分配則・逆元の存在・体であること・代数閉であること・
値が代数的数であること（`Qbar`）・`n` と「n 乗して 1 になる」という条件そのもの・
`v` が `w` の冪であること・**積の可換性**。

可換性が削れたことがこの版の眼目である。具体版は第 2 の往復で
`w * w^{n-1} = w^{n-1} * w` を 1 度使うが、必要十分版では両側の等式
`hvw` / `hwv` を仮定に置くことで可換則が消える。すなわち可換性は
「片側の逆元から反対側の逆元を得る手段」としてしか使われていない。

住処: ここに ℝ / ℂ は現れない（元は一般のモノイドの元）。
-/
import Mathlib.Algebra.Group.Defs
import Mathlib.Data.Set.Basic
import Mathlib.Logic.Function.Defs

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 必要十分版の写像。`S` が積で閉じているとき、`w ∈ S` を掛ける操作は `S` から `S` への
写像である。 -/
def mulMapNecSuf {M : Type*} [Monoid M] (S : Set M)
    (hmul : ∀ a b : M, a ∈ S → b ∈ S → a * b ∈ S) {w : M} (hw : w ∈ S) : S → S :=
  fun z => ⟨w * z.1, hmul _ _ hw z.2⟩

/-- 必要十分版の本体。`S` が積で閉じ、`w, v ∈ S` が `v * w = 1` かつ `w * v = 1` を
満たすならば、`w` を掛ける操作は `S` の上の全単射である。 -/
theorem mulMap_bijective_necSuf {M : Type*} [Monoid M] (S : Set M)
    (hmul : ∀ a b : M, a ∈ S → b ∈ S → a * b ∈ S) {w v : M}
    (hw : w ∈ S) (hv : v ∈ S) (hvw : v * w = 1) (hwv : w * v = 1) :
    Function.Bijective (mulMapNecSuf S hmul hw) := by
  -- 第 1 の往復。v を掛ける写像は w を掛ける写像の左逆である。
  have left : ∀ z : ↥S, mulMapNecSuf S hmul hv (mulMapNecSuf S hmul hw z) = z := by
    intro z
    apply Subtype.ext
    show v * (w * z.1) = z.1
    calc v * (w * z.1)
        = (v * w) * z.1 := (mul_assoc _ _ _).symm
      _ = 1 * z.1 := by rw [hvw]
      _ = z.1 := one_mul _
  -- 第 2 の往復。v を掛ける写像は w を掛ける写像の右逆でもある。
  have right : ∀ z : ↥S, mulMapNecSuf S hmul hw (mulMapNecSuf S hmul hv z) = z := by
    intro z
    apply Subtype.ext
    show w * (v * z.1) = z.1
    calc w * (v * z.1)
        = (w * v) * z.1 := (mul_assoc _ _ _).symm
      _ = 1 * z.1 := by rw [hwv]
      _ = z.1 := one_mul _
  constructor
  · intro z₁ z₂ h
    calc z₁ = mulMapNecSuf S hmul hv (mulMapNecSuf S hmul hw z₁) := (left z₁).symm
      _ = mulMapNecSuf S hmul hv (mulMapNecSuf S hmul hw z₂) := by rw [h]
      _ = z₂ := left z₂
  · intro z
    exact ⟨mulMapNecSuf S hmul hv z, right z⟩

end Ising2DLambda.NecSuf.AlgebraicEigenvalue

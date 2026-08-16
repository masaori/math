/-
「対数順序群から有理係数の対数順序群への写像は加法を保ち単射である」の必要十分版。

素数・整数・有理数を外し、添字型 `ι` 上の有限台写像に、値ごとの写像 `f : A → B` を
持ち上げたものを考える。加法を保つことに要るのは `f` が加法を保つこと（と `f 0 = 0`）だけ、
単射であることに要るのは `f` が単射であることだけである。
証明手順は具体版と同じ（各添字での値へ落として、持ち上げの定義・和の定義・`f` の性質の順）。
-/
import Mathlib.Data.Finsupp.Basic
import Mathlib.Data.Finsupp.SMulWithZero

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 値ごとの持ち上げは、`f` が加法を保てば加法を保ち、`f` が単射なら単射である。 -/
theorem pointwise_lift_add_and_injective_necSuf
    {ι : Type*} {A B : Type*} [AddZeroClass A] [AddZeroClass B]
    (f : A → B) (hf0 : f 0 = 0) (hfadd : ∀ a b : A, f (a + b) = f a + f b)
    (hfinj : ∀ a b : A, f a = f b → a = b) :
    (∀ l m : ι →₀ A, Finsupp.mapRange f hf0 (l + m) =
        Finsupp.mapRange f hf0 l + Finsupp.mapRange f hf0 m) ∧
    (∀ l m : ι →₀ A, Finsupp.mapRange f hf0 l = Finsupp.mapRange f hf0 m → l = m) := by
  refine ⟨fun l m => ?_, fun l m h => ?_⟩
  · ext i
    calc
      Finsupp.mapRange f hf0 (l + m) i = f ((l + m) i) := Finsupp.mapRange_apply
      _ = f (l i + m i) := by rw [Finsupp.add_apply]
      _ = f (l i) + f (m i) := hfadd _ _
      _ = Finsupp.mapRange f hf0 l i + Finsupp.mapRange f hf0 m i := by
          rw [Finsupp.mapRange_apply, Finsupp.mapRange_apply]
      _ = (Finsupp.mapRange f hf0 l + Finsupp.mapRange f hf0 m) i :=
          (Finsupp.add_apply _ _ _).symm
  · ext i
    apply hfinj
    calc
      f (l i) = Finsupp.mapRange f hf0 l i := Finsupp.mapRange_apply.symm
      _ = Finsupp.mapRange f hf0 m i := by rw [h]
      _ = f (m i) := Finsupp.mapRange_apply

/-- 「対数順序群から有理係数の対数順序群への写像は整数倍と交換する」の必要十分版。
値ごとの持ち上げは、`f` が整数倍と交換すれば整数倍と交換する。
証明手順は具体版と同じ（各添字での値へ落として、整数倍の定義・持ち上げの定義・`f` の性質・
整数倍の定義・持ち上げの定義の順）。
`A`・`B` に要るのは加法群の構造（整数倍が定義できること）だけであり、体も有理数も要らない。 -/
theorem pointwise_lift_intSmul_necSuf
    {ι : Type*} {A B : Type*} [AddCommGroup A] [AddCommGroup B]
    (f : A → B) (hf0 : f 0 = 0) (hfsmul : ∀ (n : ℤ) (a : A), f (n • a) = n • f a)
    (n : ℤ) (l : ι →₀ A) :
    n • Finsupp.mapRange f hf0 l = Finsupp.mapRange f hf0 (n • l) := by
  ext i
  calc
    (n • Finsupp.mapRange f hf0 l) i = n • Finsupp.mapRange f hf0 l i := Finsupp.smul_apply _ _ _
    _ = n • f (l i) := by rw [Finsupp.mapRange_apply]
    _ = f (n • l i) := (hfsmul n (l i)).symm
    _ = f ((n • l) i) := by rw [Finsupp.smul_apply]
    _ = Finsupp.mapRange f hf0 (n • l) i := Finsupp.mapRange_apply.symm

end Ising2DLambda.NecSuf.ThermodynamicLimit

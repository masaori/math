/-
「取り出した分解の残りの因子の根は、取り出した因子の根と相異なる」の必要十分版。

具体版と同じ背理法に必要なのは、点の型 Q・多項式の型 P・値の型 V の上で、
分解の等式 h = A * g、点 w での評価が「この積」を保つこと 1 件、
「この値」と零元との積が零元であること 1 件、終点の非零性 E w h ≠ 0、
そして E w' g = 0 だけである。多項式であること・係数・環の法則・体・代数閉性は
一切使わない（積は抽象の 2 項演算でよく、法則を仮定しない）。

evaluation の族 E : Q → P → V を点で添字づけたのは、背理法の仮定 w' = w による
書き換えが、等しい点での評価の一致（関数の合同性）だけで済むことを見せるためである。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

theorem extracted_root_distinct_necSuf {Q P V : Type*} [Mul P] [Mul V] [Zero V]
    (E : Q → P → V) (h A g : P) (w w' : Q)
    (hAg : h = A * g)
    (hmul : E w (A * g) = E w A * E w g)
    (habs : E w A * (0 : V) = 0)
    (hne : E w h ≠ 0) (hg : E w' g = 0) :
    w' ≠ w := by
  intro heq
  apply hne
  calc
    E w h = E w (A * g) := by rw [hAg]
    _ = E w A * E w g := hmul
    _ = E w A * E w' g := by rw [heq]
    _ = E w A * 0 := by rw [hg]
    _ = 0 := habs

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
